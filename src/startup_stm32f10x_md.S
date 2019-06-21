/****************************************************
* A SIMPLE BLINK LED ON THE BLUE PILL STM32F103C8T6 *
* WITHOUT ANY CMSIS, HEADERS AND OTHER MAGIC FILES  *
*****************************************************/

/********************/
/* STM32 DEVICE IS: */
/*  STM32F103C8T6   */
/********************/

/****************************************************************/
/* BLUE PILL LED IS EMBEDDED ON ---->PC 13<----  = GPIOC->PIN13 */
/****************************************************************/

#define RCC_APB2ENR                              0x40021018
#define RCC_APB2ENR_IOPCEN                       0x10

#define GPIOC_CRH                                0x40011004
#define GPIOC_CRH_VALUE                          0x44144444

#define GPIOC_ODR_OFFSET_FROM_CRH                0x08
#define GPIOC_ODR_ODR13                           0x2000

#define TOP_OF_STACK                             0x20005000
/*
***************************************************************
*** just done bellowed main function C routine in assembler ***
***************************************************************
int main(void)
{
    RCC->APB2ENR |= RCC_APB2ENR_IOPCEN;
    GPIOC->CRH = 0x44144444;
    uint32_t delay;
    while(1)
    {
        GPIOC->ODR ^= GPIO_ODR_ODR13;
        for(delay = 100000; 0; delay--) {};
    }
}
*/


    .syntax unified
    .arch armv7-m

    .section .isr_vector

    .long    TOP_OF_STACK
    .long    __Reset_Handler         /* Reset Handler */
    .thumb_func
    .text


__Reset_Handler:
/*********************************************/
/*
//RCC->APB2ENR |= RCC_APB2ENR_IOPCEN;
*/

	ldr	r2, =RCC_APB2ENR
	ldr	r3, [r2]
	orr.w	r3, r3, RCC_APB2ENR_IOPCEN
	str	r3, [r2]
/********************************************/
/*
//GPIOC->CRH = GPIOC_CRH_VALUE;
*/

	ldr	r1, =GPIOC_CRH_VALUE
	ldr	r2, =GPIOC_CRH
	str	r1, [r2]
/*******************************************/

/*
// while(1)
*/
//{
/*******************************************/
/*
//GPIOC->ODR ^= GPIO_ODR_ODR13;
*/
blink:

	ldr	r3, [r2, GPIOC_ODR_OFFSET_FROM_CRH]
	eor.w	r3, r3, GPIOC_ODR_ODR13
	str	r3, [r2, GPIOC_ODR_OFFSET_FROM_CRH]
/********************************************/
/*
//for(uint32_t delay = 500000; 0 ; delay--) {};
*/

	ldr	r3, =500000
count_delay:
	subs	r3, #1
	bne count_delay

    b  blink

//} /* end while(1){} */
    .end
