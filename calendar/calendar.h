
// =======================================================================================
// Function name	: F_24HourClock
// Purpose			: F_24HourClock
// Parameter		: F_24HourClock
// Return			: None
// Destroy			: A 
// C_ARGN			: 0
// C_ARGZ			: 0
// ======================================================================================
void	F_24HourClock(void) ;//
//void	F_GetNsLiCalendar(void);
void	F_JudegLeapYear(void);
void	F_Check_Alarming(void);
void	F_JudgeWeek(void);

void	Disable_Alarm(void);

extern	unsigned char	R_Week;
extern	unsigned char	R_Month;
extern	unsigned char	R_Month_temp;
extern	unsigned char	R_Day_temp;
extern	unsigned char	R_Day;
extern	unsigned char	R_Year[2];
extern	unsigned char	R_Year_temp[2];
extern	unsigned char	R_Hejira_LeapYear_CalendarFlag;
extern	unsigned char	R_LCDHourBuff;
extern	unsigned char	R_LCDMinuBuff;
extern	unsigned char	R_LCDSecBuff;
extern	unsigned char	R_DateMinute;
extern	unsigned char	R_DateHour;
extern	unsigned char	R_DateSecond;
extern	unsigned char	R_AlarmHour[3];
extern	unsigned char	R_AlarmMinute[3];
extern	unsigned char	R_CurrentGroup;
extern	unsigned char	R_DispAlmDay[3];
extern	unsigned char	R_AlarmOnOff;
extern	unsigned char	R_Alarm_ENDIS_Flag;
extern	unsigned char	R_TimerMinute;
extern	unsigned char	R_TimerSecond;

extern	unsigned char	R_SnoozeCount;

#define		D_Alarm_EN		0X80




extern	unsigned char	RB_12_24_Status;
#define		D_24H	0X00
#define		D_12H	0X80

