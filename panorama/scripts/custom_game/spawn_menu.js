function HoverSound()
{
     $.DispatchEvent("ClientUI_FireOutput", 0);
}

function ClickSound()
{
     $.DispatchEvent("ClientUI_FireOutput", 1);
}

function Add()
{
     $.DispatchEvent("ClientUI_FireOutput", 2);
     ClickSound()
}

function Subtract()
{
     $.DispatchEvent("ClientUI_FireOutput", 3);
     ClickSound()
}


/*function Select(enemy)
{
     SelectedNPC = enemy
     //Yeah I don't fucking know how to get the panels children in this shit
    /* $("#Headcrab").SetHasClass("SelectedItem", false )
     $("#ArmoredHeadcrab").SetHasClass("SelectedItem", false )
     $("#PoisonHeadcrab").SetHasClass("SelectedItem", false )
     $("#Manhack").SetHasClass("SelectedItem", false )
     $("#Zombie").SetHasClass("SelectedItem", false )
     $("#ArmoredZombie").SetHasClass("SelectedItem", false )
     $("#Antlion").SetHasClass("SelectedItem", false )
     $("#AntlionWorker").SetHasClass("SelectedItem", false )
     $("#CombineGrunt").SetHasClass("SelectedItem", false )
     $("#CombineCharger").SetHasClass("SelectedItem", false )
     $("#CombineOrdinal").SetHasClass("SelectedItem", false )
     $("#CombineSuppressor").SetHasClass("SelectedItem", false )
     $("#Reviver").SetHasClass("SelectedItem", false )
     $("#Jeff").SetHasClass("SelectedItem", false )
     $("#"+enemy).SetHasClass("SelectedItem", true)
     
     Rework to be managed by Vscript-Panorama link
     */

     /*
     switch(enemy)
     {
          case "Headcrab":
               $.DispatchEvent("ClientUI_FireOutput", 2);
               break;
          case "ArmoredHeadcrab":
               $.DispatchEvent("ClientUI_FireOutput", 3);
               break;
          case "PoisonHeadcrab":
               $.DispatchEvent("ClientUI_FireOutput", 4);
               break;
          case "Manhack":
               $.DispatchEvent("ClientUI_FireOutput", 5);
               break;
          case "Zombie":
               $.DispatchEvent("ClientUI_FireOutput", 6);
               break;
          case "ArmoredZombie":
               $.DispatchEvent("ClientUI_FireOutput", 7);
               break;
          case "Antlion":
               $.DispatchEvent("ClientUI_FireOutput", 8);
               break;
          case "AntlionWorker":
               $.DispatchEvent("ClientUI_FireOutput", 9);
               break;
          case "CombineGrunt":
               $.DispatchEvent("ClientUI_FireOutput", 10);
               break;
          case "CombineCharger":
               $.DispatchEvent("ClientUI_FireOutput", 11);
               break;
          case "CombineOrdinal":
               $.DispatchEvent("ClientUI_FireOutput", 12);
               break;
          case "CombineSuppressor":
               $.DispatchEvent("ClientUI_FireOutput", 13);
               break;
          case "Reviver":
               $.DispatchEvent("ClientUI_FireOutput", 14);
               break;
          case "Jeff":
               $.DispatchEvent("ClientUI_FireOutput", 15);
               break;
     }
}

Select("Headcrab")*/

function DecodeCommand(command)
{
   var decoded = JSON.parse(command);

   var PreviewTitle = $("#PreviewTitle")
   PreviewTitle.text = decoded["SelectedEnemy"]
   var PreviewNpcAmount = $("#PreviewNpcAmount")
   PreviewNpcAmount.text = decoded["SelectedEnemyAmount"]
   var ArenaCapacity = $("#ArenaCapacityLabel")
   ArenaCapacity.text = "Arena Capacity: " + decoded["EnemySum"] + "/" + decoded["EnemyMaxAmount"]
   
}

(function()
{
    $.RegisterForUnhandledEvent('AddStyle',function (param,ioud) {DecodeCommand(ioud);});
})();