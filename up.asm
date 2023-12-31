		.model small
		.stack 64
		.data
msg1	db 'use enter key,to quit!$'
msg2	db 10,13,'enter lowecase string : $'
msg3	db 10,13,'error! enter again : $'
msg4	db 10,13,'your lowercase : $'
msg5	db 10,13,'its uppercase : $'

buffer	db 1000 dup(?)
		.code
	main proc far
		mov ax,@data
		mov ds,ax
		
		lea dx,msg1			;display msg1
		mov ah,9
		int 21h
		
		lea dx,msg2			;display msg2
		mov ah,9
		int 21h
		
		mov cx,0			;initialize cx for counting
		
		lea si,buffer		;load offset buffer in si
		
	yy:	mov ah,1			;input from keyboard
		int 21h
		
		cmp al,13			;cmp al, with enter_key
		je xx				;jump to xx if al is enter_key
		
		cmp al,'a'			;cmp al with 'a'
		jb err				;jump to err if al is below 'a'
		
		
		cmp al,'z'			;cmp al with 'z'
		ja err				;jump to err if al is above 'z', non-lowecase
		
		mov [si],al			;load al, on[si],storing in buffer
		
		inc si				;increament si
		inc cx				;increament cx, number of chars
		
		jmp yy				;go to yy to enter string untill you click enter_key
		
	err:	lea dx,msg3		;display msg3
			mov ah,9
			int 21h
			
			jmp yy			;go to yy to enter again
			
	xx:	lea dx,msg4			;display msg4
		mov ah,9
		int 21h
		
		mov cx,cx			;load cx, on cx, number of chars on cx
		mov bx,cx			;load cx on bx
		
		lea si,buffer		;load offset of buffer on si
		
top1:	mov al,[si]			;load [si] on al, to display on screen
		
		mov ah,2
		mov dl,al			;display al on screen
		int 21h
		
		inc si
		
		loop top1			;go to top1 until cx=0
		
		mov cx,bx			;load bx on cx, number of chars in buffer
		
		lea si,buffer		;load offset of buffer on si
		
		lea dx,msg5			;display msg5
		mov ah,9
		int 21h
		
		
top2:	mov al,[si]			;load chars from buffer on al

		sub al,20h			;convert uppercase to lowercase
		
		mov ah,2
		mov dl,al			;display each chars on screen
		int 21h
		
		inc si
		
		loop top2			;go to top2 until cx=0
		
		mov ah,4ch			;return to os
		int 21h
		
	main endp
		end main