# VDMEM[0:127]: Re(out)
# VDMEM[128:255]: Im(out)
# VDMEM[256:383]: Re(X)
# VDMEM[384:511]: Im(X)
# VDMEM[512:575]: Re(W_128)
# VDMEM[576:639]: Im(W_128)
# VDMEM[640:767]: Re(y_0)
# VDMEM[768:895]: Im(y_0)
# VDMEM[896:1023]: Re(y_1)
# VDMEM[1024:1151]: Im(y_1)
# VDMEM[1152:1279]: Re(y_2)
# VDMEM[1280:1407]: Im(y_2)
# VDMEM[1408:1535]: Re(y_3)
# VDMEM[1536:1663]: Im(y_3)
# VDMEM[1664:1791]: Re(y_4)
# VDMEM[1792:1919]: Im(y_4)
# VDMEM[1920:2047]: Re(y_5)
# VDMEM[2048:2175]: Im(y_5)

# SDMEM[0] = 0
# SDMEM[1] = 1
# SDMEM[2] = 2
# SDMEM[3] = 64
# SDMEM[4] = 128
# SDMEM[5] = 256
# SDMEM[6] = garbage
# SDMEM[7] = garbage
# SDMEM[8] = 640
# SDMEM[9] = 768
# SDMEM[10] = 512
# SDMEM[11] = 32
# SDMEM[12] = 4
# SDMEM[13] = 896
# SDMEM[14] = 576
# SDMEM[15] = 1024
# SDMEM[16] = 16
# SDMEM[17] = 1152
# SDMEM[18] = 8

# first stage
# for i = 0 to 63
#     y_even = x[i]
#     y_odd = x[i+64]
#     y[i * 2] = y_even + W^0_128 * y_odd
#     y[i * 2 + 1] = y_even - W^0_128 * y_odd
# end

LS SR5 SR0 3        # SR5 = 64
LS SR6 SR0 4        # SR6 = 128
LS SR7 SR0 5        # SR7 = 256

# setup pointers
ADD SR3 SR0 SR7         # SR3 = 256 -- pointer to Re(X[0])
ADD SR4 SR5 SR7         # SR4 = 64 + 256 -- pointer to Re(X[64])
LV  VR1 SR3             # VR1 = Re(y_even)
LV  VR2 SR4             # VR2 = Re(y_odd)
# handle real part
LS SR2 SR0 10           # SR2 = 512 -- pointer to Re(W_128)
LVI VR7 SR2 VR0         # VR7 = [Re(W_128)[0]] * 64
MULVV VR2 VR2 VR7       # VR2 = Re(W^0_128) * Re(y_odd)
# handle imaginary part
LS SR2 SR0 14           # SR2 = pointer to Im(W^0_128)
LVI VR7 SR2 VR0         # VR7 = [Im(W^0_128)] * 64
ADD SR1 SR4 SR6         # SR1 = pointer to Im(X[64])
LV VR6 SR1              # VR6 = Im(x[64:127]) = Im(y_odd)
MULVV VR6 VR6 VR7       # VR6 = Im(W^0_128) * Im(y_odd)
ADDVV VR3 VR3 VR6       # VR3 = Re(y_even) + Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)

# combine to get final results
ADDVV VR3 VR1 VR2       # VR3 = Re(y_even) + Re(W^0_128) * Re(y_odd)
SUBVV VR4 VR1 VR2       # VR4 = y_even - W^0_128 * y_odd
UNPACKLO VR5 VR3 VR4    # VR5 = y[0:63]
UNPACKHI VR6 VR3 VR4    # VR6 = y[64:127]
LS SR1 SR0 8            # SR1 = 640
SV VR5 SR1
ADD SR1 SR1 SR5         # SR1 += 64
SV VR6 SR1

LS SR2 SR0 14           # SR2 = pointer to Im(W_128)
ADD SR3 SR6 SR7         # SR3 = 128 + 256 = 384
ADD SR4 SR3 SR5         # SR4 = 384 + 64 = 448
LVI VR7 SR2 VR0         # VR7 = [Im(W_128)[0]] * 64
LV  VR1 SR3             # VR1 = Im(y_even)
LV  VR2 SR4             # VR2 = Im(y_odd)
MULVV VR2 VR2 VR7       # VR2 = W^0_128 * y_odd
ADDVV VR3 VR1 VR2       # VR3 = y_even + W^0_128 * y_odd
SUBVV VR4 VR1 VR2       # VR4 = y_even - W^0_128 * y_odd
UNPACKLO VR5 VR3 VR4    # VR5 = y[0:63]
UNPACKHI VR6 VR3 VR4    # VR6 = y[64:127]
LS SR1 SR0 9            # SR1 = 768
SV VR5 SR1
ADD SR1 SR1 SR5         # SR1 += 64
SV VR6 SR1

# second stage
# 32 4-point FFTs
for i = 0 to 31
    y_even = fft(x[i], x[i + 64], 2)
    y_odd = fft(x[i + 32], x[i + 96], 2)
    for k = 0 to 1
        y[i * 4 + k] = y_even[k] + W^k_128 * y_odd[k]
        y[i * 4 + k + 2] = y_even[k] - W^k_128 * y_odd[k]
    end
end

# the output of the first stage is mapped to the second stage:
# y_even_0 = [y_0[0],  y_0[1]]
# y_even_i = [y_0[i*2],  y_0[i*2+1]]
# y_even_31 = [y_0[62],  y_0[63]]

# y_odd_0 =  [y_0[64],  y_0[65]]
# y_odd_i  = [y_0[i*2+N/2], y_0[i*2+N/2+1]]
# y_odd_31  = [y_0[126],  y_0[127]]

# computation
# i = 0
# y[0] = y_even_0[0] + W^0_128 * y_odd_0[0]   | = y_0[0] + W^0_128 * y_0[64]
# y[2] = y_even_0[0] - W^0_128 * y_odd_0[0]   | = y_0[0] - W^0_128 * y_0[64]
# y[1] = y_even_0[1] + W^1_128 * y_odd_0[1]   | = y_0[1] + W^1_128 * y_0[65]
# y[3] = y_even_0[1] - W^1_128 * y_odd_0[1]   | = y_0[1] - W^1_128 * y_0[65]

# i = 1
# y[4] = y_even_1[0] + W^0_128 * y_odd_1[0]   | = y_0[2] + W^0_128 * y_0[66]
# y[6] = y_even_1[0] - W^0_128 * y_odd_1[0]   | = y_0[2] - W^0_128 * y_0[66]
# y[5] = y_even_1[1] + W^0_128 * y_odd_1[1]   | = y_0[3] + W^1_128 * y_0[67]
# y[7] = y_even_1[1] + W^0_128 * y_odd_1[1]   | = y_0[3] - W^1_128 * y_0[67]

# we can break this down into 4 major operations:
# 1. y_1[0:128:4] = y_0[0:64:2] + W^0_128 * y_0[64:128:2]
# 2. y_1[2:128:4] = y_0[0:64:2] - W^0_128 * y_0[64:128:2]
# 3. y_1[1:128:4] = y_0[1:64:2] + W^1_128 * y_0[65:128:2]
# 4. y_1[3:128:4] = y_0[1:64:2] - W^1_128 * y_0[65:128:2]

LS SR1 SR0 11       # SR1 = 32
MTCL SR1            # VLR = 32

# handle real part first
# this does steps 1 and 2 and stores the results in VR4 and VR5
LS SR1 SR0 8        # SR1 = 640 -- pointer to Re(y_0[0])
LS SR2 SR0 3        # SR2 = 64
ADD SR2 SR2 SR1     # SR2 = 704 -- pointer to Re(y_0[64])
LS SR3 SR0 2        # SR3 = 2 (stride)
LS SR4 SR0 10       # SR4 = 512 -- pointer to Re(W^0_128)
LSWS VR1 SR1 SR3    # VR1 = y_0[0:64:2]
LSWS VR2 SR2 SR3    # VR2 = y_0[64:128:2]
LVI VR3 SR4 VR0     # VR3 = Re(W^0_128) * 32
MULVV VR2 VR2 VR3   # VR2 = W^0_128 * y_0[64:128:2]
ADDVV VR4 VR1 VR2   # VR4 = y_0[0:64:2] + W^0_128 * y_0[64:128:2]
SUBVV VR5 VR1 VR2   # VR5 = y_0[0:64:2] - W^0_128 * y_0[64:128:2]

# this does steps 3 and 4 and stores the results in VR6 and VR7
LS SR5 SR0 1        # SR5 = 1
ADD SR1 SR1 SR5     # SR1 = 641 -- pointer to Re(y_0[1])
ADD SR2 SR2 SR5     # SR2 = 705 -- pointer to Re(y_0[65])
ADD SR4 SR4 SR5     # SR4 = 513 -- pointer to Re(W^1_128)
LSWS VR1 SR1 SR3    # VR1 = y_0[1:64:2]
LSWS VR2 SR2 SR3    # VR2 = y_0[65:128:2]
LVI VR3 SR4 VR0     # VR3 = Re(W^1_128) * 32
MULVV VR2 VR2 VR3   # VR2 = W^1_128 * y_0[65:128:2]
ADDVV VR6 VR1 VR2   # VR6 = y_0[1:64:2] + W^1_128 * y_0[65:128:2]
SUBVV VR7 VR1 VR2   # VR7 = y_0[1:64:2] - W^1_128 * y_0[65:128:2]

LS SR1 SR0 12       # SR1 = 4
LS SR2 SR0 13       # SR2 = 896 -- pointer to Re(y_1[0])
SVWS VR4 SR2 SR1    # y_1[0:128:4]
ADD SR2 SR2 SR5     # SR2 = 897 -- pointer to Re(y_1[1])
SVWS VR6 SR2 SR1    # y_1[1:128:4]
ADD SR2 SR2 SR5     # SR2 = 898 -- pointer to Re(y_1[2])
SVWS VR5 SR2 SR1    # y_1[2:128:4]
ADD SR2 SR2 SR5     # SR2 = 899 -- pointer to Re(y_1[3])
SVWS VR7 SR2 SR1    # y_1[3:128:4]

# handle imaginary part
# TODO

# third stage
# 16 8-point FFTs
for i = 0 to 15
    y_even = fft(x[i], x[i + 32], ..., x[i + 96], 4)
    y_odd = fft(x[i + 16], x[i + 48], ..., x[i + 112], 4)
    for k = 0 to 3
        y[i * 8 + k] = y_even[k] + W^k_128 * y_odd[k]
        y[i * 8 + k + 4] = y_even[k] - W^k_128 * y_odd[k]
    end
end

# the output of the second stage is mapped to the third stage:
# y_even_0 = [y_0[0],  y_0[1], y_0[2], y_0[3]]
# y_even_i = [y_0[i*4],  y_0[i*4+1],  y_0[i*4+2],  y_0[i*4+3]]
# y_even_15 = [y_0[60],  y_0[61],  y_0[62],  y_0[63]]

# y_odd_0 =  [y_0[64],  y_0[65]],  y_0[66],  y_0[67]
# y_odd_i  = [y_0[i*4+N/2], y_0[i*4+N/2+1], y_0[i*4+N/2+2], y_0[i*4+N/2+3]]
# y_odd_15  = [y_0[124],  y_0[125],  y_0[126],  y_0[127]]

# we can break this down into 8 major operations:
# 1. y_2[0:128:8] = y_1[0:64:4] + W^0_128 * y_1[64:128:4]
# 2. y_2[4:128:8] = y_1[0:64:4] - W^0_128 * y_1[64:128:4]
# 3. y_2[1:128:8] = y_1[1:64:4] + W^1_128 * y_1[65:128:4]
# 4. y_2[5:128:8] = y_1[1:64:4] - W^1_128 * y_1[65:128:4]
# 4. y_2[2:128:8] = y_1[2:64:4] + W^2_128 * y_1[66:128:4]
# 5. y_2[6:128:8] = y_1[2:64:4] - W^2_128 * y_1[66:128:4]
# 6. y_2[3:128:8] = y_1[3:64:4] + W^3_128 * y_1[67:128:4]
# 7. y_2[7:128:8] = y_1[3:64:4] - W^3_128 * y_1[67:128:4]

LS SR1 SR0 16       # SR1 = 16
MTCL SR1            # VLR = 16
LS SR3 SR0 2        # SR3 = 4 (input stride)
LS SR7 SR0 18       # SR7 = 8 (output stride)

# steps 1 and 2
LS SR1 SR0 13       # SR1 = 896 -- pointer to Re(y_1[0])
LS SR2 SR0 3        # SR2 = 64
ADD SR2 SR2 SR1     # SR2 = 960 -- pointer to Re(y_1[64])
LS SR4 SR0 10       # SR4 = 512 -- pointer to Re(W^0_128)
LSWS VR1 SR1 SR3    # VR1 = y_1[0:64:4]
LSWS VR2 SR2 SR3    # VR2 = y_1[64:128:4]
LVI VR3 SR4 VR0     # VR3 = [Re(W^0_128)] * 16
MULVV VR2 VR2 VR3   # VR2 = W^0_128 * y_1[64:128:4]
ADDVV VR4 VR1 VR2   # VR4 = y_0[0:64:2] + W^0_128 * y_0[64:128:2]
SUBVV VR5 VR1 VR2   # VR5 = y_0[0:64:2] - W^0_128 * y_0[64:128:2]
LS SR6 SR0 17       # SR6 = 1152 -- pointer to y_2[0]
SVWS VR4 SR6 SR7
ADD SR6 SR6 SR3     # SR6 = 1156 -- pointer to y_2[4]
SVWS VR5 SR6 SR7

# steps 3 and 4
ADD SR1 SR1 SR5     # SR1 = 897 -- pointer to Re(y_1[1])
ADD SR2 SR2 SR5     # SR2 = 961 -- pointer to Re(y_1[65])
ADD SR4 SR4 SR5     # SR4 = 513 -- pointer to Re(W^1_128)
LSWS VR1 SR1 SR3    # VR1 = y_1[1:64:4]
LSWS VR2 SR2 SR3    # VR2 = y_1[65:128:4]
LVI VR3 SR4 VR0     # VR3 = [Re(W^1_128)] * 16
MULVV VR2 VR2 VR3   # VR2 = W^1_128 * y_1[65:128:4]
ADDVV VR4 VR1 VR2   # VR4 = y_1[1:64:4] + W^1_128 * y_1[65:128:4]
SUBVV VR5 VR1 VR2   # VR5 = y_1[1:64:4] - W^1_128 * y_1[65:128:4]
ADD SR6 SR6 SR5     # SR6 = 1157 -- pointer to y_2[5]
SVWS VR5 SR6 SR7
SUB SR6 SR6 SR3     # SR6 = 1153 -- pointer to y_2[1]
SVWS VR4 SR6 SR7

# steps 5 and 6
ADD SR1 SR1 SR5     # SR1 = 898 -- pointer to Re(y_1[2])
ADD SR2 SR2 SR5     # SR2 = 962 -- pointer to Re(y_1[66])
ADD SR4 SR4 SR5     # SR4 = 514 -- pointer to Re(W^2_128)
LSWS VR1 SR1 SR3    # VR1 = y_1[2:64:4]
LSWS VR2 SR2 SR3    # VR2 = y_1[66:128:4]
LVI VR3 SR4 VR0     # VR3 = [Re(W^2_128)] * 16
MULVV VR2 VR2 VR3   # VR2 = W^2_128 * y_0[66:128:4]
ADDVV VR4 VR1 VR2   # VR4 = y_1[1:64:4] + W^1_128 * y_0[65:128:4]
SUBVV VR5 VR1 VR2   # VR5 = y_1[1:64:4] - W^1_128 * y_0[65:128:4]
ADD SR6 SR6 SR5     # SR6 = 1154 -- pointer to y_2[2]
SVWS VR4 SR6 SR7
ADD SR6 SR6 SR3     # SR6 = 1158 -- pointer to y_2[6]
SVWS VR5 SR6 SR7

# steps 7 and 8
ADD SR1 SR1 SR5     # SR1 = 899 -- pointer to Re(y_1[1])
ADD SR2 SR2 SR5     # SR2 = 963 -- pointer to Re(y_1[65])
ADD SR4 SR4 SR5     # SR4 = 515 -- pointer to Re(W^3_128)
LSWS VR1 SR1 SR3    # VR1 = y_0[3:64:4]
LSWS VR2 SR2 SR3    # VR2 = y_0[67:128:4]
LVI VR3 SR4 VR0     # VR3 = [Re(W^3_128)] * 16
MULVV VR2 VR2 VR3   # VR2 = W^3_128 * y_1[65:128:4]
ADDVV VR4 VR1 VR2   # VR4 = y_1[3:64:4] + W^3_128 * y_1[65:128:4]
SUBVV VR5 VR1 VR2   # VR5 = y_1[3:64:4] - W^3_128 * y_1[65:128:4]
ADD SR6 SR6 SR5     # SR6 = 1159 -- pointer to y_2[7]
SVWS VR5 SR6 SR7
SUB SR6 SR6 SR3     # SR6 = 1155 -- pointer to y_2[3]
SVWS VR4 SR6 SR7

# fourth stage
# 8 16-point FFTs
for i = 0 to 7
    y_even = fft(x[i], x[i + 16], ..., x[i + 112], 8)
    y_odd = fft(x[i + 8], x[i + 24], ..., x[i + 120], 8)
    for k = 0 to 7
        y[i * 16 + k] = y_even[k] + W^k_128 * y_odd[k]
        y[i * 16 + k + 8] = y_even[k] - W^k_128 * y_odd[k]
    end
end

# the output of the third stage is mapped to the fourth stage:
# y_even_0 = [y_2[0],  y_2[1], y_2[2], y_2[3],  y_2[4], y_2[5], y_2[6], y_2[7]]
# y_even_i = [y_2[i*8],  y_2[i*8+1],  y_2[i*8+2],  y_2[i*8+3], y_2[i*8],  y_2[i*8+1],  y_2[i*8+2],  y_2[i*8+3]]
# y_even_15 = [y_2[60],  y_2[61],  y_2[62],  y_2[63]]

# y_odd_0 =  [y_2[64],  y_2[65]],  y_2[66],  y_2[67]
# y_odd_i  = [y_2[i*4+N/2], y_2[i*4+N/2+1], y_2[i*4+N/2+2], y_2[i*4+N/2+3]]
# y_odd_15  = [y_2[124],  y_2[125],  y_2[126],  y_2[127]]

# we can break this down into 8 major operations:
# 1. y_2[0:128:8] = y_1[0:64:4] + W^0_128 * y_1[64:128:4]
# 2. y_2[4:128:8] = y_1[0:64:4] - W^0_128 * y_1[64:128:4]
# 3. y_2[1:128:8] = y_1[1:64:4] + W^1_128 * y_1[65:128:4]
# 4. y_2[5:128:8] = y_1[1:64:4] - W^1_128 * y_1[65:128:4]
# 4. y_2[2:128:8] = y_1[2:64:4] + W^2_128 * y_1[66:128:4]
# 5. y_2[6:128:8] = y_1[2:64:4] - W^2_128 * y_1[66:128:4]
# 6. y_2[3:128:8] = y_1[3:64:4] + W^3_128 * y_1[67:128:4]
# 7. y_2[7:128:8] = y_1[3:64:4] - W^3_128 * y_1[67:128:4]

HALT
