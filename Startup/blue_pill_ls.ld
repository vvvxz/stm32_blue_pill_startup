/*LINKER SCRIPT FOR STM32F103C8T6*/
/*Firmware's entry point*/
ENTRY(Reset_Handler)

/*Available memory*/
MEMORY
{
  FLASH (rx): ORIGIN = 0x08000000, LENGTH = 64K
  SRAM (rwx): ORIGIN = 0x20000000, LENGTH = 20K
}

/*Stack pointer's initial location*/
_estack = ORIGIN(SRAM)+LENGTH(SRAM);

/*Heap and stack sizes*/
_min_heap_size = 0x200;
_min_stack_size = 0x400;

/*Memory layout*/
SECTIONS {
  .text :
  {
    /*Merge .isr_vector_tbl, .text, and .rodata sections*/
    /*Give each end a global symbol*/
    . = ALIGN(4); /*Should start at zero, align anyways*/
    KEEP(*(.isr_vector_tbl))
    *(.text)
    *(.rodata)
    = ALIGN(4);
    _etext = .;
  }>FLASH

  .data :
  {
    . = ALIGN(4);
    _sdata = .;
    *(.data)
    . = ALIGN(4);
    _edata = .;
  } > SRAM AT> FLASH /*Load VMA from LMA (SRAM from FLASH)*/

  .bss :
  {
    . = ALIGN(4);
    _sbss = .;
    *(.bss)
    . = ALIGN(4);
    _ebss = .;
  }> SRAM
}
