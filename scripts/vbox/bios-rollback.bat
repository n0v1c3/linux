:: ====================================================================================================
:: Title: Factory Talk Activation Crack
:: Author: Travis Gall
:: Date Modified: 07-Apr-13
:: Description: This will roll back the BIOS system time on a VirtualBox Virtual Machine to the month
::			    that Factory Talk was first activated
:: ====================================================================================================

::Turn off command repeat
@Echo off

::Title
Echo =====================================
Echo Travis' Factory Talk Activation Crack
Echo =====================================

::Constants
Set ActivationMonth= 4
Set ActivationYear= 2013
Set MonthsInYear= 12
Set DaysInMonth= 31
Set MillisecondsInDay= 86400000

::Get current system date
For /F "tokens=1-3 delims=/ " %%A in ('Date /t') do @(
		Set Day= %%A
		Set Month= %%B
		Set Year= %%C
		)

::Calculate the number of years and months that have passed since the license has been activated
Set /A Year -= ActivationYear
If Month lss ActivationMonth (
		Set /A Year -= 1
		Set /A Month += MonthsInYear - ActivationMonth
		)
Set /A Month -= ActivationMonth

::Number of months that has passed since license has been activated
Set /A NumMonths= (Year * MonthsInYear) + Month

::Aproximate number of milliseconds that has passed since license has been activated
Set /A NumMilliseconds= NumMonths * DaysInMonth * MillisecondsInDay

::Blank line
Echo.

::Get all Virtual Machines in VirtualBox's default dir
setlocal enabledelayedexpansion
set Index=1
for /d %%D in ("%dir%%HOMEDRIVE%%HOMEPATH%\VirtualBox VMs\*") do (
		set "VBoxs[!Index!]=%%D"
		set /a Index+=1
		)
set /a UBound=Index-1

::Calculate the length of the path upto the Virtual Machine folder
cd "C:\Users\Travis\VirtualBox VMs"
for /L %%n in (1 1 500) do if "!__cd__:~%%n,1!" neq "" set /a "len=%%n+1"

::Remove folder path and display Virtul Machine name
for /l %%i in (1,1,%UBound%) do (
		set "VBoxs[%%i]=!VBoxs[%%i]:~%len%!"
		echo %%i. !VBoxs[%%i]!
		)

::Ensure that Choice is within allowed parameters
:choiceloop
set /p Choice=Select Virtual Machine:
if "%Choice%"=="" goto chioceloop
if %Choice% LSS 1 goto choiceloop
if %Choice% GTR %UBound% goto choiceloop

::Set VBox to selected Virtual Machine
set VBox=!VBoxs[%Choice%]!

::Display selected Virtual Machine and pause for a cancel
Echo.
Echo Virtual Box Selected: %VBox%
Echo Exit Now to Cancel
pause

::Change directory to have access to the VirtualBox commands
cd "C:\Program Files\Oracle\VirtualBox"

::Set BIOS system time back to when license was first activated
@Echo on
VBoxManage modifyvm "%VBox%" --biossystemtimeoffset -%NumMilliseconds%

::Clean-Up and pause
@Echo off
pause
