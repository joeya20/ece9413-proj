ADDVV VR2 VR0 VR1
ADDVS VR2 VR0 SR0
SUBVV VR2 VR0 VR1
SUBVS VR2 VR0 SR0
UNPACKLO VR2 VR0 VR1
UNPACKHI VR2 VR0 VR1
PACKHI VR2 VR0 VR1
PACKLO VR2 VR0 VR1
BEQ SR0 SR1 10
SEQVV VR2 VR1
MULVV VR2 VR1 VR0
POP SR7
CVM
MTCL SR3
MFCL SR3
ADD SR2 SR1 SR0
HALT
