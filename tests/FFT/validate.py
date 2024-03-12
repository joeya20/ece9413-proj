import numpy as np


def main():
    with open('VDMEMOP.txt') as vdmem:
        vdmem_lines = vdmem.readlines()
        
    # we have to read directly from VDMEM for inputs since they are
    # randomly generated using gen.py
    x_re = np.array(vdmem_lines[256:384], dtype=np.int32)
    x_im = np.array(vdmem_lines[384:512], dtype=np.int32)
    W0_re = np.array([vdmem_lines[512] for _ in range(64)], dtype=np.int32)
    W0_im = np.array([vdmem_lines[576] for _ in range(64)], dtype=np.int32)
    
    y_re_actual = np.array(vdmem_lines[640:768], dtype=np.int32)
    y_im_actual = np.array(vdmem_lines[768:896], dtype=np.int32)
    
    y_even_re = x_re[:64]
    y_odd_re = x_re[64:]
    y_even_im = x_im[:64]
    y_odd_im = x_im[64:]
    
    w_y_odd_re = W0_re * y_odd_re + y_odd_im * W0_im
    w_y_odd_im = W0_im * y_odd_re + y_odd_im * W0_re
    y_0_re = y_even_re + w_y_odd_re
    y_1_re = y_even_re - w_y_odd_re
    y_0_im = y_even_im + w_y_odd_im
    y_1_im = y_even_im - w_y_odd_im
    
    y_re = np.zeros(shape=(128,), dtype=np.int32)
    y_re[0:128:2] = y_0_re / 1000
    y_re[1:128:2] = y_1_re / 1000
    y_re = y_re.astype(np.int32)
    
    y_im = np.zeros(shape=(128,), dtype=np.int32)
    y_im[0:128:2] = y_0_im / 1000
    y_im[1:128:2] = y_1_im / 1000
    y_im = y_im.astype(np.int32)
    
    print(y_re_actual == y_re)
    print(y_im_actual == y_im)

    # checking output of second stage
    # W0_re = np.array([vdmem_lines[512] for _ in range(32)], dtype=np.int32)
    # W0_im = np.array([vdmem_lines[576] for _ in range(32)], dtype=np.int32)
    # W32_re = np.array([vdmem_lines[512+32] for _ in range(32)], dtype=np.int32)
    # W32_im = np.array([vdmem_lines[576+32] for _ in range(32)], dtype=np.int32)

    # w0_y_odd_re = W0_re * y_re[64::2] + y_im[64::2] * W0_im
    # w0_y_odd_im = W0_im * y_re[64::2] + y_re[64::2] * W0_re
    # w32_y_odd_re = W32_re * y_re[65::2] + y_im[65::2] * W0_im
    # w32_y_odd_im = W32_im * y_re[65::2] + y_re[65::2] * W0_re
    # y_0_re = y_re[:64:2] + w0_y_odd_re
    # y_1_re = y_re[:64:2] - w0_y_odd_re
    # y_2_re = y_re[1:64:2] + w32_y_odd_re
    # y_3_re = y_re[1:64:2] - w32_y_odd_re
    
    # y_0_im = y_im[:64:2] + w0_y_odd_im
    # y_1_im = y_im[:64:2] - w0_y_odd_im
    # y_2_im = y_im[1:64:2] + w32_y_odd_im
    # y_3_im = y_im[1:64:2] - w32_y_odd_im
    
    # y_re = np.zeros(shape=(128,), dtype=np.int32)
    # y_re[0:128:4] = y_0_re / 1000
    # y_re[2:128:4] = y_1_re / 1000
    # y_re[1:128:4] = y_2_re / 1000
    # y_re[3:128:4] = y_3_re / 1000
    # y_re = y_re.astype(np.int32)
    
    # y_im = np.zeros(shape=(128,), dtype=np.int32)
    # y_im[0:128:4] = y_0_im / 1000
    # y_im[2:128:4] = y_1_im / 1000
    # y_re[1:128:4] = y_2_im / 1000
    # y_re[3:128:4] = y_3_im / 1000
    # y_im = y_im.astype(np.int32)
    
    # y_re_actual = np.array(vdmem_lines[896:1024], dtype=np.int32)
    # y_im_actual = np.array(vdmem_lines[1024:1152], dtype=np.int32)
    
    # print(y_re_actual == y_re)
    # print(y_im_actual == y_im)
    
if __name__ == '__main__':
    main()
