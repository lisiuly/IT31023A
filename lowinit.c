/* =========================================================================  */
/*    File Name   : lowinit.c                                                 */
/*    Description : The function __low_level_init is called by the start-up 
                    code before doing the normal initialization of data 
                    segments. If the return value is zero, initialization 
                    is not performed.

                    In the run-time library there is a dummy __low_level_init, 
                    which does nothing but return 1. This means that the 
                    start-up routine proceeds with initialization of data 
                    segments.
 
                    To replace this dummy, compile a customized version 
                    (like the example below) and link it with the rest of your 
                    code.

                    For the 6502, note that the bank system has NOT been 
                    initialized at this point. You can initialize it here if 
                    you want to.                                               */

/*    Body        : GPL815P series 6502 CPU                                    */
/*    Toolchain   : gp65cc Compiler V0.9x                                      */
/*    Date        : 2014/09/09                                                 */
/*    Version     : 1.0.0                                                      */
/* =========================================================================   */
#include	"GPL815P.h"

#pragma save
#pragma nooverlay
unsigned char low_level_init (void)
{
  /* Insert your low-level initializations here */
  
  P_BANK_Sel=0;
  
  /*==================================*/
  /* Choose if segment initialization */
  /* should be done or not.           */
  /* Return: 0 to omit seg_init       */
  /*         1 to run seg_init        */
  /*==================================*/
  return 1;
}
#pragma restore
