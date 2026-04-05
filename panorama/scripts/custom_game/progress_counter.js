function DecodeCommand(command)
{
   var decoded = JSON.parse(command);

   var ProgressValueLabel = $("#Text")
   if (decoded["SetupStage"] == true) {
     ProgressValueLabel.text = "-/-"
   }
   else 
   {
     ProgressValueLabel.text = decoded["Killcount"] + "/" + decoded["EnemySum"]
   }
   
   
}

(function()
{
    $.RegisterForUnhandledEvent('AddStyle',function (param,ioud) {DecodeCommand(ioud);});
})();