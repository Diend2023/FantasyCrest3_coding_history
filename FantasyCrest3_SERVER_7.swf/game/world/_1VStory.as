package game.world
{
   import game.data.Game; //
   import game.data.OverTag; //
   import game.view.GameOverView; //
   import game.view.GameStartMain; //
   import zygame.core.SceneCore; //
   import zygame.data.GameTroopData; //
   
   public class _1VStory extends _1VFB
   {
      
      public static var troop:GameTroopData = new GameTroopData();
      
      public function _1VStory(mapName:String, toName:String)
      {
         super(mapName,toName);
      }
      
      override public function cheakGameOver() : int
      {
         return -1;
      }
      
      override public function over() : void //
      { //
         var over:GameOverView; //
         var id:int = cheakGameOver(); //
         var tag:String = OverTag.NONE; //
         if(id == 0) //
         { //
            tag = OverTag.GAME_WIN; //
            Game.fbData.addWinTimes(targetName); //
         } //
         else //
         { //
            tag = OverTag.GAME_OVER; //
         } //
         troop.reset(); //
         over = new GameOverView(fightData.data1,fightData.data2,tag); //
         over.callBack = function():void //
         { //
            SceneCore.replaceScene(new GameStartMain()); //
         }; //
         SceneCore.replaceScene(over); //
      } //
      
      override public function initRole() : void
      {
         super.initRole();
         if(!troop.getAttrudete(role.targetName))
         {
            troop.joinAttrudetes(role.targetName);
         }
         role.applyAttridute(troop.getAttrudete(role.targetName));
         this.cameraPy = 0.35;
      }
      
      override public function onFrame() : void
      {
         var i:int = 0;
         this.unLockAsk();
         i = 0;
         while(i < this.roles.length)
         {
            if(this.roles[i].troopid != role.troopid)
            {
               this.lockAsk();
            }
            i++;
         }
         super.onFrame();
      }
   }
}

