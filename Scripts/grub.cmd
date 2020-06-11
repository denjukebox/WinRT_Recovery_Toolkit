MOUNTVOL S: /S
XCOPY /S D:\GRUB\* S:\

bcdedit /set {bootmgr} path \BOOT.EFI
