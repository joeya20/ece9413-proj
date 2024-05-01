LS SR5 SR0 3            # SR5 = 64
LS SR6 SR0 4            # SR6 = 128
LS SR7 SR0 5            # SR7 = 256
ADD SR4 SR5 SR7         # SR4 = 64 + 256 = 320 = pointer to Re(y_odd)
LV VR2 [320, 321, 322, 323, 324, 325, 326, 327, 328, 329, 330, 331, 332, 333, 334, 335, 336, 337, 338, 339, 340, 341, 342, 343, 344, 345, 346, 347, 348, 349, 350, 351, 352, 353, 354, 355, 356, 357, 358, 359, 360, 361, 362, 363, 364, 365, 366, 367, 368, 369, 370, 371, 372, 373, 374, 375, 376, 377, 378, 379, 380, 381, 382, 383]
LS SR2 SR0 10           # SR2 = 512 = pointer to Re(W^0_128)
LVI VR7 [512, 512, 512, 512, 512, 512, 512, 512, 512, 512, 512, 512, 512, 512, 512, 512, 512, 512, 512, 512, 512, 512, 512, 512, 512, 512, 512, 512, 512, 512, 512, 512, 512, 512, 512, 512, 512, 512, 512, 512, 512, 512, 512, 512, 512, 512, 512, 512, 512, 512, 512, 512, 512, 512, 512, 512, 512, 512, 512, 512, 512, 512, 512, 512]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR4 SR6         # SR1 = pointer to Im(y_odd)
LV VR6 [448, 449, 450, 451, 452, 453, 454, 455, 456, 457, 458, 459, 460, 461, 462, 463, 464, 465, 466, 467, 468, 469, 470, 471, 472, 473, 474, 475, 476, 477, 478, 479, 480, 481, 482, 483, 484, 485, 486, 487, 488, 489, 490, 491, 492, 493, 494, 495, 496, 497, 498, 499, 500, 501, 502, 503, 504, 505, 506, 507, 508, 509, 510, 511]
LS SR2 SR0 14           # SR2 = pointer to Im(W^0_128)
LVI VR5 [576, 576, 576, 576, 576, 576, 576, 576, 576, 576, 576, 576, 576, 576, 576, 576, 576, 576, 576, 576, 576, 576, 576, 576, 576, 576, 576, 576, 576, 576, 576, 576, 576, 576, 576, 576, 576, 576, 576, 576, 576, 576, 576, 576, 576, 576, 576, 576, 576, 576, 576, 576, 576, 576, 576, 576, 576, 576, 576, 576, 576, 576, 576, 576]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
LS SR4 SR0 5            # SR4 = 256 -- pointer to Re(y_even)
LV VR3 [256, 257, 258, 259, 260, 261, 262, 263, 264, 265, 266, 267, 268, 269, 270, 271, 272, 273, 274, 275, 276, 277, 278, 279, 280, 281, 282, 283, 284, 285, 286, 287, 288, 289, 290, 291, 292, 293, 294, 295, 296, 297, 298, 299, 300, 301, 302, 303, 304, 305, 306, 307, 308, 309, 310, 311, 312, 313, 314, 315, 316, 317, 318, 319]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
LS SR4 SR0 19           # SR4 = 384 -- pointer to Im(y_even)
LV VR3 [384, 385, 386, 387, 388, 389, 390, 391, 392, 393, 394, 395, 396, 397, 398, 399, 400, 401, 402, 403, 404, 405, 406, 407, 408, 409, 410, 411, 412, 413, 414, 415, 416, 417, 418, 419, 420, 421, 422, 423, 424, 425, 426, 427, 428, 429, 430, 431, 432, 433, 434, 435, 436, 437, 438, 439, 440, 441, 442, 443, 444, 445, 446, 447]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 8            # SR1 = pointer to Re(y_0[0])
LS SR2 SR0 1
ADD SR2 SR1 SR2         # SR2 = pointer to Re(y_0[1])
LS SR3 SR0 2            # load output stride
LS SR4 SR0 36           # SR4 = 1000
DIVVS VR4 VR4 SR4       # VR4 /= 1000
DIVVS VR7 VR7 SR4       # VR4 /= 1000
DIVVS VR6 VR6 SR4       # VR4 /= 1000
DIVVS VR5 VR5 SR4       # VR4 /= 1000
SVWS VR4 [640, 642, 644, 646, 648, 650, 652, 654, 656, 658, 660, 662, 664, 666, 668, 670, 672, 674, 676, 678, 680, 682, 684, 686, 688, 690, 692, 694, 696, 698, 700, 702, 704, 706, 708, 710, 712, 714, 716, 718, 720, 722, 724, 726, 728, 730, 732, 734, 736, 738, 740, 742, 744, 746, 748, 750, 752, 754, 756, 758, 760, 762, 764, 766]
SVWS VR7 [641, 643, 645, 647, 649, 651, 653, 655, 657, 659, 661, 663, 665, 667, 669, 671, 673, 675, 677, 679, 681, 683, 685, 687, 689, 691, 693, 695, 697, 699, 701, 703, 705, 707, 709, 711, 713, 715, 717, 719, 721, 723, 725, 727, 729, 731, 733, 735, 737, 739, 741, 743, 745, 747, 749, 751, 753, 755, 757, 759, 761, 763, 765, 767]
ADD SR1 SR1 SR6         # SR1 = pointer to Im(y_0[0])
ADD SR2 SR2 SR6         # SR1 = pointer to Im(y_0[1])
SVWS VR6 [768, 770, 772, 774, 776, 778, 780, 782, 784, 786, 788, 790, 792, 794, 796, 798, 800, 802, 804, 806, 808, 810, 812, 814, 816, 818, 820, 822, 824, 826, 828, 830, 832, 834, 836, 838, 840, 842, 844, 846, 848, 850, 852, 854, 856, 858, 860, 862, 864, 866, 868, 870, 872, 874, 876, 878, 880, 882, 884, 886, 888, 890, 892, 894]
SVWS VR5 [769, 771, 773, 775, 777, 779, 781, 783, 785, 787, 789, 791, 793, 795, 797, 799, 801, 803, 805, 807, 809, 811, 813, 815, 817, 819, 821, 823, 825, 827, 829, 831, 833, 835, 837, 839, 841, 843, 845, 847, 849, 851, 853, 855, 857, 859, 861, 863, 865, 867, 869, 871, 873, 875, 877, 879, 881, 883, 885, 887, 889, 891, 893, 895]
LS SR1 SR0 11           # SR1 = 32
MTCL SR1                # VLR = 32
LS SR7 SR0 2            # SR7 = 2 = input stride
LS SR6 SR0 4            # SR6 = 128 = offset from y_Re to y_Im
LS SR5 SR0 3            # SR5 = 64 = offset from y_even to y_odd and w_Re and w_Im
LS SR4 SR0 13           # SR5 = 896 = pointer to Re(y_1[0]) (Re(y_odd))
LS SR3 SR0 20           # SR3 = 704 = pointer to Re(y_0[64]) (Re(y_odd))
LS SR2 SR0 10           # SR2 = 512 = pointer to Re(W^0_128)
LVWS VR2 [704, 706, 708, 710, 712, 714, 716, 718, 720, 722, 724, 726, 728, 730, 732, 734, 736, 738, 740, 742, 744, 746, 748, 750, 752, 754, 756, 758, 760, 762, 764, 766]
LVI VR7 [512, 512, 512, 512, 512, 512, 512, 512, 512, 512, 512, 512, 512, 512, 512, 512, 512, 512, 512, 512, 512, 512, 512, 512, 512, 512, 512, 512, 512, 512, 512, 512]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 704 + 128 = pointer to Im(y_odd)
LVWS VR6 [832, 834, 836, 838, 840, 842, 844, 846, 848, 850, 852, 854, 856, 858, 860, 862, 864, 866, 868, 870, 872, 874, 876, 878, 880, 882, 884, 886, 888, 890, 892, 894]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [576, 576, 576, 576, 576, 576, 576, 576, 576, 576, 576, 576, 576, 576, 576, 576, 576, 576, 576, 576, 576, 576, 576, 576, 576, 576, 576, 576, 576, 576, 576, 576]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [512, 514, 516, 518, 520, 522, 524, 526, 528, 530, 532, 534, 536, 538, 540, 542, 544, 546, 548, 550, 552, 554, 556, 558, 560, 562, 564, 566, 568, 570, 572, 574]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [640, 642, 644, 646, 648, 650, 652, 654, 656, 658, 660, 662, 664, 666, 668, 670, 672, 674, 676, 678, 680, 682, 684, 686, 688, 690, 692, 694, 696, 698, 700, 702]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 12           # SR1 = 4 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 2            # SR7 = 2
SVWS VR4 [896, 900, 904, 908, 912, 916, 920, 924, 928, 932, 936, 940, 944, 948, 952, 956, 960, 964, 968, 972, 976, 980, 984, 988, 992, 996, 1000, 1004, 1008, 1012, 1016, 1020]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[2])
SVWS VR7 [898, 902, 906, 910, 914, 918, 922, 926, 930, 934, 938, 942, 946, 950, 954, 958, 962, 966, 970, 974, 978, 982, 986, 990, 994, 998, 1002, 1006, 1010, 1014, 1018, 1022]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [1026, 1030, 1034, 1038, 1042, 1046, 1050, 1054, 1058, 1062, 1066, 1070, 1074, 1078, 1082, 1086, 1090, 1094, 1098, 1102, 1106, 1110, 1114, 1118, 1122, 1126, 1130, 1134, 1138, 1142, 1146, 1150]
SUB SR4 SR4 SR7         # SR1 = SR1 - 2 = pointer to Im(y_1[0])
SVWS VR6 [1024, 1028, 1032, 1036, 1040, 1044, 1048, 1052, 1056, 1060, 1064, 1068, 1072, 1076, 1080, 1084, 1088, 1092, 1096, 1100, 1104, 1108, 1112, 1116, 1120, 1124, 1128, 1132, 1136, 1140, 1144, 1148]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 6            # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 6            # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [705, 707, 709, 711, 713, 715, 717, 719, 721, 723, 725, 727, 729, 731, 733, 735, 737, 739, 741, 743, 745, 747, 749, 751, 753, 755, 757, 759, 761, 763, 765, 767]
LVI VR7 [544, 544, 544, 544, 544, 544, 544, 544, 544, 544, 544, 544, 544, 544, 544, 544, 544, 544, 544, 544, 544, 544, 544, 544, 544, 544, 544, 544, 544, 544, 544, 544]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 704 + 128 = pointer to Im(y_odd)
LVWS VR6 [833, 835, 837, 839, 841, 843, 845, 847, 849, 851, 853, 855, 857, 859, 861, 863, 865, 867, 869, 871, 873, 875, 877, 879, 881, 883, 885, 887, 889, 891, 893, 895]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [608, 608, 608, 608, 608, 608, 608, 608, 608, 608, 608, 608, 608, 608, 608, 608, 608, 608, 608, 608, 608, 608, 608, 608, 608, 608, 608, 608, 608, 608, 608, 608]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [544, 546, 548, 550, 552, 554, 556, 558, 560, 562, 564, 566, 568, 570, 572, 574, 576, 578, 580, 582, 584, 586, 588, 590, 592, 594, 596, 598, 600, 602, 604, 606]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [672, 674, 676, 678, 680, 682, 684, 686, 688, 690, 692, 694, 696, 698, 700, 702, 704, 706, 708, 710, 712, 714, 716, 718, 720, 722, 724, 726, 728, 730, 732, 734]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 12           # SR1 = 4 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 2            # SR7 = 2
SVWS VR4 [897, 901, 905, 909, 913, 917, 921, 925, 929, 933, 937, 941, 945, 949, 953, 957, 961, 965, 969, 973, 977, 981, 985, 989, 993, 997, 1001, 1005, 1009, 1013, 1017, 1021]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[2])
SVWS VR7 [899, 903, 907, 911, 915, 919, 923, 927, 931, 935, 939, 943, 947, 951, 955, 959, 963, 967, 971, 975, 979, 983, 987, 991, 995, 999, 1003, 1007, 1011, 1015, 1019, 1023]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [1027, 1031, 1035, 1039, 1043, 1047, 1051, 1055, 1059, 1063, 1067, 1071, 1075, 1079, 1083, 1087, 1091, 1095, 1099, 1103, 1107, 1111, 1115, 1119, 1123, 1127, 1131, 1135, 1139, 1143, 1147, 1151]
SUB SR4 SR4 SR7         # SR1 = SR1 - 2 = pointer to Im(y_1[0])
SVWS VR6 [1025, 1029, 1033, 1037, 1041, 1045, 1049, 1053, 1057, 1061, 1065, 1069, 1073, 1077, 1081, 1085, 1089, 1093, 1097, 1101, 1105, 1109, 1113, 1117, 1121, 1125, 1129, 1133, 1137, 1141, 1145, 1149]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 6            # SR6 = k
ADD SR6 SR6 SR1         # k += 1
LS SR1 SR0 16           # SR1 = 16
MTCL SR1                # VLR = 16
LS SR7 SR0 12           # SR7 = 4 = input stride
LS SR6 SR0 4            # SR6 = 128 = offset from y_Re to y_Im
LS SR5 SR0 3            # SR5 = 64 = offset from y_even to y_odd and w_Re and w_Im
LS SR4 SR0 17           # SR5 = 1152 = pointer to Re(y_2[0])
LS SR3 SR0 23           # SR3 = 960 = pointer to Re(y_1[64]) (Re(y_odd))
LS SR2 SR0 10           # SR2 = 512 = pointer to Re(W^0_128)
LVWS VR2 [960, 964, 968, 972, 976, 980, 984, 988, 992, 996, 1000, 1004, 1008, 1012, 1016, 1020]
LVI VR7 [512, 512, 512, 512, 512, 512, 512, 512, 512, 512, 512, 512, 512, 512, 512, 512]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 704 + 128 = pointer to Im(y_odd)
LVWS VR6 [1088, 1092, 1096, 1100, 1104, 1108, 1112, 1116, 1120, 1124, 1128, 1132, 1136, 1140, 1144, 1148]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [576, 576, 576, 576, 576, 576, 576, 576, 576, 576, 576, 576, 576, 576, 576, 576]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [512, 516, 520, 524, 528, 532, 536, 540, 544, 548, 552, 556, 560, 564, 568, 572]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [640, 644, 648, 652, 656, 660, 664, 668, 672, 676, 680, 684, 688, 692, 696, 700]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 18           # SR1 = 8 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 12           # SR7 = 4 = input stride
SVWS VR4 [1152, 1160, 1168, 1176, 1184, 1192, 1200, 1208, 1216, 1224, 1232, 1240, 1248, 1256, 1264, 1272]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[4])
SVWS VR7 [1156, 1164, 1172, 1180, 1188, 1196, 1204, 1212, 1220, 1228, 1236, 1244, 1252, 1260, 1268, 1276]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [1284, 1292, 1300, 1308, 1316, 1324, 1332, 1340, 1348, 1356, 1364, 1372, 1380, 1388, 1396, 1404]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [1280, 1288, 1296, 1304, 1312, 1320, 1328, 1336, 1344, 1352, 1360, 1368, 1376, 1384, 1392, 1400]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 7            # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 7            # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [961, 965, 969, 973, 977, 981, 985, 989, 993, 997, 1001, 1005, 1009, 1013, 1017, 1021]
LVI VR7 [528, 528, 528, 528, 528, 528, 528, 528, 528, 528, 528, 528, 528, 528, 528, 528]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 704 + 128 = pointer to Im(y_odd)
LVWS VR6 [1089, 1093, 1097, 1101, 1105, 1109, 1113, 1117, 1121, 1125, 1129, 1133, 1137, 1141, 1145, 1149]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [592, 592, 592, 592, 592, 592, 592, 592, 592, 592, 592, 592, 592, 592, 592, 592]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [528, 532, 536, 540, 544, 548, 552, 556, 560, 564, 568, 572, 576, 580, 584, 588]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [656, 660, 664, 668, 672, 676, 680, 684, 688, 692, 696, 700, 704, 708, 712, 716]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 18           # SR1 = 8 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 12           # SR7 = 4 = input stride
SVWS VR4 [1153, 1161, 1169, 1177, 1185, 1193, 1201, 1209, 1217, 1225, 1233, 1241, 1249, 1257, 1265, 1273]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[4])
SVWS VR7 [1157, 1165, 1173, 1181, 1189, 1197, 1205, 1213, 1221, 1229, 1237, 1245, 1253, 1261, 1269, 1277]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [1285, 1293, 1301, 1309, 1317, 1325, 1333, 1341, 1349, 1357, 1365, 1373, 1381, 1389, 1397, 1405]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [1281, 1289, 1297, 1305, 1313, 1321, 1329, 1337, 1345, 1353, 1361, 1369, 1377, 1385, 1393, 1401]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 7            # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 7            # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [962, 966, 970, 974, 978, 982, 986, 990, 994, 998, 1002, 1006, 1010, 1014, 1018, 1022]
LVI VR7 [544, 544, 544, 544, 544, 544, 544, 544, 544, 544, 544, 544, 544, 544, 544, 544]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 704 + 128 = pointer to Im(y_odd)
LVWS VR6 [1090, 1094, 1098, 1102, 1106, 1110, 1114, 1118, 1122, 1126, 1130, 1134, 1138, 1142, 1146, 1150]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [608, 608, 608, 608, 608, 608, 608, 608, 608, 608, 608, 608, 608, 608, 608, 608]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [544, 548, 552, 556, 560, 564, 568, 572, 576, 580, 584, 588, 592, 596, 600, 604]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [672, 676, 680, 684, 688, 692, 696, 700, 704, 708, 712, 716, 720, 724, 728, 732]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 18           # SR1 = 8 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 12           # SR7 = 4 = input stride
SVWS VR4 [1154, 1162, 1170, 1178, 1186, 1194, 1202, 1210, 1218, 1226, 1234, 1242, 1250, 1258, 1266, 1274]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[4])
SVWS VR7 [1158, 1166, 1174, 1182, 1190, 1198, 1206, 1214, 1222, 1230, 1238, 1246, 1254, 1262, 1270, 1278]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [1286, 1294, 1302, 1310, 1318, 1326, 1334, 1342, 1350, 1358, 1366, 1374, 1382, 1390, 1398, 1406]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [1282, 1290, 1298, 1306, 1314, 1322, 1330, 1338, 1346, 1354, 1362, 1370, 1378, 1386, 1394, 1402]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 7            # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 7            # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [963, 967, 971, 975, 979, 983, 987, 991, 995, 999, 1003, 1007, 1011, 1015, 1019, 1023]
LVI VR7 [560, 560, 560, 560, 560, 560, 560, 560, 560, 560, 560, 560, 560, 560, 560, 560]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 704 + 128 = pointer to Im(y_odd)
LVWS VR6 [1091, 1095, 1099, 1103, 1107, 1111, 1115, 1119, 1123, 1127, 1131, 1135, 1139, 1143, 1147, 1151]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [624, 624, 624, 624, 624, 624, 624, 624, 624, 624, 624, 624, 624, 624, 624, 624]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [560, 564, 568, 572, 576, 580, 584, 588, 592, 596, 600, 604, 608, 612, 616, 620]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [688, 692, 696, 700, 704, 708, 712, 716, 720, 724, 728, 732, 736, 740, 744, 748]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 18           # SR1 = 8 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 12           # SR7 = 4 = input stride
SVWS VR4 [1155, 1163, 1171, 1179, 1187, 1195, 1203, 1211, 1219, 1227, 1235, 1243, 1251, 1259, 1267, 1275]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[4])
SVWS VR7 [1159, 1167, 1175, 1183, 1191, 1199, 1207, 1215, 1223, 1231, 1239, 1247, 1255, 1263, 1271, 1279]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [1287, 1295, 1303, 1311, 1319, 1327, 1335, 1343, 1351, 1359, 1367, 1375, 1383, 1391, 1399, 1407]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [1283, 1291, 1299, 1307, 1315, 1323, 1331, 1339, 1347, 1355, 1363, 1371, 1379, 1387, 1395, 1403]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 7            # SR6 = k
ADD SR6 SR6 SR1         # k += 1
LS SR1 SR0 18           # SR1 = 8
MTCL SR1                # VLR = 8
LS SR7 SR0 18           # SR7 = 8 = input stride
LS SR6 SR0 4            # SR6 = 128 = offset from y_Re to y_Im
LS SR5 SR0 3            # SR5 = 64 = offset from y_even to y_odd and w_Re and w_Im
LS SR4 SR0 24           # SR5 = 1408 = pointer to Re(y_3[0])
LS SR3 SR0 25           # SR3 = 1216 = pointer to Re(y_2[64]) (Re(y_odd))
LS SR2 SR0 10           # SR2 = 512 = pointer to Re(W^0_128)
LVWS VR2 [1216, 1224, 1232, 1240, 1248, 1256, 1264, 1272]
LVI VR7 [512, 512, 512, 512, 512, 512, 512, 512]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [1344, 1352, 1360, 1368, 1376, 1384, 1392, 1400]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [576, 576, 576, 576, 576, 576, 576, 576]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [512, 520, 528, 536, 544, 552, 560, 568]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [640, 648, 656, 664, 672, 680, 688, 696]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 26           # SR1 = 16 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 18           # SR7 = 8 = input stride
SVWS VR4 [1408, 1424, 1440, 1456, 1472, 1488, 1504, 1520]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[8])
SVWS VR7 [1416, 1432, 1448, 1464, 1480, 1496, 1512, 1528]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [1544, 1560, 1576, 1592, 1608, 1624, 1640, 1656]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [1536, 1552, 1568, 1584, 1600, 1616, 1632, 1648]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 27           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 27           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [1217, 1225, 1233, 1241, 1249, 1257, 1265, 1273]
LVI VR7 [520, 520, 520, 520, 520, 520, 520, 520]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [1345, 1353, 1361, 1369, 1377, 1385, 1393, 1401]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [584, 584, 584, 584, 584, 584, 584, 584]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [520, 528, 536, 544, 552, 560, 568, 576]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [648, 656, 664, 672, 680, 688, 696, 704]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 26           # SR1 = 16 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 18           # SR7 = 8 = input stride
SVWS VR4 [1409, 1425, 1441, 1457, 1473, 1489, 1505, 1521]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[8])
SVWS VR7 [1417, 1433, 1449, 1465, 1481, 1497, 1513, 1529]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [1545, 1561, 1577, 1593, 1609, 1625, 1641, 1657]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [1537, 1553, 1569, 1585, 1601, 1617, 1633, 1649]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 27           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 27           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [1218, 1226, 1234, 1242, 1250, 1258, 1266, 1274]
LVI VR7 [528, 528, 528, 528, 528, 528, 528, 528]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [1346, 1354, 1362, 1370, 1378, 1386, 1394, 1402]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [592, 592, 592, 592, 592, 592, 592, 592]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [528, 536, 544, 552, 560, 568, 576, 584]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [656, 664, 672, 680, 688, 696, 704, 712]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 26           # SR1 = 16 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 18           # SR7 = 8 = input stride
SVWS VR4 [1410, 1426, 1442, 1458, 1474, 1490, 1506, 1522]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[8])
SVWS VR7 [1418, 1434, 1450, 1466, 1482, 1498, 1514, 1530]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [1546, 1562, 1578, 1594, 1610, 1626, 1642, 1658]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [1538, 1554, 1570, 1586, 1602, 1618, 1634, 1650]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 27           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 27           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [1219, 1227, 1235, 1243, 1251, 1259, 1267, 1275]
LVI VR7 [536, 536, 536, 536, 536, 536, 536, 536]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [1347, 1355, 1363, 1371, 1379, 1387, 1395, 1403]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [600, 600, 600, 600, 600, 600, 600, 600]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [536, 544, 552, 560, 568, 576, 584, 592]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [664, 672, 680, 688, 696, 704, 712, 720]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 26           # SR1 = 16 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 18           # SR7 = 8 = input stride
SVWS VR4 [1411, 1427, 1443, 1459, 1475, 1491, 1507, 1523]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[8])
SVWS VR7 [1419, 1435, 1451, 1467, 1483, 1499, 1515, 1531]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [1547, 1563, 1579, 1595, 1611, 1627, 1643, 1659]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [1539, 1555, 1571, 1587, 1603, 1619, 1635, 1651]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 27           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 27           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [1220, 1228, 1236, 1244, 1252, 1260, 1268, 1276]
LVI VR7 [544, 544, 544, 544, 544, 544, 544, 544]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [1348, 1356, 1364, 1372, 1380, 1388, 1396, 1404]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [608, 608, 608, 608, 608, 608, 608, 608]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [544, 552, 560, 568, 576, 584, 592, 600]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [672, 680, 688, 696, 704, 712, 720, 728]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 26           # SR1 = 16 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 18           # SR7 = 8 = input stride
SVWS VR4 [1412, 1428, 1444, 1460, 1476, 1492, 1508, 1524]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[8])
SVWS VR7 [1420, 1436, 1452, 1468, 1484, 1500, 1516, 1532]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [1548, 1564, 1580, 1596, 1612, 1628, 1644, 1660]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [1540, 1556, 1572, 1588, 1604, 1620, 1636, 1652]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 27           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 27           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [1221, 1229, 1237, 1245, 1253, 1261, 1269, 1277]
LVI VR7 [552, 552, 552, 552, 552, 552, 552, 552]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [1349, 1357, 1365, 1373, 1381, 1389, 1397, 1405]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [616, 616, 616, 616, 616, 616, 616, 616]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [552, 560, 568, 576, 584, 592, 600, 608]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [680, 688, 696, 704, 712, 720, 728, 736]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 26           # SR1 = 16 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 18           # SR7 = 8 = input stride
SVWS VR4 [1413, 1429, 1445, 1461, 1477, 1493, 1509, 1525]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[8])
SVWS VR7 [1421, 1437, 1453, 1469, 1485, 1501, 1517, 1533]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [1549, 1565, 1581, 1597, 1613, 1629, 1645, 1661]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [1541, 1557, 1573, 1589, 1605, 1621, 1637, 1653]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 27           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 27           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [1222, 1230, 1238, 1246, 1254, 1262, 1270, 1278]
LVI VR7 [560, 560, 560, 560, 560, 560, 560, 560]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [1350, 1358, 1366, 1374, 1382, 1390, 1398, 1406]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [624, 624, 624, 624, 624, 624, 624, 624]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [560, 568, 576, 584, 592, 600, 608, 616]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [688, 696, 704, 712, 720, 728, 736, 744]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 26           # SR1 = 16 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 18           # SR7 = 8 = input stride
SVWS VR4 [1414, 1430, 1446, 1462, 1478, 1494, 1510, 1526]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[8])
SVWS VR7 [1422, 1438, 1454, 1470, 1486, 1502, 1518, 1534]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [1550, 1566, 1582, 1598, 1614, 1630, 1646, 1662]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [1542, 1558, 1574, 1590, 1606, 1622, 1638, 1654]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 27           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 27           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [1223, 1231, 1239, 1247, 1255, 1263, 1271, 1279]
LVI VR7 [568, 568, 568, 568, 568, 568, 568, 568]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [1351, 1359, 1367, 1375, 1383, 1391, 1399, 1407]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [632, 632, 632, 632, 632, 632, 632, 632]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [568, 576, 584, 592, 600, 608, 616, 624]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [696, 704, 712, 720, 728, 736, 744, 752]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 26           # SR1 = 16 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 18           # SR7 = 8 = input stride
SVWS VR4 [1415, 1431, 1447, 1463, 1479, 1495, 1511, 1527]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[8])
SVWS VR7 [1423, 1439, 1455, 1471, 1487, 1503, 1519, 1535]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [1551, 1567, 1583, 1599, 1615, 1631, 1647, 1663]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [1543, 1559, 1575, 1591, 1607, 1623, 1639, 1655]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 27           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
LS SR1 SR0 12           # SR1 = 4
MTCL SR1                # VLR = 4
LS SR7 SR0 26           # SR7 = 16 = input stride
LS SR6 SR0 4            # SR6 = 128 = offset from y_Re to y_Im
LS SR5 SR0 3            # SR5 = 64 = offset from y_even to y_odd and w_Re and w_Im
LS SR4 SR0 28           # SR5 = 1664 = pointer to Re(y_4[0])
LS SR3 SR0 29           # SR3 = 1472 = pointer to Re(y_3[64]) (Re(y_odd))
LS SR2 SR0 10           # SR2 = 512 = pointer to Re(W^0_128)
LVWS VR2 [1472, 1488, 1504, 1520]
LVI VR7 [512, 512, 512, 512]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [1600, 1616, 1632, 1648]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [576, 576, 576, 576]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [512, 528, 544, 560]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [640, 656, 672, 688]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 11           # SR1 = 32 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 26           # SR7 = 16 = input stride
SVWS VR4 [1664, 1696, 1728, 1760]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [1680, 1712, 1744, 1776]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [1808, 1840, 1872, 1904]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [1792, 1824, 1856, 1888]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 30           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 30           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [1473, 1489, 1505, 1521]
LVI VR7 [516, 516, 516, 516]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [1601, 1617, 1633, 1649]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [580, 580, 580, 580]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [516, 532, 548, 564]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [644, 660, 676, 692]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 11           # SR1 = 32 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 26           # SR7 = 16 = input stride
SVWS VR4 [1665, 1697, 1729, 1761]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [1681, 1713, 1745, 1777]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [1809, 1841, 1873, 1905]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [1793, 1825, 1857, 1889]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 30           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 30           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [1474, 1490, 1506, 1522]
LVI VR7 [520, 520, 520, 520]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [1602, 1618, 1634, 1650]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [584, 584, 584, 584]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [520, 536, 552, 568]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [648, 664, 680, 696]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 11           # SR1 = 32 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 26           # SR7 = 16 = input stride
SVWS VR4 [1666, 1698, 1730, 1762]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [1682, 1714, 1746, 1778]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [1810, 1842, 1874, 1906]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [1794, 1826, 1858, 1890]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 30           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 30           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [1475, 1491, 1507, 1523]
LVI VR7 [524, 524, 524, 524]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [1603, 1619, 1635, 1651]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [588, 588, 588, 588]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [524, 540, 556, 572]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [652, 668, 684, 700]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 11           # SR1 = 32 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 26           # SR7 = 16 = input stride
SVWS VR4 [1667, 1699, 1731, 1763]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [1683, 1715, 1747, 1779]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [1811, 1843, 1875, 1907]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [1795, 1827, 1859, 1891]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 30           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 30           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [1476, 1492, 1508, 1524]
LVI VR7 [528, 528, 528, 528]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [1604, 1620, 1636, 1652]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [592, 592, 592, 592]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [528, 544, 560, 576]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [656, 672, 688, 704]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 11           # SR1 = 32 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 26           # SR7 = 16 = input stride
SVWS VR4 [1668, 1700, 1732, 1764]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [1684, 1716, 1748, 1780]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [1812, 1844, 1876, 1908]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [1796, 1828, 1860, 1892]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 30           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 30           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [1477, 1493, 1509, 1525]
LVI VR7 [532, 532, 532, 532]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [1605, 1621, 1637, 1653]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [596, 596, 596, 596]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [532, 548, 564, 580]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [660, 676, 692, 708]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 11           # SR1 = 32 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 26           # SR7 = 16 = input stride
SVWS VR4 [1669, 1701, 1733, 1765]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [1685, 1717, 1749, 1781]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [1813, 1845, 1877, 1909]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [1797, 1829, 1861, 1893]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 30           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 30           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [1478, 1494, 1510, 1526]
LVI VR7 [536, 536, 536, 536]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [1606, 1622, 1638, 1654]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [600, 600, 600, 600]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [536, 552, 568, 584]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [664, 680, 696, 712]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 11           # SR1 = 32 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 26           # SR7 = 16 = input stride
SVWS VR4 [1670, 1702, 1734, 1766]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [1686, 1718, 1750, 1782]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [1814, 1846, 1878, 1910]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [1798, 1830, 1862, 1894]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 30           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 30           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [1479, 1495, 1511, 1527]
LVI VR7 [540, 540, 540, 540]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [1607, 1623, 1639, 1655]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [604, 604, 604, 604]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [540, 556, 572, 588]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [668, 684, 700, 716]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 11           # SR1 = 32 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 26           # SR7 = 16 = input stride
SVWS VR4 [1671, 1703, 1735, 1767]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [1687, 1719, 1751, 1783]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [1815, 1847, 1879, 1911]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [1799, 1831, 1863, 1895]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 30           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 30           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [1480, 1496, 1512, 1528]
LVI VR7 [544, 544, 544, 544]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [1608, 1624, 1640, 1656]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [608, 608, 608, 608]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [544, 560, 576, 592]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [672, 688, 704, 720]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 11           # SR1 = 32 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 26           # SR7 = 16 = input stride
SVWS VR4 [1672, 1704, 1736, 1768]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [1688, 1720, 1752, 1784]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [1816, 1848, 1880, 1912]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [1800, 1832, 1864, 1896]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 30           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 30           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [1481, 1497, 1513, 1529]
LVI VR7 [548, 548, 548, 548]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [1609, 1625, 1641, 1657]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [612, 612, 612, 612]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [548, 564, 580, 596]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [676, 692, 708, 724]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 11           # SR1 = 32 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 26           # SR7 = 16 = input stride
SVWS VR4 [1673, 1705, 1737, 1769]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [1689, 1721, 1753, 1785]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [1817, 1849, 1881, 1913]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [1801, 1833, 1865, 1897]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 30           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 30           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [1482, 1498, 1514, 1530]
LVI VR7 [552, 552, 552, 552]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [1610, 1626, 1642, 1658]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [616, 616, 616, 616]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [552, 568, 584, 600]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [680, 696, 712, 728]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 11           # SR1 = 32 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 26           # SR7 = 16 = input stride
SVWS VR4 [1674, 1706, 1738, 1770]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [1690, 1722, 1754, 1786]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [1818, 1850, 1882, 1914]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [1802, 1834, 1866, 1898]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 30           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 30           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [1483, 1499, 1515, 1531]
LVI VR7 [556, 556, 556, 556]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [1611, 1627, 1643, 1659]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [620, 620, 620, 620]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [556, 572, 588, 604]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [684, 700, 716, 732]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 11           # SR1 = 32 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 26           # SR7 = 16 = input stride
SVWS VR4 [1675, 1707, 1739, 1771]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [1691, 1723, 1755, 1787]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [1819, 1851, 1883, 1915]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [1803, 1835, 1867, 1899]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 30           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 30           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [1484, 1500, 1516, 1532]
LVI VR7 [560, 560, 560, 560]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [1612, 1628, 1644, 1660]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [624, 624, 624, 624]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [560, 576, 592, 608]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [688, 704, 720, 736]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 11           # SR1 = 32 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 26           # SR7 = 16 = input stride
SVWS VR4 [1676, 1708, 1740, 1772]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [1692, 1724, 1756, 1788]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [1820, 1852, 1884, 1916]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [1804, 1836, 1868, 1900]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 30           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 30           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [1485, 1501, 1517, 1533]
LVI VR7 [564, 564, 564, 564]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [1613, 1629, 1645, 1661]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [628, 628, 628, 628]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [564, 580, 596, 612]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [692, 708, 724, 740]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 11           # SR1 = 32 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 26           # SR7 = 16 = input stride
SVWS VR4 [1677, 1709, 1741, 1773]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [1693, 1725, 1757, 1789]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [1821, 1853, 1885, 1917]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [1805, 1837, 1869, 1901]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 30           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 30           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [1486, 1502, 1518, 1534]
LVI VR7 [568, 568, 568, 568]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [1614, 1630, 1646, 1662]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [632, 632, 632, 632]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [568, 584, 600, 616]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [696, 712, 728, 744]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 11           # SR1 = 32 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 26           # SR7 = 16 = input stride
SVWS VR4 [1678, 1710, 1742, 1774]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [1694, 1726, 1758, 1790]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [1822, 1854, 1886, 1918]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [1806, 1838, 1870, 1902]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 30           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 30           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [1487, 1503, 1519, 1535]
LVI VR7 [572, 572, 572, 572]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [1615, 1631, 1647, 1663]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [636, 636, 636, 636]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [572, 588, 604, 620]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [700, 716, 732, 748]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 11           # SR1 = 32 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 26           # SR7 = 16 = input stride
SVWS VR4 [1679, 1711, 1743, 1775]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [1695, 1727, 1759, 1791]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [1823, 1855, 1887, 1919]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [1807, 1839, 1871, 1903]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 30           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
LS SR1 SR0 2            # SR1 = 2
MTCL SR1                # VLR = 2
LS SR7 SR0 11           # SR7 = 32 = input stride
LS SR6 SR0 4            # SR6 = 128 = offset from y_Re to y_Im
LS SR5 SR0 3            # SR5 = 64 = offset from y_even to y_odd and w_Re and w_Im
LS SR4 SR0 31           # SR5 = 1920 = pointer to Re(y_5[0])
LS SR3 SR0 32           # SR3 = 1728 = pointer to Re(y_4[64]) (Re(y_odd))
LS SR2 SR0 10           # SR2 = 512 = pointer to Re(W^0_128)
LVWS VR2 [1728, 1760]
LVI VR7 [512, 512]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [1856, 1888]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [576, 576]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [512, 544]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [640, 672]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 3           # SR1 = 64 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 11           # SR7 = 32 = input stride
SVWS VR4 [1920, 1984]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [1952, 2016]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [2080, 2144]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [2048, 2112]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 33           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 33           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [1729, 1761]
LVI VR7 [514, 514]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [1857, 1889]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [578, 578]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [514, 546]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [642, 674]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 3           # SR1 = 64 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 11           # SR7 = 32 = input stride
SVWS VR4 [1921, 1985]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [1953, 2017]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [2081, 2145]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [2049, 2113]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 33           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 33           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [1730, 1762]
LVI VR7 [516, 516]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [1858, 1890]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [580, 580]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [516, 548]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [644, 676]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 3           # SR1 = 64 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 11           # SR7 = 32 = input stride
SVWS VR4 [1922, 1986]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [1954, 2018]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [2082, 2146]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [2050, 2114]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 33           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 33           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [1731, 1763]
LVI VR7 [518, 518]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [1859, 1891]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [582, 582]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [518, 550]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [646, 678]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 3           # SR1 = 64 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 11           # SR7 = 32 = input stride
SVWS VR4 [1923, 1987]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [1955, 2019]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [2083, 2147]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [2051, 2115]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 33           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 33           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [1732, 1764]
LVI VR7 [520, 520]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [1860, 1892]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [584, 584]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [520, 552]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [648, 680]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 3           # SR1 = 64 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 11           # SR7 = 32 = input stride
SVWS VR4 [1924, 1988]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [1956, 2020]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [2084, 2148]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [2052, 2116]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 33           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 33           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [1733, 1765]
LVI VR7 [522, 522]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [1861, 1893]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [586, 586]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [522, 554]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [650, 682]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 3           # SR1 = 64 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 11           # SR7 = 32 = input stride
SVWS VR4 [1925, 1989]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [1957, 2021]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [2085, 2149]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [2053, 2117]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 33           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 33           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [1734, 1766]
LVI VR7 [524, 524]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [1862, 1894]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [588, 588]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [524, 556]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [652, 684]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 3           # SR1 = 64 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 11           # SR7 = 32 = input stride
SVWS VR4 [1926, 1990]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [1958, 2022]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [2086, 2150]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [2054, 2118]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 33           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 33           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [1735, 1767]
LVI VR7 [526, 526]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [1863, 1895]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [590, 590]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [526, 558]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [654, 686]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 3           # SR1 = 64 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 11           # SR7 = 32 = input stride
SVWS VR4 [1927, 1991]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [1959, 2023]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [2087, 2151]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [2055, 2119]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 33           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 33           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [1736, 1768]
LVI VR7 [528, 528]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [1864, 1896]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [592, 592]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [528, 560]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [656, 688]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 3           # SR1 = 64 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 11           # SR7 = 32 = input stride
SVWS VR4 [1928, 1992]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [1960, 2024]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [2088, 2152]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [2056, 2120]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 33           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 33           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [1737, 1769]
LVI VR7 [530, 530]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [1865, 1897]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [594, 594]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [530, 562]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [658, 690]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 3           # SR1 = 64 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 11           # SR7 = 32 = input stride
SVWS VR4 [1929, 1993]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [1961, 2025]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [2089, 2153]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [2057, 2121]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 33           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 33           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [1738, 1770]
LVI VR7 [532, 532]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [1866, 1898]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [596, 596]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [532, 564]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [660, 692]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 3           # SR1 = 64 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 11           # SR7 = 32 = input stride
SVWS VR4 [1930, 1994]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [1962, 2026]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [2090, 2154]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [2058, 2122]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 33           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 33           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [1739, 1771]
LVI VR7 [534, 534]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [1867, 1899]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [598, 598]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [534, 566]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [662, 694]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 3           # SR1 = 64 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 11           # SR7 = 32 = input stride
SVWS VR4 [1931, 1995]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [1963, 2027]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [2091, 2155]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [2059, 2123]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 33           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 33           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [1740, 1772]
LVI VR7 [536, 536]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [1868, 1900]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [600, 600]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [536, 568]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [664, 696]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 3           # SR1 = 64 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 11           # SR7 = 32 = input stride
SVWS VR4 [1932, 1996]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [1964, 2028]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [2092, 2156]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [2060, 2124]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 33           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 33           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [1741, 1773]
LVI VR7 [538, 538]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [1869, 1901]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [602, 602]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [538, 570]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [666, 698]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 3           # SR1 = 64 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 11           # SR7 = 32 = input stride
SVWS VR4 [1933, 1997]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [1965, 2029]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [2093, 2157]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [2061, 2125]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 33           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 33           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [1742, 1774]
LVI VR7 [540, 540]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [1870, 1902]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [604, 604]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [540, 572]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [668, 700]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 3           # SR1 = 64 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 11           # SR7 = 32 = input stride
SVWS VR4 [1934, 1998]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [1966, 2030]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [2094, 2158]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [2062, 2126]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 33           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 33           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [1743, 1775]
LVI VR7 [542, 542]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [1871, 1903]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [606, 606]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [542, 574]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [670, 702]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 3           # SR1 = 64 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 11           # SR7 = 32 = input stride
SVWS VR4 [1935, 1999]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [1967, 2031]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [2095, 2159]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [2063, 2127]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 33           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 33           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [1744, 1776]
LVI VR7 [544, 544]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [1872, 1904]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [608, 608]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [544, 576]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [672, 704]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 3           # SR1 = 64 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 11           # SR7 = 32 = input stride
SVWS VR4 [1936, 2000]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [1968, 2032]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [2096, 2160]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [2064, 2128]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 33           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 33           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [1745, 1777]
LVI VR7 [546, 546]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [1873, 1905]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [610, 610]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [546, 578]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [674, 706]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 3           # SR1 = 64 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 11           # SR7 = 32 = input stride
SVWS VR4 [1937, 2001]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [1969, 2033]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [2097, 2161]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [2065, 2129]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 33           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 33           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [1746, 1778]
LVI VR7 [548, 548]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [1874, 1906]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [612, 612]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [548, 580]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [676, 708]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 3           # SR1 = 64 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 11           # SR7 = 32 = input stride
SVWS VR4 [1938, 2002]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [1970, 2034]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [2098, 2162]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [2066, 2130]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 33           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 33           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [1747, 1779]
LVI VR7 [550, 550]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [1875, 1907]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [614, 614]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [550, 582]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [678, 710]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 3           # SR1 = 64 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 11           # SR7 = 32 = input stride
SVWS VR4 [1939, 2003]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [1971, 2035]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [2099, 2163]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [2067, 2131]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 33           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 33           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [1748, 1780]
LVI VR7 [552, 552]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [1876, 1908]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [616, 616]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [552, 584]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [680, 712]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 3           # SR1 = 64 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 11           # SR7 = 32 = input stride
SVWS VR4 [1940, 2004]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [1972, 2036]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [2100, 2164]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [2068, 2132]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 33           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 33           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [1749, 1781]
LVI VR7 [554, 554]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [1877, 1909]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [618, 618]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [554, 586]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [682, 714]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 3           # SR1 = 64 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 11           # SR7 = 32 = input stride
SVWS VR4 [1941, 2005]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [1973, 2037]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [2101, 2165]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [2069, 2133]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 33           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 33           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [1750, 1782]
LVI VR7 [556, 556]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [1878, 1910]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [620, 620]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [556, 588]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [684, 716]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 3           # SR1 = 64 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 11           # SR7 = 32 = input stride
SVWS VR4 [1942, 2006]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [1974, 2038]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [2102, 2166]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [2070, 2134]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 33           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 33           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [1751, 1783]
LVI VR7 [558, 558]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [1879, 1911]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [622, 622]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [558, 590]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [686, 718]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 3           # SR1 = 64 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 11           # SR7 = 32 = input stride
SVWS VR4 [1943, 2007]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [1975, 2039]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [2103, 2167]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [2071, 2135]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 33           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 33           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [1752, 1784]
LVI VR7 [560, 560]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [1880, 1912]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [624, 624]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [560, 592]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [688, 720]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 3           # SR1 = 64 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 11           # SR7 = 32 = input stride
SVWS VR4 [1944, 2008]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [1976, 2040]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [2104, 2168]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [2072, 2136]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 33           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 33           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [1753, 1785]
LVI VR7 [562, 562]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [1881, 1913]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [626, 626]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [562, 594]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [690, 722]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 3           # SR1 = 64 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 11           # SR7 = 32 = input stride
SVWS VR4 [1945, 2009]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [1977, 2041]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [2105, 2169]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [2073, 2137]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 33           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 33           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [1754, 1786]
LVI VR7 [564, 564]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [1882, 1914]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [628, 628]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [564, 596]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [692, 724]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 3           # SR1 = 64 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 11           # SR7 = 32 = input stride
SVWS VR4 [1946, 2010]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [1978, 2042]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [2106, 2170]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [2074, 2138]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 33           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 33           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [1755, 1787]
LVI VR7 [566, 566]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [1883, 1915]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [630, 630]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [566, 598]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [694, 726]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 3           # SR1 = 64 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 11           # SR7 = 32 = input stride
SVWS VR4 [1947, 2011]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [1979, 2043]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [2107, 2171]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [2075, 2139]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 33           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 33           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [1756, 1788]
LVI VR7 [568, 568]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [1884, 1916]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [632, 632]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [568, 600]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [696, 728]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 3           # SR1 = 64 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 11           # SR7 = 32 = input stride
SVWS VR4 [1948, 2012]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [1980, 2044]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [2108, 2172]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [2076, 2140]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 33           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 33           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [1757, 1789]
LVI VR7 [570, 570]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [1885, 1917]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [634, 634]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [570, 602]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [698, 730]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 3           # SR1 = 64 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 11           # SR7 = 32 = input stride
SVWS VR4 [1949, 2013]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [1981, 2045]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [2109, 2173]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [2077, 2141]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 33           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 33           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [1758, 1790]
LVI VR7 [572, 572]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [1886, 1918]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [636, 636]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [572, 604]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [700, 732]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 3           # SR1 = 64 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 11           # SR7 = 32 = input stride
SVWS VR4 [1950, 2014]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [1982, 2046]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [2110, 2174]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [2078, 2142]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 33           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 33           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [1759, 1791]
LVI VR7 [574, 574]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [1887, 1919]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [638, 638]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [574, 606]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [702, 734]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 3           # SR1 = 64 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 11           # SR7 = 32 = input stride
SVWS VR4 [1951, 2015]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [1983, 2047]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [2111, 2175]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [2079, 2143]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 33           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
LS SR1 SR0 1            # SR1 = 1
MTCL SR1                # VLR = 1
LS SR7 SR0 3            # SR7 = 64 = input stride
LS SR6 SR0 4            # SR6 = 128 = offset from y_Re to y_Im
LS SR5 SR0 3            # SR5 = 64 = offset from y_even to y_odd and w_Re and w_Im
LS SR4 SR0 0            # SR5 = 0 = pointer to y_out
LS SR3 SR0 34           # SR3 = 1984 = pointer to Re(y_5[64]) (Re(y_odd))
LS SR2 SR0 10           # SR2 = 512 = pointer to Re(W^0_128)
LVWS VR2 [1984]
LVI VR7 [512]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [2112]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [576]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [512]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [640]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 1            # SR1 = 1 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 3            # SR7 = 64 = input stride
SVWS VR4 [0]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [64]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [192]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [128]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 35           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 35           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [1985]
LVI VR7 [513]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [2113]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [577]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [513]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [641]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 1            # SR1 = 1 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 3            # SR7 = 64 = input stride
SVWS VR4 [1]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [65]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [193]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [129]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 35           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 35           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [1986]
LVI VR7 [514]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [2114]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [578]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [514]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [642]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 1            # SR1 = 1 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 3            # SR7 = 64 = input stride
SVWS VR4 [2]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [66]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [194]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [130]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 35           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 35           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [1987]
LVI VR7 [515]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [2115]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [579]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [515]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [643]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 1            # SR1 = 1 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 3            # SR7 = 64 = input stride
SVWS VR4 [3]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [67]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [195]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [131]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 35           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 35           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [1988]
LVI VR7 [516]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [2116]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [580]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [516]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [644]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 1            # SR1 = 1 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 3            # SR7 = 64 = input stride
SVWS VR4 [4]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [68]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [196]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [132]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 35           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 35           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [1989]
LVI VR7 [517]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [2117]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [581]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [517]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [645]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 1            # SR1 = 1 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 3            # SR7 = 64 = input stride
SVWS VR4 [5]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [69]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [197]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [133]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 35           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 35           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [1990]
LVI VR7 [518]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [2118]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [582]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [518]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [646]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 1            # SR1 = 1 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 3            # SR7 = 64 = input stride
SVWS VR4 [6]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [70]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [198]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [134]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 35           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 35           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [1991]
LVI VR7 [519]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [2119]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [583]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [519]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [647]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 1            # SR1 = 1 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 3            # SR7 = 64 = input stride
SVWS VR4 [7]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [71]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [199]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [135]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 35           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 35           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [1992]
LVI VR7 [520]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [2120]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [584]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [520]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [648]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 1            # SR1 = 1 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 3            # SR7 = 64 = input stride
SVWS VR4 [8]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [72]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [200]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [136]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 35           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 35           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [1993]
LVI VR7 [521]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [2121]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [585]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [521]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [649]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 1            # SR1 = 1 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 3            # SR7 = 64 = input stride
SVWS VR4 [9]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [73]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [201]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [137]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 35           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 35           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [1994]
LVI VR7 [522]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [2122]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [586]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [522]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [650]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 1            # SR1 = 1 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 3            # SR7 = 64 = input stride
SVWS VR4 [10]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [74]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [202]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [138]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 35           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 35           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [1995]
LVI VR7 [523]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [2123]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [587]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [523]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [651]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 1            # SR1 = 1 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 3            # SR7 = 64 = input stride
SVWS VR4 [11]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [75]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [203]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [139]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 35           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 35           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [1996]
LVI VR7 [524]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [2124]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [588]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [524]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [652]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 1            # SR1 = 1 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 3            # SR7 = 64 = input stride
SVWS VR4 [12]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [76]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [204]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [140]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 35           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 35           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [1997]
LVI VR7 [525]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [2125]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [589]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [525]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [653]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 1            # SR1 = 1 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 3            # SR7 = 64 = input stride
SVWS VR4 [13]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [77]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [205]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [141]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 35           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 35           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [1998]
LVI VR7 [526]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [2126]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [590]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [526]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [654]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 1            # SR1 = 1 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 3            # SR7 = 64 = input stride
SVWS VR4 [14]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [78]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [206]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [142]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 35           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 35           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [1999]
LVI VR7 [527]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [2127]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [591]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [527]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [655]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 1            # SR1 = 1 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 3            # SR7 = 64 = input stride
SVWS VR4 [15]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [79]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [207]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [143]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 35           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 35           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [2000]
LVI VR7 [528]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [2128]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [592]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [528]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [656]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 1            # SR1 = 1 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 3            # SR7 = 64 = input stride
SVWS VR4 [16]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [80]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [208]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [144]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 35           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 35           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [2001]
LVI VR7 [529]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [2129]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [593]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [529]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [657]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 1            # SR1 = 1 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 3            # SR7 = 64 = input stride
SVWS VR4 [17]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [81]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [209]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [145]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 35           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 35           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [2002]
LVI VR7 [530]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [2130]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [594]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [530]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [658]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 1            # SR1 = 1 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 3            # SR7 = 64 = input stride
SVWS VR4 [18]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [82]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [210]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [146]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 35           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 35           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [2003]
LVI VR7 [531]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [2131]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [595]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [531]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [659]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 1            # SR1 = 1 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 3            # SR7 = 64 = input stride
SVWS VR4 [19]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [83]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [211]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [147]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 35           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 35           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [2004]
LVI VR7 [532]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [2132]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [596]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [532]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [660]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 1            # SR1 = 1 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 3            # SR7 = 64 = input stride
SVWS VR4 [20]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [84]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [212]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [148]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 35           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 35           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [2005]
LVI VR7 [533]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [2133]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [597]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [533]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [661]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 1            # SR1 = 1 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 3            # SR7 = 64 = input stride
SVWS VR4 [21]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [85]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [213]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [149]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 35           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 35           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [2006]
LVI VR7 [534]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [2134]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [598]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [534]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [662]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 1            # SR1 = 1 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 3            # SR7 = 64 = input stride
SVWS VR4 [22]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [86]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [214]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [150]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 35           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 35           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [2007]
LVI VR7 [535]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [2135]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [599]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [535]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [663]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 1            # SR1 = 1 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 3            # SR7 = 64 = input stride
SVWS VR4 [23]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [87]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [215]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [151]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 35           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 35           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [2008]
LVI VR7 [536]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [2136]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [600]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [536]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [664]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 1            # SR1 = 1 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 3            # SR7 = 64 = input stride
SVWS VR4 [24]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [88]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [216]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [152]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 35           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 35           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [2009]
LVI VR7 [537]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [2137]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [601]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [537]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [665]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 1            # SR1 = 1 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 3            # SR7 = 64 = input stride
SVWS VR4 [25]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [89]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [217]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [153]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 35           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 35           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [2010]
LVI VR7 [538]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [2138]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [602]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [538]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [666]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 1            # SR1 = 1 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 3            # SR7 = 64 = input stride
SVWS VR4 [26]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [90]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [218]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [154]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 35           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 35           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [2011]
LVI VR7 [539]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [2139]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [603]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [539]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [667]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 1            # SR1 = 1 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 3            # SR7 = 64 = input stride
SVWS VR4 [27]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [91]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [219]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [155]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 35           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 35           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [2012]
LVI VR7 [540]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [2140]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [604]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [540]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [668]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 1            # SR1 = 1 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 3            # SR7 = 64 = input stride
SVWS VR4 [28]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [92]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [220]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [156]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 35           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 35           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [2013]
LVI VR7 [541]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [2141]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [605]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [541]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [669]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 1            # SR1 = 1 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 3            # SR7 = 64 = input stride
SVWS VR4 [29]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [93]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [221]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [157]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 35           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 35           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [2014]
LVI VR7 [542]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [2142]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [606]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [542]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [670]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 1            # SR1 = 1 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 3            # SR7 = 64 = input stride
SVWS VR4 [30]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [94]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [222]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [158]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 35           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 35           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [2015]
LVI VR7 [543]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [2143]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [607]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [543]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [671]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 1            # SR1 = 1 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 3            # SR7 = 64 = input stride
SVWS VR4 [31]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [95]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [223]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [159]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 35           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 35           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [2016]
LVI VR7 [544]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [2144]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [608]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [544]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [672]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 1            # SR1 = 1 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 3            # SR7 = 64 = input stride
SVWS VR4 [32]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [96]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [224]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [160]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 35           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 35           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [2017]
LVI VR7 [545]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [2145]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [609]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [545]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [673]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 1            # SR1 = 1 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 3            # SR7 = 64 = input stride
SVWS VR4 [33]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [97]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [225]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [161]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 35           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 35           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [2018]
LVI VR7 [546]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [2146]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [610]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [546]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [674]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 1            # SR1 = 1 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 3            # SR7 = 64 = input stride
SVWS VR4 [34]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [98]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [226]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [162]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 35           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 35           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [2019]
LVI VR7 [547]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [2147]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [611]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [547]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [675]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 1            # SR1 = 1 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 3            # SR7 = 64 = input stride
SVWS VR4 [35]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [99]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [227]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [163]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 35           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 35           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [2020]
LVI VR7 [548]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [2148]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [612]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [548]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [676]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 1            # SR1 = 1 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 3            # SR7 = 64 = input stride
SVWS VR4 [36]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [100]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [228]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [164]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 35           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 35           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [2021]
LVI VR7 [549]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [2149]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [613]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [549]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [677]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 1            # SR1 = 1 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 3            # SR7 = 64 = input stride
SVWS VR4 [37]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [101]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [229]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [165]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 35           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 35           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [2022]
LVI VR7 [550]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [2150]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [614]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [550]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [678]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 1            # SR1 = 1 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 3            # SR7 = 64 = input stride
SVWS VR4 [38]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [102]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [230]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [166]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 35           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 35           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [2023]
LVI VR7 [551]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [2151]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [615]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [551]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [679]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 1            # SR1 = 1 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 3            # SR7 = 64 = input stride
SVWS VR4 [39]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [103]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [231]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [167]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 35           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 35           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [2024]
LVI VR7 [552]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [2152]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [616]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [552]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [680]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 1            # SR1 = 1 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 3            # SR7 = 64 = input stride
SVWS VR4 [40]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [104]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [232]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [168]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 35           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 35           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [2025]
LVI VR7 [553]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [2153]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [617]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [553]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [681]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 1            # SR1 = 1 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 3            # SR7 = 64 = input stride
SVWS VR4 [41]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [105]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [233]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [169]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 35           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 35           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [2026]
LVI VR7 [554]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [2154]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [618]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [554]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [682]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 1            # SR1 = 1 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 3            # SR7 = 64 = input stride
SVWS VR4 [42]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [106]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [234]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [170]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 35           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 35           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [2027]
LVI VR7 [555]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [2155]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [619]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [555]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [683]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 1            # SR1 = 1 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 3            # SR7 = 64 = input stride
SVWS VR4 [43]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [107]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [235]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [171]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 35           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 35           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [2028]
LVI VR7 [556]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [2156]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [620]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [556]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [684]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 1            # SR1 = 1 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 3            # SR7 = 64 = input stride
SVWS VR4 [44]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [108]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [236]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [172]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 35           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 35           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [2029]
LVI VR7 [557]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [2157]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [621]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [557]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [685]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 1            # SR1 = 1 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 3            # SR7 = 64 = input stride
SVWS VR4 [45]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [109]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [237]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [173]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 35           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 35           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [2030]
LVI VR7 [558]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [2158]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [622]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [558]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [686]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 1            # SR1 = 1 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 3            # SR7 = 64 = input stride
SVWS VR4 [46]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [110]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [238]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [174]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 35           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 35           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [2031]
LVI VR7 [559]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [2159]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [623]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [559]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [687]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 1            # SR1 = 1 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 3            # SR7 = 64 = input stride
SVWS VR4 [47]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [111]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [239]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [175]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 35           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 35           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [2032]
LVI VR7 [560]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [2160]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [624]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [560]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [688]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 1            # SR1 = 1 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 3            # SR7 = 64 = input stride
SVWS VR4 [48]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [112]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [240]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [176]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 35           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 35           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [2033]
LVI VR7 [561]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [2161]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [625]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [561]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [689]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 1            # SR1 = 1 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 3            # SR7 = 64 = input stride
SVWS VR4 [49]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [113]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [241]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [177]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 35           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 35           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [2034]
LVI VR7 [562]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [2162]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [626]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [562]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [690]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 1            # SR1 = 1 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 3            # SR7 = 64 = input stride
SVWS VR4 [50]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [114]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [242]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [178]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 35           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 35           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [2035]
LVI VR7 [563]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [2163]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [627]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [563]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [691]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 1            # SR1 = 1 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 3            # SR7 = 64 = input stride
SVWS VR4 [51]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [115]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [243]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [179]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 35           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 35           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [2036]
LVI VR7 [564]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [2164]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [628]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [564]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [692]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 1            # SR1 = 1 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 3            # SR7 = 64 = input stride
SVWS VR4 [52]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [116]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [244]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [180]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 35           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 35           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [2037]
LVI VR7 [565]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [2165]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [629]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [565]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [693]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 1            # SR1 = 1 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 3            # SR7 = 64 = input stride
SVWS VR4 [53]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [117]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [245]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [181]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 35           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 35           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [2038]
LVI VR7 [566]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [2166]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [630]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [566]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [694]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 1            # SR1 = 1 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 3            # SR7 = 64 = input stride
SVWS VR4 [54]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [118]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [246]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [182]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 35           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 35           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [2039]
LVI VR7 [567]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [2167]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [631]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [567]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [695]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 1            # SR1 = 1 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 3            # SR7 = 64 = input stride
SVWS VR4 [55]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [119]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [247]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [183]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 35           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 35           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [2040]
LVI VR7 [568]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [2168]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [632]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [568]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [696]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 1            # SR1 = 1 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 3            # SR7 = 64 = input stride
SVWS VR4 [56]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [120]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [248]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [184]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 35           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 35           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [2041]
LVI VR7 [569]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [2169]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [633]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [569]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [697]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 1            # SR1 = 1 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 3            # SR7 = 64 = input stride
SVWS VR4 [57]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [121]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [249]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [185]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 35           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 35           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [2042]
LVI VR7 [570]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [2170]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [634]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [570]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [698]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 1            # SR1 = 1 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 3            # SR7 = 64 = input stride
SVWS VR4 [58]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [122]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [250]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [186]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 35           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 35           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [2043]
LVI VR7 [571]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [2171]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [635]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [571]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [699]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 1            # SR1 = 1 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 3            # SR7 = 64 = input stride
SVWS VR4 [59]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [123]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [251]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [187]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 35           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 35           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [2044]
LVI VR7 [572]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [2172]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [636]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [572]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [700]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 1            # SR1 = 1 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 3            # SR7 = 64 = input stride
SVWS VR4 [60]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [124]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [252]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [188]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 35           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 35           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [2045]
LVI VR7 [573]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [2173]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [637]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [573]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [701]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 1            # SR1 = 1 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 3            # SR7 = 64 = input stride
SVWS VR4 [61]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [125]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [253]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [189]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 35           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 35           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [2046]
LVI VR7 [574]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [2174]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [638]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [574]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [702]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 1            # SR1 = 1 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 3            # SR7 = 64 = input stride
SVWS VR4 [62]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [126]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [254]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [190]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 35           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
SS SR6 SR0 35           # store k
LS SR6 SR0 4            # restore SR6 = 128 = offset from Re to Im
MFCL SR1                # SR1 = 32
ADD SR2 SR2 SR1         # SR2 = 544 = pointer to Re(W^32_128)
LS SR1 SR0 1            # SR1 = 1
SUB SR4 SR4 SR6         # SR4 = pointer to Re(y_1[0])
ADD SR4 SR4 SR1         # SR5 = 897 = pointer to Re(y_1[1])
ADD SR3 SR3 SR1         # SR3 = 705 = pointer to Re(y_0[65])
LVWS VR2 [2047]
LVI VR7 [575]
MULVV VR3 VR7 VR2       # VR3 = Re(W^0_128) * Re(y_odd)
ADD SR1 SR3 SR6         # SR1 = 1216 + 128 = pointer to Im(y_odd)
LVWS VR6 [2175]
ADD SR1 SR2 SR5         # SR1 = pointer to Re(W^0_128) + 64 = pointer to Im(W^0_128)
LVI VR5 [639]
MULVV VR4 VR5 VR6       # VR4 = Im(W^0_128) * Im(y_odd)
ADDVV VR1 VR3 VR4       # VR1 =  Re(W^0_128) * Re(y_odd) + Im(W^0_128) * Im(y_odd)
MULVV VR3 VR5 VR2       # VR3 = Im(W^0_128) * Re(y_odd)
MULVV VR4 VR7 VR6       # VR4 = Re(W^0_128) * Im(y_odd)
ADDVV VR2 VR3 VR4       # VR2 =  Im(W^0_128) * Re(y_odd) + Re(W^0_128) * Im(y_odd)
SUB SR1 SR1 SR5         # SR1 = pointer to Re(y_odd) - 64 = pointer to Re(y_even)
LVWS VR3 [575]
ADDVV VR4 VR3 VR1       # VR4 = Re(y_even) + Re(W^0_128 * y_odd)
SUBVV VR7 VR3 VR1       # VR7 = Re(y_even) - Re(W^0_128 * y_odd)
ADD SR1 SR1 SR6         # SR1 = pointer to Re(y_even) + 128 = pointer to Im(y_even)
LVWS VR3 [703]
ADDVV VR6 VR3 VR2       # VR6 = Im(y_even) + Im(W^0_128 * y_odd)
SUBVV VR5 VR3 VR2       # VR5 = Im(y_even) - Im(W^0_128 * y_odd)
LS SR1 SR0 1            # SR1 = 1 = output stride
LS SR7 SR0 36           # SR7 = 1000
DIVVS VR4 VR4 SR7
DIVVS VR7 VR7 SR7
DIVVS VR5 VR5 SR7
DIVVS VR6 VR6 SR7
LS SR7 SR0 3            # SR7 = 64 = input stride
SVWS VR4 [63]
ADD SR4 SR4 SR7         # SR4 = Re(y_1[16])
SVWS VR7 [127]
ADD SR4 SR4 SR6         # SR1 = SR1 + 128 = pointer to Im(y_1[2])
SVWS VR5 [255]
SUB SR4 SR4 SR7         # SR1 = SR1 - 4 = pointer to Im(y_1[0])
SVWS VR6 [191]
LS SR1 SR0 1            # SR1 = 1
LS SR6 SR0 35           # SR6 = k
ADD SR6 SR6 SR1         # k += 1
HALT
