extern _malloc

section .text
    global _ft_create_elem

_ft_create_elem:

    ; 1-arg rdi holds the data address of the struct

    push rdi

    mov rdi, 16

    call _malloc

    ;rax here holds the new address with size of 16 bytes
    cmp rax, 0
    je _malloc_error

    pop rdi
    mov QWORD [rax], rdi
    mov QWORD [rax + 8], QWORD 0

    ret


_malloc_error:
    pop rdi
    xor rax, rax
    ret
