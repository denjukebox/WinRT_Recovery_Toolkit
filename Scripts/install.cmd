@ECHO OFF
:START
ECHO BEFORE CONTINUING, VERIFY THAT ALL BITLOCKERS ARE TURNED OFF AND USB DRIVE LETTER IS D
set /p CONFIRM_CONTINUE=CONFIRM READY FOR INSTALL [y/n]?:

IF /I "%CONFIRM_CONTINUE%"=="n" GOTO EOF
IF /I "%CONFIRM_CONTINUE%"=="N" GOTO EOF
IF /I "%CONFIRM_CONTINUE%"=="Y" GOTO MENU
IF /I "%CONFIRM_CONTINUE%"=="y" GOTO MENU
IF %CONFIRM_CONTINUE% GOTO START

ECHO GOOD, LETS BEGIN

:MENU
ECHO [MAIN MENU]
ECHO 0 ^| EXIT
ECHO 1 ^| PARTIONING
ECHO 2 ^| INSTALL
ECHO 3 ^| BOOT
ECHO 4 ^| UNLOCK

set /p ID=ENTER ACTION:
ECHO ID
IF "%ID%"=="0" EXIT 0
IF "%ID%"=="1" GOTO PARTITIONING
IF "%ID%"=="2" GOTO INSTALL
IF "%ID%"=="3" GOTO BOOT
IF "%ID%"=="4" GOTO UNLOCK
IF %ID% GOTO MENU

:PARTITIONING
ECHO PARTITIONING DISK, THIS MIGHT TAKE A WHILE...
DISKPART /S INSTALLRT.TXT
ECHO PARTITIONING DISK COMPLETE
GOTO MENU

:INSTALL
ECHO [INSTALL]
ECHO 0 ^| UP
ECHO 1 ^| INSTALL WINDOWS RT 8.0
ECHO 2 ^| INSTALL WINDOWS RT 10

set /p ID=ENTER ACTION:
ECHO ID
IF "%ID%"=="0" GOTO MENU
IF "%ID%"=="1" GOTO INSTALL_WN_RT_8
IF "%ID%"=="2" GOTO INSTALL_WN_RT_10
IF %ID% GOTO INSTALL

:INSTALL_WN_RT_8
ECHO INSTALLING RT
DISM /APPLY-IMAGE /IMAGEFILE:D:\SOURCES\INSTALL_8.WIM /INDEX:1 /APPLYDIR:C:\
ECHO WIN RT 8.0 INSTALL FINISHED
GOTO INSTALL

:INSTALL_WN_RT_10
ECHO INSTALLING RT
DISM /APPLY-IMAGE /IMAGEFILE:D:\SOURCES\INSTALL_10_15035.WIM /INDEX:1 /APPLYDIR:C:\
ECHO WIN RT 10 INSTALL FINISHED
CALL WIN10_REG.CMD
ECHO REGISTRY PATCHES APPLIED
GOTO INSTALL

:BOOT
ECHO [BOOT]
ECHO 0 ^| UP
ECHO 1 ^| COPY RECOVERY EFI
ECHO 2 ^| COPY ESP EFI
ECHO 3 ^| SCAN AND ADD BOOT DEVICES
ECHO 4 ^| COPY GRUB AS BOOT

set /p ID=ENTER ACTION:
ECHO ID
IF "%ID%"=="0" GOTO MENU
IF "%ID%"=="1" GOTO EFI
IF "%ID%"=="2" GOTO ESPEFI
IF "%ID%"=="3" GOTO FIXBOOT
IF "%ID%"=="4" GOTO GRUB
IF %ID% GOTO BOOT

:ESPEFI
ECHO COPYING ESPEFI
CALL ESPEFI.CMD
GOTO BOOT

:EFI
ECHO COPYING EFI
CALL EFI.CMD
GOTO BOOT

:FIXBOOT
ECHO FIXING BOOT ENTRIES
BOOTREC /FIXBOOT
BOOTREC /REBUILDBCD
GOTO BOOT

:GRUB
ECHO COPYING GRUB
CALL GRUB.CMD
GOTO BOOT

:UNLOCK
ECHO [UNLOCK]
ECHO 0 ^| UP
ECHO 1 ^| SET TESTSIGNING MODE
ECHO 2 ^| APPLY SECUREBOOT SIGNING WORKAROUND

set /p ID=ENTER ACTION:
ECHO ID
IF "%ID%"=="0" GOTO MENU
IF "%ID%"=="1" GOTO TESTSIGNING
IF "%ID%"=="2" GOTO SECUREBOOT
IF %ID% GOTO UNLOCK

:TESTSIGNING
ECHO SETTING TESTSIGNING
CALL TESTSIGNING.CMD
GOTO UNLOCK

:SECUREBOOT
ECHO EXECUTING SECUREBOOT SIGNING WORKAROUND
CALL SECUREBOOT.CMD
GOTO UNLOCK
