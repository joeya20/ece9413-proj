Run with python simulator.py --iodir tests\dot_product

LS SR7 SR0 31       #store 64 to be edited later
LS SR6 SR0 31       #store 64 for repeated use
LS SR5 SR0 25       #store 512 for comparison
LS SR1 SR0 1        #store 1 for iteration
ADD SR4 SR0 SR6     #use SR4 as accumulator for comparison
MTCL SR7            #set VLEN to 64
LV VR1 SR0          #load first 64 elements into VRF
LV VR2 SR0          #same as above
MULVV VR3 VR1 VR2   #multiplication step of dot product
ADDVV VR6 VR6 VR3   #accumulate addition in VR6
LV VR1 SR4          #load next 64 elements, branch here when looping
LV VR2 SR4          #again, load same vector
MULVV VR3 VR1 VR2   #multiplication
ADDVV VR6 VR6 VR3   #accumulate addition in VR6
ADD SR4 SR4 SR6     #increment for loop count
BLE SR4 SR5 -5      #branch if we haven't passed 450 elements yet
LS SR3 SR0 23       #store 30 for loop start point, representing address in SDMEM
LS SR4 SR0 22       #store 26 for loop end point
PACKLO VR4 VR6 VR0  #split the lower half of the vector for addition
PACKHI VR5 VR6 VR0  #split the upper half of the vector for addition
LS SR7 SR3 0        #load the new vector length which is half the old vector length
MTCL SR7            #set VLEN_new = VLEN_old / 2
ADDVV VR6 VR4 VR5   #sum the vectors and re-accumulate into VR6
SUB SR3 SR3 SR1     #decrement the position in SDMEM to where the new VLEN value is stored
BGE SR3 SR4 -6      #loop until VLEN = 2
PACKLO VR4 VR6 VR0  #split low
PACKHI VR5 VR6 VR0  #split high
MTCL SR1            #set VLEN = 1
ADDVV VR6 VR4 VR5   #final summation
LS SR2 SR0 24       #load value 2048 for address in VDMEM
SV VR6 SR2          #store final value in VDMEM
HALT                #end
