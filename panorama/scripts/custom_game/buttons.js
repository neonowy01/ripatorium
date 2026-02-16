function Hover()
{
     $.DispatchEvent("ClientUI_FireOutput", 0);
}

function Clicked()
{
     $.DispatchEvent("ClientUI_FireOutput", 1);
}