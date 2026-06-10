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

:: Step 1: Listing Saved Wi-Fi Profiles
echo [ Available Saved Wi-Fi Profiles ]
echo -------------------------------------------------------------------------------
:: Execute netsh and filter the output to show a clean list of SSIDs
netsh wlan show profiles | findstr /C:"All User Profile"
echo -------------------------------------------------------------------------------
echo.

:: Step 2: Prompting user dynamically for the target network
set /p "target_ssid=Enter the Wi-Fi Profile Name: "

:: Handle blank inputs gracefully
if "%target_ssid%"=="" (
    goto MainMenu
)

echo.
echo Retrieving security settings...
echo -------------------------------------------------------------------------------

:: Step 5: Error Handling - Verify if the inputted profile actually exists
netsh wlan show profile name="%target_ssid%" >nul 2>&1
if %errorlevel% neq 0 (
    echo Error: The specified Wi-Fi profile was not found. Please check the spelling and try again.
    echo -------------------------------------------------------------------------------
    goto EndMenu
)

:: Step 3 & 4: Extract and display ONLY the critical information
echo Profile Name           : %target_ssid%
:: Execute the clear key command and filter purely for the "Key Content" line
netsh wlan show profile name="%target_ssid%" key=clear | findstr /C:"Key Content"

:: Check if findstr failed (meaning the network is open and has no password)
if %errorlevel% neq 0 (
    echo Key Content            : [None / Open Network]
)
echo -------------------------------------------------------------------------------

:EndMenu
echo.
:: Pause the script so the user can comfortably read the password details
pause

:: Looping Interactive Menu
echo.
echo [1] Check Another Wi-Fi
echo [2] Exit
echo.
set /p "user_choice=Select an option: "

if "%user_choice%"=="1" goto MainMenu
if "%user_choice%"=="2" exit

:: Catch-all for invalid keystrokes to prevent crashing
goto EndMenu