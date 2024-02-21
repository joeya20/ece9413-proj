import unittest
import tempfile
import pathlib
from simulator import Core, IMEM, DMEM


class TestCore(unittest.TestCase):
    def setUp(self):
        # create tmp dir and IO files inside
        self.tmpdir = tempfile.TemporaryDirectory()
        with open(pathlib.Path(self.tmpdir.name, 'SDMEM.txt'), 'w') as ofile:
            ofile.writelines(
                [str(i) for i in range(64)]
            )
        with open(pathlib.Path(self.tmpdir.name, 'VDMEM.txt'), 'w') as ofile:
            ofile.writelines(
                [str(i) for i in range(64)]
            )
        with open(pathlib.Path(self.tmpdir.name, 'Code.asm'), 'w') as ofile:
            pass
        
        self.core = Core(IMEM(self.tmpdir.name), DMEM('SDMEM', self.tmpdir.name, 13), DMEM("VDMEM", self.tmpdir.name, 17))

    def tearDown(self):
        self.tmpdir.cleanup()

    def test_addvv(self):
        self.core.IMEM.instructions = ['ADDVV VR2 VR1 VR0', 'HALT']
        self.core.RFs['VRF'].registers[0] = [i for i in range(64)]
        self.core.RFs['VRF'].registers[1] = [i*2 for i in range(64)]
        self.core.run()
        
        self.assertEqual([i + i*2 for i in range(64)], self.core.RFs['VRF'].registers[2])

    def test_subvv(self):
        self.core.IMEM.instructions = ['SUBVV VR2 VR1 VR0', 'HALT']
        self.core.RFs['VRF'].registers[0] = [i for i in range(64)]
        self.core.RFs['VRF'].registers[1] = [i*2 for i in range(64)]
        self.core.run()
        
        self.assertEqual([i*2 - i for i in range(64)], self.core.RFs['VRF'].registers[2])
    
    def test_addvs(self):
        self.core.IMEM.instructions = ['ADDVS VR2 VR1 SR1', 'HALT']
        self.core.RFs['VRF'].registers[1] = [i*2 for i in range(64)]
        self.core.RFs['SRF'].registers[1] = [63]
        self.core.run()
        
        self.assertEqual([i*2 + 63 for i in range(64)], self.core.RFs['VRF'].registers[2])
    
    def test_subvs(self):
        self.core.IMEM.instructions = ['SUBVS VR2 VR1 SR1', 'HALT']
        self.core.RFs['VRF'].registers[1] = [i*2 for i in range(64)]
        self.core.RFs['SRF'].registers[1] = [63]
        self.core.run()
        
        self.assertEqual([i*2 - 63 for i in range(64)], self.core.RFs['VRF'].registers[2])
        
    def test_mulvv(self):
        self.core.IMEM.instructions = ['MULVV VR2 VR1 VR0', 'HALT']
        self.core.RFs['VRF'].registers[0] = [i for i in range(64)]
        self.core.RFs['VRF'].registers[1] = [i*2 for i in range(64)]
        self.core.run()
        
        self.assertEqual([i*2 * i for i in range(64)], self.core.RFs['VRF'].registers[2])
        
    def test_divvv(self):
        self.core.IMEM.instructions = ['DIVVV VR2 VR1 VR0', 'HALT']
        self.core.RFs['VRF'].registers[0] = [i for i in range(1, 65)]
        self.core.RFs['VRF'].registers[1] = [i*2 for i in range(1, 65)]
        self.core.run()
        
        self.assertEqual([i*2 / i for i in range(1, 65)], self.core.RFs['VRF'].registers[2])
    
    def test_mulvs(self):
        self.core.IMEM.instructions = ['MULVS VR2 VR1 SR1', 'HALT']
        self.core.RFs['VRF'].registers[1] = [i for i in range(64)]
        self.core.RFs['SRF'].registers[1] = [2]
        self.core.run()
        
        self.assertEqual([i*2 for i in range(64)], self.core.RFs['VRF'].registers[2])
        
    def test_divvs(self):
        self.core.IMEM.instructions = ['DIVVS VR2 VR1 SR1', 'HALT']
        self.core.RFs['VRF'].registers[1] = [i for i in range(64)]
        self.core.RFs['SRF'].registers[1] = [2]
        self.core.run()
        
        self.assertEqual([i // 2 for i in range(64)], self.core.RFs['VRF'].registers[2])

    def test_SEQVV(self):
        self.core.IMEM.instructions = ['SEQVV VR1 VR0', 'HALT']
        self.core.RFs['VRF'].registers[0] = [i for i in range(64)]
        self.core.RFs['VRF'].registers[1][:32] = self.core.RFs['VRF'].registers[0][:32]
        self.core.RFs['VRF'].registers[1][32:] = [0] * 32
        self.core.run()
        
        self.assertEqual(([True] * 32) + ([False] * 32), self.core.mask_reg)
    
    def test_SNEVV(self):
        self.core.IMEM.instructions = ['SNEVV VR1 VR0', 'HALT']
        self.core.RFs['VRF'].registers[0] = [i for i in range(64)]
        self.core.RFs['VRF'].registers[1][:32] = self.core.RFs['VRF'].registers[0][:32]
        self.core.RFs['VRF'].registers[1][32:] = [0] * 32
        self.core.run()
        
        self.assertEqual(([False] * 32) + ([True] * 32), self.core.mask_reg)
    
    def test_SGTVV(self):
        self.core.IMEM.instructions = ['SGTVV VR1 VR0', 'HALT']
        self.core.RFs['VRF'].registers[0] = [i for i in range(64)]
        self.core.RFs['VRF'].registers[1][:32] = [i+1 for i in range(32)]
        self.core.RFs['VRF'].registers[1][32:] = [0] * 32
        self.core.run()
        
        self.assertEqual(([True] * 32) + ([False] * 32), self.core.mask_reg)
    
    def test_SLTVV(self):
        self.core.IMEM.instructions = ['SLTVV VR1 VR0', 'HALT']
        self.core.RFs['VRF'].registers[0] = [i for i in range(64)]
        self.core.RFs['VRF'].registers[1][:32] = [i+1 for i in range(32)]
        self.core.RFs['VRF'].registers[1][32:] = [0] * 32
        self.core.run()
        
        self.assertEqual(([False] * 32) + ([True] * 32), self.core.mask_reg)
    
    def test_SGEVV(self):
        self.core.IMEM.instructions = ['SGEVV VR1 VR0', 'HALT']
        self.core.RFs['VRF'].registers[0] = [i for i in range(64)]
        self.core.RFs['VRF'].registers[1][:16] = [i for i in range(16)]
        self.core.RFs['VRF'].registers[1][16:48] = [i+1 for i in range(16, 48)]
        self.core.RFs['VRF'].registers[1][48:] = [0] * 16
        self.core.run()
        
        self.assertEqual(([True] * 48) + ([False] * 16), self.core.mask_reg)
    
    def test_SLEVV(self):
        self.core.IMEM.instructions = ['SLEVV VR1 VR0', 'HALT']
        self.core.RFs['VRF'].registers[0] = [i for i in range(64)]
        self.core.RFs['VRF'].registers[1][:16] = [i for i in range(16)]
        self.core.RFs['VRF'].registers[1][16:48] = [i+1 for i in range(16, 48)]
        self.core.RFs['VRF'].registers[1][48:] = [0] * 16
        self.core.run()
        
        self.assertEqual(([True] * 16) + ([False] * 32)  + ([True] * 16), self.core.mask_reg)
    
    def test_SEQVS(self):
        self.core.IMEM.instructions = ['SEQVS VR1 SR1', 'HALT']
        self.core.RFs['VRF'].registers[1] = [i for i in range(64)]
        self.core.RFs['SRF'].registers[1] = [32]
        self.core.run()
        
        expected = [False] * 64
        expected[32] = True
        self.assertEqual(expected, self.core.mask_reg)
    
    def test_SNEVS(self):
        self.core.IMEM.instructions = ['SNEVS VR1 SR1', 'HALT']
        self.core.RFs['VRF'].registers[1] = [i for i in range(64)]
        self.core.RFs['SRF'].registers[1] = [32]
        self.core.run()
        
        expected = [True] * 64
        expected[32] = False
        self.assertEqual(expected, self.core.mask_reg)
    
    def test_SGTVS(self):
        self.core.IMEM.instructions = ['SGTVS VR1 SR1', 'HALT']
        self.core.RFs['VRF'].registers[1] = [i for i in range(64)]
        self.core.RFs['SRF'].registers[1] = [32]
        self.core.run()
        
        expected = ([False] * 33) + ([True] * 31)
        self.assertEqual(expected, self.core.mask_reg)
        
    def test_SLTVS(self):
        self.core.IMEM.instructions = ['SLTVS VR1 SR1', 'HALT']
        self.core.RFs['VRF'].registers[1] = [i for i in range(64)]
        self.core.RFs['SRF'].registers[1] = [32]
        self.core.run()

        expected = ([True] * 32) + ([False] * 32)
        self.assertEqual(expected, self.core.mask_reg)
    
    def test_SLEVS(self):
        self.core.IMEM.instructions = ['SLEVS VR1 SR1', 'HALT']
        self.core.RFs['VRF'].registers[1] = [i for i in range(64)]
        self.core.RFs['SRF'].registers[1] = [32]
        self.core.run()
        
        expected = ([True] * 33) + ([False] * 31)
        
        self.assertEqual(expected, self.core.mask_reg)
        
    def test_SGEVS(self):
        self.core.IMEM.instructions = ['SGEVS VR1 SR1', 'HALT']
        self.core.RFs['VRF'].registers[1] = [i for i in range(64)]
        self.core.RFs['SRF'].registers[1] = [32]
        self.core.run()
        
        expected = ([False] * 32) + ([True] * 32)
        
        self.assertEqual(expected, self.core.mask_reg)

    def test_CVM(self):
        self.core.IMEM.instructions = ['CVM', 'HALT']
        self.core.run()
        
        self.assertEqual([True] * 64, self.core.mask_reg)
        
    def test_POP(self):
        self.core.IMEM.instructions = ['SNEVS VR1 SR1', 'POP SR2', 'CVM', 'POP SR3', 'HALT']
        self.core.RFs['VRF'].registers[1] = [i for i in range(64)]
        self.core.RFs['SRF'].registers[1] = [32]
        self.core.run()
        
        self.assertEqual(63, self.core.RFs['SRF'].Read('SR2'))
        self.assertEqual(64, self.core.RFs['SRF'].Read('SR3'))

    def test_MTCL(self):
        self.core.IMEM.instructions = ['MTCL SR1', 'HALT']
        self.core.RFs['SRF'].registers[1] = [32]
        self.core.run()
        
        self.assertEqual(32, self.core.len_reg)
    
    def test_MFCL(self):
        self.assertEqual(64, self.core.len_reg)
        self.core.IMEM.instructions = ['MFCL SR1', 'HALT']
        self.core.run()
        
        self.assertEqual(64, self.core.RFs['SRF'].Read('SR1'))
    
    def test_LV(self):
        golden = [i for i in range(128)]
        self.core.IMEM.instructions = ['LV VR1 SR1', 'HALT']
        self.core.RFs['SRF'].Write('SR1', 32)
        self.core.VDMEM.data = golden
        self.core.run()

        self.assertEqual(golden[32:96], self.core.RFs['VRF'].Read('VR1'))
        
    def test_SV(self):
        golden = [i+1 for i in range(64)]
        self.core.IMEM.instructions = ['SV VR1 SR1', 'HALT']
        self.core.RFs['SRF'].Write('SR1', 32)
        self.core.RFs['VRF'].Write('VR1', golden)
        self.core.run()

        self.assertEqual(golden, self.core.VDMEM.data[32:96])
    
    def test_LVWS(self):
        golden = [i for i in range(128)]
        self.core.IMEM.instructions = ['LVWS VR1 SR1 SR2', 'HALT']
        self.core.RFs['SRF'].Write('SR1', 0)
        self.core.RFs['SRF'].Write('SR2', 2)
        self.core.VDMEM.data = golden
        self.core.run()

        self.assertEqual(golden[::2], self.core.RFs['VRF'].Read('VR1'))
        
    def test_SVWS(self):
        golden = [i+1 for i in range(64)]
        self.core.IMEM.instructions = ['SVWS VR1 SR1 SR2', 'HALT']
        self.core.RFs['SRF'].Write('SR1', 0)
        self.core.RFs['SRF'].Write('SR2', 2)
        self.core.RFs['VRF'].Write('VR1', golden)
        self.core.run()

        self.assertEqual(golden, self.core.VDMEM.data[:128:2])
    
    def test_LVI(self):
        golden = [i for i in range(512)]
        offset = [i*3 for i in range(64)]
        self.core.IMEM.instructions = ['LVI VR1 SR1 VR2', 'HALT']
        self.core.RFs['SRF'].Write('SR1', 32)
        self.core.RFs['VRF'].Write('VR2', offset)
        self.core.VDMEM.data = golden
        self.core.run()

        self.assertEqual(golden[32:32+64*3:3], self.core.RFs['VRF'].Read('VR1'))
    
    def test_SVI(self):
        golden = [i+1 for i in range(64)]
        offset = [i*4 for i in range(64)]
        self.core.IMEM.instructions = ['SVI VR1 SR1 VR2', 'HALT']
        self.core.RFs['SRF'].Write('SR1', 32)
        self.core.RFs['VRF'].Write('VR1', golden)
        self.core.RFs['VRF'].Write('VR2', offset)
        self.core.run()

        self.assertEqual(golden, self.core.VDMEM.data[32:64*4+32:4])
    
    def test_LS(self):
        self.core.IMEM.instructions = ['LS SR1 SR2 10', 'HALT']
        self.core.RFs['SRF'].Write('SR2', 32)
        self.core.SDMEM.data = [i for i in range(64)]
        self.core.run()
        
        self.assertEqual(42, self.core.RFs['SRF'].Read('SR1'))
    
    def test_SS(self):
        self.core.IMEM.instructions = ['SS SR1 SR2 10', 'HALT']
        self.core.RFs['SRF'].Write('SR1', 100)
        self.core.RFs['SRF'].Write('SR2', 32)
        self.core.run()
        
        self.assertEqual(100, self.core.SDMEM.data[42])
    
    def test_ADD(self):
        self.core.IMEM.instructions = ['ADD SR3 SR2 SR1', 'HALT']
        self.core.RFs['SRF'].Write('SR1', 10)
        self.core.RFs['SRF'].Write('SR2', 20)
        self.core.run()
        
        self.assertEqual(30, self.core.RFs['SRF'].Read('SR3'))
    
    def test_SUB(self):
        self.core.IMEM.instructions = ['SUB SR3 SR2 SR1', 'HALT']
        self.core.RFs['SRF'].Write('SR1', 10)
        self.core.RFs['SRF'].Write('SR2', 20)
        self.core.run()
        
        self.assertEqual(10, self.core.RFs['SRF'].Read('SR3'))
    
    def test_AND(self):
        self.core.IMEM.instructions = ['AND SR3 SR2 SR1', 'HALT']
        self.core.RFs['SRF'].Write('SR1', 0x0fff_ffff)
        self.core.RFs['SRF'].Write('SR2', 0x0101_1010)
        self.core.run()
        
        self.assertEqual(0x0101_1010, self.core.RFs['SRF'].Read('SR3'))
    
    def test_OR(self):
        self.core.IMEM.instructions = ['OR SR3 SR2 SR1', 'HALT']
        self.core.RFs['SRF'].Write('SR1', 0x0fff_ffff)
        self.core.RFs['SRF'].Write('SR2', 0x0101_1010)
        self.core.run()
        
        self.assertEqual(0x0fff_ffff, self.core.RFs['SRF'].Read('SR3'))
    
    def test_XOR(self):
        self.core.IMEM.instructions = ['XOR SR3 SR2 SR1', 'HALT']
        self.core.RFs['SRF'].Write('SR1', 0x0fff_ffff)
        self.core.RFs['SRF'].Write('SR2', 0x0101_1010)
        self.core.run()
        
        self.assertEqual(0x0efe_efef, self.core.RFs['SRF'].Read('SR3'))
        
    def test_SLL(self):
        self.core.IMEM.instructions = ['SLL SR4 SR1 SR2', 'SLL SR5 SR1 SR3', 'HALT']
        self.core.RFs['SRF'].Write('SR1', 0x0000_0001)
        self.core.RFs['SRF'].Write('SR2', 1)
        self.core.RFs['SRF'].Write('SR3', 16)
        self.core.run()
        
        self.assertEqual(0x0000_0002, self.core.RFs['SRF'].Read('SR4'))
        self.assertEqual(0x0001_0000, self.core.RFs['SRF'].Read('SR5'))
        
    def test_SRL(self):
        self.core.IMEM.instructions = ['SRL SR4 SR1 SR2', 'SRL SR5 SR1 SR3', 'HALT']
        self.core.RFs['SRF'].Write('SR1', -2147483648)  # 0x8000_0000
        self.core.RFs['SRF'].Write('SR2', 1)
        self.core.RFs['SRF'].Write('SR3', 16)
        self.core.run()
        
        self.assertEqual(0x4000_0000, self.core.RFs['SRF'].Read('SR4'))
        self.assertEqual(0x0000_8000, self.core.RFs['SRF'].Read('SR5'))
        
    def test_SRA(self):
        self.core.IMEM.instructions = ['SRA SR4 SR1 SR2', 'SRA SR5 SR1 SR3', 'HALT']
        self.core.RFs['SRF'].Write('SR1', -2147483648)  # 0x8000_0000
        self.core.RFs['SRF'].Write('SR2', 1)
        self.core.RFs['SRF'].Write('SR3', 16)
        self.core.run()
        
        self.assertEqual(-2147483648 / 2**1, self.core.RFs['SRF'].Read('SR4'))
        self.assertEqual(-2147483648 / 2**16, self.core.RFs['SRF'].Read('SR5'))
        
    def test_BEQ(self):
        self.core.IMEM.instructions = ['BEQ SR1 SR2 2', 'POP SR3', 'BEQ SR1 SR3 2', 'POP SR4', 'HALT']
        self.core.RFs['SRF'].Write('SR1', 32)
        self.core.RFs['SRF'].Write('SR2', 32)
        self.core.RFs['SRF'].Write('SR3', 10)
        self.core.run()

        self.assertEqual(self.core.RFs['SRF'].Read('SR3'), 10)
        self.assertEqual(self.core.RFs['SRF'].Read('SR4'), 64)
    
    def test_BNE(self):
        self.core.IMEM.instructions = ['BNE SR1 SR2 2', 'POP SR3', 'BNE SR1 SR3 2', 'POP SR4', 'HALT']
        self.core.RFs['SRF'].Write('SR1', 32)
        self.core.RFs['SRF'].Write('SR2', 32)
        self.core.RFs['SRF'].Write('SR4', 10)
        self.core.run()
        
        # check not taken
        self.assertEqual(self.core.RFs['SRF'].Read('SR3'), 64)
        # check taken
        self.assertEqual(self.core.RFs['SRF'].Read('SR4'), 10)
    
    def test_BGT(self):
        self.core.IMEM.instructions = ['BGT SR1 SR2 2', 'POP SR3', 'BGT SR2 SR1 2', 'POP SR4', 'HALT']
        self.core.RFs['SRF'].Write('SR1', 32)
        self.core.RFs['SRF'].Write('SR2', 42)
        self.core.RFs['SRF'].Write('SR4', 10)
        self.core.run()

        # check not taken
        self.assertEqual(self.core.RFs['SRF'].Read('SR3'), 64)
        # check taken
        self.assertEqual(self.core.RFs['SRF'].Read('SR4'), 10)
    
    def test_BLT(self):
        self.core.IMEM.instructions = ['BLT SR1 SR2 2', 'POP SR3', 'BLT SR2 SR1 2', 'POP SR4', 'HALT']
        self.core.RFs['SRF'].Write('SR1', 32)
        self.core.RFs['SRF'].Write('SR2', 42)
        self.core.RFs['SRF'].Write('SR3', 10)
        self.core.run()
        # check taken
        self.assertEqual(self.core.RFs['SRF'].Read('SR3'), 10)
        # check not taken
        self.assertEqual(self.core.RFs['SRF'].Read('SR4'), 64)
    
    def test_BGE(self):
        self.core.IMEM.instructions = ['BGE SR1 SR2 2', 'POP SR3', 'BGE SR3 SR1 2', 'POP SR4', 'BGE SR1 SR3 2', 'POP SR5', 'HALT']
        self.core.RFs['SRF'].Write('SR1', 32)
        self.core.RFs['SRF'].Write('SR2', 32)
        self.core.RFs['SRF'].Write('SR3', 10)
        self.core.RFs['SRF'].Write('SR4', 10)
        self.core.RFs['SRF'].Write('SR5', 10)
        self.core.run()

        # check taken equals
        self.assertEqual(self.core.RFs['SRF'].Read('SR3'), 10)
        
        # check not taken
        self.assertEqual(self.core.RFs['SRF'].Read('SR4'), 64)
        
        # check taken greater than
        self.assertEqual(self.core.RFs['SRF'].Read('SR5'), 10)
    
    def test_BLE(self):
        self.core.IMEM.instructions = ['BLE SR1 SR2 2', 'POP SR3', 'BLE SR3 SR1 2', 'POP SR4', 'BLE SR1 SR3 2', 'POP SR5', 'HALT']
        self.core.RFs['SRF'].Write('SR1', 32)
        self.core.RFs['SRF'].Write('SR2', 32)
        self.core.RFs['SRF'].Write('SR3', 10)
        self.core.RFs['SRF'].Write('SR4', 10)
        self.core.RFs['SRF'].Write('SR5', 10)
        self.core.run()

        # check taken equals
        self.assertEqual(self.core.RFs['SRF'].Read('SR3'), 10)
        
        # check taken less than
        self.assertEqual(self.core.RFs['SRF'].Read('SR4'), 10)
        
        # check not taken
        self.assertEqual(self.core.RFs['SRF'].Read('SR5'), 64)
    
    def test_UNPACKLO(self):
        self.core.IMEM.instructions = ['UNPACKLO VR3 VR1 VR2', 'HALT']
        self.core.RFs['VRF'].Write('VR1', [i for i in range(64)])
        self.core.RFs['VRF'].Write('VR2', [-1*i for i in range(64)])
        self.core.run()
        expected = [0] * 64
        expected[::2] = [i for i in range(64)][:32]
        expected[1::2] = [-1*i for i in range(64)][:32]
        # check taken equals
        self.assertEqual(expected, self.core.RFs['VRF'].Read('VR3'))

    def test_UNPACKHI(self):
        self.core.IMEM.instructions = ['UNPACKHI VR3 VR1 VR2', 'HALT']
        self.core.RFs['VRF'].Write('VR1', [i for i in range(64)])
        self.core.RFs['VRF'].Write('VR2', [-1*i for i in range(64)])
        self.core.run()
        expected = [0] * 64
        expected[::2] = [i for i in range(64)][32:]
        expected[1::2] = [-1*i for i in range(64)][32:]
        # check taken equals
        self.assertEqual(expected, self.core.RFs['VRF'].Read('VR3'))
    
    def test_PACKLO(self):
        self.core.IMEM.instructions = ['PACKLO VR3 VR1 VR2', 'HALT']
        self.core.RFs['VRF'].Write('VR1', [i for i in range(64)])
        self.core.RFs['VRF'].Write('VR2', [-1*i for i in range(64)])
        self.core.run()
        expected = [0] * 64
        expected[:32] = [i for i in range(64)][::2]
        expected[32:] = [-1*i for i in range(64)][::2]
        # check taken equals
        self.assertEqual(expected, self.core.RFs['VRF'].Read('VR3'))
    
    def test_PACKHI(self):
        self.core.IMEM.instructions = ['PACKHI VR3 VR1 VR2', 'HALT']
        self.core.RFs['VRF'].Write('VR1', [i for i in range(64)])
        self.core.RFs['VRF'].Write('VR2', [-1*i for i in range(64)])
        self.core.run()
        expected = [0] * 64
        expected[:32] = [i for i in range(64)][1::2]
        expected[32:] = [-1*i for i in range(64)][1::2]
        # check taken equals
        self.assertEqual(expected, self.core.RFs['VRF'].Read('VR3'))
    
    def test_len_reg(self):
        golden = [i for i in range(128)]
        self.core.IMEM.instructions = ['LV VR1 SR1', 'HALT']
        self.core.RFs['SRF'].Write('SR1', 32)
        self.core.VDMEM.data = golden
        self.core.len_reg = 32
        self.core.run()

        self.assertEqual(golden[32:64], self.core.RFs['VRF'].Read('VR1')[:32])

    def test_mask(self):
        pass


if __name__ == '__main__':
    unittest.main()
