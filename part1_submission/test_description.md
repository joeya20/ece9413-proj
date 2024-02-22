# Testing

## Dot Product
To run the dot product test:
```bash
python simulator.py --iodir <path to IO>
```

Input:
- code is contained in tests/Code.asm
- tests/VDMEM.txt and tests/SRMEM.txt intialize the Vector Data Memory and Scalar Data Memory respectively

Output:
- output/SDMEMOP.txt    : final state of Scalar Data Memory
- output/VDMEMOP.txt    : final state of Vector Data Memory
- output/SRF.txt        : final state of Scalar Register File
- output/VRF.txt        : final state of Vector Register File

## ISA Test

The ISA test was implemented as a set of unit tests (as OK'd by Tim).

### Description
The test suite is implemented as a set of python unit tests using the unittest package in *test.py*.
It contains one test for each instruction variant (28 base instructions + all variations), and one instruction to test the VLR and mask functionality.
The unit tests are implemented as functions with the following naming scheme: "test_{instruction}", where instuction is the mnemonic of the instruction under test.
The tests are fairly simple and test for functional correctness for one or two set of inputs, depending on the instruction (e.g., branching instruction tests check for taken and not taken behaviour). 

A temp directory is created before each test to serve as input for the simulator and deleted after the completion of the test. This is strictly to adhere to the IO and does not serve any functional purpose. Each test is self-isolated and modifies the instruction memory, (scalar and vector) data memory, and (scalar and vector) register files before executing the simulator. The result of each test is then verified using an appropriate assert*(...) statement.

### Instructions
to run the entire test suite:
```bash
python -m tests.unittest [-vbf] # it is necessary to call it as a module
```

to run a specific test:
```bash
python -m tests.unittest TestCore.<test_name> [-vbf]  # it is necessary to call it as a module
```

-v for verbose errors  
-b to buffer stdout from simulator.py  
-f to exit after first error is encountered  

**This REQUIRES that funcsimulator.py is in the same directory as tests/**
