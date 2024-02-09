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
            # print("IMEM - Instructions:", self.instructions)
        except Exception as e:
            print("IMEM - ERROR: Couldn't open file in path:", self.filepath)
            print("Exception: ", e)

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
            print("Exception: ", e)

    def checkIdx(self, idx):
        if idx < 0 or idx >= self.size:
            raise ValueError('invalid DMEM index')
    
    def checkVal(self, val):
        if val < self.min_value or val > self.max_value:
            raise ValueError('invalid register write value')
    
    # this can only service word reads, not vector reads
    # TODO: implement vector read later?
    def Read(self, idx): # Use this to read from DMEM.
        self.checkIdx(idx)
        return self.instructions[idx]

    # this can only service word writes, not vector writes
    # TODO: implement vector write later?
    def Write(self, idx, val): # Use this to write into DMEM.
        self.checkIdx(idx)
        self.checkVal(val)
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

    def checkIdx(self, idx):
        if idx < 0 or idx >= self.reg_count:
            raise ValueError('invalid register index')
    
    # assuming that val is list for vector register
    # and any other type for scalar register
    def checkVal(self, val):
        if type(val) is list:
            for element in val:
                if element < self.min_value or element > self.max_value:
                    raise ValueError('invalid register write value')
        else:
            if val < self.min_value or val > self.max_value:
                raise ValueError('invalid register write value')
        
    def Read(self, idx):
        self.checkIdx(idx)
        if self.name == 'SRF':
            return self.registers[idx][0]
        else:
            return self.registers[idx]

    def Write(self, idx, val):
        self.checkIdx(idx)
        self.checkVal(val)
        if self.name == 'SRF':
            self.registers[idx][0] = val & 0xffff_ffff  # ensure it is 32-bits
        else:
            self.registers[idx] = val

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
    def __init__(self, imem, sdmem, vdmem):
        self.IMEM = imem
        self.SDMEM = sdmem
        self.VDMEM = vdmem

        self.RFs = {"SRF": RegisterFile("SRF", 8),
                    "VRF": RegisterFile("VRF", 8, 64)}
        
        # Your code here.
        self.mask_reg = 0x0
        self.len_reg = 0x0
        self.pc = 0x0
        
    class VECTOR_OP_TYPE(IntEnum):
        ADD = 1
        SUB = 2
        MUL = 3
        DIV = 4
        
    class SCALAR_OP_TYPE(IntEnum):
        ADD = 1
        SUB = 2
        AND = 3
        OR  = 4
        XOR = 5
        SRL = 6
        SLL = 7
        SRA = 8

    class BRANCH_TYPE(IntEnum):
        EQ = 1
        NE = 2
        GT = 3
        LT = 4
        GE = 5
        LE = 6

    def run(self):
        while (True):
            # TODO
            # fetch
            # execute
            # match...
            # case HALT:
            #     break
            # update pc
            break # Replace this line with your code.

    def dumpregs(self, iodir):
        for rf in self.RFs.values():
            rf.dump(iodir)

    def update_len_reg(self, val):
        if val < 0 or val >= 64:
            raise ValueError('invalid length register val')
        self.len_reg = val & 0xffff_ffff    # ensure it is 32-bits
    
    # Instruction 1 and 3
    def ___VV(self, vr1_idx, vr2_idx, vr3_idx, op):
        src1 = self.RFs['VRF'].Read(vr2_idx)
        src2 = self.RFs['VRF'].Read(vr3_idx)
        res = self.RFs['VRF'].Read(vr1_idx)[:]
        
        # not sure if we can just write zeros?
        match op:
            case self.VECTOR_OP_TYPE.ADD:
                for i in range(self.len_reg):
                    res[i] = src2[i] + src1[i]
            case self.VECTOR_OP_TYPE.SUB:
                for i in range(self.len_reg):
                    res[i] = src1[i] - src2[i]
            case self.VECTOR_OP_TYPE.MUL:
                for i in range(self.len_reg):
                    res[i] = src1[i] * src2[i]
            case self.VECTOR_OP_TYPE.DIV:
                for i in range(self.len_reg):
                    res[i] = src1[i] / src2[i]
            case _:
                raise ValueError("invalid VV op")
            
        self.RFs['VRF'].Write(vr1_idx, res)
    
        # Instruction 1 and 3
    def ___VS(self, vr1_idx, vr2_idx, sr1_idx, op):
        sclr_src = self.RFs['SRF'].Read(sr1_idx)
        vtr_src = self.RFs['VRF'].Read(vr2_idx)
        vtr_res = self.RFs['VRF'].Read(vr1_idx)[:]
        
        # not sure if we can just write zeros?
        match op:
            case self.VECTOR_OP_TYPE.ADD:
                for i in range(self.len_reg):
                    vtr_res[i] = vtr_src[i] + sclr_src
            case self.VECTOR_OP_TYPE.SUB:
                for i in range(self.len_reg):
                    vtr_res[i] = vtr_src[i] - sclr_src
            case self.VECTOR_OP_TYPE.MUL:
                for i in range(self.len_reg):
                    vtr_res[i] = vtr_src[i] * sclr_src
            case self.VECTOR_OP_TYPE.DIV:
                for i in range(self.len_reg):
                    vtr_res[i] = vtr_src[i] / sclr_src
            case _:
                raise ValueError("invalid VS op")
        
        self.RFs['VRF'].Write(vr1_idx, vtr_res)
    
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
        for _ in range(64):
            if curr % 2 != 0:
                cnt += 1
            curr = curr >> 1
        self.RFs['SRF'].Write(curr)
        
    # Vector Length Register Operations
    # Instruction 9
    def MTCL(self, idx):
        self.update_len_reg(self.RFs['SRF'].Read(idx))
        
    # Instruction 10
    def MFCL(self, idx):
        self.RFs['SRF'].Write(idx, self.len_reg)
    
    # Memory Access Operations
    # Instruction 11
    def LV(self, vr1_idx, sr1_idx):
        pass
    
    # Instruction 12
    def SV(self, vr1_idx, sr1_idx):
        pass
    
    # Instruction 13
    def LVWS(self, vr1_idx, sr1_idx, sr2_idx):
        pass
    
    # Instruction 14
    def SVWS(self, vr1_idx, sr1_idx, sr2_idx):
        pass
    
    # Instruction 15
    def LVI(self, vr1_idx, sr1_idx, sr2_idx):
        pass
    
    # Instruction 16
    def SVI(self, vr1_idx, sr1_idx, sr2_idx):
        pass
    
    # Instruction 17
    def LS(self, sr1_idx, sr2_idx, imm):
        pass
    
    # Instruction 18
    def SS(self, sr1_idx, sr2_idx, imm):
        pass
    
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
                pass    # TODO
            case _:
                raise ValueError('invalid scalar op enum')

    # scalar branches
    # Instruction 23
    def branch(self, sr1_idx, sr2_idx, op, imm):
        # src1 = self.RFs['SRF'].Read(sr1_idx)
        # src2 = self.RFs['SRF'].Read(sr2_idx)
        # match
        pass
    
    # Instruction 24
    def UNPACKLO(self, vr1_idx, vr2_idx, vr3_idx):
        pass
    
    # Instruction 25
    def UNPACKHI(self, vr1_idx, vr2_idx, vr3_idx):
        pass
    
    # Instruction 26
    def PACKLO(self, vr1_idx, vr2_idx, vr3_idx):
        pass
    
    # Instruction 27
    def PACKHI(self, vr1_idx, vr2_idx, vr3_idx):
        pass


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
