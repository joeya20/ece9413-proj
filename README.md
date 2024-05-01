# ECE 9413 Final Project

## Usage
The functional simulator accepts a directory as a command line argument, which must contain the following files:
- Code.asm: The le should contain your assembly code for the test function. The sample le (Code.asm)
released with this document shows the syntax for all the instructions in the ISA.
- SDMEM.txt: The le should contain the initial state of the SDMEM containing the data required for the
test function in integer format. Each line in this le represents one word (32 bit) of data in the SDMEM.
- VDMEM.txt: The le should contain the initial state of the VDMEM containing the data required for the
test function in integer format. Each line in this le represents one word (32 bit) of data in the VDMEM


The timing simulator depends on the dynamic trace generated by the functional simulator. There are two ways it can be used, as shown below.
It requires two additional files on top of the files needed by the functional simulator:
- resolved_code.asm (automatically generated by funcsimulator.py)
- Config.txt

It will output the number of cycles needed in stdout with the following format: "total cycles: <num_cycles>"
Option 1:
```bash
python funcsimulator.py --iodir <path> --tb 1 # generate trace in iodir
python timingsimulator.py --iodir <path>
```

Option 2:
```bash
chmod +x run_timing.sh
./run_timing.sh <iodir_path>
```

Option 2 will automatically use the functional simulator to generate the dynamic trace and diff the output afterward to validate its behavior.
