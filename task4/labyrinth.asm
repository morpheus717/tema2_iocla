%include "../include/io.mac"

extern printf
extern position
global solve_labyrinth

; you can declare any helper variables in .data or .bss

section .bss
    out_line resd 1
    out_col resd 1
    lines resd 1
    cols resd 1

section .data
    dir_x dd -1, 0, 1, 0
    dir_y dd 0, -1, 0, 1
    cur_x dd 0
    cur_y dd 0
section .text

; void solve_labyrinth(int *out_line, int *out_col, int m, int n, char **labyrinth);
solve_labyrinth:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     eax, [ebp + 8]  ; unsigned int *out_line, pointer to structure containing exit position
    mov     ebx, [ebp + 12] ; unsigned int *out_col, pointer to structure containing exit position
    mov     ecx, [ebp + 16] ; unsigned int m, number of lines in the labyrinth
    mov     edx, [ebp + 20] ; unsigned int n, number of colons in the labyrinth
    mov     esi, [ebp + 24] ; char **a, matrix represantation of the labyrinth
    ;; DO NOT MODIFY
   
    ;; Freestyle starts here 
    push eax
    push ebx
    dec ecx
    dec edx
    mov dword [out_line], eax   ; stocam pentru a elibera registrele
    mov dword [out_col], ebx
    mov dword [lines], ecx
    mov dword [cols], edx
    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
in_labyrinth:
    mov eax, dword [cur_x]
    mov ebx, dword [cur_y]
    mov eax, [esi + 4 * eax]    ; punem 1 pe valoarea curenta sa nu ne intoarcem
    inc byte [eax + ebx]

    mov ebx, dword [lines]      ; conditiile de break
    cmp ebx, dword [cur_x]
    jz end
    mov ebx, dword [cols]
    cmp ebx, dword [cur_y]
    jz end   

    mov ecx, -1
check_directions:
    inc ecx
    mov eax, dword [dir_x + 4 * ecx]
    mov ebx, dword [dir_y + 4 * ecx]
    add eax, dword [cur_x]      ; pozitia posibila pt fiecare miscare
    add ebx, dword [cur_y]
    cmp eax, 0
    jl check_directions
    cmp ebx, 0
    jl check_directions
    mov eax, [esi + 4 * eax]
    mov dl, byte [eax + ebx]
    cmp dl, '0'
    jnz check_directions
    mov eax, dword [dir_x + 4 * ecx]
    mov ebx, dword [dir_y + 4 * ecx]
    add eax, dword [cur_x]      ; modific cur_x si cur_y
    add ebx, dword [cur_y]
    mov dword [cur_x], eax
    mov dword [cur_y], ebx

    jmp in_labyrinth

end:
    pop ebx
    pop eax
    mov ecx, dword [cur_y]
    mov edx, dword [cur_x]
    mov dword [ebx], ecx
    mov dword [eax], edx
    mov dword [cur_x], 0
    mov dword [cur_y], 0
    ;; Freestyle ends here
    ;; DO NOT MODIFY

    popa
    leave
    ret
    
    ;; DO NOT MODIFY
