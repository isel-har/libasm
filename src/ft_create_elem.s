extern malloc

section .text
    global ft_create_elem

ft_create_elem:


    push rbp
    mov rbp, rsp
    sub rsp, 32

    mov qword [rbp - 8], rdi ; save the first argument into the stack
    
    mov rdi, 16 ; perpare the malloc parameter 16 byte for the node
    call malloc

    ; here rax register expected to hold the malloc return address
    mov qword [rbp - 16], rax ; save the return value into the stack

    xor rax, rax; set rax to zero using xor
    cmp qword [rbp - 16], 0
    je __return

    mov rax, qword [rbp - 16]; update rax with address of the node
    mov rdx, qword [rbp - 8] ; copy the data address into rdx
    mov [rax], rdx   ; dereference node to get data pointer then copy the rdx which is the data address
    mov qword [rax + 8], 0 ; fill the next with null address



__return:
    add rsp, 32
    pop rbp
    ret
