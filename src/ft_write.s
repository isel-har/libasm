extern __errno_location
section .text
    global ft_write

ft_write:

    ;1-arg: rdi, 2-arg: rsi, 3-arg: rdx 

    mov rax, 1 ; sys call for write linux expects rax register to read the sys call code
    syscall ; ask kernel to execute

    test rax, rax ; check the error using test perform bitwise AND operator to check if sign = negative
    js  _handle_error ; jump if sign to handle error

    ret ; rax filled with written bytes by the sys call

_handle_error:
    neg rax                     ; Invert negative error code to a positive value
    push rax                    ; Save the error code on the stack to protect it

    ; Call _error_location to get the memory address of errno
    call __errno_location      ; Pointer to errno is now returned in rax

    pop rdi                     ; Retrieve our positive error code into rdi
    mov [rax], edi              ; Move the 32-bit error integer into the errno memory address
    
    mov rax, -1               ; Standard C convention: return -1 on failure
    ret
