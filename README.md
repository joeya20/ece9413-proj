# ECE 9413 Final Project

## Directory structure
```bash
├── ECE-GY-9413 - Project Description - Functional Simulator.pdf # Project spec
├── README.md
├── run_tests.sh    # bash script to run all tests in ./tests
├── simulator.py    # simulator
└── tests           # test directory
    ├── ISA_Sample  # sample test provided
    └── test1
```

## Usage
The simulator accepts a directory as a command line argument, which must contain the following files:
- Code.asm: The le should contain your assembly code for the test function. The sample le (Code.asm)
released with this document shows the syntax for all the instructions in the ISA.
- SDMEM.txt: The le should contain the initial state of the SDMEM containing the data required for the
test function in integer format. Each line in this le represents one word (32 bit) of data in the SDMEM.
- VDMEM.txt: The le should contain the initial state of the VDMEM containing the data required for the
test function in integer format. Each line in this le represents one word (32 bit) of data in the VDMEM

```bash
python simulator.py </path/to/IODIR>
```

## Testing
A test script is provided to run all tests in ./tests

```bash
./run_test.sh
```
