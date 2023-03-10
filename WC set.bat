@echo off 
rem mode con cols=80 lines=20 
color 0a

>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
    echo Run as Administrator...
    goto UACPrompt
) else ( goto gotAdmin )
:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"=""
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    rem del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
title 위더스컴퓨터 마스터

:main
cls
echo.
echo.
echo		[44;37m[위더스컴퓨터 마스터 세팅][0m
echo.
echo		1. 위더스컴퓨터 세팅 한번에 적용하기 (2~4번 내용)
echo.
echo		2. 위더스컴퓨터 배경화면만 적용하기
echo.
echo		3. 위더스컴퓨터 OEM 로고 추가하기
echo.
echo		4. 위더스컴퓨터 링크/북마크 추가하기
echo.
echo		5. 윈도우 디펜더 끄기 / 켜기
echo.
echo		6. 원드라이브(OneDrive) 제거
echo.
echo		7. 윈도우 자동 업데이트 차단 / 활성화
echo.
echo		8. Administrator 최고 관리자 계정 활성화 / 비활성화
echo.
echo		9. 종료하기
echo.

echo.
set menu=
set /p menu=원하시는 작업 번호를 입력 후 엔터(Enter)를 눌러주세요 : 
if "%menu%" == "1" goto all
if "%menu%" == "2" goto background
if "%menu%" == "3" goto oem
if "%menu%" == "4" goto links
if "%menu%" == "5" goto def
if "%menu%" == "6" goto one_del
if "%menu%" == "7" goto no_update
if "%menu%" == "8" goto admin_enable
if "%menu%" == "9" goto EXIT
goto main


:all
regedit.exe /s "%~dp0\set\oem Withus.reg" /f

copy "%~dp0\set\OEMLOGO.bmp" "c:\windows\system32\oobe" /y
copy "%~dp0\set\withusbackground.jpg" "C:\Windows\System32" /y

reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d  wallpaper_path /f 
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d C:\Windows\System32\withusbackground.jpg /f
RUNDLL32.EXE user32.dll, UpdatePerUserSystemParameters ,1 ,True

copy "%~dp0\set\Google.url" "C:\Users\%USERNAME%\Favorites\Links"
copy "%~dp0\set\NAVER.url" "C:\Users\%USERNAME%\Favorites\Links"
copy "%~dp0\set\YouTube.url" "C:\Users\%USERNAME%\Favorites\Links"
copy "%~dp0\set\간편한 원격지원 - 헬프유.url" "C:\Users\%USERNAME%\Favorites\Links"
copy "%~dp0\set\위더스컴퓨터.url" "C:\Users\%USERNAME%\Favorites\Links"
reg add "HKCU\Software\Microsoft\Internet Explorer\MINIE" /v AlwaysShowMenus /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Internet Explorer\MINIE" /v LinksBandEnabled /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Internet Explorer\MINIE" /v CommandBarEnabled /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Internet Explorer\MINIE" /v ShowStatusBar /t REG_DWORD /d 1 /f
copy "%~dp0\set\Bookmarks" "C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\User Data\Default"


echo.
pause
goto main

:oem
rem oem 레지스토리 추가 ::::
regedit.exe /s "%~dp0\set\oem Withus.reg" /f

rem oem 로고 추가 ::::
copy "%~dp0\set\OEMLOGO.bmp" "c:\windows\system32\oobe" /y

echo.
pause
goto main

:background
rem 위더스 배경화면 등록 ::::
copy "%~dp0\set\withusbackground.jpg" "C:\Windows\System32" /y
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d  wallpaper_path /f 
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d C:\Windows\System32\withusbackground.jpg /f  
RUNDLL32.EXE user32.dll, UpdatePerUserSystemParameters ,1 ,True


echo.
pause
goto main


:links
rem 위더스 링크/북마크 추가 ::::
copy "%~dp0\set\Google.url" "C:\Users\%USERNAME%\Favorites\Links"
copy "%~dp0\set\NAVER.url" "C:\Users\%USERNAME%\Favorites\Links"
copy "%~dp0\set\YouTube.url" "C:\Users\%USERNAME%\Favorites\Links"
copy "%~dp0\set\간편한 원격지원 - 헬프유.url" "C:\Users\%USERNAME%\Favorites\Links"
copy "%~dp0\set\위더스컴퓨터.url" "C:\Users\%USERNAME%\Favorites\Links"
reg add "HKCU\Software\Microsoft\Internet Explorer\MINIE" /v AlwaysShowMenus /t REG_DWORD /d 1 /f   
reg add "HKCU\Software\Microsoft\Internet Explorer\MINIE" /v LinksBandEnabled /t REG_DWORD /d 1 /f   
reg add "HKCU\Software\Microsoft\Internet Explorer\MINIE" /v CommandBarEnabled /t REG_DWORD /d 1 /f   
reg add "HKCU\Software\Microsoft\Internet Explorer\MINIE" /v ShowStatusBar /t REG_DWORD /d 1 /f
copy "%~dp0\set\Bookmarks" "C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\User Data\Default"

echo.
pause
goto main


:def
start %~dp0\set\def\"DefenderControl.exe"
echo.
pause
goto main


:one_del
cls
echo.
echo.
echo		[44;37m[ 원드라이브(OneDrive) 제거하기 ][0m
echo.
set x86="%SYSTEMROOT%\System32\OneDriveSetup.exe"
set x64="%SYSTEMROOT%\SysWOW64\OneDriveSetup.exe"
echo.
echo OneDrive 제거 준비중...
echo.
taskkill /f /im OneDrive.exe > NUL 2>&1
ping 127.0.0.1 -n 5 > NUL 2>&1
echo OneDrive 관련 프로세스를 닫는중...
echo.
if exist %x64% (
%x64% /uninstall
) else (
%x86% /uninstall
)
ping 127.0.0.1 -n 5 > NUL 2>&1
echo OneDrive 관련 파일 제거중...
echo.
rd "%USERPROFILE%\OneDrive" /Q /S > NUL 2>&1
rd "C:\OneDriveTemp" /Q /S > NUL 2>&1
rd "%LOCALAPPDATA%\Microsoft\OneDrive" /Q /S > NUL 2>&1
rd "%PROGRAMDATA%\Microsoft OneDrive" /Q /S > NUL 2>&1 
echo OneDrive 관련 레지스트리 정보 제거중...
echo.
REG DELETE "HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f > NUL 2>&1
REG DELETE "HKEY_CLASSES_ROOT\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f > NUL 2>&1
echo.
echo OneDrive를 정상적으로 제거하였습니다!
echo.
echo.
echo.
pause
goto main

:no_update
start %~dp0\set\no_update\"Wub.exe"
echo.
pause
goto main


:admin_enable
cls
echo.
echo.
echo		[44;37m[ 최고 관리자 administrator 계정 관리  ][0m
echo.
echo.
echo		1. Administrator 최고 관리자 계정 활성화 하기
echo.
echo		2. 활성화된 Administrator 최고 관리자 계정 비활성화 하기
echo.
echo		3. 매인 메뉴로 가기
echo.
echo.
set menu=
set /p menu=원하시는 작업 번호를 입력 후 엔터(Enter)키를 눌러주세요 : 
if "%menu%" == "1" goto a
if "%menu%" == "2" goto b
if "%menu%" == "3" goto main
goto admin

:a
net user administrator /active:yes
echo.
pause
goto main

:b
net user Administrator /active:no
echo.
pause
goto main


rem goto SUCCESS

rem :SUCCESS
rem rem echo 설정 변경 및 정리가 완료되었습니다.

:EXIT 
exit

rem 크롬 북마크 추가 경로
rem %UserProfile%\AppData\Local\Microsoft\Edge\User Data\Default