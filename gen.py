with open('SDMEM.txt', '+w') as out:
    for i in range(256):
        out.write(f'{i}\n')
    out.write('66048')
