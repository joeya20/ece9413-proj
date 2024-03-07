import numpy as np


def main():
    with open('VDMEMOP.txt') as vdmem:
        vdmem_lines = vdmem.readlines()
        
    # we have to read directly from VDMEM for inputs since they are
    # randomly generated using gen.py
    a = np.array(vdmem_lines[256:512], dtype=np.int32)
    W = np.reshape(np.array(vdmem_lines[512:66048], dtype=np.int32), (-1, 256))
    b = np.array(vdmem_lines[66048:66304], dtype=np.int32)

    dot_res = np.dot(W, a)
    dot_out = np.array(vdmem_lines[66304:66560], dtype=np.int32)
    print(dot_res == dot_out)
    final_res = dot_res + b
    final_out = np.array(vdmem_lines[:256], dtype=np.int32)
    print(final_res == final_out)


if __name__=='__main__':
    main()
