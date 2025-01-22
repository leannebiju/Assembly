; program to print a pattern by specifying the number of rows
;      1
;     2 2
;    3 3 3
;   4 4 4 4

data segment
    msg1 db "Enter the number of rows: $"
    newline db 10,13,'$'

data ENDS

code segment
    assume ds:data,cs:code
    
	start:
        mov ax,data
        mov ds,ax

        lea dx,msg1
        mov ah,09H
        int 21H

        mov ah,01H
        int 21H    
        sub al,30H     ;num of rows
		
        lea dx,newline
        mov ah,09H
        int 21H

        mov bl,al      
        
	mov ch, al	;storing to ch also since al changes 
	inc ch
		
	mov cl,01H      ;first number
		
	loop1:
        
	mov dl,' '
        mov ah,02H
        int 21h

        dec bl
        JNZ loop1
		
	;we need to print cl times
	mov bh, cl
		
	;adding loop and logic to print n times
	
	loop2:
        
	add cl,30H
        mov dl,cl
        sub cl,30H
        mov ah,02H
        int 21H
		
	mov dl, ' '
	mov ah, 02h
	int 21h
	dec bh
	jnz loop2
		
        lea dx,newline
        mov ah,09H
        int 21H

        inc cl
        cmp cl,ch
        jz exit
		
	;added 3 line logic to set the spaces 
	mov al, ch
	sub al,cl
	mov bl,al
	jmp loop1
		
	exit:
        mov ah,4CH
        int 21H

code ENDS
    end start
