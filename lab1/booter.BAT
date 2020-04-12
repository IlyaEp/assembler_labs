; goto cmpl1
.model tiny
.386
.code
org 100h
start:
	jmp start
	db (510-($-start)) dup(0)
	db 55h,0AAh

end start
;:cmpl1
;tasm /m5 booter1.bat
;tlink /x/t booter1