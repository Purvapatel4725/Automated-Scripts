#Persistent

^+d::  ; This will trigger when you press Ctrl+Shift+D
    ProcessBeforeActions(1144, 658)  ; Click at (1144, 658)
    MouseClickAndType(821, 721, 846, 813, "5/")  ; Click at (821, 721), then (846, 813) and type "5/"
    MouseClickTo(860, 891)  ; Click at (860, 891)
    MouseClickAndType(1099, 712, 1014, 821, "Call Co")  ; Click at (1099, 712)
    MouseClickTo(1001, 894)  ; Click at (1008, 885)
    MouseDoubleClickAndType(687, 864, "{#}call")  ; Double click at (687, 864) and type "#call"
    PressEnter()  ; Press Enter key
    return

ProcessBeforeActions(x, y) {
    MouseClickTo(x, y)  ; Click at the specified coordinates
    Sleep, 1000  ;
}

MouseClickAndType(x1, y1, x2, y2, text) {
    MouseClickTo(x1, y1)  ; Click at the first coordinates
    MouseClickTo(x2, y2)  ; Click at the second coordinates
    SendInput, % text  ; Type the specified text
}

MouseClickTo(destX, destY) {
    MouseMove, % destX, % destY  ; Move the mouse to the destination coordinates
    Click  ; Click at the destination coordinates
}

MouseDoubleClickAndType(destX, destY, text) {
    MouseClickTo(destX, destY)  ; Double click at the destination coordinates
    SendInput, % text  ; Type the specified text
}

PressEnter() {
    SendInput {Enter}  ; Simulate pressing Enter key
}
