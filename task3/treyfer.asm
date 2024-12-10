%include "../include/io.mac"
section .rodata
	global sbox
	global num_rounds
	sbox db 126, 3, 45, 32, 174, 104, 173, 250, 46, 141, 209, 96, 230, 155, 197, 56, 19, 88, 50, 137, 229, 38, 16, 76, 37, 89, 55, 51, 165, 213, 66, 225, 118, 58, 142, 184, 148, 102, 217, 119, 249, 133, 105, 99, 161, 160, 190, 208, 172, 131, 219, 181, 248, 242, 93, 18, 112, 150, 186, 90, 81, 82, 215, 83, 21, 162, 144, 24, 117, 17, 14, 10, 156, 63, 238, 54, 188, 77, 169, 49, 147, 218, 177, 239, 143, 92, 101, 187, 221, 247, 140, 108, 94, 211, 252, 36, 75, 103, 5, 65, 251, 115, 246, 200, 125, 13, 48, 62, 107, 171, 205, 124, 199, 214, 224, 22, 27, 210, 179, 132, 201, 28, 236, 41, 243, 233, 60, 39, 183, 127, 203, 153, 255, 222, 85, 35, 30, 151, 130, 78, 109, 253, 64, 34, 220, 240, 159, 170, 86, 91, 212, 52, 1, 180, 11, 228, 15, 157, 226, 84, 114, 2, 231, 106, 8, 43, 23, 68, 164, 12, 232, 204, 6, 198, 33, 152, 227, 136, 29, 4, 121, 139, 59, 31, 25, 53, 73, 175, 178, 110, 193, 216, 95, 245, 61, 97, 71, 158, 9, 72, 194, 196, 189, 195, 44, 129, 154, 168, 116, 135, 7, 69, 120, 166, 20, 244, 192, 235, 223, 128, 98, 146, 47, 134, 234, 100, 237, 74, 138, 206, 149, 26, 40, 113, 111, 79, 145, 42, 191, 87, 254, 163, 167, 207, 185, 67, 57, 202, 123, 182, 176, 70, 241, 80, 122, 0
	num_rounds dd 10

extern printf

section .text
	global treyfer_crypt
	global treyfer_dcrypt

; void treyfer_crypt(char text[8], char key[8]);
treyfer_crypt:
	;; DO NOT MODIFY
	push ebp
	mov ebp, esp
	pusha

	mov esi, [ebp + 8] ; plaintext
	mov edi, [ebp + 12] ; key	
	;; DO NOT MODIFY
	;; FREESTYLE STARTS HERE
	;; TODO implement treyfer_crypt
	mov ecx, 10	; runde de criptare
encrypt_round:
	push ecx
	xor ebx, ebx
	mov al, byte [esi]	; al este t-ul, primul caracter la inceput
	mov ecx, 0
for_byte_encrypt:	; in fiecare runda
	and eax, 0xFF
	add al, byte [edi + ecx]	; 1.adunam byte-ul i din cheie
	mov al, byte [sbox + eax]	; 2.inlocuim t cu sbox[t]
	mov bl, cl
	inc bl
	and bl, 0x07		; gestionam cazul de ultimul bit
	add al, byte [esi + ebx]  ;	3.adaugam urmatorul din plaintext
	rol al, 1	; 4.rotatia
	mov byte [esi + ebx], al	; 5.actualizam byteul i + 1
	inc ecx
	cmp ecx, 8
	jnz for_byte_encrypt
	pop ecx
loop encrypt_round
    	;; FREESTYLE ENDS HERE
	;; DO NOT MODIFY
	popa
	leave
	ret

; void treyfer_dcrypt(char text[8], char key[8]);
treyfer_dcrypt:
	;; DO NOT MODIFY
	push ebp
	mov ebp, esp
	pusha
	;; DO NOT MODIFY
	;; FREESTYLE STARTS HERE
	;; TODO implement treyfer_dcrypt
	mov esi, [ebp + 8] ; plaintext
	mov edi, [ebp + 12] ; key	
	mov ecx, 10
decrypt_round:
	push ecx
	xor ebx, ebx
	mov ecx, 8
for_byte_decrypt:
	mov al, byte [esi + ecx - 1]
	add al, byte [edi + ecx - 1]	; 1.adaugam byteul corespondent al cheii
	and eax, 0xFF	; ne asiguram ca in afara lui al e 0
	mov al, byte [sbox + eax]	; 2.t = sbox[t]
	mov ebx, ecx	
	and ebx, 0x07
	mov dl, byte [esi + ebx]
	ror dl, 1
	sub dl, al
	mov byte [esi + ebx], dl
	loop for_byte_decrypt
	pop ecx
	loop decrypt_round
	;; FREESTYLE ENDS HERE
	;; DO NOT MODIFY
	popa
	leave
	ret

