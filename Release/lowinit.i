# 1 ".\\lowinit.c"
# 1 "<built-in>"
# 1 "<command line>"
# 1 ".\\lowinit.c"
# 26 ".\\lowinit.c"
# 1 ".\\/GPL815P.h" 1
# 57 ".\\/GPL815P.h"
# 1 "C:/Program Files (x86)/Generalplus/GPIDE_6502 1.3.0/Tools/CLib/6502/Include/intr6502.h" 1





# 1 "C:/Program Files (x86)/Generalplus/GPIDE_6502 1.3.0/Tools/CLib/6502/Include/bank.h" 1
# 34 "C:/Program Files (x86)/Generalplus/GPIDE_6502 1.3.0/Tools/CLib/6502/Include/bank.h"
unsigned char __bgetc(unsigned char* src, unsigned char bID);
# 7 "C:/Program Files (x86)/Generalplus/GPIDE_6502 1.3.0/Tools/CLib/6502/Include/intr6502.h" 2
# 58 ".\\/GPL815P.h" 2
# 27 ".\\lowinit.c" 2

#pragma save
#pragma nooverlay
unsigned char low_level_init (void)
{


  *(volatile unsigned char *) (0x3000 +0x00)=0;







  return 1;
}
#pragma restore
