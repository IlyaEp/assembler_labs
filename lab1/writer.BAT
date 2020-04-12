; goto cmpl1
.model tiny
.386
.code
org 100h
start:
	jmp next
filename db 'booter1.com',0
errormes db 'Error!$'
success	 db 'Success!$'
next:
	mov ah, 3Dh
	mov al, 0
	lea dx, filename
	int 21h
	jc err1
	
	mov bx, ax
	mov ah, 3Fh
	mov cx, 512
	lea dx, buff
	int 21h
	jc err1

	mov ah,3Eh
	int 21h

	mov ah, 03h
	mov al, 1
	mov ch, 0
	mov cl, 1
	mov dh, 0
	mov dl, 0
	lea bx, buff
	int 13h
	jc err1
	
	lea dx, success
	mov ah, 09h
	int 21h
	
	xor dx, dx   ; Обнуление регистра
	
	mov cl, 0    ; Инициализация регистра для символов
	
	xor bx, bx   ; Обнуление и иннициализация регистра
	mov bl, 0    ;	 	для подсчета сиволов в строке
	
	mov ah, 02h  ; Запись функции для вывода
	
newline:
	mov dl, 0Dh
	int 21h
	
	mov dl, 0Ah
	int 21h
	
	mov bl, 0
	
	jmp control

	
while:
	mov dl, 20h  ; Вывод 
	int 21h 	 ; 	пробела
	
	mov dl, cl	 ; Вывод
	int 21h		 ; 	символа ascii
	
	mov dl, 20h  ; Вывод 
	int 21h		 ; 	пробела
	
	mov dl, 0B3h ; Вывод
	int 21h		 ; 	вертикалььной черты
	
	add cl, 1	 ; Инкремент для символа
	add bl, 1	 ; Инкремент для кол-ва символов в строке
	
	cmp bl, 12	 ; Проверка конца строки
	je newline

control:	
	cmp 255, cl	 ; Контроль кол-ва символов для таблицы
	jae while
	
	
	ret
buff	db 512 dup(0)
err1:
	lea dx, errormes
	mov ah, 09h
	int 21h
	ret
end start
;:cmpl1
;tasm /m5 writer.bat
;tlink /x/t writer