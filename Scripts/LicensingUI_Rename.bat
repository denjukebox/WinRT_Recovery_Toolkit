@echo off

set filename="%SystemRoot%\System32\LicensingUI.exe"

if exist %filename% (
  takeown /f %filename%
  icacls %filename% /grant *S-1-3-4:F /t /c /l
  rename %filename% "LicensingUI_1.exe"
  echo Done.
) else (
  echo LicensingUI has already been renamed.
)

pause