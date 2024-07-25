; Define hotkey to trigger the actions (Ctrl + Shift + Alt + F12)
^+a::TriggerActions()

; Function to trigger the actions
TriggerActions()
{
    ; Define the coordinates for the additional process
    additionalX := 1144
    additionalY := 658

    ; Call the function to perform the additional process
    ProcessBeforeActions(additionalX, additionalY)

    ; Wait for 1 second before continuing
    Sleep, 1000

    ; Define the coordinates of the first location (adjust as needed)
    x1 := 821
    y1 := 721

    ; Define the coordinates of the updated second location (adjust as needed)
    x2 := 846
    y2 := 813

    ; Define the coordinates of the third location (adjust as needed)
    x3 := 962
    y3 := 718

    ; Define the coordinates of the fourth location (adjust as needed)
    x4 := 1008
    y4 := 903

    ; Define the coordinates of the fifth location (adjust as needed)
    x5 := 687
    y5 := 864

    ; Call the functions to scroll to and click on each location
    ScrollToAndClick(x1, y1)
    SendInput, No  ; Type "No a" at (x2, y2)
    MouseClickTo(860, 891)  ; Click at the new x2 (860, 891)
    ScrollToAndClick(x3, y3)
    ClickAndType(987, 819, "Call C")
    MoveToAndClick(x4, y4)

    ; Move to the fifth location and insert text
    MoveToAndDoubleClick(x5, y5)
    InsertText("Purva P.")
}

; Function to perform additional process before actions
ProcessBeforeActions(x, y)
{
    ; Save current mouse position
    MouseGetPos, startX, startY

    ; Move to specified location
    MouseMove, %x%, %y%, 0

    ; Click at the specified location
    Click

    ; Restore mouse position
    MouseMove, %startX%, %startY%, 0
}

; Scroll to specified location and click
ScrollToAndClick(x, y)
{
    ; Save current mouse position
    MouseGetPos, startX, startY
    
    ; Scroll to specified location
    MouseMove, %x%, %y%, 0
    
    ; Click at the specified location
    Click
    
    ; Restore mouse position
    MouseMove, %startX%, %startY%, 0
}

; Move to another location and click
MoveToAndClick(x, y)
{
    ; Save current mouse position
    MouseGetPos, startX, startY
    
    ; Move to specified location
    MouseMove, %x%, %y%, 0
    
    ; Click at the specified location
    Click
    
    ; Restore mouse position
    MouseMove, %startX%, %startY%, 0
}

; Move to fifth location and double click
MoveToAndDoubleClick(x, y)
{
    ; Save current mouse position
    MouseGetPos, startX, startY

    ; Move to fifth location
    MouseMove, %x%, %y%, 0

    ; Double click
    Click, 2

    ; Restore mouse position
    MouseMove, %startX%, %startY%, 0
}

; Function to insert text
InsertText(text)
{
    ; Insert text
    SendInput %text%
}

; Function to click at specified location and type, then continue
ClickAndType(destX, destY, text)
{
    ; Click at the specified location
    MouseClickTo(destX, destY)

    ; Type the specified text
    SendInput, % text
}

; Function to click at specified location
MouseClickTo(destX, destY)
{
    ; Move to specified location
    MouseMove, %destX%, %destY%, 0
    
    ; Click at the specified location
    Click
    
    ; Restore mouse position
    MouseMove, %startX%, %startY%, 0
}
