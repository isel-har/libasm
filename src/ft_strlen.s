section .text
    global _ft_strlen

_ft_strlen:

    xor rax, rax ; is similar to mov rax, 0 but preferred for nano-optimization (faster)

start_loop: 

    cmp byte [rdi + rax], 0 ; compare the fetchted byte pointed by rdi + position with 0
    je end_loop ; if equal jump or go to end loop and return


    inc rax ; inc rax
    jmp start_loop ; then jump back to start againe

end_loop:
    ret ; return value that hold by rax register
