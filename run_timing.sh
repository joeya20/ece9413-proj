#! /bin/sh

python funcsimulator.py --iodir "$1" --tb 1
python timingsimulator.py --iodir "$1"
diff "$1"/SRF.txt "$1"/SRF_timing.txt 
diff "$1"/VRF.txt "$1"/VRF_timing.txt 
diff "$1"/SDMEM_timing_OP.txt "$1"/SDMEMOP.txt 
diff "$1"/VDMEM_timing_OP.txt "$1"/VDMEMOP.txt
