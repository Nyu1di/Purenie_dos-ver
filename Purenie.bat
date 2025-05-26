@echo off
echo 안녕하세요!! & echo.

:loop
	@echo off
	color 71
	title 푸른이
	setlocal enabledelayedexpansion

	echo (무엇을 하시겠습니까?)
	echo 1. 침입자 탐지 - 제거
	echo 2. 자동 실행 프로세스 관리
	echo 3. 간식 주기
	echo bye. 안녕!

	call :selectionIs
	goto loop

:detect
	cd C:\Users\USER\OneDrive\바탕 화면\Command-Center\Personal-Office\P-data\MalwareZero\malzero & start.bat

:auto-mng
	cd C:\Users\USER\OneDrive\바탕 화면\Command-Center\Personal-Office\P-data & cls & auto_manager.bat
	goto loop

:feed

:bye
	echo 또 불러죠!
	pause
	exit

:selectionIs
	set /p select=:

	if "%select%"=="1" goto detect
	if "%select%"=="2" goto auto-mng
	if "%select%"=="3" goto feed
	if "%select%"=="bye" goto bye
	if "%select%" neq "1" if "%select%" neq "2" if "%select%" neq "3" if "%select%" neq "bye" (
	
	echo ( 명령을 알아듣지 못한 모양이다. )
	goto loop

	exit /b