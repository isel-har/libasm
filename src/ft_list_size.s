section .text
    global ft_list_size


ft_list_size:

    ; 1 rdi, pointer to list
    xor eax, eax ; initialize the eax


_start_loop:

    cmp rdi, 0
    je _end_loop


    inc eax
    mov rdi, [rdi + 8]

    jmp _start_loop


_end_loop:
    ret
