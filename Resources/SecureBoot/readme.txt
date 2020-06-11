Extract this zip.
Run InstallPolicy.cmd as admin.
After you get back in windows, open admin cmd and run this:

bcdedit /set {default} testsigning on && bcdedit /set {bootmgr} testsigning on

Then reboot.