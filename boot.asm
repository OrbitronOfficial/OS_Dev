[BITS 16]     ; Tell the assembler we're writing 16-bit real mode code
[ORG 0x7C00]  ; BIOS loads bootloader at 0x7C00

start:
    mov si, msg       ; Load the address of our message
    call print_string ; Call function to print

    jmp $            ; Infinite loop (prevents crashing)

print_string:
    mov ah, 0x0E     ; BIOS teletype function
.loop:
    lodsb            ; Load next byte from SI into AL
    or al, al        ; Check if it's null (end of string)
    jz done
    int 0x10         ; BIOS interrupt to print character
    jmp .loop
done:
    ret

msg db 'Hello from Bootloader!', 0

times 510-($-$$) db 0  ; Fill remaining bytes with zeros
dw 0xAA55              ; Boot signature (must be 0xAA55)

