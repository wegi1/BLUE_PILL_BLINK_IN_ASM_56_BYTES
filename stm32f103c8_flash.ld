

/*------------------------------------------------------------------------------
 *      Linker script for running in internal FLASH on the STM32F103C8
 *----------------------------------------------------------------------------*/

OUTPUT_FORMAT("elf32-littlearm", "elf32-littlearm", "elf32-littlearm")
OUTPUT_ARCH(arm)
SEARCH_DIR(.)

/* Memory Spaces Definitions */
MEMORY
{
    ROM  (rx) : ORIGIN = 0x08000000, LENGTH = 64K
    RAM (rwx) : ORIGIN = 0x20000000, LENGTH = 20K
}


SECTIONS
{
	.text :
	{
		KEEP(*(.isr_vector))
		*(.text*)
		
	} > ROM
}
