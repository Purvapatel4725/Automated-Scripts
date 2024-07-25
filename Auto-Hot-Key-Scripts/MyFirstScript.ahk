#Persistent  ; Keeps script running until explicitly closed
CoordMode, Mouse, Screen  ; Set mouse coordinates to be based on screen

; Function to move mouse to a specific point and click
MoveAndClick(x, y) {
    MouseMove, % x, % y, 0  ; Move mouse to the specified coordinates
    Sleep, 100  ; Wait for 100 milliseconds (adjust as needed)
    Click  ; Click at the current mouse position
}

; Define hotkey Alt + A to trigger the mouse movement and clicking
!a::  
    ; Move and click at the first point (adjust coordinates as needed)
    MoveAndClick(736, 1216)
    
    ; Move and click at the second point (adjust coordinates as needed)
    MoveAndClick(2162, 293)
    
    ; Move and click at the third point (adjust coordinates as needed)
    MoveAndClick(2221, 298)
    MoveAndClick(2221, 298)
    
    ; Add more MoveAndClick calls as needed for additional points
return


!z::
MoveAndClick(713, 1139)

^e::
    SendInput, Purva P.
return
