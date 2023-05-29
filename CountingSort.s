		AREA ORNEK,CODE,READONLY
		ENTRY
		EXPORT main
			
main	PROC

		LDR R6,=Adizi
		LDR R2, =2 ; which procedure
		CMP R2, #1
		BEQ find
		CMP R2, #2
		BEQ sort
		B finish

sort 	LDR R7,[R6] ; length of array
		MOV R3,#4 ; for index
		LDR R4,[R6,R3] ;  Adizi[1] to r4

max_loop	ADD R3,R3,#4
			LDR R5,[R6,R3]
			CMP R4,R5 ; compare to elements
			BGT next_element ; if bigger first one bigger go to start of max_loop
			MOV R4,R5 ; if r5 is bigger
			
next_element	SUBS R7,R7,#1
				CMP R7,#2 ; until r7 is #2 because we start from second element
				BNE max_loop ; if we are not finished yet 
				
countArray	ADD R4, R4, #1 ; add 1 to r4
			MOV R2, R4 ; copy r4 to r2
			SUB SP, SP, R4, LSL #2 ; create space in stack for array with r4 length
			MOV R5, SP   ; arrays adress to r5
			MOV R3,#0 ; for index
			MOV R9, #0 ; for assign 0 to all elements

zeroToArray	STR R9, [R5, R3] ; assign 0
			ADD R3, #4 ; to next element
			SUBS R2, R2, #1 ; loop end control
			CMP R2, #0 ; compare if it is zero
			BNE zeroToArray
			MOV R3,#4 ; for index
			LDR R7,[R6] ; length of array

countArrayCont	LDR R1,[R6, R3] ;  Adizi[1] R4
				MOV R0, #4
				MUL R1, R1, R0 ; for address multiply with 4
				LDR R2, [R5, R1] ; R2 = R5[R1]
				ADD R2, R2, #1 ; increase 1
				STR R2, [R5, R1] ; after increase assign r2 to R5[R1]
				ADD R3, R3, #4 ; to next element
				SUBS R7,R7,#1
				CMP R7,#1 ; loop end control
				BNE countArrayCont
				MOV R3,#0 ; for index
				MOV R7,#4 ; for index
				MOV R0, R4 ; size of counted new array

add_loop	LDR R2, [R5, R3] ; R2 = R5[R3]
			LDR R1, [R5, R7] ; R1 = R5[R3+1]
			ADD R2, R2,R1 ; add r2+r1
			STR R2, [R5, R7] ; R5[R7] = R2 new element
			ADD R3, #4 ; to next element
			ADD R7, #4 ; to next element
			SUBS R0, R0, #1
			CMP R0, #1	; loop end control
			BNE add_loop
			LDR R7,[R6] ; size of first array
			SUBS R7,R7,#1 ; size - 1
			SUB SP, SP, R7, LSL #2 ; for result array, create space from stack
			MOV R0, SP   ; arrays address
			MOV R3,#4 ; for index
			
result_loop	MUL R8, R7, R3 ; (size-1)*4 for index
			LDR R2,[R6,R8] ; array[i]
			MUL R8,R2,R3 ; address of array[i]
			LDR R9,[R5,R8] ; count[array[i]]
			SUBS R10, R9, #1 ; count[array[i]] - 1
			MUL R8, R3, R10 ; address of count[array[i]] - 1
			STR R2,[R0,R8] ;   array[i](r2) to r0[r8]
			MUL R8, R3, R2
			STR R10,[R5,R8] ; R5[R8]--
			SUBS R7,R7,#1 ; size - 1
			CMP R7,#0
			BNE result_loop
			b finish
			
find	MOV R3,#0 ; for index
		LDR R7,[R6] ; length
		MOV R0,#4 ; value that need to be find

find_loop	ADD R3,R3,#4 ; to next element
			LDR R4,[R6,R3] ; assigning value to r4
			CMP R0,R4 ; comparing to value 
			BEQ found ; if its equal then go to found
			SUBS R7,R7,#1
			CMP R7,#1
			BNE find_loop ; if its not equal and loop is not finished
			MOV R0, #0 ; if loop finished value can't found
			B finish		
		
found	MOV R0, #1 ; if its found assign 1
		LDR R1,[R6,R3] ; save the address at R1 register
		
finish		b finish
			ENDP
			
			
Adizi	dcd	8,4,2,2,8,3,3,1

	
		AREA    MyData,DATA,READWRITE
			
        align        
			
		END