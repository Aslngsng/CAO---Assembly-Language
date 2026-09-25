org 100h

section .data
    name db 'APRIL MAE L. SALANGSANG'
    name_len equ $ - name

section .text

    mov bp, 10          ; Repeat fullname 10 times

print_line:
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

    ; Repeat until fullname is printed 10 times
    dec bp
    jnz print_line

    int 20h