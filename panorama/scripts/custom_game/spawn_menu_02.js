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


     switch(enemy)
     {
          case "AntlionWorker":
               $.DispatchEvent("ClientUI_FireOutput", 2);
               break;
          case "CombineGrunt":
               $.DispatchEvent("ClientUI_FireOutput", 3);
               break;
          case "CombineCharger":
               $.DispatchEvent("ClientUI_FireOutput", 4);
               break;
          case "CombineOrdinal":
               $.DispatchEvent("ClientUI_FireOutput", 5);
               break;
          case "CombineSuppressor":
               $.DispatchEvent("ClientUI_FireOutput", 6);
               break;
          case "Reviver":
               $.DispatchEvent("ClientUI_FireOutput", 7);
               break;
          case "Jeff":
               $.DispatchEvent("ClientUI_FireOutput", 8);
               break;
          default:
               break;
     }
}

function DecodeCommand(command)
{
   var decoded = JSON.parse(command);

   var AntlionWorkerValue = $("#AntlionWorkerValue")
   AntlionWorkerValue.text = decoded["AntlionWorker"]
   
   var GruntValue = $("#GruntValue")
   GruntValue.text = decoded["CombineGrunt"]

   var ChargerValue = $("#ChargerValue")
   ChargerValue.text = decoded["CombineCharger"]

   var OrdinalValue = $("#OrdinalValue")
   OrdinalValue.text = decoded["CombineOrdinal"]

   var SuppressorValue = $("#SuppressorValue")
   SuppressorValue.text = decoded["CombineSuppressor"]

   var ReviverValue = $("#ReviverValue")
   ReviverValue.text = decoded["Reviver"]

   var JeffValue = $("#JeffValue")
   JeffValue.text = decoded["Jeff"]
   
}

(function()
{
    $.RegisterForUnhandledEvent('AddStyle',function (param,ioud) {DecodeCommand(ioud);});
})();