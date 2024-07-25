#$language = "VBScript"
#$interface = "1.0"

crt.Screen.Synchronous = True
'Deletes vlan.dat file and startup-config
'Reloads and does not save the running-config


'Does not work if inside config mode in any device.
'Feature, so as to not reload if you accidentally click on the button for the script on the screen

Sub Main
	crt.Screen.Send "delete flash:vlan.dat" & chr(13)
	crt.Screen.WaitForString "Delete filename [vlan.dat]? "
	crt.Screen.Send chr(13)
	crt.Screen.WaitForString "flash:/vlan.dat? [confirm]"
	crt.Screen.Send chr(13) & chr(13) & chr(13)
	crt.Screen.WaitForString "#"
	crt.Screen.Send "erase startup-config" & chr(13)
	crt.Screen.WaitForString "Erasing the nvram filesystem will remove all configuration files! Continue? [confirm]"
	crt.Screen.Send chr(13) & chr(13) & chr(13) & chr(13) & chr(13)
	crt.Screen.WaitForString "#"
	crt.Screen.Send chr(13) & "reload" & chr(13)
	crt.Screen.WaitForString "System configuration has been modified. Save? [yes/no]: "
	crt.Screen.Send "no" & chr(13)
	crt.Screen.WaitForString "Proceed with reload? [confirm]"
	crt.Screen.Send chr(13) & chr(13)
End Sub
