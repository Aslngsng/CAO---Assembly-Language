bits 16
org 100h

start:

    mov bh, 0
    mov al, ' '

    call background
    call ascii_art

    ; Wait for a key
    mov ah, 00h
    int 16h

    ; Exit to DOS
    mov ax, 4C00h
    int 21h


; =====================================================
; BACKGROUND
; White background
; Attribute 70h = White/Light Gray background
; =====================================================

background:

    mov cx, 25             ; 25 rows
    mov bl, 70h            ; White background, black foreground
    mov dh, 0              ; Start at row 0

bg_loop:

    mov dl, 0              ; Start at column 0

    mov ah, 02h            ; Set cursor position
    int 10h

    push cx

    mov ah, 09h            ; Write character with attribute
    mov cx, 80             ; Fill 80 columns
    int 10h

    pop cx

    inc dh
    loop bg_loop

    ret


; =====================================================
; ASCII ART
; Colored cat on white background
; =====================================================

ascii_art:

    ; Blue
    mov bl, 71h
    mov si, m1
    mov dh, 5
    mov dl, 31
    call print_line

    ; Green
    mov bl, 72h
    mov si, m2
    mov dh, 6
    mov dl, 31
    call print_line

    ; Red
    mov bl, 74h
    mov si, m3
    mov dh, 7
    mov dl, 31
    call print_line

    ; Magenta
    mov bl, 75h
    mov si, m4
    mov dh, 8
    mov dl, 31
    call print_line

    ; Brown / Dark Yellow
    mov bl, 76h
    mov si, m5
    mov dh, 9
    mov dl, 31
    call print_line

    ; Cyan
    mov bl, 73h
    mov si, m6
    mov dh, 10
    mov dl, 31
    call print_line

    ; Bright Blue
    mov bl, 79h
    mov si, m7
    mov dh, 11
    mov dl, 31
    call print_line

    ret


; =====================================================
; PRINT_LINE
;
; SI = address of string
; DH = row
; DL = column
; BL = attribute
; =====================================================

print_line:

next_character:

    mov al, [si]

    ; Check for end of string
    cmp al, 0
    je line_done

    ; Set cursor position
    mov ah, 02h
    int 10h

    ; Print one character
    push dx
    push si

    mov ah, 09h
    mov cx, 1
    int 10h

    pop si
    pop dx

    ; Move to next character
    inc si
    inc dl

    jmp next_character

line_done:

    ret


; =====================================================
; ASCII ART DATA
; =====================================================


m1 db '    /\_____/\', 0
m2 db '   /  o   o  \', 0
m3 db '  ( ==  ^  == )', 0
m4 db '   )         (', 0
m5 db '  (           )', 0
m6 db ' ( (  )   (  ) )', 0
m7 db '(__(__)___(__)__)', 0