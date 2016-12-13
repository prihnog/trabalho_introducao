segment .data

msg1 db "Vetor 1 - Digite 10 numeros e presione enter:", 0xA
len1 equ $-msg1

vetor1 db 0,0,0,0,0,0,0,0,0,0
la equ $-vetor1

msg2 db "Vetor 2 - Digite 10 numeros e presione enter:", 0xA
len2 equ $-msg2

vetor2 db 0,0,0,0,0,0,0,0,0,0
la equ $-vetor2

msg3 db  0xA
lm3 equ $-msg3


segment .bss

vetor_1 resb 2			;reserva de 2 bytes
vetor_2 resb 2			;reserva de 2 bytes
vetor_3 resb 2			;reserva de 2 bytes


segment .text

global _start
_start:

;VETOR 1:
mov eax, 4			;sys_write
mov ebx, 1			;stdout
mov ecx, msg1		;mensagem que aparece na tela
mov edx, len1		;tamanho da mensagem
int 0x80			;interrupção

mov esi, vetor1
mov edi, 0			;contador

leitura:
mov eax, 3			;sys_read
mov ebx, 2			;stdin
mov ecx, vetor_1
mov edx, 2			;tamanho de 2 byte
int 0x80			;interrupção

mov al, [vetor_1]
sub al, '0'			;conversão

mov [esi], al		;por o valor na memória

add esi, 1			;incremento de elemento no vetor
add edi, 1			;incremento do contador

cmp edi, la			;comparação entre contador e tamanho do vetor
jb leitura			;condição: enquanto edi<la, loop continua

;=============================================

;VETOR 2:
mov eax, 4			;sys_write
mov ebx, 1			;stdout
mov ecx, msg2		;mensagem que aparece na tela
mov edx, len2		;tamanho da mensagem
int 0x80			;interrupção

mov esi, vetor2
mov edi, 0			;contador

leitura:
mov eax, 3			;sys_read
mov ebx, 2			;stdin
mov ecx, vetor_2
mov edx, 2			;tamanho de 2 byte
int 0x80			;interrupção

mov al, [vetor_2]
sub al, '0'			;conversão

mov [esi], al		;por o valor na memória

add esi, 1			;incremento de elemento no vetor
add edi, 1			;incremento do contador

cmp edi, la			;comparação entre contador e tamanho do vetor
jb leitura			;condição: enquanto edi<la, loop continua

;=============================================

;SOMA:
mov esi, vetor1
mov ecx, vetor2
mov edi, 0			;contador

vetor3:
	mov edx,[esi]	;põe no registrador vetor 1
	mov ebx,[ecx]	;põe no registrador vetor 2
	sub bh,'0'		;conversão
	sub dh,'0'		;conversão
	add edx,ebx		;soma

	add bl, 1		;adiciona indice do vetor 1
	add dl, 1       ;adiciona indice do vetor 2

	inc edi			;incremento
loop vetor3

;=============================================

;Impressão Vetor C:
mov esi, 0
imp_vetor:

	mov [vetor_3], eax	;vai para memória
	add eax, '0'		;conversão

	mov eax, 4		    ;sys_write
	mov ebx, 1		    ;stdout
	mov ecx, vetor_3	;impressão do vetor resultante
	mov edx, 2		    ;tamanho de 2 byte
	int 0x80            ;interrupção

	inc esi			    ;incremento

loop imp_vetor

	mov eax, 4		    ;sys_write
	mov ebx, 1		    ;stdout
	mov ecx, msg3		;mensagem que aparece na tela
	mov edx, lm3		;tamanho da mensagem
	int 0x80	        ;interrupção

;========================================================

sair:
 mov eax, 1             ;saida do sistema
 xor ebx, ebx
 int 0x80		        ;interrupção

