import os
import argparse
from enum import IntEnum
import re
from typing import Literal

'''TODO
Frontend:
1. Finish instruction decode
Backend:
1.1 Modify VDMEM to be banked
1.2 Implement bank conflicts
'''


class VECTOR_OP_TYPE(IntEnum):
    ''' enum for vector arithmetic operations '''
    ADD = 1
    SUB = 2
    MUL = 3
    DIV = 4


class SCALAR_OP_TYPE(IntEnum):
    ''' enum for scalar arithmetic and logical operations '''
    ADD = 1
    SUB = 2
    AND = 3
    OR  = 4
    XOR = 5
    SRL = 6
    SLL = 7
    SRA = 8


class BRANCH_TYPE(IntEnum):
    ''' enum for branch and mask operations '''
    EQ = 1
    NE = 2
    GT = 3
    LT = 4
    GE = 5
    LE = 6


class REGS(IntEnum):
    ''' enum for registers '''
    SR0 = 0
    SR1 = 1
    SR2 = 2
    SR3 = 3
    SR4 = 4
    SR5 = 5
    SR6 = 6
    SR7 = 7
    VR0 = 8
    VR1 = 9
    VR2 = 10
    VR3 = 11
    VR4 = 12
    VR5 = 13
    VR6 = 14
    VR7 = 15


class Config(object):
    def __init__(self, iodir):
        self.filepath = os.path.abspath(os.path.join(iodir, "Config.txt"))
        self.parameters = {} # dictionary of parameter name: value as strings.

        try:
            with open(self.filepath, 'r') as conf:
                self.parameters = {line.split('=')[0].strip(): line.split('=')[1].split('#')[0].strip() for line in conf.readlines() if not (line.startswith('#') or line.strip() == '')}
            print("Config - Parameters loaded from file:", self.filepath)
            print("Config parameters:", self.parameters)
        except Exception as e:
            print("Config - ERROR: Couldn't open file in path:", self.filepath)
            print("Exception:", str(e))
            raise


# ************************ Frontend *******************************
# gets created at decode stage
class Instruction(object):
    def __init__(self) -> None:
        self.op = None
        self.type: Literal['HALT', 'BRANCH', 'SI', 'CI', 'LSI'] | None = None
        self.operand1 = None
        self.operand2 = None
        self.operand3 = None
        # for vector instructions only
        self.num_cycles = None
        self.regs = []
        self.pipeline_needed: Literal['Vadd', 'Vmul', 'Vdiv', 'Vshuffle'] | None = None
        self.address = None


# Instruction Decoder
class Decoder(object):
    '''TODO: add support for new LSI instruction format and compute num_cycles'''
    def __init__(self) -> None:
        self.re_pattern = re.compile(r"(?:^(?P<instruction>\w+)(?:[ ]+(?P<operand1>\w+))?(?:[ ]+(?P<operand2>\w+))?(?:[ ]+(?P<operand3>[-\w]+))?[ ]*(?P<inline_comment>#.*)?$)|(?:^(?P<comment_line>[ ]*?#.*)$)|(?P<empty_line>^(?<!.)$|(?:^[ ]+$)$)")

    def decode(self, instr_str: str, len_reg, mask_reg):
        instr = Instruction()
        instr_match = self.re_pattern.search(instr_str)
        if instr_match is None:
            raise Exception(f'Could not parse instruction: {instr_str}')
        instr_dict = instr_match.groupdict()
        instr.op = instr_dict['instruction']
        # BRANCHES
        if instr.op in ['BEQ', 'BNE', 'BLT', 'BLE', 'BGT', 'VGE']:
            instr.type = 'BRANCH'
        # HALT
        elif instr.op == 'HALT':
            instr.type = 'HALT'
        # SI instructions with three operands
        elif instr.op in ['ADD', 'SUB', 'AND', 'OR', 'XOR', 'SLL', 'SRL', 'SRA', 'LS', 'SS']:
            instr.type = 'SI'
            # parse operands
            if instr_dict['operand1'] is None or instr_dict['operand2'] is None or instr_dict['operand3'] is None:
                raise Exception(f'invalid instruction: {instr_str}')
            instr.operand1 = instr_dict['operand1']
            instr.operand2 = instr_dict['operand2']
            instr.operand3 = instr_dict['operand3']
        # SI instructions with one operand
        elif instr.op in ['POP', 'MTCL', 'MFCL']:
            instr.type = 'SI'
            # parse operands
            if instr_dict['operand1'] is None or instr_dict['operand2'] is None or instr_dict['operand3'] is None:
                raise (f'invalid instruction: {instr_str}')
            instr.operand1 = instr_dict['operand1']
        # SI instructions with no operand
        elif instr.op in ['CVM']:
            instr.type = 'SI'
        # CI instructions
        # shuffle instructions
        elif instr.op in ['UNPACKLO', 'UNPACKHI', 'PACKHI', 'PACKLO']:
            instr.type = 'CI'
            instr.pipeline_needed = 'Vshuffle'
            # parse operands
            if instr_dict['operand1'] is None or instr_dict['operand2'] is None or instr_dict['operand3'] is None:
                raise (f'invalid instruction: {instr_str}')
            instr.operand1 = instr_dict['operand1']
            instr.operand2 = instr_dict['operand2']
            instr.operand3 = instr_dict['operand3']
        # add/sub instructions
        elif instr.op in ['ADDVV', 'SUBVV', 'ADDVS', 'SUBVS']:
            # num of cycles needed is number of operations to do
            num_cycles = 0
            for i in range(len_reg):
                if mask_reg[i]:
                    num_cycles += 1
            instr.num_cycles = num_cycles
            instr.type = 'CI'
            instr.pipeline_needed = 'Vadd'
            # parse operands
            if instr_dict['operand1'] is None or instr_dict['operand2'] is None or instr_dict['operand3'] is None:
                raise (f'invalid instruction: {instr_str}')
            instr.operand1 = instr_dict['operand1']
            instr.operand2 = instr_dict['operand2']
            instr.operand3 = instr_dict['operand3']
        # mul instructions
        elif instr.op in ['MULVV', 'MULVS']:
            # num of cycles needed is number of operations to do
            num_cycles = 0
            for i in range(len_reg):
                if mask_reg[i]:
                    num_cycles += 1
            instr.num_cycles = num_cycles
            instr.type = 'CI'
            instr.pipeline_needed = 'Vmul'
            # parse operands
            if instr_dict['operand1'] is None or instr_dict['operand2'] is None or instr_dict['operand3'] is None:
                raise (f'invalid instruction: {instr_str}')
            instr.operand1 = instr_dict['operand1']
            instr.operand2 = instr_dict['operand2']
            instr.operand3 = instr_dict['operand3']
        # div instructions
        elif instr.op in ['DIVVV', 'DIVVS']:
            # num of cycles needed is number of operations to do
            num_cycles = 0
            for i in range(len_reg):
                if mask_reg[i]:
                    num_cycles += 1
            instr.num_cycles = num_cycles
            instr.type = 'CI'
            instr.pipeline_needed = 'Vdiv'
            # parse operands
            if instr_dict['operand1'] is None or instr_dict['operand2'] is None or instr_dict['operand3'] is None:
                raise (f'invalid instruction: {instr_str}')
            instr.operand1 = instr_dict['operand1']
            instr.operand2 = instr_dict['operand2']
            instr.operand3 = instr_dict['operand3']
        # LSI instructions
        elif instr.op in ['LV', 'LVWS', 'LVI', 'SV', 'SVWS', 'SVI']:
            instr.type = 'LSI'

        return instr


# base class for dispatch queues
class DispatchQueue(object):
    ''' DONE '''
    def __init__(self, depth) -> None:
        self.depth = depth
        self.queue = []
        self.size = 0

    def isFull(self):
        return self.size == self.depth

    def isEmpty(self):
        return self.size == 0

    def peek(self):
        '''returns None if the queue is empty'''
        if self.size == 0:
            return None
        return self.queue[0]

    def pop(self):
        '''returns None if the queue is empty'''
        if self.size == 0:
            return None
        self.size -= 1
        return self.queue.pop(0)

    def push(self, instr):
        if self.isFull():
            raise Exception('queue is full')
        self.size += 1
        self.queue.append(instr)


class BusyBoard(object):
    ''' DONE '''
    def __init__(self, srf_size=8, vrf_size=8) -> None:
        # vrf and srf size are ]hardcoded to a max of 8 each due to enum
        self.board = [False for _ in range(srf_size + vrf_size)]

    def setBusy(self, regs: list[REGS]):
        ''' sets the busy bit for the registers in regs
        throws exception if already busy
        '''
        for reg in regs:
            if self.board[reg.value]:
                raise ValueError(f'register {reg.name} already busy')
            self.board[reg.value] = True

    def clear(self, regs: list[REGS]):
        ''' clears the busy bit for the registers in regs
        throws exception if already free
        '''
        for reg in regs:
            if not self.board[reg.value]:
                raise ValueError(f'register {reg.name} already free')
            self.board[reg.value] = False

    def isBusy(self, regs: list[REGS]):
        ''' returns True if the register is busy '''
        return [self.board[reg.value] for reg in regs]


class IMEM(object):
    def __init__(self, iodir):
        self.size = pow(2, 16) # Can hold a maximum of 2^16 instructions.
        self.filepath = os.path.abspath(os.path.join(iodir, "Code.asm"))
        self.instructions = []

        try:
            with open(self.filepath, 'r') as insf:
                self.instructions = [ins.split('#')[0].strip() for ins in insf.readlines() if not (ins.startswith('#') or ins.strip() == '')]
            print("IMEM - Instructions loaded from file:", self.filepath)
            # print("IMEM - Instructions:", self.instructions)
        except Exception as e:
            print("IMEM - ERROR: Couldn't open file in path:", self.filepath)
            print("Exception:", str(e))
            raise

    def Read(self, idx): # Use this to read from IMEM.
        if idx >= 0 and idx < self.size:
            return self.instructions[idx]
        else:
            print("IMEM - ERROR: Invalid memory access at index: ", idx, " with memory size: ", self.size)


# ************************ Backend *******************************
class ComputePipeline(object):
    '''base class for vector compute unit (ADD,SUB,MUL,DIV)'''
    def __init__(self, type, latency, lanes, SRF, VRF) -> None:
        self.latency = latency
        self.type = type
        self.busy = False
        self.instr = None
        self.cycles_needed = 0
        self.SRF = SRF
        self.VRF = VRF
        self.lanes = lanes

    # Instruction 1 and 3
    def ___VV(self, vr1_idx, vr2_idx, vr3_idx, op):
        vr2 = self.VRF.Read(vr2_idx)
        vr3 = self.VRF.Read(vr3_idx)
        match op:
            case VECTOR_OP_TYPE.ADD:
                for i in range(self.len_reg):
                    if self.mask_reg[i]:
                        self.VRF.write_vec_element(vr1_idx, i, vr2[i] + vr3[i])
            case VECTOR_OP_TYPE.SUB:
                for i in range(self.len_reg):
                    if self.mask_reg[i]:
                        self.VRF.write_vec_element(vr1_idx, i, vr2[i] - vr3[i])
            case VECTOR_OP_TYPE.MUL:
                for i in range(self.len_reg):
                    if self.mask_reg[i]:
                        self.VRF.write_vec_element(vr1_idx, i, vr2[i] * vr3[i])
            case VECTOR_OP_TYPE.DIV:
                for i in range(self.len_reg):
                    if self.mask_reg[i]:
                        self.VRF.write_vec_element(vr1_idx, i, int(vr2[i] / vr3[i]))
            case _:
                raise ValueError("invalid VV op")

    # Instruction 2 and 4
    def ___VS(self, vr1_idx, vr2_idx, op):
        vr2 = self.VRF.Read(vr2_idx)
        sr1 = self.instr.scalar_operand
        match op:
            case VECTOR_OP_TYPE.ADD:
                for i in range(self.len_reg):
                    if self.mask_reg[i]:
                        self.VRF.write_vec_element(vr1_idx, i, vr2[i] + sr1)
            case VECTOR_OP_TYPE.SUB:
                for i in range(self.len_reg):
                    if self.mask_reg[i]:
                        self.VRF.write_vec_element(vr1_idx, i, vr2[i] - sr1)
            case VECTOR_OP_TYPE.MUL:
                for i in range(self.len_reg):
                    self.VRF.write_vec_element(vr1_idx, i, vr2[i] * sr1)
            case VECTOR_OP_TYPE.DIV:
                for i in range(self.len_reg):
                    if self.mask_reg[i]:
                        self.VRF.write_vec_element(vr1_idx, i, int(vr2[i] / sr1))
            case _:
                raise ValueError("invalid VS op")

    # Vector Mask Operations
    # Instruction 5
    def S__VV(self, vr1_idx, vr2_idx, op):
        vr1 = self.RFs['VRF'].Read(vr1_idx)
        vr2 = self.RFs['VRF'].Read(vr2_idx)
        
        match op:
            case BRANCH_TYPE.EQ:
                for i in range(self.len_reg):
                    self.mask_reg[i] = vr1[i] == vr2[i]
            case BRANCH_TYPE.NE:
                for i in range(self.len_reg):
                    self.mask_reg[i] = vr1[i] != vr2[i]
            case BRANCH_TYPE.GT:
                for i in range(self.len_reg):
                    self.mask_reg[i] = vr1[i] > vr2[i]
            case BRANCH_TYPE.LT:
                for i in range(self.len_reg):
                    self.mask_reg[i] = vr1[i] < vr2[i]
            case BRANCH_TYPE.GE:
                for i in range(self.len_reg):
                    self.mask_reg[i] = vr1[i] >= vr2[i]
            case BRANCH_TYPE.LE:
                for i in range(self.len_reg):
                    self.mask_reg[i] = vr1[i] <= vr2[i]
            case _:
                raise ValueError("invalid vv branch type")

    # Instruction 6
    def S__VS(self, vr1_idx, sr1_idx, op):
        vr1 = self.RFs['VRF'].Read(vr1_idx)
        sr1 = self.RFs['SRF'].Read(sr1_idx)
        
        match op:
            case BRANCH_TYPE.EQ:
                for i in range(self.len_reg):
                    self.mask_reg[i] = vr1[i] == sr1
            case BRANCH_TYPE.NE:
                for i in range(self.len_reg):
                    self.mask_reg[i] = vr1[i] != sr1
            case BRANCH_TYPE.GT:
                for i in range(self.len_reg):
                    self.mask_reg[i] = vr1[i] > sr1
            case BRANCH_TYPE.LT:
                for i in range(self.len_reg):
                    self.mask_reg[i] = vr1[i] < sr1
            case BRANCH_TYPE.GE:
                for i in range(self.len_reg):
                    self.mask_reg[i] = vr1[i] >= sr1
            case BRANCH_TYPE.LE:
                for i in range(self.len_reg):
                    self.mask_reg[i] = vr1[i] <= sr1
            case _:
                raise ValueError("invalid vs branch type")

    # Memory Access Operations
    # Instruction 11
    def LV(self, vr1_idx, sr1_idx):
        sr1 = self.RFs['SRF'].Read(sr1_idx)
        for i in range(self.len_reg):
            if self.mask_reg[i]:
                val = self.VDMEM.Read(sr1 + i)
                self.RFs['VRF'].write_vec_element(vr1_idx, i, val)

    # Instruction 12
    def SV(self, vr1_idx, sr1_idx):
        vr1 = self.RFs['VRF'].Read(vr1_idx)
        sr1 = self.RFs['SRF'].Read(sr1_idx)
        for i in range(self.len_reg):
            if self.mask_reg[i]:
                self.VDMEM.Write(sr1+i, vr1[i])
        
    # Instruction 13
    # stride applies to both mem read and vrf write?
    def LVWS(self, vr1_idx, sr1_idx, sr2_idx):
        sr1 = self.RFs['SRF'].Read(sr1_idx)
        sr2 = self.RFs['SRF'].Read(sr2_idx)
        for i in range(self.len_reg):
            if self.mask_reg[i]:
                val = self.VDMEM.Read(sr1 + i * sr2)
                self.RFs['VRF'].write_vec_element(vr1_idx, i, val)
            
    # Instruction 14
    def SVWS(self, vr1_idx, sr1_idx, sr2_idx):
        vr1 = self.RFs['VRF'].Read(vr1_idx)
        sr1 = self.RFs['SRF'].Read(sr1_idx)
        sr2 = self.RFs['SRF'].Read(sr2_idx)
        for i in range(self.len_reg):
            if self.mask_reg[i]:
                self.VDMEM.Write(sr1 + i*sr2, vr1[i])
    
    # Instruction 15
    def LVI(self, vr1_idx, sr1_idx, vr2_idx):
        sr1 = self.RFs['SRF'].Read(sr1_idx)
        vr2 = self.RFs['VRF'].Read(vr2_idx)
        
        for i in range(self.len_reg):
            if self.mask_reg[i]:
                val = self.VDMEM.Read(sr1 + vr2[i])
                self.RFs['VRF'].write_vec_element(vr1_idx, i, val)
    
    # Instruction 16
    def SVI(self, vr1_idx, sr1_idx, vr2_idx):
        vr1 = self.RFs['VRF'].Read(vr1_idx)
        sr1 = self.RFs['SRF'].Read(sr1_idx)
        vr2 = self.RFs['VRF'].Read(vr2_idx)
        
        # VDMEM[sr1 + vr2[i]] = vr1[i]
        for i in range(self.len_reg):
            if self.mask_reg[i]:
                self.VDMEM.Write(sr1 + vr2[i], vr1[i])

    # Instruction 24
    def UNPACKLO(self, vr1_idx, vr2_idx, vr3_idx):
        vr2 = self.RFs['VRF'].Read(vr2_idx)
        vr3 = self.RFs['VRF'].Read(vr3_idx)

        # this works for even numbers
        for i in range(self.len_reg//2):
            self.RFs['VRF'].write_vec_element(vr1_idx, i*2, vr2[i])
            self.RFs['VRF'].write_vec_element(vr1_idx, i*2+1, vr3[i])
        
        # for odd numbers, we need to update the last element to vr2[i]
        if self.len_reg % 2 != 0:
            i = self.len_reg//2
            self.RFs['VRF'].write_vec_element(vr1_idx, i*2, vr2[i])
             
    # Instruction 25
    def UNPACKHI(self, vr1_idx, vr2_idx, vr3_idx):
        vr2 = self.RFs['VRF'].Read(vr2_idx)
        vr3 = self.RFs['VRF'].Read(vr3_idx)
        
        for i in range(self.len_reg//2):
            self.RFs['VRF'].write_vec_element(vr1_idx, i*2, vr2[i + self.len_reg//2])
            self.RFs['VRF'].write_vec_element(vr1_idx, i*2+1, vr3[i + self.len_reg//2])
    
        if self.len_reg % 2 != 0:
            i = self.len_reg//2
            self.RFs['VRF'].write_vec_element(vr1_idx, i*2, vr2[i + self.len_reg//2])
    
    # Instruction 26
    def PACKLO(self, vr1_idx, vr2_idx, vr3_idx):
        vr2 = self.RFs['VRF'].Read(vr2_idx)
        vr3 = self.RFs['VRF'].Read(vr3_idx)
        
        for i in range(self.len_reg//2):
            self.RFs['VRF'].write_vec_element(vr1_idx, i, vr2[i*2])
            self.RFs['VRF'].write_vec_element(vr1_idx, i + self.len_reg//2, vr3[i*2])
    
    # Instruction 27
    def PACKHI(self, vr1_idx, vr2_idx, vr3_idx):
        vr2 = self.RFs['VRF'].Read(vr2_idx)
        vr3 = self.RFs['VRF'].Read(vr3_idx)

        for i in range(self.len_reg//2):
            self.RFs['VRF'].write_vec_element(vr1_idx, i, vr2[i*2 + 1])
            self.RFs['VRF'].write_vec_element(vr1_idx, i + self.len_reg//2, vr3[i*2 + 1])

    def isBusy(self):
        return self.busy

    def acceptInstr(self, instr):
        self.busy = True
        self.instr = instr
        self.cycles_needed = instr.num_cycles / self.lanes * self.latency if instr.num_cycles % self.lanes == 0 \
            else (instr.num_cycles // self.lanes + 1) * self.latency

    def finishedInstr(self):
        # update VRF
        match self.instr.op:
            case "ADDVV":
                self.___VV(self.instr['operand1'], self.instr['operand2'], self.instr['operand3'], VECTOR_OP_TYPE.ADD)
            case "SUBVV":
                self.___VV(self.instr['operand1'], self.instr['operand2'], self.instr['operand3'], VECTOR_OP_TYPE.SUB)
            case "MULVV":
                self.___VV(self.instr['operand1'], self.instr['operand2'], self.instr['operand3'], VECTOR_OP_TYPE.MUL)
            case "DIVVV":
                self.___VV(self.instr['operand1'], self.instr['operand2'], self.instr['operand3'], VECTOR_OP_TYPE.DIV)
            case "ADDVS":
                self.___VS(self.instr['operand1'], self.instr['operand2'], VECTOR_OP_TYPE.ADD)
            case "SUBVS":
                self.___VS(self.instr['operand1'], self.instr['operand2'], VECTOR_OP_TYPE.SUB)
            case "MULVS":
                self.___VS(self.instr['operand1'], self.instr['operand2'], VECTOR_OP_TYPE.MUL)
            case "DIVVS":
                self.___VS(self.instr['operand1'], self.instr['operand2'], VECTOR_OP_TYPE.DIV)
            case "SEQVV":
                self.S__VV(self.instr['operand1'], self.instr['operand2'], BRANCH_TYPE.EQ)
            case "SNEVV":
                self.S__VV(self.instr['operand1'], self.instr['operand2'], BRANCH_TYPE.NE)
            case "SGTVV":
                self.S__VV(self.instr['operand1'], self.instr['operand2'], BRANCH_TYPE.GT)
            case "SLTVV":
                self.S__VV(self.instr['operand1'], self.instr['operand2'], BRANCH_TYPE.LT)
            case "SGEVV":
                self.S__VV(self.instr['operand1'], self.instr['operand2'], BRANCH_TYPE.GE)
            case "SLEVV":
                self.S__VV(self.instr['operand1'], self.instr['operand2'], BRANCH_TYPE.LE)
            case "SEQVS":
                self.S__VS(self.instr['operand1'], self.instr['operand2'], BRANCH_TYPE.EQ)
            case "SNEVS":
                self.S__VS(self.instr['operand1'], self.instr['operand2'], BRANCH_TYPE.NE)
            case "SGTVS":
                self.S__VS(self.instr['operand1'], self.instr['operand2'], BRANCH_TYPE.GT)
            case "SLTVS":
                self.S__VS(self.instr['operand1'], self.instr['operand2'], BRANCH_TYPE.LT)
            case "SGEVS":
                self.S__VS(self.instr['operand1'], self.instr['operand2'], BRANCH_TYPE.GE)
            case "SLEVS":
                self.S__VS(self.instr['operand1'], self.instr['operand2'], BRANCH_TYPE.LE)
            case "LV":
                self.LV(self.instr['operand1'], self.instr['operand2'])
            case "SV":
                self.SV(self.instr['operand1'], self.instr['operand2'])
            case "LVWS":
                self.LVWS(self.instr['operand1'], self.instr['operand2'], self.instr['operand3'])
            case "SVWS":
                self.SVWS(self.instr['operand1'], self.instr['operand2'], self.instr['operand3'])
            case "LVI":
                self.LVI(self.instr['operand1'], self.instr['operand2'], self.instr['operand3'])
            case "SVI":
                self.SVI(self.instr['operand1'], self.instr['operand2'], self.instr['operand3'])
            case "UNPACKLO":
                self.UNPACKLO(self.instr['operand1'], self.instr['operand2'], self.instr['operand3'])
            case "UNPACKHI":
                self.UNPACKHI(self.instr['operand1'], self.instr['operand2'], self.instr['operand3'])
            case "PACKLO":
                self.PACKLO(self.instr['operand1'], self.instr['operand2'], self.instr['operand3'])
            case "PACKHI":
                self.PACKHI(self.instr['operand1'], self.instr['operand2'], self.instr['operand3'])
        # update state
        self.busy = False

    def update(self):
        if self.cycles_needed == 0:
            self.finishedInstr()
            return self.instr
        self.cycles_needed -= 1
        return None


class DMEM(object):
    # Word addressible - each address contains 32 bits.
    def __init__(self, name, iodir, addressLen):
        self.name = name
        self.size = pow(2, addressLen)
        self.min_value  = -pow(2, 31)
        self.max_value  = pow(2, 31) - 1
        self.ipfilepath = os.path.abspath(os.path.join(iodir, name + ".txt"))
        self.opfilepath = os.path.abspath(os.path.join(iodir, name + "OP.txt"))
        self.data = []

        try:
            with open(self.ipfilepath, 'r') as ipf:
                self.data = [int(line.strip()) for line in ipf.readlines()]
            print(self.name, "- Data loaded from file:", self.ipfilepath)
            # print(self.name, "- Data:", self.data)
            self.data.extend([0x0 for i in range(self.size - len(self.data))])
        except Exception as e:
            print(self.name, "- ERROR: Couldn't open input file in path:", self.ipfilepath)
            print("Exception:", str(e))
            raise

    def checkIdx(self, idx):
        ''' Checks if the memory index is valid (within bounds) '''
        if idx < 0 or idx >= self.size:
            raise ValueError(f'invalid DMEM index: {idx}')

    def checkVal(self, val):
        if type(val) is list:
            for element in val:
                if element > self.max_value or element < self.min_value:
                    raise ValueError('Value to write to DMEM is out of range')
        else:
            if val > self.max_value or val < self.min_value:
                raise ValueError('Value to write to DMEM is out of range')

    def Read(self, idx): # Use this to read from DMEM.
        pass # Replace this line with your code here.

    def Write(self, idx, val): # Use this to write into DMEM.
        pass # Replace this line with your code here.

    def dump(self):
        try:
            with open(self.opfilepath, 'w') as opf:
                lines = [str(data) + '\n' for data in self.data]
                opf.writelines(lines)
            print(self.name, "- Dumped data into output file in path:", self.opfilepath)
        except Exception as e:
            print(self.name, "- ERROR: Couldn't open output file in path:", self.opfilepath)
            print("Exception:", str(e))
            raise


class VDMEM(DMEM):
    def __init__(self, name, iodir, addressLen, numBanks):
        super().__init__(name, iodir, addressLen)
        self.numBanks = numBanks

    def Read(self, idx):
        return super().Read(idx)
    
    def Write(self, idx, val):
        return super().Write(idx, val)


class SDMEM(DMEM):
    pass


class RegisterFile(object):
    def __init__(self, name, count, length=1, size=32):
        self.name       = name
        self.reg_count  = count
        self.vec_length = length # Number of 32 bit words in a register.
        self.reg_bits   = size
        self.min_value  = -pow(2, self.reg_bits-1)
        self.max_value  = pow(2, self.reg_bits-1) - 1
        self.registers  = [[0x0 for e in range(self.vec_length)] for r in range(self.reg_count)] # list of lists of integers

    def getIdx(self, reg_name):
        '''
        converts a register name to its index inside of the register file
        and checks for invalid register names
        '''
        if str(reg_name).startswith("VR") and self.name != "VRF":
            raise ValueError('accessing incorrect register file type')
        if str(reg_name).startswith("SR") and self.name != "SRF":
            raise ValueError('accessing incorrect register file type')
        if not (str(reg_name).startswith("SR") or str(reg_name).startswith("VR")):
            raise ValueError('invalid register name')
        
        idx = int(reg_name[2:])
        if idx < 0 or idx >= self.reg_count:
            raise ValueError('invalid register index')

        return idx
    
    # assuming that val is list for vector register
    # and int for scalar register
    def checkVal(self, val):
        if type(val) is list:
            for element in val:
                if element > self.max_value or element < self.min_value:
                    raise ValueError('Value to write to register is out of range')
        else:
            if val > self.max_value or val < self.min_value:
                raise ValueError(f'Value to write to register is out of range {val}')
    
    def Read(self, idx):
        ''' returns the register at the provided index.
        integer for SRF, list for VRF
        '''
        idx = self.getIdx(idx)
        if self.name == 'SRF':
            return self.registers[idx][0]
        else:
            return self.registers[idx]

    def Write(self, idx, val):
        '''
        update the register at the provided index using val
        expects integer for SRF, list for VRF
        input validation is handled internally :)
        '''
        idx = self.getIdx(idx)
        self.checkVal(val)
        if self.name == 'SRF':
            if type(val) is not int:
                raise ValueError('expected type int for SRF write')
            self.registers[idx][0] = val
        else:
            if type(val) is not list or len(val) != 64:
                raise ValueError('expected type list with length 64 for VRF write')
            self.registers[idx] = val
            
    def write_vec_element(self, idx, ele, val):
        idx = self.getIdx(idx)
        if self.name == 'SRF':
            raise Exception()
        if ele >= len(self.registers[idx]):
            raise ValueError('element out of bounds')
        self.checkVal(val)
        self.registers[idx][ele] = val

    def dump(self, iodir):
        opfilepath = os.path.abspath(os.path.join(iodir, self.name + ".txt"))
        try:
            with open(opfilepath, 'w') as opf:
                row_format = "{:<13}"*self.vec_length
                lines = [row_format.format(*[str(i) for i in range(self.vec_length)]) + "\n", '-'*(self.vec_length*13) + "\n"]
                lines += [row_format.format(*[str(val) for val in data]) + "\n" for data in self.registers]
                opf.writelines(lines)
            print(self.name, "- Dumped data into output file in path:", opfilepath)
        except Exception as e:
            print(self.name, "- ERROR: Couldn't open output file in path:", opfilepath)
            print("Exception:", str(e))
            raise


class Core():
    def __init__(self, imem, sdmem, vdmem, config):
        self.IMEM = imem
        self.SDMEM = sdmem
        self.VDMEM = vdmem

        self.RFs = {"SRF": RegisterFile("SRF", 8),
                    "VRF": RegisterFile("VRF", 8, 64)}
        # Your code here.
        self.MVL = 64
        self.len_reg = self.MVL
        self.mask_reg = [True for _ in range(self.MVL)]
        self.pc = 0
        self.data_queue = DispatchQueue(config['dataQueueDepth'])
        self.compute_queue = DispatchQueue(config['computeQueueDepth'])
        self.busyboard = BusyBoard()
        self.decoder = Decoder(self.RFs['SRF'])
        self.compute_pipelines = {
            'Vadd': ComputePipeline('Vadd', config['pipelineDepthAdd'], config['numLanes'], self.RFs['SRF'], self.RFs['VRF']),
            'Vmul': ComputePipeline('Vmul', config['pipelineDepthMul'], config['numLanes'], self.RFs['SRF'], self.RFs['VRF']),
            'Vdiv': ComputePipeline('Vdiv', config['pipelineDepthDiv'], config['numLanes'], self.RFs['SRF'], self.RFs['VRF']),
            'Vshuffle': ComputePipeline('Vshu', config['pipelineDepthShuffle'], config['numLanes'], self.RFs['SRF'], self.RFs['VRF'])
        }
        self.cycle_count = 1 # we start cycle count at 1 because we assume instr[0] has already been fetched

    def update_len_reg(self, val):
        if val < 0 or val > self.MVL:
            raise ValueError('invalid length register val')
        self.len_reg = val

    def run(self):
        instr = self.IMEM.Read(self.pc)
        while True:
            # EX stage (backend)
            for pipeline in self.compute_pipelines.values():
                completed_instr = pipeline.update()
                if completed_instr is not None:
                    self.busyboard.clear(completed_instr.regs)

            # add instruction to compute pipeline if possible
            curr_instr = self.compute_queue.peek()
            if curr_instr is not None and not self.compute_pipelines[curr_instr.pipeline_needed].isBusy():
                self.compute_pipelines[curr_instr.pipeline_needed].acceptInstr(curr_instr)
                self.compute_queue.pop()
            # add instruction to data pipeline if possible

            # ID stage
            stall_frontend = False
            # first decode instruction
            decoded_instr = self.decoder.decode(instr, self.len_reg, self.mask_reg)
            # then check data dependence
            if self.busyboard.isBusy(decoded_instr.regs):
                stall_frontend = True
            # then check structural dependence
            match decoded_instr.type:
                case "LSI":
                    if self.data_queue.isFull():
                        stall_frontend = True
                    else:
                        self.data_queue.push(decoded_instr)
                case "CI":
                    if self.compute_queue.isFull():
                        stall_frontend = True
                    else:
                        self.compute_queue.push(decoded_instr)
                case "HALT": # for HALT we just stall the frontend (no more instructions to fetch) and wait until all instructions are executed
                    stall_frontend = True
                    if self.data_queue.isEmpty() and self.compute_queue.isEmpty() and not self.compute_pipelines['Vadd'].busy \
                        and not self.compute_pipelines['Vmul'].busy and not self.compute_pipelines['Vdiv'].busy \
                            and not self.compute_pipelines['Vshuffle'].busy:
                        break
                case "BRANCH": # for branch, we just continue to the next instruction
                    self.pc += 1
                    self.cycle_count += 1
                    continue
                case "SI":
                    ''' ALL SI take 1 cycle '''
                    match decoded_instr.op:
                        case "CVM":
                            self.CVM()
                        case "POP":
                            self.POP(decoded_instr.operand1)
                        case "MTCL":
                            self.MTCL(decoded_instr['operand1'])
                        case "MFCL":
                            self.MFCL(decoded_instr['operand1'])
                        case "LS":
                            self.LS(decoded_instr['operand1'], decoded_instr['operand2'], decoded_instr['operand3'])
                        case "SS":
                            self.SS(decoded_instr['operand1'], decoded_instr['operand2'], decoded_instr['operand3'])
                        case "ADD":
                            self.scalarExec(decoded_instr['operand1'], decoded_instr['operand2'], decoded_instr['operand3'], SCALAR_OP_TYPE.ADD)
                        case "SUB":
                            self.scalarExec(decoded_instr['operand1'], decoded_instr['operand2'], decoded_instr['operand3'], SCALAR_OP_TYPE.SUB)
                        case "AND":
                            self.scalarExec(decoded_instr['operand1'], decoded_instr['operand2'], decoded_instr['operand3'], SCALAR_OP_TYPE.AND)
                        case "OR":
                            self.scalarExec(decoded_instr['operand1'], decoded_instr['operand2'], decoded_instr['operand3'], SCALAR_OP_TYPE.OR)
                        case "XOR":
                            self.scalarExec(decoded_instr['operand1'], decoded_instr['operand2'], decoded_instr['operand3'], SCALAR_OP_TYPE.XOR)
                        case "SLL":
                            self.scalarExec(decoded_instr['operand1'], decoded_instr['operand2'], decoded_instr['operand3'], SCALAR_OP_TYPE.SLL)
                        case "SRL":
                            self.scalarExec(decoded_instr['operand1'], decoded_instr['operand2'], decoded_instr['operand3'], SCALAR_OP_TYPE.SRL)
                        case "SRA":
                            self.scalarExec(decoded_instr['operand1'], decoded_instr['operand2'], decoded_instr['operand3'], SCALAR_OP_TYPE.SRA)
                        case _:
                            raise ValueError('invalid SI op:', decoded_instr.op)
                case _:
                    raise ValueError('invalid instr type:', str(decoded_instr.type))
            # IF stage
            if not stall_frontend:
                self.pc += 1
            self.cycle_count += 1

    # Instruction 7
    def CVM(self):
        self.mask_reg = [True for _ in range(self.MVL)]

    # Instruction 8
    def POP(self, sr1_idx):
        cnt = 0
        for mask_bit in self.mask_reg:
            cnt += int(mask_bit)
        self.RFs['SRF'].Write(sr1_idx, cnt)

    # Vector Length Register Operations
    # Instruction 9
    def MTCL(self, sr1_idx):
        self.update_len_reg(self.RFs['SRF'].Read(sr1_idx))

    # Instruction 10
    def MFCL(self, sr1_idx):
        self.RFs['SRF'].Write(sr1_idx, self.len_reg)
    
    # Instruction 17
    # sr2 = SDMEM[sr1+imm]
    def LS(self, sr2_idx, sr1_idx, imm):
        # need to cast imm to int
        imm = int(imm)
        sr1 = self.RFs['SRF'].Read(sr1_idx)
        sdm = self.SDMEM.Read(sr1+imm)
        self.RFs['SRF'].Write(sr2_idx, sdm)
    
    # Instruction 18
    # SDMEM[sr1+imm] = sr2
    def SS(self, sr2_idx, sr1_idx, imm):
        # need to cast imm to int
        imm = int(imm)
        sr1 = self.RFs['SRF'].Read(sr1_idx)
        sr2 = self.RFs['SRF'].Read(sr2_idx)
        self.SDMEM.Write(sr1+imm, sr2)

    # Scalar Operations
    # Instructions 19 to 22
    def scalarExec(self, sr3_idx, sr1_idx, sr2_idx, op):
        src1 = self.RFs['SRF'].Read(sr1_idx)
        src2 = self.RFs['SRF'].Read(sr2_idx)
        match op:
            case SCALAR_OP_TYPE.ADD:
                self.RFs['SRF'].Write(sr3_idx, src1 + src2)
            case SCALAR_OP_TYPE.SUB:
                self.RFs['SRF'].Write(sr3_idx, src1 - src2)
            case SCALAR_OP_TYPE.AND:
                self.RFs['SRF'].Write(sr3_idx, src1 & src2)
            case SCALAR_OP_TYPE.OR:
                self.RFs['SRF'].Write(sr3_idx, src1 | src2)
            case SCALAR_OP_TYPE.XOR:
                self.RFs['SRF'].Write(sr3_idx, src1 ^ src2)
            case SCALAR_OP_TYPE.SRL:
                self.RFs['SRF'].Write(sr3_idx, (src1 & 0xffff_ffff) >> src2)
            case SCALAR_OP_TYPE.SLL:
                self.RFs['SRF'].Write(sr3_idx, src1 << src2)
            case SCALAR_OP_TYPE.SRA:
                self.RFs['SRF'].Write(sr3_idx, src1 >> src2)
            case _:
                raise ValueError('invalid scalar op enum')

    def dumpregs(self, iodir):
        for rf in self.RFs.values():
            rf.dump(iodir)


if __name__ == "__main__":
    # parse arguments for input file location
    parser = argparse.ArgumentParser(description='Vector Core Functional Simulator')
    parser.add_argument('--iodir', default="", type=str, help='Path to the folder containing the input files - instructions and data.')
    args = parser.parse_args()

    iodir = os.path.abspath(args.iodir)
    print("IO Directory:", iodir)

    # Parse Config
    config = Config(iodir)

    # Parse IMEM
    imem = IMEM(iodir)
    # Parse SMEM
    sdmem = DMEM("SDMEM", iodir, 13) # 32 KB is 2^15 bytes = 2^13 K 32-bit words.
    # Parse VMEM
    vdmem = DMEM("VDMEM", iodir, 17) # 512 KB is 2^19 bytes = 2^17 K 32-bit words.

    # Create Vector Core
    vcore = Core(imem, sdmem, vdmem, config)

    # Run Core
    vcore.run()
    vcore.dumpregs(iodir)

    sdmem.dump()
    vdmem.dump()

    # THE END
