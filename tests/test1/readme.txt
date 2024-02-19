LV VR0 SR0                  # VR0 = [0...63]
LS SR1 SR0 1                # SR1 = 1
LS SR2 SR0 63               # SR2 = 63
ADD SR3 SR2 SR1             # SR3 = 64
SS SR3 SR0 0                # SDMEM[0] = 64
ADDVS VR1 VR0 SR1           # VR1 = [1...64]
ADDVV VR2 VR1 VR0           # VR2 = [0+1, 1+2, ..., 63+64]
SUBVV VR3 VR1 VR0           # VR3 = [1, ..., 1]
SUBVS VR4 VR0 SR3           # VR4 = [-64, -63, ..., -1]
SV VR2 SR2                  # VDMEM[64:127] = VR2
MULVV VR5 VR1 VR4           # VR5 = [-64, -126, ..., -1024, ..., -126, -64]
DIVVV VR6 VR5 VR4           # VR6 = [1...64]
# MULVS/DIVVS               
SEQVV VR1 VR3               # mask_reg = [1, 0, 0, ..., 0]
CVM                         # mask_reg = 64
POP SR4                     # SR4 = 64

# S__VV
# S__VS
# MTCL
# MFCL
# LVWS
# SVWS
# LVI
# SVI
# SUB
# AND/OR/XOR
# SLL, SRL
# SRA
# B__
# UNPACK__
# PACK__
HALT
