LS SR7 SR0 31
LS SR6 SR0 31
LS SR5 SR0 25
ADD SR4 SR0 SR6
MTCL SR7
LV VR1 SR0
LV VR2 SR0
MULVV VR3 VR1 VR2
ADDVV VR6 VR6 VR3
LV VR1 SR4
LV VR2 SR4
MULVV VR3 VR1 VR2
ADDVV VR6 VR6 VR3
ADD SR4 SR4 SR6
BLE SR4 SR5 -5
PACKLO VR4 VR6 VR0
PACKHI VR5 VR6 VR0
LS SR7 SR0 30
MTCL SR7
ADDVV VR6 VR4 VR5
PACKLO VR4 VR6 VR0
PACKHI VR5 VR6 VR0
LS SR7 SR0 29
MTCL SR7
ADDVV VR6 VR4 VR5
PACKLO VR4 VR6 VR0
PACKHI VR5 VR6 VR0
LS SR7 SR0 28
MTCL SR7
ADDVV VR6 VR4 VR5
PACKLO VR4 VR6 VR0
PACKHI VR5 VR6 VR0
LS SR7 SR0 27
MTCL SR7
ADDVV VR6 VR4 VR5
PACKLO VR4 VR6 VR0
PACKHI VR5 VR6 VR0
LS SR7 SR0 26
MTCL SR7
ADDVV VR6 VR4 VR5
PACKLO VR4 VR6 VR0
PACKHI VR5 VR6 VR0
LS SR7 SR0 1
MTCL SR7
ADDVV VR6 VR4 VR5
LS SR2 SR0 24
SV VR6 SR2
HALT