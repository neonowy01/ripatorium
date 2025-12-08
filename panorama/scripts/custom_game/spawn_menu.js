function HoverSound()
{
     $.DispatchEvent("ClientUI_FireOutput", 0);
}

function ClickSound()
{
     $.DispatchEvent("ClientUI_FireOutput", 1);
}