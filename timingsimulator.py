import os
import argparse
from enum import IntEnum
from queue import SimpleQueue
import re

'''TODO
1.1 Modify VDMEM to be banked
1.2 Implement bank conflicts
2.  Implement controller/control logic
3.  define data to be stored in queues (depends on 2)
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


# gets created at decode stage
class Instruction(object):
    def __init__(self, instr_str) -> None:
        # parse instruction
        self.op = None
        self.operand1 = None
        # stores second operand for CI
        self.operand2 = None
        # stores address for LSI
        self.address = None
        self.dest = None


# base class for dispatch queues
class ExecQueue(object):
    def __init__(self, lanes, depth) -> None:
        self.lanes = lanes
        self.depth = depth
        self.queue = SimpleQueue()
    
    def getHead(self):
        '''returns None if the queue is empty'''
        if self.queue.empty():
            return None
        return self.queue.get(block=False)

    # TODO: what do we store in queues? define instr data type
    def addToQueue(self, instr):
        self.queue.put(instr)


class ComputeUnit(object):
    '''base class for vector compute unit (ADD,SUB,MUL,DIV)'''
    def __init__(self, latency, OP_TYPE: VECTOR_OP_TYPE) -> None:
        self.latency = latency
        self.TYPE = OP_TYPE

    def compute(self):
        '''TODO: define operands'''
        match self.TYPE:
            case VECTOR_OP_TYPE.ADD:
                return None
            case VECTOR_OP_TYPE.SUB:
                return None
            case VECTOR_OP_TYPE.MUL:
                return None
            case VECTOR_OP_TYPE.DIV:
                return None
            case _:
                # practically impossible but whatevs
                raise ValueError(f'Invalid Compute Unit Type: {self.TYPE}')


class BusyBoard(object):
    ''' DONE '''
    def __init__(self, srf_size=8, vrf_size=8) -> None:
        # vrf and srf size are ]hardcoded to a max of 8 each due to enum
        self.board = [False for _ in range(srf_size + vrf_size)]

    def setBusy(self, reg_enum):
        ''' sets the busy bit for the register 
        throws exception if already busy
        '''
        if self[reg_enum.value]:
            raise ValueError(f'register {reg_enum.name} already busy')
        self[reg_enum.value] = True

    def clear(self, reg_enum):
        ''' clears the busy bit for the register 
        throws exception if already free
        '''
        if not self[reg_enum.value]:
            raise ValueError(f'register {reg_enum.name} already free')
        self[reg_enum.value] = False

    def isBusy(self, reg_enum):
        ''' returns True if the register is busy '''
        return self.board[reg_enum.value]
    
        
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
        self.data_queue = ExecQueue(config['numLanes'], config['dataQueueDepth'])
        self.compute_queue = ExecQueue(config['numLanes'], config['computeQueueDepth'])
        self.re_pattern = re.compile("(?:^(?P<instruction>\w+)(?:[ ]+(?P<operand1>\w+))?(?:[ ]+(?P<operand2>\w+))?(?:[ ]+(?P<operand3>[-\w]+))?[ ]*(?P<inline_comment>#.*)?$)|(?:^(?P<comment_line>[ ]*?#.*)$)|(?P<empty_line>^(?<!.)$|(?:^[ ]+$)$)")
        self.cycle_count = 0

    def parseInstr(self, instr: str):
        # TODO
        return None

    def update_len_reg(self, val):
        if val < 0 or val > self.MVL:
            raise ValueError('invalid length register val')
        self.len_reg = val

    def run(self):
        while(True):
            # IF stage
            instr = self.IMEM.Read(self.pc)
            
            # ID stage
            
            # EX stage (backend)
            
            
            break # Replace this line with your code.

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
                self.RFs['SRF'].Write(sr3_idx, (src1 & 0xffff_ffff) >> src2)
            case self.SCALAR_OP_TYPE.SLL:
                self.RFs['SRF'].Write(sr3_idx, src1 << src2)
            case self.SCALAR_OP_TYPE.SRA:
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
