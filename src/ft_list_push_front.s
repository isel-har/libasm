extern ft_create_elem

section .text

    global ft_list_push_front


ft_list_push_front:

    ;rdi ptr to ptr, rsi void ptr

    push rbp
    mov rbp, rsp
    sub rsp, 40
    ; reserve 40 bytes stack frame

    mov qword [rbp - 8], rdi ; save the first arg **begin
    mov qword [rbp - 16], rsi ; save the second arg *data




    mov rdi, qword [rbp - 16] ; change the rdi with data address to be used as argument for ft_create_elem
    call ft_create_elem
    ; rax return

    mov qword [rbp - 24], rax ; save rax value into the stack


    mov rax, qword [rbp - 8] ; update rax with the **begin pointer
    mov rax, [rax] ; update againe with original pointer of the list

    mov rdx, qword [rbp - 24] ; copy the node address into rdx register
    mov qword [rdx + 8], rax ; copy the rax which is the original pointer to next pointer of the npode
    

    mov rax, qword [rbp - 8] ; update rax with **begin
    mov rdx, qword [rbp - 24]
    mov [rax], rdx ; dereference it to get the original then make points on the node


    ; release the stack
    add rsp, 40
    pop rbp
    ret
