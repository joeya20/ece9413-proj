import os
import argparse
from enum import IntEnum


class IMEM(object):
    def __init__(self, iodir):
        self.size = pow(2, 16) # Can hold a maximum of 2^16 instructions.
        self.filepath = os.path.abspath(os.path.join(iodir, "Code.asm"))
        self.instructions = []

        try:
            with open(self.filepath, 'r') as insf:
                self.instructions = [ins.strip() for ins in insf.readlines()]
            print("IMEM - Instructions loaded from file:", self.filepath)
        except Exception as e:
            print("IMEM - ERROR: Couldn't open file in path:", self.filepath)
            print("Exception: ", e)

    def Read(self, idx): # Use this to read from IMEM.
        if idx >= 0 and idx < self.size:
            return self.instructions[idx]
        else:
            raise ValueError("IMEM - ERROR: Invalid memory access at index: ", idx, " with memory size: ", self.size)


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
            print("Exception: ", e)

    def checkIdx(self, idx):
        ''' Checks if the memory index is valid (within bounds) '''
        if idx < 0 or idx >= self.size:
            raise ValueError('invalid DMEM index')
    
    def checkVal(self, val):
        ''' reduces the length of val to 32-bits '''
        if type(val) is list:
            for i, element in enumerate(val):
                val[i] = element & 0xffff_ffff
        else:
            val = val & 0xffff_ffff
        return val
    
    # TODO: implement vector read later?
    def Read(self, idx): # Use this to read from DMEM.
        '''
        returns the data word at the provided index
        this can only service word reads, not vector reads
        '''
        self.checkIdx(idx)
        return self.data[idx]

    # TODO: implement vector write later?
    def Write(self, idx, val): # Use this to write into DMEM.
        '''
        update the data word at the provided index using val
        this can only service word writes, not vector writes
        '''
        self.checkIdx(idx)
        val = self.checkVal(val)
        self.data[idx] = val

    def dump(self):
        try:
            with open(self.opfilepath, 'w') as opf:
                lines = [str(data) + '\n' for data in self.data]
                opf.writelines(lines)
            print(self.name, "- Dumped data into output file in path:", self.opfilepath)
        except Exception as e:
            print(self.name, "- ERROR: Couldn't open output file in path:", self.opfilepath)
            print("Exception: ", e)


class RegisterFile(object):
    def __init__(self, name, count, length=1, size=32):
        if length < 1:
            raise ValueError('invalid RF vec length')
        if count < 1:
            raise ValueError('invalid RF reg count')
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
        ''' reduces the length of val to 32-bits '''
        if type(val) is list:
            for i, element in enumerate(val):
                val[i] = element & 0xffff_ffff
        else:
            val = val & 0xffff_ffff
        return val
    
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
        val = self.checkVal(val)
        if self.name == 'SRF':
            if type(val) is not int:
                raise ValueError('expected type int for SRF write')
            self.registers[idx][0] = val
        else:
            if type(val) is not list:
                raise ValueError('expected type list for VRF write')
            self.registers[idx] = val
            
    def write_vec_element(self, idx, ele, val):
        idx = self.getIdx(idx)
        if self.name == 'SRF':
            raise Exception()
        if ele >= len(self.registers[idx]):
            raise ValueError('element out of bounds')
        val = self.checkVal(val)
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
            print("Exception: ", e)


class Core():
    def __init__(self, imem: IMEM, sdmem: DMEM, vdmem: DMEM):
        self.IMEM = imem
        self.SDMEM = sdmem
        self.VDMEM = vdmem

        self.RFs = {"SRF": RegisterFile("SRF", 8),
                    "VRF": RegisterFile("VRF", 8, 64)}
        
        # Your code here.
        self.mask_reg = 0x0
        self.pc = 0x0
        self.len_reg = 64
        self.MVL = 64
    
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

    def run(self):
        while (True):
            # fetch instruction
            instr = self.IMEM.Read(self.pc)
            
            # decode and execute instruction
            # we assume valid instructions...
            decoded_instr = str(instr).split(' ')
            match decoded_instr[0]:
                case "ADDVV":
                    self.___VV(decoded_instr[1], decoded_instr[2], decoded_instr[3], self.VECTOR_OP_TYPE.ADD)
                case "SUBVV":
                    self.___VV(decoded_instr[1], decoded_instr[2], decoded_instr[3], self.VECTOR_OP_TYPE.SUB)
                case "ADDVS":
                    self.___VS(decoded_instr[1], decoded_instr[2], decoded_instr[3], self.VECTOR_OP_TYPE.ADD)
                case "SUBVS":
                    self.___VS(decoded_instr[1], decoded_instr[2], decoded_instr[3], self.VECTOR_OP_TYPE.SUB)
                case "MULVV":
                    self.___VV(decoded_instr[1], decoded_instr[2], decoded_instr[3], self.VECTOR_OP_TYPE.MUL)
                case "DIVVV":
                    self.___VV(decoded_instr[1], decoded_instr[2], decoded_instr[3], self.VECTOR_OP_TYPE.DIV)
                case "MULVS":
                    self.___VS(decoded_instr[1], decoded_instr[2], decoded_instr[3], self.VECTOR_OP_TYPE.MUL)
                case "DIVVS":
                    self.___VS(decoded_instr[1], decoded_instr[2], decoded_instr[3], self.VECTOR_OP_TYPE.DIV)
                case "SEQVV":
                    self.S__VV(decoded_instr[1], decoded_instr[2], self.BRANCH_TYPE.EQ)
                case "SNEVV":
                    self.S__VV(decoded_instr[1], decoded_instr[2], self.BRANCH_TYPE.NE)
                case "SGTVV":
                    self.S__VV(decoded_instr[1], decoded_instr[2], self.BRANCH_TYPE.GT)
                case "SLTVV":
                    self.S__VV(decoded_instr[1], decoded_instr[2], self.BRANCH_TYPE.LT)
                case "SGEVV":
                    self.S__VV(decoded_instr[1], decoded_instr[2], self.BRANCH_TYPE.GE)
                case "SLEVV":
                    self.S__VV(decoded_instr[1], decoded_instr[2], self.BRANCH_TYPE.LE)
                case "SEQVS":
                    self.S__VS(decoded_instr[1], decoded_instr[2], self.BRANCH_TYPE.EQ)
                case "SNEVS":
                    self.S__VS(decoded_instr[1], decoded_instr[2], self.BRANCH_TYPE.NE)
                case "SGTVS":
                    self.S__VS(decoded_instr[1], decoded_instr[2], self.BRANCH_TYPE.GT)
                case "SLTVS":
                    self.S__VS(decoded_instr[1], decoded_instr[2], self.BRANCH_TYPE.LT)
                case "SGEVS":
                    self.S__VS(decoded_instr[1], decoded_instr[2], self.BRANCH_TYPE.GE)
                case "SLEVS":
                    self.S__VS(decoded_instr[1], decoded_instr[2], self.BRANCH_TYPE.LE)
                case "CVM":
                    self.CVM()
                case "POP":
                    self.POP(decoded_instr[1])
                case "MTCL":
                    self.MTCL(decoded_instr[1])
                case "MFCL":
                    self.MFCL(decoded_instr[1])
                case "LV":
                    self.LV(decoded_instr[1], decoded_instr[2])
                case "SV":
                    self.SV(decoded_instr[1], decoded_instr[2])
                case "LVWS":
                    self.LVWS(decoded_instr[1], decoded_instr[2], decoded_instr[3])
                case "SVWS":
                    self.SVWS(decoded_instr[1], decoded_instr[2], decoded_instr[3])
                case "LVI":
                    self.LVI(decoded_instr[1], decoded_instr[2], decoded_instr[3])
                case "SVI":
                    self.SVI(decoded_instr[1], decoded_instr[2], decoded_instr[3])
                case "LS":
                    self.LS(decoded_instr[1], decoded_instr[2], decoded_instr[3])
                case "SS":
                    self.SS(decoded_instr[1], decoded_instr[2], decoded_instr[3])
                case "ADD":
                    self.scalar_op(decoded_instr[1], decoded_instr[2], decoded_instr[3], self.SCALAR_OP_TYPE.ADD)
                case "SUB":
                    self.scalar_op(decoded_instr[1], decoded_instr[2], decoded_instr[3], self.SCALAR_OP_TYPE.SUB)
                case "AND":
                    self.scalar_op(decoded_instr[1], decoded_instr[2], decoded_instr[3], self.SCALAR_OP_TYPE.AND)
                case "OR":
                    self.scalar_op(decoded_instr[1], decoded_instr[2], decoded_instr[3], self.SCALAR_OP_TYPE.OR)
                case "XOR":
                    self.scalar_op(decoded_instr[1], decoded_instr[2], decoded_instr[3], self.SCALAR_OP_TYPE.XOR)
                case "SLL":
                    self.scalar_op(decoded_instr[1], decoded_instr[2], decoded_instr[3], self.SCALAR_OP_TYPE.SLL)
                case "SRL":
                    self.scalar_op(decoded_instr[1], decoded_instr[2], decoded_instr[3], self.SCALAR_OP_TYPE.SRL)
                case "SRA":
                    self.scalar_op(decoded_instr[1], decoded_instr[2], decoded_instr[3], self.SCALAR_OP_TYPE.SRA)
                case "BEQ":
                    self.branch(decoded_instr[1], decoded_instr[2], decoded_instr[3], self.BRANCH_TYPE.EQ)
                    continue
                case "BNE":
                    self.branch(decoded_instr[1], decoded_instr[2], decoded_instr[3], self.BRANCH_TYPE.NE)
                    continue
                case "BGT":
                    self.branch(decoded_instr[1], decoded_instr[2], decoded_instr[3], self.BRANCH_TYPE.GT)
                    continue
                case "BLT":
                    self.branch(decoded_instr[1], decoded_instr[2], decoded_instr[3], self.BRANCH_TYPE.LT)
                    continue
                case "BGE":
                    self.branch(decoded_instr[1], decoded_instr[2], decoded_instr[3], self.BRANCH_TYPE.GE)
                    continue
                case "BLE":
                    self.branch(decoded_instr[1], decoded_instr[2], decoded_instr[3], self.BRANCH_TYPE.LE)
                    continue
                case "UNPACKLO":
                    self.UNPACKLO(decoded_instr[1], decoded_instr[2], decoded_instr[3])
                case "UNPACKHI":
                    self.UNPACKHI(decoded_instr[1], decoded_instr[2], decoded_instr[3])
                case "PACKLO":
                    self.PACKLO(decoded_instr[1], decoded_instr[2], decoded_instr[3])
                case "PACKHI":
                    self.PACKHI(decoded_instr[1], decoded_instr[2], decoded_instr[3])
                case "HALT":
                    break
                case _:
                    raise IOError('Invalid instruction')
            # update PC
            # skipped for branch instructions
            self.pc += 1

    def dumpregs(self, iodir):
        for rf in self.RFs.values():
            rf.dump(iodir)

    def update_len_reg(self, val):
        if val < 0 or val >= self.MVL:
            raise ValueError('invalid length register val')
        self.len_reg = val

    # Instruction 1 and 3
    def ___VV(self, vr1_idx, vr2_idx, vr3_idx, op):
        vr2 = self.RFs['VRF'].Read(vr2_idx)
        vr3 = self.RFs['VRF'].Read(vr3_idx)
        
        # Q: not sure if we write zeros or retain?
        match op:
            case self.VECTOR_OP_TYPE.ADD:
                for i in range(self.len_reg):
                    self.RFs['VRF'].write_vec_element(vr1_idx, i, vr2[i] + vr3[i])
            case self.VECTOR_OP_TYPE.SUB:
                for i in range(self.len_reg):
                    self.RFs['VRF'].write_vec_element(vr1_idx, i, vr2[i] - vr3[i])
            case self.VECTOR_OP_TYPE.MUL:
                for i in range(self.len_reg):
                    self.RFs['VRF'].write_vec_element(vr1_idx, i, vr2[i] * vr3[i])
            case self.VECTOR_OP_TYPE.DIV:
                for i in range(self.len_reg):
                    self.RFs['VRF'].write_vec_element(vr1_idx, i, vr2[i] / vr3[i])
            case _:
                raise ValueError("invalid VV op")
    
        # Instruction 1 and 3
    def ___VS(self, vr1_idx, vr2_idx, sr1_idx, op):
        vr2 = self.RFs['VRF'].Read(vr2_idx)
        sr1 = self.RFs['SRF'].Read(sr1_idx)
        
        match op:
            case self.VECTOR_OP_TYPE.ADD:
                for i in range(self.len_reg):
                    self.RFs['VRF'].write_vec_element(vr1_idx, i, vr2[i] + sr1)
                    # vr1[i] = vr2[i] + sr1
            case self.VECTOR_OP_TYPE.SUB:
                for i in range(self.len_reg):
                    self.RFs['VRF'].write_vec_element(vr1_idx, i, vr2[i] - sr1)
            case self.VECTOR_OP_TYPE.MUL:
                for i in range(self.len_reg):
                    self.RFs['VRF'].write_vec_element(vr1_idx, i, vr2[i] * sr1)
            case self.VECTOR_OP_TYPE.DIV:
                for i in range(self.len_reg):
                    self.RFs['VRF'].write_vec_element(vr1_idx, i, vr2[i] / sr1)
            case _:
                raise ValueError("invalid VS op")
    
    # Vector Mask Operations
    # Instruction 5
    def S__VV(self, vr1_idx, vr2_idx, op):
        mask = 1
        vr1 = self.RFs['VRF'].Read(vr1_idx)
        vr2 = self.RFs['VRF'].Read(vr2_idx)
        mask_reg = 0
        if len(vr1) != len(vr2):
            raise ValueError("invalid vector length")
        
        match op:
            case self.BRANCH_TYPE.EQ:
                for i in enumerate(vr1):
                    if vr1[i] == vr2[i]:
                        mask_reg |= mask
                    mask = mask << 1
            case self.BRANCH_TYPE.NE:
                for i in enumerate(vr1):
                    if vr1[i] != vr2[i]:
                        mask_reg |= mask
                    mask = mask << 1
            case self.BRANCH_TYPE.GT:
                for i in enumerate(vr1):
                    if vr1[i] > vr2[i]:
                        mask_reg |= mask
                    mask = mask << 1
            case self.BRANCH_TYPE.LT:
                for i in enumerate(vr1):
                    if vr1[i] < vr2[i]:
                        mask_reg |= mask
                    mask = mask << 1
            case self.BRANCH_TYPE.GE:
                for i in enumerate(vr1):
                    if vr1[i] >= vr2[i]:
                        mask_reg |= mask
                    mask = mask << 1
            case self.BRANCH_TYPE.LE:
                for i in enumerate(vr1):
                    if vr1[i] <= vr2[i]:
                        mask_reg |= mask
                    mask = mask << 1
            case _:
                raise ValueError("invalid vv branch type")
        self.mask_reg = mask_reg

    # Instruction 6
    def S__VS(self, vr1_idx, sr1_idx, op):
        mask = 1
        vr1 = self.RFs['VRF'].Read(vr1_idx)
        sr1 = self.RFs['SRF'].Read(sr1_idx)
        mask_reg = 0
        
        match op:
            case self.BRANCH_TYPE.EQ:
                for i in enumerate(vr1):
                    if vr1[i] == sr1:
                        mask_reg |= mask
                    mask = mask << 1
            case self.BRANCH_TYPE.NE:
                for i in enumerate(vr1):
                    if vr1[i] != sr1:
                        mask_reg |= mask
                    mask = mask << 1
            case self.BRANCH_TYPE.GT:
                for i in enumerate(vr1):
                    if vr1[i] > sr1:
                        mask_reg |= mask
                    mask = mask << 1
            case self.BRANCH_TYPE.LT:
                for i in enumerate(vr1):
                    if vr1[i] < sr1:
                        mask_reg |= mask
                    mask = mask << 1
            case self.BRANCH_TYPE.GE:
                for i in enumerate(vr1):
                    if vr1[i] >= sr1:
                        mask_reg |= mask
                    mask = mask << 1
            case self.BRANCH_TYPE.LE:
                for i in enumerate(vr1):
                    if vr1[i] <= sr1:
                        mask_reg |= mask
                    mask = mask << 1
            case _:
                raise ValueError("invalid vs branch type")
        self.mask_reg = mask_reg
    
    # Instruction 7
    def CVM(self):
        self.mask_reg = 0xffffffff_ffffffff
    
    # Instruction 8
    def POP(self, sr1_idx):
        cnt = 0
        curr = self.mask_reg
        # check the lsb and shift left until all 64 bits have been checked
        for _ in range(self.MVL):
            if curr % 2 != 0:
                cnt += 1
            curr = curr >> 1
        self.RFs['SRF'].Write(sr1_idx, cnt)
        
    # Vector Length Register Operations
    # Instruction 9
    def MTCL(self, sr1_idx):
        self.update_len_reg(self.RFs['SRF'].Read(sr1_idx))
        
    # Instruction 10
    def MFCL(self, sr1_idx):
        self.RFs['SRF'].Write(sr1_idx, self.len_reg)
    
    # Memory Access Operations
    # Instruction 11
    def LV(self, vr1_idx, sr1_idx):
        sr1 = self.RFs['SRF'].Read(sr1_idx)
        for i in range(self.len_reg):
            val = self.VDMEM.Read(sr1 + i)
            self.RFs['VRF'].write_vec_element(vr1_idx, i, val)

    # Instruction 12
    def SV(self, vr1_idx, sr1_idx):
        vr1 = self.RFs['VRF'].Read(vr1_idx)
        sr1 = self.RFs['SRF'].Read(sr1_idx)
        for i in range(self.len_reg):
            self.VDMEM.Write(sr1+i, vr1[i])
        
    # Instruction 13
    # stride applies to both mem read and vrf write?
    def LVWS(self, vr1_idx, sr1_idx, sr2_idx):
        sr1 = self.RFs['SRF'].Read(sr1_idx)
        sr2 = self.RFs['SRF'].Read(sr2_idx)
        for i in range(self.len_reg):
            val = self.VDMEM.Read(sr1 + i * sr2)
            self.RFs['VRF'].write_vec_element(vr1_idx, i, val)
        
    # Instruction 14
    def SVWS(self, vr1_idx, sr1_idx, sr2_idx):
        vr1 = self.RFs['VRF'].Read(vr1_idx)
        sr1 = self.RFs['SRF'].Read(sr1_idx)
        sr2 = self.RFs['SRF'].Read(sr2_idx)
        for i in range(self.len_reg):
            self.VDMEM.Write(sr1 + i*sr2, vr1[i])
    
    # Instruction 15
    def LVI(self, vr1_idx, sr1_idx, vr2_idx):
        sr1 = self.RFs['SRF'].Read(sr1_idx)
        vr2 = self.RFs['VRF'].Read(vr2_idx)
        
        # vr1[i] = VDMEM[sr1 + vr2[i]]
        for i in range(self.len_reg):
            val = self.VDMEM.Read(sr1 + vr2[i])
            self.RFs['VRF'].write_vec_element(vr1_idx, i, val)
    
    # Instruction 16
    def SVI(self, vr1_idx, sr1_idx, vr2_idx):
        vr1 = self.RFs['VRF'].Read(vr1_idx)
        sr1 = self.RFs['SRF'].Read(sr1_idx)
        vr2 = self.RFs['VRF'].Read(vr2_idx)
        
        # VDMEM[sr1 + vr2[i]] = vr1[i]
        for i in range(self.len_reg):
            self.VDMEM.Write(sr1 + vr2[i], vr1[i])
    
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
    def scalar_op(self, sr3_idx, sr1_idx, sr2_idx, op):
        src1 = self.RFs['SRF'].Read(sr1_idx)
        src2 = self.RFs['SRF'].Read(sr2_idx)
        match op:
            case self.SCALAR_OP_TYPE.ADD:
                self.RFs['SRF'].Write(sr3_idx, src1 + src2)
            case self.SCALAR_OP_TYPE.SUB:
                self.RFs['SRF'].Write(sr3_idx, src1 - src2)
            case self.SCALAR_OP_TYPE.AND:
                self.RFs['SRF'].Write(sr3_idx, src1 & src2)
            case self.SCALAR_OP_TYPE.OR:
                self.RFs['SRF'].Write(sr3_idx, src1 | src2)
            case self.SCALAR_OP_TYPE.XOR:
                self.RFs['SRF'].Write(sr3_idx, src1 ^ src2)
            case self.SCALAR_OP_TYPE.SRL:
                self.RFs['SRF'].Write(sr3_idx, src1 >> src2)
            case self.SCALAR_OP_TYPE.SLL:
                self.RFs['SRF'].Write(sr3_idx, src1 << src2)
            case self.SCALAR_OP_TYPE.SRA:
                tmp = ((src1 >> src2) | ((src1 << (32 - src2)) & 0xffff_ffff))
                self.RFs['SRF'].Write(sr3_idx, tmp)
            case _:
                raise ValueError('invalid scalar op enum')

    # scalar branches
    # Instruction 23
    def branch(self, sr1_idx, sr2_idx, imm, op):
        src1 = self.RFs['SRF'].Read(sr1_idx)
        src2 = self.RFs['SRF'].Read(sr2_idx)
        imm = int(imm)
        
        if imm > 2**20 or imm < -(2**20):
            raise ValueError('invalid branch immediate')
        
        # Q: do we consider an instruction 4 bytes (divide imm by 4)?
        match op:
            case self.BRANCH_TYPE.EQ:
                if src1 == src2:
                    self.pc = self.pc + imm
            case self.BRANCH_TYPE.NE:
                if src1 != src2:
                    self.pc = self.pc + imm
            case self.BRANCH_TYPE.GT:
                if src1 > src2:
                    self.pc = self.pc + imm
            case self.BRANCH_TYPE.LT:
                if src1 < src2:
                    self.pc = self.pc + imm
            case self.BRANCH_TYPE.GE:
                if src1 >= src2:
                    self.pc = self.pc + imm
            case self.BRANCH_TYPE.LE:
                if src1 <= src2:
                    self.pc = self.pc + imm
            case _:
                raise ValueError("invalid branch type")
    
    # Instruction 24
    def UNPACKLO(self, vr1_idx, vr2_idx, vr3_idx):
        vr2 = self.RFs['VRF'].Read(vr2_idx)
        vr3 = self.RFs['VRF'].Read(vr3_idx)

        for i in range(self.MVL/2):
            self.RFs['VRF'].write_vec_element(vr1_idx, i*2, vr2[i])
            self.RFs['VRF'].write_vec_element(vr1_idx, i*2+1, vr3[i])
    
    # Instruction 25
    def UNPACKHI(self, vr1_idx, vr2_idx, vr3_idx):
        vr2 = self.RFs['VRF'].Read(vr2_idx)
        vr3 = self.RFs['VRF'].Read(vr3_idx)
        
        for i in range(self.MVL/2):
            self.RFs['VRF'].write_vec_element(vr1_idx, i*2, vr2[i + self.MVL/2])
            self.RFs['VRF'].write_vec_element(vr1_idx, i*2+1, vr3[i + self.MVL/2])
    
    # Instruction 26
    def PACKLO(self, vr1_idx, vr2_idx, vr3_idx):
        vr2 = self.RFs['VRF'].Read(vr2_idx)
        vr3 = self.RFs['VRF'].Read(vr3_idx)
        
        for i in range(self.MVL/2):
            self.RFs['VRF'].write_vec_element(vr1_idx, i, vr2[i*2])
            self.RFs['VRF'].write_vec_element(vr1_idx, i + self.MVL/2, vr3[i*2])
    
    # Instruction 27
    def PACKHI(self, vr1_idx, vr2_idx, vr3_idx):
        vr2 = self.RFs['VRF'].Read(vr2_idx)
        vr3 = self.RFs['VRF'].Read(vr3_idx)

        for i in range(self.MVL/2):
            self.RFs['VRF'].write_vec_element(vr1_idx, i, vr2[i*2 + 1])
            self.RFs['VRF'].write_vec_element(vr1_idx, i + self.MVL/2, vr3[i*2 + 1])


if __name__ == "__main__":
    # parse arguments for input file location
    parser = argparse.ArgumentParser(description='Vector Core Performance Model')
    parser.add_argument('--iodir', default="", type=str, help='Path to the folder containing the input files - instructions and data.')
    args = parser.parse_args()

    iodir = os.path.abspath(args.iodir)
    print("IO Directory:", iodir)

    # Parse IMEM
    imem = IMEM(iodir)
    # Parse SMEM
    sdmem = DMEM("SDMEM", iodir, 13)  # 32 KB is 2^15 bytes = 2^13 K 32-bit words.
    # Parse VMEM
    vdmem = DMEM("VDMEM", iodir, 17)  # 512 KB is 2^19 bytes = 2^17 K 32-bit words.

    # Create Vector Core
    vcore = Core(imem, sdmem, vdmem)

    # Run Core
    vcore.run()
    vcore.dumpregs(iodir)

    sdmem.dump()
    vdmem.dump()
    # THE END
