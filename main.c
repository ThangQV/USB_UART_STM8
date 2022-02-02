/* MAIN.C file
 * 
 * Copyright (c) 2002-2005 STMicroelectronics
 */
#include "stm8s105c6.h"
#include <stdlib.h>
#include <stdio.h>

@far @interrupt void Interrupt_EXTI1 (void)
{
	int i;
	PD_ODR = 0;
	for(i = 0; i < 1000; i++);
	PD_ODR = 1;
return;
}

main()
{
	PD_DDR = 1;
	PD_ODR = 1;
	PB_DDR = 0;
	PB_CR1 = 0b00000001;
	PB_CR2 = 0b00000001;
	EXTI_CR1 |= 0b00001100;
	EXTI_CR2 |= 0;
	//#pragma asm
	//__asm("ld PD_ODR,1");
	//#pragma endasm
	//#asm
	//RIM
	//#endasm
	//_asm("RIM");
	while (1)
	{
	}
}