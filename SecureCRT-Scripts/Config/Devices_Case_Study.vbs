#$language = "VBScript"
#$interface = "1.0"

crt.Screen.Synchronous = True

' This automatically generated script may need to be
' edited in order to work correctly.

Sub Main

Set MainTab = crt.GetScriptTab
Set ALS2Tab = MainTab.Clone
Set ALS1Tab = MainTab.Clone
Set DLS2Tab = MainTab.Clone
Set DLS1Tab = MainTab.Clone
Set R4Tab = MainTab.Clone
Set R3Tab = MainTab.Clone
Set R2Tab = MainTab.Clone
Set R1Tab = MainTab.Clone


MainTab.Caption = "Main"

R1Tab.Caption = "Core1"
R1Tab.Screen.Send "1" & chr(13) & chr(13) & chr(13) & chr(13) & chr(13) & chr(13) 

R2Tab.Caption = "Core2"
R2Tab.Screen.Send "2" & chr(13) & chr(13) & chr(13) & chr(13) & chr(13) & chr(13) 

R3Tab.Caption = "Edge1"
R3Tab.Screen.Send "3" & chr(13) & chr(13) & chr(13) & chr(13) & chr(13) & chr(13) 

R4Tab.Caption = "ISP"
R4Tab.Screen.Send "4" & chr(13) & chr(13) & chr(13) & chr(13) & chr(13) & chr(13) 

DLS1Tab.Caption = "DLS1"
DLS1Tab.Screen.Send "5" & chr(13) & chr(13) & chr(13) & chr(13) & chr(13) & chr(13) 

DLS2Tab.Caption = "DLS2"
DLS2Tab.Screen.Send "6" & chr(13) & chr(13) & chr(13) & chr(13) & chr(13) & chr(13) 

ALS1Tab.Caption = "ALS1"
ALS1Tab.Screen.Send "7" & chr(13) & chr(13) & chr(13) & chr(13) & chr(13) & chr(13) 

ALS2Tab.Caption = "ALS2"
ALS2Tab.Screen.Send "8" & chr(13) & chr(13) & chr(13) & chr(13) & chr(13) & chr(13) 



End Sub
