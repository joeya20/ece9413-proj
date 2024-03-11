#Run with python simulator.py --iodir tests\conv2D
#Optimized to minimize vector loads
#results start at address 100

LS SR7 SR0 23      #store value 31 for addressing
LS SR6 SR0 31      #store value 16 for vlen
LS SR5 SR0 25      #store value 127 for output row & column length comparison without padding
LS SR1 SR0 1       #store 1
LS SR3 SR0 0       #row-wise counter
LS SR2 SR0 0       #column-wise counter
MTCL SR6           #set vlen=16
LV VR1 SR0         #load filter/kernel into VR1
ADD SR4 SR4 SR6    #increment address by 16
LV VR2 SR4         #load first possible window pattern for convolution
ADD SR4 SR4 SR6    #increment address by 16
LV VR3 SR4         #load second possible window pattern for convolution
ADD SR4 SR4 SR6    #increment address by 16
LV VR4 SR4         #load third possible window pattern for convolution
LS SR4 SR0 21      #use SR4 as a destination address counter now, results start at address 100
LS SR7 SR0 23      #store value 31 for loop
LS SR6 SR0 31      #store value 16 for loop
MTCL SR6           #set vlen
SUB SR7 SR7 SR1    #decrement vlen address
LS SR6 SR7 0       #store new halved vlen (to be set later)
MULVV VR5 VR1 VR2  #multiply window by filter
PACKLO VR6 VR5 VR0 #pack low for addition
PACKHI VR7 VR5 VR0 #pack high for addition
MTCL SR6           #set new vector length
ADDVV VR5 VR6 VR7  #add split vectors
SUB SR7 SR7 SR1    #decrement vlen address
LS SR6 SR7 0       #store new halved vlen
BGE SR6 SR1 -6     #branch back to packs if addition not completed
SV VR5 SR4         #store in VDMEMOP, starting at address 100
ADD SR4 SR4 SR1    #increment store address
LS SR7 SR0 23      #reset vlen address
LS SR6 SR0 31      #reset vlen value
MTCL SR6           #set vlen to 16
ADD SR3 SR3 SR1    #increment row counter
BLT SR3 SR5 -15    #loop through row
LS SR7 SR0 23      #reset vlen address
LS SR6 SR0 31      #reset vlen value
MTCL SR6           #set vlen to 16
SUB SR7 SR7 SR1    #decrement vlen address
LS SR6 SR7 0       #store new halved vlen
MULVV VR5 VR1 VR3  #multiply by 2nd window pattern, i.e. end of row with padding to right
PACKLO VR6 VR5 VR0 #pack low for addition
PACKHI VR7 VR5 VR0 #pack high for addition
MTCL SR6           #set new vector length
ADDVV VR5 VR6 VR7  #add split vectors
SUB SR7 SR7 SR1    #decrement vlen address
LS SR6 SR7 0       #store new halved vlen
BGE SR6 SR1 -6     #branch back to packs if addition not completed
SV VR5 SR4         #store in VDMEMOP
ADD SR4 SR4 SR1    #increment store address
LS SR3 SR0 0       #reset row-wise counter
ADD SR2 SR2 SR1    #increment column-wise counter
BLT SR2 SR5 -37    #branch if there are more column-wise steps to take
LS SR7 SR0 23      #reset vlen address
LS SR6 SR0 31      #reset vlen value
MTCL SR6           #set vlen to 16
SUB SR7 SR7 SR1    #decrement vlen address
LS SR6 SR7 0       #store new halved vlen
MULVV VR5 VR1 VR4  #multiply by 3rd window pattern, i.e. bottom of the input matrix with zeros in last row
PACKLO VR6 VR5 VR0 #pack low for addition
PACKHI VR7 VR5 VR0 #pack high for addition
MTCL SR6           #set new vector length
ADDVV VR5 VR6 VR7  #add split vectors
SUB SR7 SR7 SR1    #decrement vlen address
LS SR6 SR7 0       #store new halved vlen
BGE SR6 SR1 -6     #branch back to packs if addition not completed
SV VR5 SR4         #store in VDMEMOP
ADD SR4 SR4 SR1    #increment store address
LS SR7 SR0 23      #reset vlen
LS SR6 SR0 31
MTCL SR6
ADD SR3 SR3 SR1    #increment row-wise counter
BLT SR3 SR5 -15    #branch if more row steps to go
LS SR7 SR0 23      #reset vlen
LS SR6 SR0 31
MTCL SR6
LS SR2 SR0 33      #store address for final window pattern
LV VR2 SR2         #load final window pattern in VR2 which is no longer in use
SUB SR7 SR7 SR1    #decrement vlen address
LS SR6 SR7 0       #store new halved vlen
MULVV VR5 VR1 VR2  #final multiplication step
PACKLO VR6 VR5 VR0 #final addition loop
PACKHI VR7 VR5 VR0
MTCL SR6
ADDVV VR5 VR6 VR7
SUB SR7 SR7 SR1
LS SR6 SR7 0
BGE SR6 SR1 -6
SV VR5 SR4          #store last value
HALT                #end
