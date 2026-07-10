@echo off
setlocal EnableDelayedExpansion

:: ==============================================================================
:: Tool Name: Wi-Fi Password Retriever
:: Developer: Ben Timothy
:: GitHub: https://github.com/BenTimothyM
:: Description: Native batch script to view and retrieve saved Wi-Fi passwords 
::              using Netsh.
:: ==============================================================================

:: Requesting Administrative Privileges
:: The script checks if it is running as Admin. If not, it prompts UAC to elevate itself.
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Requesting Administrative Privileges...
    powershell -Command "Start-Process cmd -ArgumentList '/c \"\"%~dpnx0\"\"' -Verb RunAs"
    exit /b
)

:: Setting Professional Color Scheme (Light Aqua text on Black background)
color 0B

:MainMenu
cls
:: Drawing the Structured Character Border Header
echo ===============================================================================
echo +                                                                             +
echo +                     WI-FI PASSWORD RETRIEVER UTILITY                        +
echo +                                                                             +
echo ===============================================================================
echo   Created by: Ben Timothy ^| GitHub: https://github.com/BenTimothyM
echo ===============================================================================
echo.
echo   [1] Export all saved Wi-Fi profiles and passwords to a text file
echo   [2] View a specific Wi-Fi profile password
echo   [3] Exit
echo.
echo ===============================================================================
echo.

set /p "menu_choice=Please select an option (1-3): "

if "%menu_choice%"=="1" goto ExportAll
if "%menu_choice%"=="2" goto ViewSpecific
if "%menu_choice%"=="3" exit

:: Catch-all for invalid keystrokes to prevent crashing
goto MainMenu


:ExportAll
cls
echo ===============================================================================
echo               EXPORTING ALL SAVED WI-FI PROFILES ^& PASSWORDS
echo ===============================================================================
echo.
echo Scanning system and extracting credentials. Please wait...
echo.

set "output_file=%~dp0all_wifi_passwords.txt"

:: Create or overwrite the output file with a header
echo =============================================================================== > "%output_file%"
echo  EXPORTED WI-FI PROFILES ^& PASSWORDS                                          >> "%output_file%"
echo  Generated on: %date% %time%                                                   >> "%output_file%"
echo =============================================================================== >> "%output_file%"
echo. >> "%output_file%"

set "count=0"

:: Loop through each profile name found in netsh
for /f "tokens=1* delims=:" %%A in ('netsh wlan show profiles ^| findstr /C:"All User Profile"') do (
    set "ssid=%%B"
    :: Strip leading space from SSID
    set "ssid=!ssid:~1!"
    
    :: Remove trailing carriage return characters if present
    for /f "tokens=*" %%I in ("!ssid!") do set "ssid=%%I"
    
    set "password="
    :: Retrieve password for the current SSID
    for /f "tokens=1* delims=:" %%C in ('netsh wlan show profile name^="!ssid!" key^=clear ^| findstr /C:"Key Content"') do (
        set "password=%%D"
    )
    
    :: If password variable is set, strip leading space; otherwise mark as Open/No password
    if defined password (
        set "password=!password:~1!"
    ) else (
        set "password=[No Password / Open Network]"
    )
    
    :: Write formatted output to the file and display to screen
    echo SSID: !ssid! ^| Password: !password! >> "%output_file%"
    echo SSID: !ssid! ^| Password: !password!
    set /a count+=1
)

echo. >> "%output_file%"
echo Total exported profiles: !count! >> "%output_file%"

echo.
echo -------------------------------------------------------------------------------
echo Export completed successfully.
echo Saved !count! profile(s) to "%output_file%" in the script directory.
echo -------------------------------------------------------------------------------
goto EndMenu


:ViewSpecific
cls
echo ===============================================================================
echo                     VIEW SPECIFIC WI-FI PASSWORD
echo ===============================================================================
echo.

:: Listing Saved Wi-Fi Profiles
echo [ Available Saved Wi-Fi Profiles ]
echo -------------------------------------------------------------------------------
netsh wlan show profiles | findstr /C:"All User Profile"
echo -------------------------------------------------------------------------------
echo.

:: Prompting user dynamically for the target network
set /p "target_ssid=Enter the Wi-Fi Profile Name: "

:: Handle blank inputs gracefully
if "%target_ssid%"=="" (
    goto MainMenu
)

echo.
echo Retrieving security settings...
echo -------------------------------------------------------------------------------

:: Verify if the inputted profile actually exists
netsh wlan show profile name="%target_ssid%" >nul 2>&1
if %errorlevel% neq 0 (
    echo Error: The specified Wi-Fi profile was not found. Please check the spelling and try again.
    echo -------------------------------------------------------------------------------
    goto EndMenu
)

:: Extract and display the critical information
echo Profile Name           : %target_ssid%
netsh wlan show profile name="%target_ssid%" key=clear | findstr /C:"Key Content"

:: Check if findstr failed (meaning the network is open and has no password)
if %errorlevel% neq 0 (
    echo Key Content            : [None / Open Network]
)
echo -------------------------------------------------------------------------------

:EndMenu
echo.
pause

:: Looping Interactive Menu
echo.
echo [1] Return to Main Menu
echo [2] Exit
echo.
set /p "user_choice=Select an option: "

if "%user_choice%"=="1" goto MainMenu
if "%user_choice%"=="2" exit

:: Catch-all for invalid choices
goto EndMenu
