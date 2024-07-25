# $language = "VBScript"
# $interface = "1.0"

' Title: ExportConfigs
' Author: Josh Lowe (josh.lowe@ontariotechu.ca)
' Last Updated: Sept 26, 2023
'
' Description: This script will quickly capture
'              the output of 'show run brief' and save
'              the results in a text file
'
' Inputs: None
' Outputs: <tab_name>.txt
' Instructions: Run this script from within
'               SecureCRT (Script>Run) or assign it to
'               a button on the button bar
'
' Note: the file is named using the name of the
'       active tab, so name your tab accordingly

Sub Main

    crt.Screen.Synchronous = True

    ' Prompt for the folder where the log file should be created
    Set objShell  = CreateObject( "Shell.Application" )
    Set objFolder = objShell.BrowseForFolder( 0, "Select Folder", 0)

    ' Set the filename to be the path chosen earlier plus the name of the tab
    Set thisTab = crt.GetScriptTab()
    crt.Session.LogFileName = objFolder.Self.Path & "\" & thisTab.Caption & ".txt"

	' Send Ctrl-C to ensure not in config mode
	crt.Screen.Send chr(3)
    crt.Screen.WaitForString "#"

    ' Set terminal length to 0 so that the config appears as a single page
    crt.Screen.Send "terminal length 0" & vbCr
    crt.Screen.WaitForString "#"

	' Show the config (brief = no PKI keys) and wait for the first ! before capturing
    crt.Screen.Send "show run brief" & vbCr
    crt.Screen.WaitForString "!"

    ' Start logging the output
    crt.Session.Log True

    ' The word "end" appears at the end of every show run output
    crt.Screen.WaitForString "end" & vbCr, 20
    crt.Screen.Send vbCr
    crt.Screen.WaitForString "#"

    ' Stop logging the output
    crt.Session.Log False

    ' Set the terminal length back to the default value
    crt.Screen.Send "terminal length 24" & vbCr

End Sub
