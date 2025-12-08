var SelectedNPC = false
function HoverSound()
{
     $.DispatchEvent("ClientUI_FireOutput", 0);
}

function ClickSound()
{
     $.DispatchEvent("ClientUI_FireOutput", 1);
}

function Select(enemy)
{
     SelectedNPC = enemy
     $("#"+enemy).SetHasClass("SelectedItem", true)
}