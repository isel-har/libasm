extern ft_strlen
extern ft_strcpy
extern malloc

section .text
    global ft_strdup

ft_strdup:

    ;1-arg: rdi, 2-arg: rsi, 3-arg: rdx

    call ft_strlen  ; call strlen also expect rdi

    push rdi ; push address hold by rdi register into memory stack

    mov rdi, rax ; copy the changed rax to rdi because malloc expects rdi which is the size to allocate

    call malloc ; now rax changed to address by malloc

    cmp rax, 0 ; check the error using test perform bitwise AND operator to check if sign = negative
    je _malloc_failed; jump if null ptr returned

    ; here rax contains the address of the allocated memory block

    mov rdi, rax ; copy rax value to rdi againe because as dest parameter for ft_strcpy
    pop rsi ; copy temp_ptr which is the source parameter for ft_strcpy

    call ft_strcpy ; now call ft_strcpy respecting registers/parameters

    ret ; finally rax hold the dest address which is the allocated


_malloc_failed:
    pop rsi ; balance the stack by poping the last pushed value if malloc fails
    xor rax, rax; return null value
    ret
