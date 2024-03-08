import numpy as np


def main():
    with open('VDMEMOP.txt') as vdmem:
        vdmem_lines = vdmem.readlines()
        
    # we have to read directly from VDMEM for inputs since they are
    # randomly generated using gen.py
    a = np.array(vdmem_lines[256:512], dtype=np.int32)
    W = np.reshape(np.array(vdmem_lines[512:66048], dtype=np.int32), (-1, 256))
    b = np.array(vdmem_lines[66048:66304], dtype=np.int32)

    # we have to transpose W because of the way we construct W
    # each weight vector is initially a row when it should be a column
    dot_expected = np.dot(a, W.T)
    dot_actual = np.array(vdmem_lines[66304:66560], dtype=np.int32)
    # compare results and reduce using AND
    print(f'dot product output valid: {np.logical_and.reduce(dot_actual == dot_expected)}')
    
    fcl_expected = dot_expected + b
    fcl_actual = np.array(vdmem_lines[:256], dtype=np.int32)
    # compare results and reduce using AND
    print(f'FCL output valid: {np.logical_and.reduce(fcl_expected == fcl_actual)}')


if __name__ == '__main__':
    main()
