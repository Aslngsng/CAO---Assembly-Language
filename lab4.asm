bits 16
org 100h

start:
    mov bh, 0          ; Video page 0
    mov al, ' '        ; Blank character used to create colored blocks

    call first
    call second
    call third

    ; Wait for a key press
    mov ah, 00h
    int 16h

    ; Return to DOS
    mov ax, 4C00h
    int 21h


; ------------------------------------------------------
; FIRST
; Fills the whole screen with red background
; Attribute 44h = Red background + Red foreground
; ------------------------------------------------------
first:
    mov cx, 24         ; 24 rows
    mov bl, 44h        ; Red background, red foreground
    mov dh, 0          ; Start at row 0

first_loop:
    mov dl, 0          ; Start at column 0

    mov ah, 02h        ; BIOS: Set cursor position
    int 10h

    push cx            ; Save row counter

    mov ah, 09h        ; BIOS: Write character and attribute
    mov cx, 80         ; Fill 80 columns
    int 10h

    pop cx             ; Restore row counter

    inc dh             ; Move to next row
    loop first_loop

    ret


; ------------------------------------------------------
; SECOND
; Creates a green block at the lower-left side
; Attribute 22h = Green background + Green foreground
; ------------------------------------------------------
second:
    mov cx, 12         ; 12 rows
    mov bl, 22h        ; Green background, green foreground
    mov dh, 13         ; Start at row 13

second_loop:
    mov dl, 0          ; Start at column 0

    mov ah, 02h        ; Set cursor position
    int 10h

    push cx            ; Save row counter

    mov ah, 09h        ; Write character and attribute
    mov cx, 25         ; Fill 25 columns
    int 10h

    pop cx

    inc dh
    loop second_loop

    ret


; ------------------------------------------------------
; THIRD
; Creates a blue block at the lower-right side
; Attribute 11h = Blue background + Blue foreground
; ------------------------------------------------------
third:
    mov cx, 12         ; 12 rows
    mov bl, 11h        ; Blue background, blue foreground
    mov dh, 13         ; Start at row 13

third_loop:
    mov dl, 55         ; Start at column 55

    mov ah, 02h        ; Set cursor position
    int 10h

    push cx

    mov ah, 09h        ; Write character and attribute
    mov cx, 25         ; Fill 25 columns
    int 10h

    pop cx

    inc dh
    loop third_loop

    ret