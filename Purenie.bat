@echo off
color 02
title 푸른이
setlocal enabledelayedexpansion

:loop
	echo 1. 자동 실행 추가
	echo 2. 자동 실행 제거
	echo 3. 자동 실행 확인
	echo exit. 나가기
	set /p option=선택하십시오: 
	if "%option%"=="1" goto add
	if "%option%"=="2" goto delete
	if "%option%"=="3" call :check just & goto loop
	if "%option%"=="exit" goto end

	:add
		set /p dir=경로를 입력하십시오:
		if not "%dir:~-1%"=="\" set "dir=%dir%\"

		for %%A in ("%dir:~0,-1%") do (
			set "folderName=%%~nxA"
			set "ext=%%~xA"
		)
		if "!folderName!"=="" set "folderName=Shortcut"

		echo DEBUG folderName = [%folderName%]

		if "!ext!"=="" (
			set "folderPath=%dir%"
			set "lnkPath=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\!folderName!.lnk"
			echo [%lnkPath%]

			powershell -NoProfile -Command ^
			"$s=(New-Object -ComObject WScript.Shell).CreateShortcut('!lnkPath!');" ^
			"$s.TargetPath='explorer.exe';" ^
			"$s.Arguments='\"!folderPath!\"';" ^
			"$s.Save()"

		) else (
			set "command=%dir%"
			reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v MyApp /t REG_SZ /d "%command%"
		)
		echo 추가 완료
		goto loop

	:delete
		call :check no
		set /p select=몇 번째를 지우시겠습니까?
		set "valname=!item%select%!"
		if "!valname!"=="" (
			echo 잘못된 번호입니다.
		) else (
			reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "!valname!" /f
			echo !valname! 항목이 삭제되었습니다.
		)
		goto loop

	:check
		set "mode=%1"
		set /a i=1
		for /f "delims=" %%a in ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" ^| findstr /v "HKEY_"') do (
			for /f "tokens=1" %%b in ("%%a") do (
				if /i not "%mode%"=="just" set "item!i!=%%b"
					echo !i!. %%b
					set /a i+=1
				)
			)
		set /a itemCount=i-1
		exit /b

	:end
		exit