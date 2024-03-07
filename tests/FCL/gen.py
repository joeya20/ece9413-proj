from random import randint

def main():
    with open('SDMEM.txt', '+w') as sdmem:
        for i in range(256):
            sdmem.write(f'{i}\n')
        sdmem.write('66304')

    with open('VDMEM.txt', '+w') as vdmem:
        # write a, then b, then W
        for _ in range(256):
            vdmem.write('0\n')
        for _ in range(66048):
            vdmem.write(f'{randint(-5, 5)}\n')


if __name__=='__main__':
    main()
