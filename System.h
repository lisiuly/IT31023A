
// =======================================================================================
// Function name	: F_InitPort
// Purpose			: Initialized PortC
// Parameter		: None
// Return			: None
// Destroy			: A 
// C_ARGN			: 0
// C_ARGZ			: 0
// ======================================================================================
extern void F_InitPort(void);

//;============================================================================
//;Function Name:	F_SYS_ClearDPRAM
//;Description:	Clear DPRAM form start address to end address
//;Destroy:		A,X,Y
//;Stack Depth:   2
//;Notice: SRAM range is C_SramAddrStart ~ C_SramAddrEnd
//;============================================================================
extern void F_SYS_ClearDPRAM(void);
extern void F_SYS_FillDPRAM();
//;============================================================================
//;Function Name:	F_SYS_ClearPage0
//;Description:	Clear DPRAM form start address to end address
//;Destroy:		A,X,Y
//;Stack Depth:   2
//;Notice: SRAM range is C_SramAddrStart ~ C_SramAddrEnd
//;============================================================================
extern void F_SYS_ClearPage0(void);
//;============================================================================
//;Function Name:	F_SYS_ClearNPage
//;Description:	Clear DPRAM form start address to end address
//;Destroy:		A,X,Y
//;Stack Depth:   2
//;Notice: SRAM range is C_SramAddrStart ~ C_SramAddrEnd
//;============================================================================
extern void F_SYS_ClearNPage(void);
//;============================================================================
//;Function Name:	F_SYS_PowerOnInitinal
//;Description:	Clear DPRAM form start address to end address
//;Destroy:		A,X,Y
//;Stack Depth:   2
//;Notice: SRAM range is C_SramAddrStart ~ C_SramAddrEnd
//;============================================================================
extern void F_SYS_PowerOnCPUInitinal(void);
//;============================================================================
//;Function Name:	F_InitIRQ
//;Description:	Clear DPRAM form start address to end address
//;Destroy:		A,X,Y
//;Stack Depth:   2
//;Notice: SRAM range is C_SramAddrStart ~ C_SramAddrEnd
//;============================================================================
extern void F_InitIRQ(void);
//;============================================================================
//;Function Name:	F_InitIRQ
//;Description:	Clear DPRAM form start address to end address
//;Destroy:		A,X,Y
//;Stack Depth:   2
//;Notice: SRAM range is C_SramAddrStart ~ C_SramAddrEnd
//;============================================================================
extern void F_GreenMode(void);
//;============================================================================
//;Function Name:	F_InitIRQ
//;Description:	Clear DPRAM form start address to end address
//;Destroy:		A,X,Y
//;Stack Depth:   2
//;Notice: SRAM range is C_SramAddrStart ~ C_SramAddrEnd
//;============================================================================
extern void F_StandbyMode(void);
//;============================================================================
//;Function Name:	F_InitIRQ
//;Description:	Clear DPRAM form start address to end address
//;Destroy:		A,X,Y
//;Stack Depth:   2
//;Notice: SRAM range is C_SramAddrStart ~ C_SramAddrEnd
//;============================================================================
extern void F_Afterwakeup_Proc(void);
extern void F_LVD_Init(void);
