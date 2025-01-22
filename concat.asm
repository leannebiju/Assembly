DATA SEGMENT
      STR1 DB 30 DUP(" $")
      STR2 DB 30 DUP("$")
      MSG1 DB 13,10,"STR 1: $"
      MSG2 DB 13,10,"STR 2: $"
      RES  DB 13,10,"CONCATENATED STRING: $"
DATA ENDS

CODE SEGMENT
      ASSUME CS:CODE, DS:DATA
START:
      MOV AX, DATA
      MOV DS, AX

      ; Display message to enter STR1
      LEA DX, MSG1
      MOV AH, 09H
      INT 21H

      ; Read characters for STR1
      LEA SI, STR1

INPUT_STR1:
      MOV AH, 01H
      INT 21H
      CMP AL, 13        ; Check for Enter key 
      JE END_STR1
      MOV [SI], AL      ; Store character in STR1
      INC SI
      JMP INPUT_STR1


END_STR1:
      MOV BYTE PTR [SI], '$' ; End STR1 with '$'

      ; Display message to enter STR2
      LEA DX, MSG2
      MOV AH, 09H
      INT 21H

      ; Read characters for STR2
      LEA SI, STR2


INPUT_STR2:
      MOV AH, 01H
      INT 21H
      CMP AL, 13        ; Check for Enter key)
      JE END_STR2
      MOV [SI], AL      ; Store character in STR2
      INC SI
      JMP INPUT_STR2


END_STR2:
      MOV BYTE PTR [SI], '$' ; End STR2 with '$'

      ; Concatenate STR2 onto STR1
      CALL CONCAT

      ; End the program
      MOV AH, 4CH
      INT 21H

; Concatenation Procedure: Append STR2 to the end of STR1
CONCAT PROC
      LEA SI, STR1
      LEA DI, STR2
      MOV AL, "$"


; Find the end of STR1
FIND_END_STR1:
      CMP BYTE PTR [SI], AL  ; Look for '$' in STR1
  	  JZ BEGIN_CONCAT        ; Jump to concatenation when end is found
      INC SI
      JMP FIND_END_STR1

BEGIN_CONCAT:
	  MOV BYTE PTR[SI], ' ' ; adding space
	  INC SI
	  HERE:
      ; Append each character of STR2 to STR1 until '$' is found
      CMP BYTE PTR [DI], AL  ; Check if end of STR2
      JZ DISPLAY_RESULT
      MOV BL, [DI]           ; Copy character from STR2 to STR1
      MOV [SI], BL
      INC SI
      INC DI
      JMP HERE

DISPLAY_RESULT:
      MOV BYTE PTR [SI], AL  ; End concatenated string with '$'
      LEA DX, RES
      MOV AH, 09H
      INT 21H
      LEA DX, STR1
      MOV AH, 09H
      INT 21H
      RET
CONCAT ENDP

CODE ENDS
END START
