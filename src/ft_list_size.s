section .text
    global ft_list_size


ft_list_size:

    xor eax, eax ; initize eax with zero

__loop:

    cmp rdi, 0 ; compare current address with null
    je __end ; if equal go return

    inc eax ; impact the rax register also


    mov rdx, [rdi + 8] ; copy the next node address to rdx
    mov rdi, rdx ; then update rdi register by the next address

    jmp __loop ; jmp to __loop

__end:
    ret
