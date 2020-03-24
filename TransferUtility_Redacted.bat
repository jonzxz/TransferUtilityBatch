@echo OFF
setlocaL enabledelayedexpansion
color B

CALL :START

:START
CALL :GET_IP_SEGMENT IP_SEGMENT
CALL :GET_VARIANT VARIANT
CALL :MAIN
exit /b

:MENU
ECHO.
ECHO. ======================================================================
ECHO.^| This toolkit allows you to choose a server to transfer REDACTED^|
ECHO.^|     and existing virus definition to the destination server.        ^|
ECHO.^|         The files will be in C:\REDACTED              ^|
ECHO.^|              Destination Server must be connected   	      	      ^|
ECHO.^|	REDACTED and definitions have to be in this directory    ^|
ECHO. ======================================================================
ECHO.
ECHO.Selected Server: !SERVER!
ECHO.Variant: !VARIANT!
ECHO.Selected IP: !IP_ADDRESS!
ECHO.Architecture: !SYSTEM_ARCHITECTURE!
ECHO.
ECHO.0. Enter IP Address Manually
ECHO.1. Select Server
ECHO.2. Transfer REDACTED and Virus Definition to selected server
ECHO.3. Delete REDACTED and Virus Definition from selected server
ECHO.4. Quit
ECHO.
SET /p "%~1=Please make your choice: "
EXIT /b

:MAIN
CALL :MENU SELECTION

IF !SELECTION! == 0 (
	SET /P "IP_ADDRESS=Enter IP: "
	CALL :GET_ARCHITECTURE SYSTEM_ARCHITECTURE
) ELSE IF !SELECTION! == 1 (
	CALL :SELECT_SERVER
	CALL :GET_ARCHITECTURE SYSTEM_ARCHITECTURE
) ELSE IF !SELECTION! == 2 (
	CALL :MAKE_FOLDER
	CALL :MAKE_SHARED_FOLDER
	CALL :COPY_FILES
) ELSE IF !SELECTION! == 3 (
	CALL :UNSHARE_FOLDER
	CALL :DELETE_SHARED_FOLDER
) ELSE IF !SELECTION! == 4 (
	EXIT
) ELSE (
	ECHO. Invalid choice. Please select again!
	ECHO.
	ECHO.
)
GOTO :MAIN

EXIT /B

:SELECT_SERVER
IF !VARIANT! == REDACTED (
	set /p "SERVER=Select Server IN CAPS (i.e REDACTED): "
	IF !SERVER! == REDACTED (
		set "IP_ADDRESS=!IP_SEGMENT!2"
	) ELSE IF !SERVER! == REDACTED (
		SET "IP_ADDRESS=!IP_SEGMENT!3"
	) ELSE IF !SERVER! == REDACTED (
		SET "IP_ADDRESS=!IP_SEGMENT!4"
	) ELSE IF !SERVER! == REDACTED (
		SET "IP_ADDRESS=!IP_SEGMENT!5"
	) ELSE IF !SERVER! == REDACTED (
		SET "IP_ADDRESS=!IP_SEGMENT!6"
	)
) ELSE (
	set /p "SERVER=Select Server IN CAPS (i.e REDACTED): "
	IF !SERVER! == REDACTED (
		SET "IP_ADDRESS=!IP_SEGMENT!1"
	) ELSE IF !SERVER! == REDACTED (
		SET "IP_ADDRESS=!IP_SEGMENT!2"
	) ELSE IF !SERVER! == REDACTED (
		SET "IP_ADDRESS=!IP_SEGMENT!3"
	) ELSE IF !SERVER! == REDACTED (
		SET "IP_ADDRESS=!IP_SEGMENT!4"
	) ELSE IF !SERVER! == REDACTED (
		SET "IP_ADDRESS=!IP_SEGMENT!5"
	) ELSE IF !SERVER! == REDACTED (
		SET "IP_ADDRESS=!IP_SEGMENT!6"
	) ELSE IF !SERVER! == REDACTED (
		SET "IP_ADDRESS=!IP_SEGMENT!7"
	) ELSE IF !SERVER! == REDACTED (
		SET "IP_ADDRESS=!IP_SEGMENT!8"
	) ELSE IF !SERVER! == REDACTED (
		SET "IP_ADDRESS=!IP_SEGMENT!9"
	) ELSE IF !SERVER! == REDACTED (
		SET "IP_ADDRESS=!IP_SEGMENT!10"
	) ELSE IF !SERVER! == REDACTED (
		SET "IP_ADDRESS=!IP_SEGMENT!11"
	) ELSE IF !SERVER! == REDACTED (
		SET "IP_ADDRESS=!IP_SEGMENT!12"
	) ELSE IF !SERVER! == REDACTED (
		SET "IP_ADDRESS=!IP_SEGMENT!13"
	)
)
EXIT /B


:GET_VARIANT
:: Retrieves computer name
FOR /F %%A IN ('HOSTNAME') DO (
	IF NOT DEFINED COMPUTER_NAME SET COMPUTER_NAME=%%A
)

:: Sets last character of computer name to LAST
FOR /F "TOKENS=1,2,3* DELIMS=" %%B IN ('ECHO !COMPUTER_NAME!') DO (
	SET "LAST=%%B"
	SET "LAST=!LAST:~-1!"
)

::Checks if last character of computer name is alphabetical or numerical
SET /A PARAM=!LAST! + 1
:: If it is numerical and IS NOT 0 -- if it is 0 the program will fail, but our computer names are all REDACTED
IF NOT !PARAM!==1 (
	SET "%~1=REDACTED"
) ELSE (
	SET "%~1=REDACTED"
)

exit /b


:GET_IP_SEGMENT
FOR /F "TOKENS=2 DELIMS=:" %%A IN ('IPCONFIG ^| FINDSTR /C:"REDACTED"') do (
	if not defined CURRENT_IP set "CURRENT_IP=%%A"
)

:: Retrieves REDACTED.X.X.X
FOR /f "tokens=1,2,3* delims=." %%B IN ('echo !CURRENT_IP!') do (
	SET "SEGMENT=%%B.%%C.%%D."
)

:: Remove white spaces
FOR /F "tokens=* delims= " %%E in ('echo !SEGMENT!') do (
	SET "SEGMENT=%%E"
)

SET "%~1=!SEGMENT!"
EXIT /b


:GET_ARCHITECTURE
for /f "TOKENS=1,2" %%A in ('wmic /node:!IP_ADDRESS! environment get Name^, VariableValue') do (
	IF %%A==PROCESSOR_ARCHITECTURE (
		set "%~1=%%B"
	)
)
EXIT /b

:MAKE_FOLDER
:: Create folder in remote server
wmic /node:!IP_ADDRESS! /user:REDACTED /password:REDACTED process call create CommandLine="cmd /c mkdir C:\REDACTED"
echo  	REDACTED folder created in desination server..

EXIT /b

:MAKE_SHARED_FOLDER
:: Make destination folder a shared folder
wmic /node:!IP_ADDRESS! /user:REDACTED /password:REDACTED share call create "","TemporarySharedFolder","10","REDACTED","","C:\REDACTED",0
ECHO  	Share enabled on REDACTED folder in destination server..

EXIT /B

:COPY_FILES
:: Copy file/directory to remote server \\REDACTED.x.x.x\REDACTED
if !SYSTEM_ARCHITECTURE! == x86 (
	set "sep=v5i32"
) else (
	set "sep=v5i64"
)
xcopy *!sep!*  \\!IP_ADDRESS!\REDACTED
xcopy REDACTED /s \\!IP_ADDRESS!\REDACTED
ECHO 	REDACTED ^& Virus Definition copied to REDACTED

exit /b

:UNSHARE_FOLDER
::Unshare over network
wmic /node:!IP_ADDRESS! /user:REDACTED /password:REDACTED process call create CommandLine='cmd.exe /c net share "C:\REDACTED" /DELETE'
ECHO 		REDACTED unshared
exit /b

:DELETE_SHARED_FOLDER
::Delete shared folder
wmic /node:!IP_ADDRESS! /user:REDACTED /password:REDACTED process call create CommandLine='cmd /c rmdir /s /q "C:\REDACTED"'
ECHO 		REDACTED deleted
exit /b
