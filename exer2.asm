org 100h

section .data
    name db 'APRIL MAE L. SALANGSANG'
    name_len equ $ - name

section .text

    mov bp, 10          ; Repeat fullname 10 times
    mov bl, 0           ; Starting indentation

print_line:

    ; Print spaces
    xor cx, cx
    mov cl, bl

print_spaces:
    cmp cx, 0
    je print_name

    mov ah, 02h
    mov dl, ' '
    int 21h

    loop print_spaces

print_name:
    mov si, name
    mov cx, name_len

print_character:
    mov ah, 02h
    mov dl, [si]
    int 21h

    inc si
    loop print_character

    ; New line
    mov ah, 02h
    mov dl, 13
    int 21h

    mov dl, 10
    int 21h

    ; Add 2 spaces for next line
    add bl, 2

    ; Repeat until 10 lines are printed
    dec bp
    jnz print_line

    int 20h