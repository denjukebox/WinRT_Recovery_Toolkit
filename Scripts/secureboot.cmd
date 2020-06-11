COPY /Y D:\SecureBoot\SecureBootDebug.efi S:\EFI\Microsoft\Boot\SecurebootDebug.efi

COPY /Y D:\SecureBoot\SecureBootDebugPolicy.p7b S:\SecureBootDebugPolicy.p7b

SET VAR={9809d174-88ef-11e1-8346-00155de8c610}

BCDEDIT /CREATE "%VAR%" /d "KitsPolicyTool" /application osloader

BCDEDIT /SET "%VAR%" path "\EFI\Microsoft\Boot\SecureBootDebug.efi"

BCDEDIT /SET {bootmgr} bootsequence "%VAR%"

BCDEDIT /SET "%VAR%" loadoptions Install

MOUNTVOL S: /S

BCDEDIT /SET "%VAR%" DEVICE PARTITION=S:
