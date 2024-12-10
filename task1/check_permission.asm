%include "../include/io.mac"

extern ant_permissions

extern printf
global check_permission

section .text

check_permission:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     eax, [ebp + 8]  ; id and permission
    mov     ebx, [ebp + 12] ; address to return the result
    ;; DO NOT MODIFY
   
    ;; Your code starts here
    mov ecx, eax
    shr ecx, 24     ; pastram idul
    mov edx, dword [ant_permissions + ecx * 4]  ; in edx permisiunile
    shl eax, 8      ; in eax dorintele
    shr eax, 8
    and edx, eax      ; and logic intre dorinte si permisiuni 
    cmp eax, edx      ; trebuie sa fie egal cu dorinte
    jz permission_granted
    mov eax, 0
    mov [ebx], eax
    popa
    leave
    ret
permission_granted:
    mov eax, 1
    mov [ebx], eax
    ;; Your code ends here
    
    ;; DO NOT MODIFY

    popa
    leave
    ret
    
    ;; DO NOT MODIFY
