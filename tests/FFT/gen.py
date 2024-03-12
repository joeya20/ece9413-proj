import re
from random import randint


def parse_twiddle():
    re_fcts = []
    im_fcts = []
    # https://regex101.com/r/ddQDDq/1
    pattern = re.compile('W_[0-9]+\s=\s(?P<real>-*[0-9]+\.[0-9]+)(?P<imag>(?:\+|-)[0-9]+\.[0-9]+)j')
    with open('twiddle_factors.txt', 'r') as in_file:
        for line in in_file.readlines():
            match = pattern.match(line)
            if match:
                re_fcts.append(str(int(float(match.group('real')) * 1000)) + '\n')
                imag_str = str(match.group('imag'))
                if imag_str.startswith('+'):
                    imag_str = imag_str[1:]
                im_fcts.append(str(int(float(imag_str) * 1000)) + '\n')
    return (re_fcts, im_fcts)


def gen():
    with open('VDMEM.txt', '+w') as out_file:
        # allocate space for output
        out_file.writelines(['0\n'] * 256)
        
        # write randomly generated input
        for _ in range(256):
            out_file.write(str(randint(-1000, 1000)) + '\n')
        
        # write twiddles
        (re_fcts, im_fcts) = parse_twiddle()
        out_file.writelines(re_fcts)
        out_file.writelines(im_fcts)

gen()
