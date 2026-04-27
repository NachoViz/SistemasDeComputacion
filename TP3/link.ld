SECTIONS
{
    . = 0x7c00;             /* Punto de carga en RAM según la BIOS [cite: 176] */
    .text :
    {
        _start = .;         /* Inicio del código [cite: 179] */
        *(.text);           /* Incluye todo tu assembler [cite: 180-181] */
        
        . = 0x1FE;          /* Salta al byte 510 de este sector  */
        SHORT(0xAA55);      /* Firma mágica del MBR [cite: 184] */
    }
}
