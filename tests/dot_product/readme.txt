Run with python simulator.py --iodir tests\dot_product

LS SR7 SR0 31       #store 64 to be edited later
LS SR6 SR0 31       #store 64 for repeated use
LS SR5 SR0 25       #store 512 for comparison
ADD SR4 SR0 SR6     #use SR4 as accumulator for comparison
MTCL SR7            #set VLEN to 64
LV VR1 SR0          #load first 64 elements into VRF
LV VR2 SR0          #same as above
MULVV VR3 VR1 VR2   #multiplication step of dot product
ADDVV VR6 VR6 VR3   #accumulate addition in VR6
LV VR1 SR4          #load next 64 elements, branch here when looping
LV VR2 SR4  
MULVV VR3 VR1 VR2   #multiplication
ADDVV VR6 VR6 VR3   #accumulate addition in VR6
ADD SR4 SR4 SR6     #increment for loop count
BLE SR4 SR5 -5      #branch if we haven't passed 450 elements yet
PACKLO VR4 VR6 VR0  #once accumulating addition is done, begin breaking down the vector
PACKHI VR5 VR6 VR0  #packlo for the bottom half, packhi for the top half
LS SR7 SR0 30       #store next VLEN step down, in this case 32
MTCL SR7            #halve the VLEN
ADDVV VR6 VR4 VR5   #add both halves of the original vector back into VR6
PACKLO VR4 VR6 VR0  #repeat splitting the vector
PACKHI VR5 VR6 VR0
LS SR7 SR0 29       #repeat halving the vector length to 16
MTCL SR7
ADDVV VR6 VR4 VR5
PACKLO VR4 VR6 VR0  #split for vector length 8
PACKHI VR5 VR6 VR0
LS SR7 SR0 28       #halve to VLEN=8
MTCL SR7
ADDVV VR6 VR4 VR5
PACKLO VR4 VR6 VR0  #split for VLEN = 4
PACKHI VR5 VR6 VR0
LS SR7 SR0 27       #halve VLEN to 4
MTCL SR7
ADDVV VR6 VR4 VR5 
PACKLO VR4 VR6 VR0  #split for VLEN = 2
PACKHI VR5 VR6 VR0
LS SR7 SR0 26       #halve to VLEN = 2
MTCL SR7
ADDVV VR6 VR4 VR5
PACKLO VR4 VR6 VR0  #final split
PACKHI VR5 VR6 VR0
LS SR7 SR0 1        #set VLEN to 1
MTCL SR7
ADDVV VR6 VR4 VR5   #calculate final value
LS SR2 SR0 24       #get 2048 for VDMEM location
SV VR6 SR2          #store final value in VDMEM address 2048 (line 2049 of output)
HALT                #end
