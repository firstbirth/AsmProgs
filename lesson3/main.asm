.686
.model flat,stdcall
option casemap:none

comment*===================================
		Console Color Template
===========================================*

include \masm32\include\kernel32.inc
include \masm32\include\masm32.inc
include \masm32\include\msvcrt.inc

include \masm32\macros\macros.asm

includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\masm32.lib
includelib \masm32\lib\msvcrt.lib
;-------------------------------------------

Quit 		proto 
SetColor 	proto :DWORD, :DWORD
.const
	Black 	= 0
	Blue 	= 1
	Green	= 2
	Cyan	= 3
	Red		= 4
	Magenta	= 5
	Brown	= 6
	LightGray	= 7
	DarkGray	= 8
	LightBlue	= 9
	LightGreen	= 10
	LightCyan	= 11
	LightRed	= 12
	LightMagenta	= 13
	Yellow	= 14
	White	= 15

.data?


.data


.code
start:
	fn SetConsoleTitle, "Test macroses"
	;-----------------------------------
	invoke SetColor,0ah,Black
	;-----------------------------------
	call main
	;-----------------------------------
	invoke Quit
	;-----------------------------------
	invoke ExitProcess,0


;---------------------------------------
main proc
	invoke crt_puts, chr$("Hello wrld!")

	ret
main endp

;---------------------------------------


Quit proc

	szText szExit,"Press any key..."
	;-------------------------------
	ccout(offset szExit)
	;-------------------------------
	_while:
		test FUNC(crt__kbhit),eax
		;------------------------
		je _while
		;---------------
		invoke crt__getch

	ret
Quit endp
;---------------------------------------
SetColor proc uses ebx esi edi color:DWORD,cBk:DWORD 
	xor ebx,ebx
	mov bl,byte ptr[cBk]
	;-------------------
	shl bl,4
	;-------------------
	or bl,byte ptr[color]
	;--------------------
	invoke SetConsoleTextAttribute, rv(GetStdHandle,-11),ebx
	;---------------------------------------------------
	
	
	ret
SetColor endp
;---------------------------------------
end start