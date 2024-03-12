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
# SDMEM[6] = k_1
# SDMEM[7] = k_2
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
# SDMEM[19] = 384
# SDMEM[20] = 704
# SDMEM[21] = 832
# SDMEM[22] = 544
# SDMEM[23] = 960
# SDMEM[24] = 1408
# SDMEM[25] = 1216
# SDMEM[26] = 16
# SDMEM[27] = k_3
# SDMEM[28] = 1664
# SDMEM[29] = 1472
# SDMEM[30] = k_4
# SDMEM[31] = 1920
# SDMEM[32] = 1728
# SDMEM[33] = k_5
# SDMEM[35] = 1984
# SDMEM[36] = k_6

# first stage
# for i = 0 to 63
#     y_even = x[i]
#     y_odd = x[i+64]
#     y[i * 2] = y_even + W^0_128 * y_odd
#     y[i * 2 + 1] = y_even - W^0_128 * y_odd
# end

# setup constants
LS SR5 SR0 3            # SR5 = 64
LS SR6 SR0 4            # SR6 = 128
LS SR7 SR0 5            # SR7 = 256

# compute Re(W^0_128 * y_odd)
# compute Re(W^0_128) * Re(y_odd)
ADD SR4 SR5 SR7         # SR4 = 64 + 256 = 320 = pointer to Re(y_odd)
LV VR2 SR4              # VR2 = Re(y_odd)
LS SR2 SR0 10           # SR2 = 512 = pointer to Re(W^0_128)
LVI VR7 SR2 VR0         # VR7 = [Re(W^0_128)] * 64
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
# compute Im(W^0_128) * Im(y_odd)
ADD SR1 SR4 SR6         # SR1 = pointer to Im(y_odd)
LV VR6 SR1              # VR6 = Im(y_odd)
LS SR2 SR0 14           # SR2 = pointer to Im(W^0_128)
LVI VR5 SR2 VR0         # VR5 = [Im(W^0_128)] * 64
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
# combine result of multiplication
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)

# compute Im(W^0_128 * y_odd)
# Im(W^0_128) * Re(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
# Re(W^0_128) * Im(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
# combine result of multiplication
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)

# get final results
# compute Re(y_even + W^0_128 * y_odd) = Re(y_even) + Re(W^0_128 * y_odd)
LS SR4 SR0 5            # SR4 = 256 -- pointer to Re(y_even)
LV VR3 SR4              # VR3 = Re(y_even)
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
# compute Re(y_even - W^0_128 * y_odd) = Re(y_even) - Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)

# compute Im(y_even + W^0_128 * y_odd) = Im(y_even) + Im(W^0_128 * y_odd)
LS SR4 SR0 19           # SR4 = 384 -- pointer to Im(y_even)
LV VR3 SR4              # VR3 = Im(y_even)
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
# compute Im(y_even - W^0_128 * y_odd) = Im(y_even) - Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)

# store results
LS SR1 SR0 8            # SR1 = pointer to Re(y_0[0])
LS SR2 SR0 1    
ADD SR2 SR1 SR2         # SR2 = pointer to Re(y_0[1])
LS SR3 SR0 2            # load output stride
SVWS VR4 SR1 SR3        # Re(y[i * 2]) = Re(y_even) + Re(W^0_128 * y_odd)
SVWS VR7 SR2 SR3        # Re(y[i * 2 + 1]) = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Im(y_0[0])
ADD SR2 SR2 SR6         # SR1 = pointer to Im(y_0[1])
SVWS VR6 SR1 SR3        # Re(y[i * 2]) = Re(y_even) + Re(W^0_128 * y_odd)
SVWS VR5 SR2 SR3        # Re(y[i * 2 + 1]) = Re(y_even) - Re(W^0_128 * y_odd)

# second stage
# 32 4-point FFTs
for i = 0 to 31
    y_even = fft(x[i], x[i + 64], 2)
    y_odd = fft(x[i + 32], x[i + 96], 2)
    for k = 0 to 1
        y[i * 4 + k] = y_even[k] + W^32k_128 * y_odd[k]
        y[i * 4 + k + 2] = y_even[k] - W^32k_128 * y_odd[k]
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
# k = 0
# y[0] = y_even_0[0] + W^0_128 * y_odd_0[0]   | = y_0[0] + W^0_128 * y_0[64]
# y[2] = y_even_0[0] - W^0_128 * y_odd_0[0]   | = y_0[0] - W^0_128 * y_0[64]
# y[4] = y_even_1[0] + W^0_128 * y_odd_1[0]   | = y_0[2] + W^0_128 * y_0[66]
# y[6] = y_even_1[0] - W^0_128 * y_odd_1[0]   | = y_0[2] - W^0_128 * y_0[66]

# k = 1
# y[1] = y_even_0[1] + W^32_128 * y_odd_0[1]  | = y_0[1] + W^32_128 * y_0[65]
# y[3] = y_even_0[1] - W^32_128 * y_odd_0[1]  | = y_0[1] - W^32_128 * y_0[65]
# y[5] = y_even_1[1] + W^32_128 * y_odd_1[1]  | = y_0[3] + W^32_128 * y_0[67]
# y[7] = y_even_1[1] - W^32_128 * y_odd_1[1]  | = y_0[3] - W^32_128 * y_0[67]

# we can break this down into
# 1. compute W^0_128 * y_0[64:127:2]
#   a. y_1[0:128:4] = y_0[0:63:2] + W^0_128 * y_0[64:127:2]
#   b. y_1[2:128:4] = y_0[0:63:2] - W^0_128 * y_0[64:127:2]
# 2. compute W^32_128 * y_0[65:127:2]
#   a. y_1[0:128:4] = y_0[1:63:2] + W^0_128 * y_0[65:127:2]
#   b. y_1[2:128:4] = y_0[1:63:2] - W^0_128 * y_0[65:127:2]

# setup VLR
LS SR1 SR0 11           # SR1 = 32
MTCL SR1                # VLR = 32
# setup input stride
LS SR7 SR0 2            # SR2 = 2
# 1. compute Re(W^0_128 * y_odd)
# 1.1 compute Re(W^0_128) * Re(y_odd)
LS SR3 SR0 20           # SR2 = 704 = pointer to y_0[64] (Re(y_odd))
LVWS VR2 SR3 SR7        # VR2 = Re(y_0[64:127:2])
LS SR2 SR0 10           # SR2 = 512 = pointer to Re(W^0_128)
LVI VR7 SR2 VR0         # VR7 = [Re(W^0_128)] * 32
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
# 1.2 compute Im(W^0_128) * Im(y_odd)
LS SR6 SR0 4            # SR6 = 128
ADD SR1 SR3 SR6         # SR1 = 704 + 128 = pointer to Im(y_odd)
LVWS VR6 SR1 SR2        # VR6 = Im(y_0[64:127:2])
LS SR2 SR0 14           # SR2 = pointer to Im(W^0_128)
LVI VR5 SR2 VR0         # VR5 = [Im(W^0_128)] * 32
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
# combine result of multiplications
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)

# 2. compute Im(W^0_128 * y_odd)
# 2.1 Im(W^0_128) * Re(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
# 2.2 Re(W^0_128) * Im(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
# combine result of multiplication
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)

# get final results
# compute Re(y_even + W^0_128 * y_odd) = Re(y_even) + Re(W^0_128 * y_odd)
LS SR4 SR0 8            # SR4 = 640 -- pointer to Re(y_even)
LVWS VR3 SR4 SR7        # VR3 = Re(y_even)
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
# compute Re(y_even - W^0_128 * y_odd) = Re(y_even) - Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)

# compute Im(y_even + W^0_128 * y_odd) = Im(y_even) + Im(W^0_128 * y_odd)
LS SR4 SR0 9            # SR4 = 768 -- pointer to Im(y_even)
LVWS VR3 SR4 SR2        # VR3 = Im(y_even)
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
# compute Im(y_even - W^0_128 * y_odd) = Im(y_even) - Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)

# store results
LS SR5 SR0 12           # SR5 = 4 = output stride
LS SR1 SR0 13           # SR1 = 896 = pointer to Re(y_1[0])
ADD SR2 SR1 SR7         # SR2 = 898 = pointer to Re(y_1[2])
SVWS VR4 SR1 SR5        # Re(y[i * 2]) = Re(y_even) + Re(W^0_128 * y_odd)
SVWS VR7 SR2 SR5        # Re(y[i * 2 + 1]) = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Im(y_1[0])
ADD SR2 SR2 SR6         # SR1 = pointer to Im(y_1[2])
SVWS VR6 SR1 SR5        # Re(y[i * 2]) = Re(y_even) + Re(W^0_128 * y_odd)
SVWS VR5 SR2 SR5        # Re(y[i * 2 + 1]) = Re(y_even) - Re(W^0_128 * y_odd)

# setup VLR
LS SR1 SR0 11           # SR1 = 32
MTCL SR1                # VLR = 32
# setup constants and pointer
LS SR7 SR0 2            # SR7 = 2 = input stride
LS SR6 SR0 4            # SR6 = 128 = offset from y_Re to y_Im
LS SR5 SR0 3            # SR5 = 64 = offset from y_even to y_odd and w_Re and w_Im
LS SR4 SR0 13           # SR5 = 896 = pointer to Re(y_1[0]) (Re(y_odd))
LS SR3 SR0 20           # SR3 = 704 = pointer to Re(y_0[64]) (Re(y_odd))
LS SR2 SR0 10           # SR2 = 512 = pointer to Re(W^0_128)

# start of loop
# 1. compute Re(W^0_128 * y_odd)
# 1.1 compute Re(W^0_128) * Re(y_odd)
LVWS VR2 SR3 SR7        # VR2 = Re(y_0[64:127:2])
LVI VR7 SR2 VR0         # VR7 = [Re(W^0_128)] * 32
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
# 1.2 compute Im(W^0_128) * Im(y_odd)
ADD SR1 SR3 SR6         # SR1 = 704 + 128 = pointer to Im(y_odd)
LVWS VR6 SR1 SR7        # VR6 = Im(y_0[64:127:2])
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 SR1 VR0         # VR5 = [Im(W^0_128)] * 32
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
# combine result of multiplications
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)

# 2. compute Im(W^0_128 * y_odd)
# 2.1 Im(W^0_128) * Re(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
# 2.2 Re(W^0_128) * Im(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
# combine result of multiplication
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)

# get final results
# compute Re(y_even + W^0_128 * y_odd) = Re(y_even) + Re(W^0_128 * y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 SR1 SR7        # VR3 = Re(y_even)
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
# compute Re(y_even - W^0_128 * y_odd) = Re(y_even) - Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)

# compute Im(y_even + W^0_128 * y_odd) = Im(y_even) + Im(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 SR1 SR7        # VR3 = Im(y_even)
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
# compute Im(y_even - W^0_128 * y_odd) = Im(y_even) - Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)

# store results
LS SR1 SR0 12           # SR1 = 4 = output stride
SVWS VR4 SR4 SR1        # Re(y[i * 4]) = Re(y_even) + Re(W^0_128 * y_odd)
ADD SR4 SR4 SR7         # SR4 = Re(y_1[2])
SVWS VR7 SR4 SR1        # Re(y[i * 4 + 2]) = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 SR4 SR1        # Im(y[i * 4 + 2]) = Im(y_even) - Im(W^0_128 * y_odd)
SUB SR4 SR4 SR7         # SR1 = SR1 - 2 = pointer to Im(y_1[0])
SVWS VR6 SR4 SR1        # Im(y[i * 4]) = Im(y_even) + Im(W^0_128 * y_odd)

# loop check
LS SR6 SR0 6            # SR6 = k
BGE SR6 SR7 11          # exit loop if k >= 2

# loop overhead
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 6            # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
BEQ SR0 SR0 -40         # go to start of loop

# third stage
# 16 8-point FFTs
for i = 0 to 15
    y_even = fft(x[i], x[i + 32], ..., x[i + 96], 4)
    y_odd = fft(x[i + 16], x[i + 48], ..., x[i + 112], 4)
    for k = 0 to 3
        y[i * 8 + k] = y_even[k] + W^16k_128 * y_odd[k]
        y[i * 8 + k + 4] = y_even[k] - W^16k_128 * y_odd[k]
    end
end

# the output of the second stage is mapped to the third stage:
# y_even_0 = [y_0[0],  y_0[1], y_0[2], y_0[3]]
# y_even_i = [y_0[i*4],  y_0[i*4+1],  y_0[i*4+2],  y_0[i*4+3]]
# y_even_15 = [y_0[60],  y_0[61],  y_0[62],  y_0[63]]

# y_odd_0 =  [y_0[64],  y_0[65]],  y_0[66],  y_0[67]
# y_odd_i  = [y_0[i*4+N/2], y_0[i*4+N/2+1], y_0[i*4+N/2+2], y_0[i*4+N/2+3]]
# y_odd_15  = [y_0[124],  y_0[125],  y_0[126],  y_0[127]]

# we can break this down into
# 1. k = 0; compute W^0_128 * y_1[64:127:4]
#   a. y_2[0:128:8] = y_1[0:64:4] + W^0_128 * y_1[64:128:4]
#   b. y_2[4:128:8] = y_1[0:64:4] - W^0_128 * y_1[64:128:4]
# 2. k = 1; compute W^16_128 * y_1[65:127:4]
#   a. y_2[1:128:8] = y_1[1:64:4] + W^16_128 * y_1[65:128:4]
#   b. y_2[5:128:8] = y_1[1:64:4] - W^16_128 * y_1[65:128:4]
# 3. k = 2; compute W^32_128 * y_1[65:127:4]
#   a. y_2[2:128:8] = y_1[2:64:4] + W^32_128 * y_1[66:128:4]
#   b. y_2[6:128:8] = y_1[2:64:4] - W^32_128 * y_1[66:128:4]
# 4. k = 3; compute W^48_128 * y_1[65:127:4]
#   a. y_2[3:128:8] = y_1[3:64:4] + W^48_128 * y_1[67:128:4]
#   b. y_2[7:128:8] = y_1[3:64:4] - W^48_128 * y_1[67:128:4]

# setup VLR
LS SR1 SR0 16           # SR1 = 16
MTCL SR1                # VLR = 16
# setup constants and pointer
LS SR7 SR0 12           # SR7 = 4 = input stride
LS SR6 SR0 4            # SR6 = 128 = offset from y_Re to y_Im
LS SR5 SR0 3            # SR5 = 64 = offset from y_even to y_odd and w_Re and w_Im
LS SR4 SR0 17           # SR5 = 1152 = pointer to Re(y_2[0])
LS SR3 SR0 23           # SR3 = 960 = pointer to Re(y_1[64]) (Re(y_odd))
LS SR2 SR0 10           # SR2 = 512 = pointer to Re(W^0_128)

# start of loop
# 1. compute Re(W^0_128 * y_odd)
# 1.1 compute Re(W^0_128) * Re(y_odd)
LVWS VR2 SR3 SR7        # VR2 = Re(y_1[64:128:4])
LVI VR7 SR2 VR0         # VR7 = [Re(W^0_128)] * 16
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
# 1.2 compute Im(W^0_128) * Im(y_odd)
ADD SR1 SR3 SR6         # SR1 = 704 + 128 = pointer to Im(y_odd)
LVWS VR6 SR1 SR7        # VR6 = Im(y_0[64:128:4])
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 SR1 VR0         # VR5 = [Im(W^0_128)] * 32
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
# combine result of multiplications
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)

# 2. compute Im(W^0_128 * y_odd)
# 2.1 Im(W^0_128) * Re(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
# 2.2 Re(W^0_128) * Im(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
# combine result of multiplication
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)

# get final results
# compute Re(y_even + W^0_128 * y_odd) = Re(y_even) + Re(W^0_128 * y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 SR1 SR7        # VR3 = Re(y_even)
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
# compute Re(y_even - W^0_128 * y_odd) = Re(y_even) - Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)

# compute Im(y_even + W^0_128 * y_odd) = Im(y_even) + Im(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 SR1 SR7        # VR3 = Im(y_even)
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
# compute Im(y_even - W^0_128 * y_odd) = Im(y_even) - Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)

# store results
LS SR1 SR0 18           # SR1 = 8 = output stride
SVWS VR4 SR4 SR1        # Re(y[i * 8]) = Re(y_even) + Re(W^0_128 * y_odd)
ADD SR4 SR4 SR7         # SR4 = Re(y_1[4])
SVWS VR7 SR4 SR1        # Re(y[i * 8 + 4]) = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 SR4 SR1        # Im(y[i * 8 + 4]) = Im(y_even) - Im(W^0_128 * y_odd)
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 SR4 SR1        # Im(y[i * 8]) = Im(y_even) + Im(W^0_128 * y_odd)

# loop check
LS SR6 SR0 7            # SR6 = k
BGE SR6 SR7 11          # exit loop if k >= 4

# loop overhead
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 7            # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
BEQ SR0 SR0 -40         # go to start of loop

# fourth stage
# 8 16-point FFTs
for i = 0 to 7
    y_even = fft(x[i], x[i + 16], ..., x[i + 112], 8)
    y_odd = fft(x[i + 8], x[i + 24], ..., x[i + 120], 8)
    for k = 0 to 7
        y[i * 16 + k] = y_even[k] + W^8k_128 * y_odd[k]
        y[i * 16 + k + 8] = y_even[k] - W^8k_128 * y_odd[k]
    end
end
# the output of the second stage is mapped to the third stage:
# y_even_0 = [y_2[0],  y_2[1], y_2[2], y_2[3], y_2[4],  y_2[5], y_2[6], y_2[7]]
# y_even_i = [y_2[i*8],  y_2[i*8+1],  y_2[i*8+2],  y_2[i*8+3], ...]
# y_even_7 = [y_2[56],  y_2[57],  y_2[58],  y_2[59],  y_2[60],  y_2[61],  y_2[62],  y_2[63]]

# y_odd_0 =  [y_2[64],  y_2[65],  y_2[66],  y_2[67], y_2[68],  y_2[69],  y_2[70],  y_2[71]]
# y_odd_i  = [y_2[i*8+N/2], y_2[i*8+N/2+1], y_2[i*8+N/2+2], y_2[i*8+N/2+3], ...]
# y_odd_7  = [y_2[120],  y_2[121],  y_2[122],  y_2[123], y_2[124],  y_2[125],  y_2[126],  y_2[127]]

# we can break this down into
# 1. k = 0; compute W^0_128 * y_2[64:127:8]
#   a. y_3[0:128:16] = y_2[0:64:8] + W^0_128 * y_2[64:128:8]
#   b. y_3[8:128:16] = y_2[0:64:8] - W^0_128 * y_2[64:128:8]
# 2. k = 1; compute W^16_128 * y_2[65:127:8]
#   a. y_3[1:128:8] = y_2[1:64:8] + W^16_128 * y_2[65:128:8]
#   b. y_3[9:128:8] = y_2[1:64:8] - W^16_128 * y_2[65:128:8]
# 3. k = 2; compute W^32_128 * y_2[65:127:8]
#   a. y_3[2:128:8] = y_2[2:64:8] + W^32_128 * y_2[66:128:8]
#   b. y_3[10:128:8] = y_2[2:64:8] - W^32_128 * y_2[66:128:8]
# 4. k = 3; compute W^48_128 * y_2[65:127:8]
#   a. y_3[3:128:8] = y_2[3:64:8] + W^48_128 * y_2[67:128:8]
#   b. y_3[11:128:8] = y_2[3:64:8] - W^48_128 * y_2[67:128:8]
# 5. k = 4; compute W^0_128 * y_2[64:127:8]
#   a. y_3[4:128:8] = y_2[4:64:8] + W^0_128 * y_2[68:128:8]
#   b. y_3[12:128:8] = y_2[4:64:8] - W^0_128 * y_2[68:128:8]
# 6. k = 5; compute W^16_128 * y_2[65:127:8]
#   a. y_3[5:128:8] = y_2[5:64:8] + W^16_128 * y_2[69:128:8]
#   b. y_3[13:128:8] = y_2[5:64:8] - W^16_128 * y_2[69:128:8]
# 7. k = 6; compute W^32_128 * y_2[65:127:8]
#   a. y_3[6:128:8] = y_2[6:64:8] + W^32_128 * y_2[70:128:8]
#   b. y_3[14:128:8] = y_2[6:64:8] - W^32_128 * y_2[70:128:8]
# 8. k = 7; compute W^48_128 * y_2[65:127:8]
#   a. y_3[7:128:8] = y_2[7:64:8] + W^48_128 * y_2[71:128:8]
#   b. y_3[15:128:8] = y_2[7:64:8] - W^48_128 * y_2[71:128:8]

# setup VLR
LS SR1 SR0 18           # SR1 = 8
MTCL SR1                # VLR = 8
# setup constants and pointer
LS SR7 SR0 18           # SR7 = 8 = input stride
LS SR6 SR0 4            # SR6 = 128 = offset from y_Re to y_Im
LS SR5 SR0 3            # SR5 = 64 = offset from y_even to y_odd and w_Re and w_Im
LS SR4 SR0 24           # SR5 = 1408 = pointer to Re(y_3[0])
LS SR3 SR0 25           # SR3 = 1216 = pointer to Re(y_2[64]) (Re(y_odd))
LS SR2 SR0 10           # SR2 = 512 = pointer to Re(W^0_128)

# start of loop
# 1. compute Re(W^0_128 * y_odd)
# 1.1 compute Re(W^0_128) * Re(y_odd)
LVWS VR2 SR3 SR7        # VR2 = Re(y_2[64:128:8])
LVI VR7 SR2 VR0         # VR7 = [Re(W^0_128)] * 8
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
# 1.2 compute Im(W^0_128) * Im(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 SR1 SR7        # VR6 = Im(y_0[64:128:4])
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 SR1 VR0         # VR5 = [Im(W^0_128)] * 16
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
# combine result of multiplications
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)

# 2. compute Im(W^0_128 * y_odd)
# 2.1 Im(W^0_128) * Re(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
# 2.2 Re(W^0_128) * Im(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
# combine result of multiplication
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)

# get final results
# compute Re(y_even + W^0_128 * y_odd) = Re(y_even) + Re(W^0_128 * y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 SR1 SR7        # VR3 = Re(y_even)
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
# compute Re(y_even - W^0_128 * y_odd) = Re(y_even) - Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)

# compute Im(y_even + W^0_128 * y_odd) = Im(y_even) + Im(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 SR1 SR7        # VR3 = Im(y_even)
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
# compute Im(y_even - W^0_128 * y_odd) = Im(y_even) - Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)

# store results
LS SR1 SR0 26           # SR1 = 16 = output stride
SVWS VR4 SR4 SR1        # Re(y[i * 16]) = Re(y_even) + Re(W^0_128 * y_odd)
ADD SR4 SR4 SR7         # SR4 = Re(y_1[8])
SVWS VR7 SR4 SR1        # Re(y[i * 16 + 8]) = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 SR4 SR1        # Im(y[i * 16 + 8]) = Im(y_even) - Im(W^0_128 * y_odd)
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 SR4 SR1        # Im(y[i * 16]) = Im(y_even) + Im(W^0_128 * y_odd)

# loop check
LS SR6 SR0 27           # SR6 = k
BGE SR6 SR7 11          # exit loop if k >= 4

# loop overhead
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 7            # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
BEQ SR0 SR0 -40         # go to start of loop

# fifth stage
# The following steps are repeated for each of the 4 32-point FFTs
for i = 0 to 3
    y_even = fft(x[i], x[i + 8], ..., x[i + 120], 16)
    y_odd = fft(x[i + 4], x[i + 12], ..., x[i + 124], 16)
    for k = 0 to 15
        y[i * 32 + k] = y_even[k] + W^4k_128 * y_odd[k]
        y[i * 32 + k + 16] = y_even[k] - W^4k_128 * y_odd[k]
    end
end

# setup VLR
LS SR1 SR0 12           # SR1 = 4
MTCL SR1                # VLR = 4
# setup constants and pointer
LS SR7 SR0 26           # SR7 = 16 = input stride
LS SR6 SR0 4            # SR6 = 128 = offset from y_Re to y_Im
LS SR5 SR0 3            # SR5 = 64 = offset from y_even to y_odd and w_Re and w_Im
LS SR4 SR0 28           # SR5 = 1664 = pointer to Re(y_4[0])
LS SR3 SR0 29           # SR3 = 1472 = pointer to Re(y_3[64]) (Re(y_odd))
LS SR2 SR0 10           # SR2 = 512 = pointer to Re(W^0_128)

# start of loop
# 1. compute Re(W^0_128 * y_odd)
# 1.1 compute Re(W^0_128) * Re(y_odd)
LVWS VR2 SR3 SR7        # VR2 = Re(y_2[64:128:8])
LVI VR7 SR2 VR0         # VR7 = [Re(W^0_128)] * 8
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
# 1.2 compute Im(W^0_128) * Im(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 SR1 SR7        # VR6 = Im(y_0[64:128:4])
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 SR1 VR0         # VR5 = [Im(W^0_128)] * 16
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
# combine result of multiplications
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)

# 2. compute Im(W^0_128 * y_odd)
# 2.1 Im(W^0_128) * Re(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
# 2.2 Re(W^0_128) * Im(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
# combine result of multiplication
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)

# get final results
# compute Re(y_even + W^0_128 * y_odd) = Re(y_even) + Re(W^0_128 * y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 SR1 SR7        # VR3 = Re(y_even)
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
# compute Re(y_even - W^0_128 * y_odd) = Re(y_even) - Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)

# compute Im(y_even + W^0_128 * y_odd) = Im(y_even) + Im(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 SR1 SR7        # VR3 = Im(y_even)
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
# compute Im(y_even - W^0_128 * y_odd) = Im(y_even) - Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)

# store results
LS SR1 SR0 11           # SR1 = 32 = output stride
SVWS VR4 SR4 SR1        # Re(y[i * 32]) = Re(y_even) + Re(W^0_128 * y_odd)
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 SR4 SR1        # Re(y[i * 32 + 16]) = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 SR4 SR1        # Im(y[i * 32 + 16]) = Im(y_even) - Im(W^0_128 * y_odd)
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 SR4 SR1        # Im(y[i * 32]) = Im(y_even) + Im(W^0_128 * y_odd)

# loop check
LS SR6 SR0 30           # SR6 = k
BGE SR6 SR7 11          # exit loop if k >= 4

# loop overhead
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 7            # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
BEQ SR0 SR0 -40         # go to start of loop

# sixth stage
# Now, we have two 64-point FFTs
for i = 0 to 1
    y_even = fft(x[i], x[i + 4], ..., x[i + 124], 32)
    y_odd = fft(x[i + 2], x[i + 6], ..., x[i + 126], 32)
    for k = 0 to 31
        y[i * 64 + k] = y_even[k] + W^2k_128 * y_odd[k]
        y[i * 64 + k + 32] = y_even[k] - W^2k_128 * y_odd[k]
    end
end

# setup VLR
LS SR1 SR0 2            # SR1 = 2
MTCL SR1                # VLR = 2
# setup constants and pointer
LS SR7 SR0 11           # SR7 = 32 = input stride
LS SR6 SR0 4            # SR6 = 128 = offset from y_Re to y_Im
LS SR5 SR0 3            # SR5 = 64 = offset from y_even to y_odd and w_Re and w_Im
LS SR4 SR0 31           # SR5 = 1920 = pointer to Re(y_5[0])
LS SR3 SR0 32           # SR3 = 1728 = pointer to Re(y_4[64]) (Re(y_odd))
LS SR2 SR0 10           # SR2 = 512 = pointer to Re(W^0_128)

# start of loop
# 1. compute Re(W^0_128 * y_odd)
# 1.1 compute Re(W^0_128) * Re(y_odd)
LVWS VR2 SR3 SR7        # VR2 = Re(y_2[64:128:8])
LVI VR7 SR2 VR0         # VR7 = [Re(W^0_128)] * 8
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
# 1.2 compute Im(W^0_128) * Im(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 SR1 SR7        # VR6 = Im(y_0[64:128:4])
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 SR1 VR0         # VR5 = [Im(W^0_128)] * 16
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
# combine result of multiplications
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)

# 2. compute Im(W^0_128 * y_odd)
# 2.1 Im(W^0_128) * Re(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
# 2.2 Re(W^0_128) * Im(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
# combine result of multiplication
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)

# get final results
# compute Re(y_even + W^0_128 * y_odd) = Re(y_even) + Re(W^0_128 * y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 SR1 SR7        # VR3 = Re(y_even)
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
# compute Re(y_even - W^0_128 * y_odd) = Re(y_even) - Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)

# compute Im(y_even + W^0_128 * y_odd) = Im(y_even) + Im(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 SR1 SR7        # VR3 = Im(y_even)
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
# compute Im(y_even - W^0_128 * y_odd) = Im(y_even) - Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)

# store results
LS SR1 SR0 3           # SR1 = 64 = output stride
SVWS VR4 SR4 SR1        # Re(y[i * 64]) = Re(y_even) + Re(W^0_128 * y_odd)
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 SR4 SR1        # Re(y[i * 64 + 16]) = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 SR4 SR1        # Im(y[i * 64 + 16]) = Im(y_even) - Im(W^0_128 * y_odd)
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 SR4 SR1        # Im(y[i * 64]) = Im(y_even) + Im(W^0_128 * y_odd)

# loop check
LS SR6 SR0 27           # SR6 = k
BGE SR6 SR7 11          # exit loop if k >= 4

# loop overhead
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 7            # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
BEQ SR0 SR0 -40         # go to start of loop

# final stage
y = fft(x, 128)
y_even = fft(x[0], x[2], ..., x[126], 64)
y_odd = fft(x[1], x[3], ..., x[127], 64)
for k = 0 to 63
    y[k] = y_even[k] + W^k_128 * y_odd[k]
    y[k + 64] = y_even[k] - W^k_128 * y_odd[k]
end

# setup VLR
LS SR1 SR0 1            # SR1 = 1
MTCL SR1                # VLR = 1
# setup constants and pointer
LS SR7 SR0 3            # SR7 = 64 = input stride
LS SR6 SR0 4            # SR6 = 128 = offset from y_Re to y_Im
LS SR5 SR0 3            # SR5 = 64 = offset from y_even to y_odd and w_Re and w_Im
LS SR4 SR0 0            # SR5 = 0 = pointer to y_out
LS SR3 SR0 35           # SR3 = 1984 = pointer to Re(y_5[64]) (Re(y_odd))
LS SR2 SR0 10           # SR2 = 512 = pointer to Re(W^0_128)

# start of loop
# 1. compute Re(W^0_128 * y_odd)
# 1.1 compute Re(W^0_128) * Re(y_odd)
LVWS VR2 SR3 SR7        # VR2 = Re(y_2[64:128:8])
LVI VR7 SR2 VR0         # VR7 = [Re(W^0_128)] * 8
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
# 1.2 compute Im(W^0_128) * Im(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 SR1 SR7        # VR6 = Im(y_0[64:128:4])
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 SR1 VR0         # VR5 = [Im(W^0_128)] * 16
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
# combine result of multiplications
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)

# 2. compute Im(W^0_128 * y_odd)
# 2.1 Im(W^0_128) * Re(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
# 2.2 Re(W^0_128) * Im(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
# combine result of multiplication
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)

# get final results
# compute Re(y_even + W^0_128 * y_odd) = Re(y_even) + Re(W^0_128 * y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 SR1 SR7        # VR3 = Re(y_even)
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
# compute Re(y_even - W^0_128 * y_odd) = Re(y_even) - Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)

# compute Im(y_even + W^0_128 * y_odd) = Im(y_even) + Im(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 SR1 SR7        # VR3 = Im(y_even)
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
# compute Im(y_even - W^0_128 * y_odd) = Im(y_even) - Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)

# store results
LS SR1 SR0 1            # SR1 = 1 = output stride
SVWS VR4 SR4 SR1        # Re(y[i]) = Re(y_even) + Re(W^0_128 * y_odd)
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 SR4 SR1        # Re(y[i + 64]) = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 SR4 SR1        # Im(y[i + 64]) = Im(y_even) - Im(W^0_128 * y_odd)
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 SR4 SR1        # Im(y[i]) = Im(y_even) + Im(W^0_128 * y_odd)

# loop check
LS SR6 SR0 36           # SR6 = k
BGE SR6 SR7 11          # exit loop if k >= 64

# loop overhead
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 7            # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
BEQ SR0 SR0 -40         # go to start of loop

HALT
