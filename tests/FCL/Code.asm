# VR1: input a; VR2: input W; VR3: input b; VR4: output
# FCL: a * W + b
# a = VDMEM[0:255]
# b = VDMEM[256:511]
# W = VDMEM[512:66047]
# W[0] = VDMEM[512:767]
# W[1] = VDMEM[768:1023]
# W[2] = VDMEM[1024:1279]
# ...
# W[i] = VDMEM[i*256+512:(i+1)*256+511]
# W[255] = VDMEM[65792:66047]
# a * W = VDMEM[66048:66303]
# out = VDMEM[66304:66559]

# calculate a * W
# iterate over every vector in W and do dot product with a
# VR4[i] = a * W[i]

# first, do the multiplication and accumulate in VR4
# SR1 = a_index; SR2 = W_index; SR3 = i; SR5 = 256; SR6 = 1
# SR7 = used for accumulating scalar and storing it into SDMEM

# init
LS SR7 SR0 64       # SR7 = 64
MTCL SR7            # VLR = 64
LS SR1 SR0 0        # SR1 = 0
LS SR2 SR0 3        # SR2 = 3
SLL SR2 SR7 SR2     # SR2 = 64 << 3 = 512
LS SR5 SR0 2        # SR5 = 2
SLL SR5 SR7 SR5     # SR5 = 64 << 2 = 256
LS SR3 SR0 0        # SR3 = 0
LS SR6 SR0 1        # SR6 = 1

# start of loop
LV VR1 SR1          # VR1 = a[:63]
LV VR2 SR2          # VR2 = W[i][:63]
MULVV VR6 VR1 VR2   # mul step of FCL
ADDVV VR4 VR4 VR6   # accumulate in VR4

ADD SR1 SR1 SR7     # SR1 = SR1 + 64
ADD SR2 SR2 SR7     # SR2 = SR2 + 64
LV VR1 SR1          # VR1 = a[64:127]
LV VR2 SR2          # VR2 = W[i][64:127]
MULVV VR6 VR1 VR2   # mul step of FCL
ADDVV VR4 VR4 VR6   # accumulate addition in VR4

ADD SR1 SR1 SR7     # SR1 = SR1 + 64
ADD SR2 SR2 SR7     # SR2 = SR2 + 64
LV VR1 SR1          # VR1 = a[128:191]
LV VR2 SR2          # VR2 = W[i][128:191]
MULVV VR6 VR1 VR2   # mul step of FCL
ADDVV VR4 VR4 VR6   # accumulate addition in VR4

ADD SR1 SR1 SR7     # SR1 = SR1 + 64
ADD SR2 SR2 SR7     # SR2 = SR2 + 64
LV VR1 SR1          # VR1 = a[192:255]
LV VR2 SR2          # VR2 = W[i][192:255]
MULVV VR6 VR1 VR2   # mul step of FCL
ADDVV VR4 VR4 VR6   # accumulate addition in VR4

# second, accumulate to get scalar value
PACKLO VR5 VR4 VR0  # VR5[:31] = VR4[:64:2] split the lower half of the vector for addition
PACKHI VR6 VR4 VR0  # VR6[:31] = VR4[1:64:2] split the upper half of the vector for addition
SRL SR7 SR7 SR6     # SR7 = SR7 >> 1 (SR7 = 64 / 2 = 32)
MTCL SR7            # VLEN = 32
ADDVV VR4 VR5 VR6   # sum the vectors and re-accumulate into VR4

PACKLO VR5 VR4 VR0  # VR5[:15] = VR4[:32:2] split the lower half of the vector for addition
PACKHI VR6 VR4 VR0  # VR6[:15] = VR4[1:32:2] split the upper half of the vector for addition
SRL SR7 SR7 SR6     # SR7 = SR7 >> 1 (SR7 = 32 / 2 = 16)
MTCL SR7            # VLEN = 16
ADDVV VR4 VR5 VR6   # sum the vectors and re-accumulate into VR4

PACKLO VR5 VR4 VR0  # VR5[:7] = VR4[:16:2] split the lower half of the vector for addition
PACKHI VR6 VR4 VR0  # VR6[:7] = VR4[1:16:2] split the upper half of the vector for addition
SRL SR7 SR7 SR6     # SR7 = SR7 >> 1 (SR7 = 16 / 2 = 8)
MTCL SR7            # VLEN = 8
ADDVV VR4 VR5 VR6   # sum the vectors and re-accumulate into VR4

PACKLO VR5 VR4 VR0  # VR5[:3] = VR4[:8:2] split the lower half of the vector for addition
PACKHI VR6 VR4 VR0  # VR6[:3] = VR4[1:8:2] split the upper half of the vector for addition
SRL SR7 SR7 SR6     # SR7 = SR7 >> 1 (SR7 = 8 / 2 = 4)
MTCL SR7            # VLEN = 4
ADDVV VR4 VR5 VR6   # sum the vectors and re-accumulate into VR4

PACKLO VR5 VR4 VR0  # VR5[:1] = VR4[:4:2] split the lower half of the vector for addition
PACKHI VR6 VR4 VR0  # VR6[:1] = VR4[1:4:2] split the upper half of the vector for addition
SRL SR7 SR7 SR6     # SR7 = SR7 >> 1 (SR7 = 4 / 2 = 2)
MTCL SR7            # VLEN = 2
ADDVV VR4 VR5 VR6   # sum the vectors and re-accumulate into VR4

PACKLO VR5 VR4 VR0  # VR5[0] = VR4[:2:2] split the lower half of the vector for addition
PACKHI VR6 VR4 VR0  # VR6[0] = VR4[1:2:2] split the upper half of the vector for addition
SRL SR7 SR7 SR6     # SR7 = SR7 >> 1 (SR7 = 2 / 2 = 1)
MTCL SR7            # VLEN = 1
ADDVV VR4 VR5 VR6   # VR4[0] = accum(VR4[:])

# third, store in VDMEM
LS SR7 SR0 256      # SR7 = SDMEM[256] = 66048
ADD SR7 SR7 SR3     # SR7 = 66048 + i
SV VR4 SR7          # VDMEM[66048+i] = VR4[0]

# now repeat process for i in in range(256)
LS SR7 SR0 64       # SR7 = 64
MTCL SR7            # VLR = 64
LS SR1 SR0 0        # SR1 = 0
ADD SR2 SR2 SR7     # SR2 = W[i+1]
ADD SR3 SR3 SR6     # i++
ADDVV VR4 VR0 VR0   # reset VR4
BLT SR3 SR5 -61     # go to start of loop

# FINISHED 'a * W'
# now do '+ b'

# at this point SR2 = 66048 and VLR = 64
ADD SR3 SR2 SR5     # SR3 = 66048 + 256 = 66304
LV VR2 SR2          # VR2 = (a * W)[:63]
LV VR1 SR5          # VR1 = b[:63]
ADDVV VR4 VR1 VR2   # VR4  = (a * W + b)[:63]
SV VR4 SR3

ADD SR3 SR3 SR7     # SR3 = SR3 + 64
ADD SR5 SR5 SR7     # SR5 = SR5 + 64
ADD SR2 SR2 SR7     # SR2 = SR2 + 64
LV VR1 SR5          # VR1 = a[64:127]
LV VR2 SR2          # VR2 = (a * W)[64:127]
ADDVV VR4 VR1 VR2   # VR4  = (a * W + b)[64:127]
SV VR4 SR3

ADD SR3 SR3 SR7     # SR3 = SR3 + 64
ADD SR5 SR5 SR7     # SR5 = SR5 + 64
ADD SR2 SR2 SR7     # SR2 = SR2 + 64
LV VR1 SR5          # VR1 = a[128:191]
LV VR2 SR2          # VR2 = (a * W)[128:191]
ADDVV VR4 VR1 VR2   # VR4  = (a * W + b)[128:191]
SV VR4 SR3

ADD SR3 SR3 SR7     # SR3 = SR3 + 64
ADD SR5 SR5 SR7     # SR5 = SR5 + 64
ADD SR2 SR2 SR7     # SR2 = SR2 + 64
LV VR1 SR5          # VR1 = a[192:255]
LV VR2 SR2          # VR2 = (a * W)[192:255]
ADDVV VR4 VR1 VR2   # VR4  = (a * W + b)[192:255]
SV VR4 SR3

# DONE
HALT
