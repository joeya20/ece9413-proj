# VDMEM[0:127]: Re(out)
# VDMEM[128:255]: Im(out)
# VDMEM[256:383]: Re(X)
# VDMEM[384:511]: Im(X)
# VDMEM[512:575]: Re(W_128)
# VDMEM[576:639]: Im(W_128)
# VDMEM[640:767]: Re(base_case)
# VDMEM[768:895]: Im(base_case)

# SDMEM[0] = 0
# SDMEM[1] = 1
# SDMEM[2] = 2
# SDMEM[3] = 64
# SDMEM[4] = 128
# SDMEM[5] = 256
# SDMEM[6] = Re(W^0_128)
# SDMEM[7] = Im(W^0_128)
# SDMEM[8] = 640
# SDMEM[9] = 768

# for i = 0 to 63
#     y_even = x[i]
#     y_odd = x[i+64]
#     y[i * 2] = y_even + W^0_128 * y_odd
#     y[i * 2 + 1] = y_even - W^0_128 * y_odd
# end

LS SR5 SR0 3        # SR5 = 64
LS SR6 SR0 4        # SR6 = 128
LS SR7 SR0 5        # SR7 = 256

# handle real part first
ADD SR3 SR0 SR7         # SR3 = &Re(X[0]) (256)
ADD SR4 SR5 SR7         # SR4 = &Re(X[64]) (320)
LV  VR1 SR3             # VR1 = Re(y_even)
LV  VR2 SR4             # VR2 = Re(y_odd)
LS SR2 SR0 6            # SR2 = Re(W^0_128)
MULVS VR2 VR2 SR2       # VR2 = W^0_128 * y_odd
ADDVV VR3 VR1 VR2       # VR3 = y_even + W^0_128 * y_odd
SUBVV VR4 VR1 VR2       # VR4 = y_even - W^0_128 * y_odd
UNPACKLO VR5 VR3 VR4    # VR5 = y[0:63]
UNPACKHI VR6 VR3 VR4    # VR6 = y[64:127]
LS SR1 SR0 8            # SR1 = 640
SV VR5 SR1
ADD SR1 SR1 SR5         # SR1 += 64
SV VR6 SR1

# handle imaginary part
ADD SR3 SR6 SR7         # SR3 = 128 + 256 = 384
ADD SR4 SR3 SR5         # SR4 = 384 + 64 = 448
LV  VR1 SR3             # VR1 = Im(y_even)
LV  VR2 SR4             # VR2 = Im(y_odd)
LS SR2 SR0 7            # SR2 = Im(W^0_128)
MULVS VR2 VR2 SR2       # VR2 = W^0_128 * y_odd
ADDVV VR3 VR1 VR2       # VR3 = y_even + W^0_128 * y_odd
SUBVV VR4 VR1 VR2       # VR4 = y_even - W^0_128 * y_odd
UNPACKLO VR5 VR3 VR4    # VR5 = y[0:63]
UNPACKHI VR6 VR3 VR4    # VR6 = y[64:127]
LS SR1 SR0 9            # SR1 = 768
SV VR5 SR1
ADD SR1 SR1 SR5         # SR1 += 64
SV VR6 SR1

# 32 4-point FFTs
for i = 0 to 31
    y_even = fft(x[i], x[i + 64], 2)
    y_odd = fft(x[i + 32], x[i + 96], 2)
    for k = 0 to 1
        y[i * 4 + k] = y_even[k] + W^k_128 * y_odd[k]
        y[i * 4 + k + 2] = y_even[k] - W^k_128 * y_odd[k]
    end
end

HALT
