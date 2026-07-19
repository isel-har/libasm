section .text
    global ft_strcmp

ft_strcmp:
    xor rax, rax ; initialize rax register to zero using xor

_start_loop:

    mov dl, [rdi + rax] ; fetch the current byte from first string
    cmp dl, 0           ; compare the current byte with 0
    je _end_loop         ; jump end loop if equal

    cmp byte [rsi + rax], 0 ; compare the fetchted current byte form second string with 0
    je _end_loop         ; jump to end loop if equal

    cmp byte [rsi + rax], dl    ; compare the current hold byte by dl register with current position of the sec string
    jne _end_loop                ; if not equal end the loop othwise go to next iteration

    inc rax                     ; inc rax register
    jmp _start_loop              ; jump to start loop

_end_loop:
    movzx r8d, byte [rsi + rax]  ; zero-extend s2[i] first, rax still valid index
    movzx eax, dl                ; zero-extend s1[i], now safe to clobber rax
    sub eax, r8d                 ; correct signed 32-bit subtraction to eax 32-bit register also used for return

    ret                          ; then return
