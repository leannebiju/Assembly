data SEGMENT
      inp1 DB 13,10, "enter first number: $"
      inp2 DB 13, 10, "enter second number: $"
      res  DB 13, 10, "result: $"
data ENDS

code SEGMENT
            ASSUME CS: code, DS: data
      start:
            MOV    AX, data
            MOV    DS, AX
      ;print input number
            MOV    AH, 09H
            LEA    DX, inp1
            INT    21H
      ;read number
            MOV    AH, 01H
            INT    21H
            SUB    AL, 30H
            MOV    BH, AL
      ;read number
            MOV    AH, 01H
            INT    21H
            SUB    AL, 30H
            MOV    BL, AL
      ;print input number
            MOV    AH, 09H
            LEA    DX, inp2
            INT    21H
      ;read number
            MOV    AH, 01H
            INT    21H
            SUB    AL, 30H
            MOV    CH, AL
      ;read number
            MOV    AH, 01H
            INT    21H
            SUB    AL, 30H
            MOV    CL, AL
      ;add
            MOV    DL, 00H
            ADD    BL, CL
            CMP    BL, 0AH
            JC     skipa
            SUB    BL, 0AH
            INC    BH
      skipa:
            ADD    BH, CH
            CMP    BH, 0AH
            JC     skipb
            SUB    BH, 0AH
            INC    DL
      skipb:
      ;print result
            MOV    AH, 30H
            ADD    BL, AH
            ADD    BH, AH
            ADD    DL, AH
            MOV    AL, DL
            MOV    AH, 09H
            LEA    DX, res
            INT    21H
            MOV    AH, 02H
            MOV    DX, 0000H
            MOV    DL, AL
            INT    21H
            MOV    DL, BH
            INT    21H
            MOV    DL, BL
            INT    21H
      ;end pgm
            MOV    AH, 4CH
            INT    21H
code ENDS
    END start
