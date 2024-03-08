import numpy as np


def main():
    with open('VDMEMOP.txt') as vdmem:
        vdmem_lines = vdmem.readlines()
        
    # we have to read directly from VDMEM for inputs since they are
    # randomly generated using gen.py
    x = np.array(vdmem_lines[256:512], dtype=np.int32)

if __name__ == '__main__':
    main()
