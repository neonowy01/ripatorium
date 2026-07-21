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

   var PreviewNpcAmount = $("#PreviewNpcAmount")
   PreviewNpcAmount.text = decoded["SelectedEnemyAmount"]
   var ArenaCapacity = $("#ArenaCapacityLabel")
   ArenaCapacity.text = "Arena Capacity: " + decoded["EnemySum"] + "/" + decoded["EnemyMaxAmount"]

   var PreviewTitle = $("#PreviewTitle")
   var PreviewImage = $("#PreviewImage")
   switch(decoded["SelectedEnemy"])
   {
     case "Headcrab": PreviewTitle.text = "Headcrab"; PreviewImage.SetImage("file://{images}/custom_game/placeholders/headcrab_color.png"); break;
     case "ArmoredHeadcrab": PreviewTitle.text = "Armored Headcrab"; PreviewImage.SetImage("file://{images}/custom_game/placeholders/headcraba_color.png");  break;
     case "PoisonHeadcrab": PreviewTitle.text = "Poison Headcrab"; PreviewImage.SetImage("file://{images}/custom_game/placeholders/poison_color.png");  break;
     case "FastHeadcrab": PreviewTitle.text = "Fast Headcrab"; PreviewImage.SetImage("file://{images}/custom_game/placeholder.png"); break;
     case "Manhack": PreviewTitle.text = "Manhack";  PreviewImage.SetImage("file://{images}/custom_game/placeholders/manhack_color.png"); break;
     case "Zombie": PreviewTitle.text = "Zombie";  PreviewImage.SetImage("file://{images}/custom_game/placeholders/zombie_color.png"); break;
     case "ArmoredZombie": PreviewTitle.text = "Armored Zombie";  PreviewImage.SetImage("file://{images}/custom_game/placeholders/zombiea_color.png"); break;
     case "Antlion": PreviewTitle.text = "Antlion";  PreviewImage.SetImage("file://{images}/custom_game/placeholders/antlion_color.png"); break;
     case "AntlionWorker": PreviewTitle.text = "Antlion Worker";  PreviewImage.SetImage("file://{images}/custom_game/placeholders/worker_color.png"); break;
     case "CombineGrunt": PreviewTitle.text = "Combine Grunt";  PreviewImage.SetImage("file://{images}/custom_game/placeholders/grunt_color.png");break;
     case "CombineCharger": PreviewTitle.text = "Combine Charger";  PreviewImage.SetImage("file://{images}/custom_game/placeholders/charger_color.png");break;
     case "CombineOrdinal": PreviewTitle.text = "Combine Ordinal";  PreviewImage.SetImage("file://{images}/custom_game/placeholders/captain_color.png");break;
     case "CombineSuppressor": PreviewTitle.text = "Combine Suppressor";  PreviewImage.SetImage("file://{images}/custom_game/placeholders/supp_color.png"); break;
     case "Reviver": PreviewTitle.text = "Reviver";  PreviewImage.SetImage("file://{images}/custom_game/placeholders/reviver_color.png");break;
     case "Jeff": PreviewTitle.text = "Jeff"; PreviewImage.SetImage("file://{images}/custom_game/placeholder.png"); break;
     default: PreviewTitle.text = "Preview Title"; break;

   }
   
}

(function()
{
    $.RegisterForUnhandledEvent('AddStyle',function (param,ioud) {DecodeCommand(ioud);});
})();