
OUTPUT_ARCH( "riscv" )

_STACK_SIZE = DEFINED(_STACK_SIZE) ? _STACK_SIZE : 0x1000; 

/* Specify the default entry point to the program */

MEMORY {
  com : ORIGIN = 0x00000000, LENGTH = 0x00000100
  mem : ORIGIN = 0x0000100, LENGTH = 0x00010000
}



ENTRY(_start)

/*****************************************************************************
 * Define the sections, and where they are mapped in memory 
 ****************************************************************************/
SECTIONS {

  /* text: test code section */
  . = 0x00000;
  .comment : {
    *(.comment)	
  } > com

  .text : 
  {
    setup.o(.text)
    *(.text)
    *(.text.*)
    *(.gnu.linkonce.t.*)
  } > mem	  

  .rodata : {
    __rodata_start = .;
    *(.rdata)
    *(.rodata)
    *(.rodata.*)
    *(.gnu.linkonce.r.*)
    __rodata_end = .;
  } > mem

  .data : {
    . = ALIGN(4);
    __data_paddr_start = LOADADDR(.data);
    __data_start = .;
    *(.data)
    *(.data.*)
    *(.srodata*)
    *(.gnu.linkonce.d.*)
    __data_end = .;
  } > mem

  .bss : {
    . = ALIGN(4);
    __bss_start = .;
    *(.bss)
    *(.bss.*)
    *(.gnu.linkonce.b.*)
    *(COMMON)
    . = ALIGN(4);
    __bss_end = .;
  } > mem

  .stack : {
    . = ALIGN(4);
    _stack_end = .;
    . += _STACK_SIZE;
    _stack = .;
    __stack = _stack;
  } > mem

  _end = .;
}
