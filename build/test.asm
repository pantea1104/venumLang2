section .text
   global _start
print:
   push    rbp
   mov     rbp, rsp
   sub     rsp, 64
   mov     DWORD   [rbp-52], edi
   mov     DWORD   [rbp-4], 1
   mov     eax, DWORD   [rbp-4]
   movsx   rdx, eax
   mov     eax, 32
   sub     rax, rdx
   mov     BYTE   [rbp-48+rax], 10
.L2:
   mov     edx, DWORD   [rbp-52]
   movsx   rax, edx
   imul    rax, rax, 1717986919
   shr     rax, 32
   sar     eax, 2
   mov     esi, edx
   sar     esi, 31
   sub     eax, esi
   mov     ecx, eax
   mov     eax, ecx
   sal     eax, 2
   add     eax, ecx
   add     eax, eax
   mov     ecx, edx
   sub     ecx, eax
   mov     eax, ecx
   lea     ecx, [rax+48]
   mov     eax, DWORD   [rbp-4]
   movsx   rdx, eax
   mov     eax, 31
   sub     rax, rdx
   mov     edx, ecx
   mov     BYTE   [rbp-48+rax], dl
   add     DWORD   [rbp-4], 1
   mov     eax, DWORD   [rbp-52]
   movsx   rdx, eax
   imul    rdx, rdx, 1717986919
   shr     rdx, 32
   sar     edx, 2
   sar     eax, 31
   mov     ecx, eax
   mov     eax, edx
   sub     eax, ecx
   mov     DWORD   [rbp-52], eax
   cmp     DWORD   [rbp-52], 0
   jg      .L2
   mov     eax, DWORD   [rbp-4]
   cdqe
   mov     edx, DWORD   [rbp-4]
   movsx   rdx, edx
   mov     ecx, 32
   sub     rcx, rdx
   lea     rdx, [rbp-48]
   add     rcx, rdx
   mov     rdx, rax
   mov     rsi, rcx
   mov     edi, 1
   mov     rax, 1
   syscall
   nop
   leave
   ret
_start:
    ; push 2 onto stack
    push 2
    ; variable declaration
    mov rax, MEMORY
    mov rdi, 0
    add rax, rdi
    push rax
    ; self.write byte to variable
    pop rax
    pop rdi
    mov [rax], rdi
    ; push 14619 onto stack
    push 14619
    ; variable declaration
    mov rax, MEMORY
    mov rdi, 2
    add rax, rdi
    push rax
    ; self.write byte to variable
    pop rax
    pop rdi
    mov [rax], rdi
    ; push 0 onto stack
    push 0
    ; variable declaration
    mov rax, MEMORY
    mov rdi, 4
    add rax, rdi
    push rax
    ; self.write byte to variable
    pop rax
    pop rdi
    mov [rax], rdi
    ; push 0 onto stack
    push 0
    ; variable declaration
    mov rax, MEMORY
    mov rdi, 8
    add rax, rdi
    push rax
    ; self.write byte to variable
    pop rax
    pop rdi
    mov [rax], rdi
    ; push 0 onto stack
    push 0
    ; push 1 onto stack
    push 1
    ; variable declaration
    mov rax, MEMORY
    mov rdi, 0
    add rax, rdi
    push rax
    ; load byte from variable
    pop r10
    xor rax, rax
    mov AX, WORD [r10]
    push rax
    pop rdx
    pop rsi
    pop rdi
    ; function call
    call open_socket
    push rax
    ; variable declaration
    mov rax, MEMORY
    mov rdi, 12
    add rax, rdi
    push rax
    ; self.write byte to variable
    pop rax
    pop rdi
    mov [rax], rdi
    ; variable declaration
    mov rax, MEMORY
    mov rdi, 12
    add rax, rdi
    push rax
    ; load byte from variable
    pop r10
    xor rax, rax
    mov RAX, QWORD [r10]
    push rax
    ; push 0 onto stack
    push 0
    ; checks if element is less then
    pop rdi
    pop rax
    cmp rax, rdi
    setl al
    movzx rax, al
    push rax
    ; if statement
    pop rax
    cmp rax, 0
    je if_82
    ; push "Couldnt create socket\n" onto stack
    push 22
    push str_77
    ; calls syscall 1
    mov rax, 1
    mov rdi, 1
    pop r8
    pop r9
    mov rsi, r8
    mov rdx, r9
    syscall
    ; push 1 onto stack
    push 1
    ; exit process
    mov rax, 60
    mov rdi, 0
    syscall
    ; else statement
    jmp if_88
 if_82:
    ; push "Socket created, is: " onto stack
    push 20
    push str_82
    ; calls syscall 1
    mov rax, 1
    mov rdi, 1
    pop r8
    pop r9
    mov rsi, r8
    mov rdx, r9
    syscall
    ; variable declaration
    mov rax, MEMORY
    mov rdi, 12
    add rax, rdi
    push rax
    ; load byte from variable
    pop r10
    xor rax, rax
    mov RAX, QWORD [r10]
    push rax
    ; calls print label to print top of stack
    pop rdi
    call print
    ; end statement
 if_88:
 do_88:
    ; push 16 onto stack
    push 16
    ; variable declaration
    mov rax, MEMORY
    mov rdi, 0
    add rax, rdi
    push rax
    ; variable declaration
    mov rax, MEMORY
    mov rdi, 12
    add rax, rdi
    push rax
    ; load byte from variable
    pop r10
    xor rax, rax
    mov RAX, QWORD [r10]
    push rax
    pop rdx
    pop rsi
    pop rdi
    ; function call
    call bind
    push rax
    ; push 0 onto stack
    push 0
    ; checks if element is not equal to
    pop rdi
    pop rax
    cmp rax, rdi
    setne al
    movzx rax, al
    push rax
    ; if statement
    pop rax
    cmp rax, 0
    je if_100
    ; push "Couldnt bind socket\n" onto stack
    push 20
    push str_96
    ; calls syscall 1
    mov rax, 1
    mov rdi, 1
    pop r8
    pop r9
    mov rsi, r8
    mov rdx, r9
    syscall
    ; exit process
    mov rax, 60
    mov rdi, 0
    syscall
    ; else statement
    jmp if_103
 if_100:
    ; push "Socket bound\n" onto stack
    push 13
    push str_100
    ; calls syscall 1
    mov rax, 1
    mov rdi, 1
    pop r8
    pop r9
    mov rsi, r8
    mov rdx, r9
    syscall
    ; end statement
 if_103:
 do_103:
    ; push 5 onto stack
    push 5
    ; variable declaration
    mov rax, MEMORY
    mov rdi, 12
    add rax, rdi
    push rax
    ; load byte from variable
    pop r10
    xor rax, rax
    mov RAX, QWORD [r10]
    push rax
    pop rsi
    pop rdi
    ; function call
    call listen
    push rax
    ; push 0 onto stack
    push 0
    ; checks if element is not equal to
    pop rdi
    pop rax
    cmp rax, rdi
    setne al
    movzx rax, al
    push rax
    ; if statement
    pop rax
    cmp rax, 0
    je if_114
    ; push "Couldnt listen to socket\n" onto stack
    push 25
    push str_110
    ; calls syscall 1
    mov rax, 1
    mov rdi, 1
    pop r8
    pop r9
    mov rsi, r8
    mov rdx, r9
    syscall
    ; exit process
    mov rax, 60
    mov rdi, 0
    syscall
    ; else statement
    jmp if_117
 if_114:
    ; push "Socket listening\n" onto stack
    push 17
    push str_114
    ; calls syscall 1
    mov rax, 1
    mov rdi, 1
    pop r8
    pop r9
    mov rsi, r8
    mov rdx, r9
    syscall
    ; end statement
 if_117:
 do_117:
    ; variable declaration
    mov rax, MEMORY
    mov rdi, 8
    add rax, rdi
    push rax
    ; variable declaration
    mov rax, MEMORY
    mov rdi, 0
    add rax, rdi
    push rax
    ; variable declaration
    mov rax, MEMORY
    mov rdi, 12
    add rax, rdi
    push rax
    ; load byte from variable
    pop r10
    xor rax, rax
    mov RAX, QWORD [r10]
    push rax
    pop rdx
    pop rsi
    pop rdi
    ; function call
    call accept
    push rax
    ; variable declaration
    mov rax, MEMORY
    mov rdi, 20
    add rax, rdi
    push rax
    ; self.write byte to variable
    pop rax
    pop rdi
    mov [rax], rdi
    ; variable declaration
    mov rax, MEMORY
    mov rdi, 20
    add rax, rdi
    push rax
    ; load byte from variable
    pop r10
    xor rax, rax
    mov RAX, QWORD [r10]
    push rax
    ; push 0 onto stack
    push 0
    ; checks if element is less then
    pop rdi
    pop rax
    cmp rax, rdi
    setl al
    movzx rax, al
    push rax
    ; if statement
    pop rax
    cmp rax, 0
    je if_133
    ; push "Couldnt accept connection\n" onto stack
    push 26
    push str_129
    ; calls syscall 1
    mov rax, 1
    mov rdi, 1
    pop r8
    pop r9
    mov rsi, r8
    mov rdx, r9
    syscall
    ; exit process
    mov rax, 60
    mov rdi, 0
    syscall
    ; else statement
    jmp if_141
 if_133:
    ; push "Connection accepted, is: \n" onto stack
    push 26
    push str_133
    ; calls syscall 1
    mov rax, 1
    mov rdi, 1
    pop r8
    pop r9
    mov rsi, r8
    mov rdx, r9
    syscall
    ; variable declaration
    mov rax, MEMORY
    mov rdi, 20
    add rax, rdi
    push rax
    ; load byte from variable
    pop r10
    xor rax, rax
    mov RAX, QWORD [r10]
    push rax
    ; calls print label to print top of stack
    pop rdi
    call print
    ; push "\n" onto stack
    push 1
    push str_138
    ; calls syscall 1
    mov rax, 1
    mov rdi, 1
    pop r8
    pop r9
    mov rsi, r8
    mov rdx, r9
    syscall
    ; end statement
 if_141:
 do_141:
    ; push "HTTP/1.1 200 OK\n" onto stack
    push 16
    push str_141
    ; variable declaration
    mov rax, MEMORY
    mov rdi, 20
    add rax, rdi
    push rax
    ; load byte from variable
    pop r10
    xor rax, rax
    mov RAX, QWORD [r10]
    push rax
    pop rdx
    pop rsi
    pop rdi
    ; function call
    call fputs
    push rax
    ; push "Server: Atest\n" onto stack
    push 14
    push str_145
    ; variable declaration
    mov rax, MEMORY
    mov rdi, 20
    add rax, rdi
    push rax
    ; load byte from variable
    pop r10
    xor rax, rax
    mov RAX, QWORD [r10]
    push rax
    pop rdx
    pop rsi
    pop rdi
    ; function call
    call fputs
    push rax
    ; push "Content-Type: text/html\n" onto stack
    push 24
    push str_149
    ; variable declaration
    mov rax, MEMORY
    mov rdi, 20
    add rax, rdi
    push rax
    ; load byte from variable
    pop r10
    xor rax, rax
    mov RAX, QWORD [r10]
    push rax
    pop rdx
    pop rsi
    pop rdi
    ; function call
    call fputs
    push rax
    ; push "Connection: Closed\n" onto stack
    push 19
    push str_153
    ; variable declaration
    mov rax, MEMORY
    mov rdi, 20
    add rax, rdi
    push rax
    ; load byte from variable
    pop r10
    xor rax, rax
    mov RAX, QWORD [r10]
    push rax
    pop rdx
    pop rsi
    pop rdi
    ; function call
    call fputs
    push rax
    ; push "\n" onto stack
    push 1
    push str_157
    ; variable declaration
    mov rax, MEMORY
    mov rdi, 20
    add rax, rdi
    push rax
    ; load byte from variable
    pop r10
    xor rax, rax
    mov RAX, QWORD [r10]
    push rax
    pop rdx
    pop rsi
    pop rdi
    ; function call
    call fputs
    push rax
    ; push "<h1>Hello World!</h1>\n" onto stack
    push 22
    push str_161
    ; variable declaration
    mov rax, MEMORY
    mov rdi, 20
    add rax, rdi
    push rax
    ; load byte from variable
    pop r10
    xor rax, rax
    mov RAX, QWORD [r10]
    push rax
    pop rdx
    pop rsi
    pop rdi
    ; function call
    call fputs
    push rax
    
    ; end of code, exit status
    mov rax, 60
    mov rdi, 0
    syscall
 ; function definition
open_socket:
    push rbp
    mov rbp, rsp
    push rdi
    push rsi
    push rdx
    ; push 41 onto stack
    push 41
    pop r15
    mov rax, r15
    pop r15
    mov rdi, r15
    pop r15
    mov rsi, r15
    pop r15
    mov rdx, r15
    syscall
    push rax
    ; early return
    pop rax
    leave
    ret
    ; function end
    leave
    ret
; function definition
bind:
    push rbp
    mov rbp, rsp
    push rdi
    push rsi
    push rdx
    ; push 49 onto stack
    push 49
    pop r15
    mov rax, r15
    pop r15
    mov rdi, r15
    pop r15
    mov rsi, r15
    pop r15
    mov rdx, r15
    syscall
    push rax
    ; early return
    pop rax
    leave
    ret
    ; function end
    leave
    ret
; function definition
fputs:
    push rbp
    mov rbp, rsp
    push rdi
    push rsi
    push rdx
    ; push 1 onto stack
    push 1
    pop r15
    mov rax, r15
    pop r15
    mov rdi, r15
    pop r15
    mov rsi, r15
    pop r15
    mov rdx, r15
    syscall
    push rax
    ; early return
    pop rax
    leave
    ret
    ; function end
    leave
    ret
; function definition
listen:
    push rbp
    mov rbp, rsp
    push rdi
    push rsi
    ; push 50 onto stack
    push 50
    pop r15
    mov rax, r15
    pop r15
    mov rdi, r15
    pop r15
    mov rsi, r15
    pop r15
    mov rdx, r15
    syscall
    push rax
    ; early return
    pop rax
    leave
    ret
    ; function end
    leave
    ret
; function definition
accept:
    push rbp
    mov rbp, rsp
    push rdi
    push rsi
    push rdx
    ; push 43 onto stack
    push 43
    pop r15
    mov rax, r15
    pop r15
    mov rdi, r15
    pop r15
    mov rsi, r15
    pop r15
    mov rdx, r15
    syscall
    push rax
    ; early return
    pop rax
    leave
    ret
    ; function end
    leave
    ret


section .data
str_77:
    db 0x43, 0x6f, 0x75, 0x6c, 0x64, 0x6e, 0x74, 0x20, 0x63, 0x72, 0x65, 0x61, 0x74, 0x65, 0x20, 0x73, 0x6f, 0x63, 0x6b, 0x65, 0x74, 0xa
str_82:
    db 0x53, 0x6f, 0x63, 0x6b, 0x65, 0x74, 0x20, 0x63, 0x72, 0x65, 0x61, 0x74, 0x65, 0x64, 0x2c, 0x20, 0x69, 0x73, 0x3a, 0x20
str_96:
    db 0x43, 0x6f, 0x75, 0x6c, 0x64, 0x6e, 0x74, 0x20, 0x62, 0x69, 0x6e, 0x64, 0x20, 0x73, 0x6f, 0x63, 0x6b, 0x65, 0x74, 0xa
str_100:
    db 0x53, 0x6f, 0x63, 0x6b, 0x65, 0x74, 0x20, 0x62, 0x6f, 0x75, 0x6e, 0x64, 0xa
str_110:
    db 0x43, 0x6f, 0x75, 0x6c, 0x64, 0x6e, 0x74, 0x20, 0x6c, 0x69, 0x73, 0x74, 0x65, 0x6e, 0x20, 0x74, 0x6f, 0x20, 0x73, 0x6f, 0x63, 0x6b, 0x65, 0x74, 0xa
str_114:
    db 0x53, 0x6f, 0x63, 0x6b, 0x65, 0x74, 0x20, 0x6c, 0x69, 0x73, 0x74, 0x65, 0x6e, 0x69, 0x6e, 0x67, 0xa
str_129:
    db 0x43, 0x6f, 0x75, 0x6c, 0x64, 0x6e, 0x74, 0x20, 0x61, 0x63, 0x63, 0x65, 0x70, 0x74, 0x20, 0x63, 0x6f, 0x6e, 0x6e, 0x65, 0x63, 0x74, 0x69, 0x6f, 0x6e, 0xa
str_133:
    db 0x43, 0x6f, 0x6e, 0x6e, 0x65, 0x63, 0x74, 0x69, 0x6f, 0x6e, 0x20, 0x61, 0x63, 0x63, 0x65, 0x70, 0x74, 0x65, 0x64, 0x2c, 0x20, 0x69, 0x73, 0x3a, 0x20, 0xa
str_138:
    db 0xa
str_141:
    db 0x48, 0x54, 0x54, 0x50, 0x2f, 0x31, 0x2e, 0x31, 0x20, 0x32, 0x30, 0x30, 0x20, 0x4f, 0x4b, 0xa
str_145:
    db 0x53, 0x65, 0x72, 0x76, 0x65, 0x72, 0x3a, 0x20, 0x41, 0x74, 0x65, 0x73, 0x74, 0xa
str_149:
    db 0x43, 0x6f, 0x6e, 0x74, 0x65, 0x6e, 0x74, 0x2d, 0x54, 0x79, 0x70, 0x65, 0x3a, 0x20, 0x74, 0x65, 0x78, 0x74, 0x2f, 0x68, 0x74, 0x6d, 0x6c, 0xa
str_153:
    db 0x43, 0x6f, 0x6e, 0x6e, 0x65, 0x63, 0x74, 0x69, 0x6f, 0x6e, 0x3a, 0x20, 0x43, 0x6c, 0x6f, 0x73, 0x65, 0x64, 0xa
str_157:
    db 0xa
str_161:
    db 0x3c, 0x68, 0x31, 0x3e, 0x48, 0x65, 0x6c, 0x6c, 0x6f, 0x20, 0x57, 0x6f, 0x72, 0x6c, 0x64, 0x21, 0x3c, 0x2f, 0x68, 0x31, 0x3e, 0xa

section .bss
    ; MEMORY
  MEMORY: resb 64000
    ; heap
