package game.world.story.yuansu
{
   import game.role.GameRole;
   import game.world._1VStory;
   import zygame.ai.AiHeart;
   import zygame.core.DataCore;
   import zygame.core.PoltCore;
   import zygame.display.EffectDisplay;
   
   public class YuanSu01 extends _1VStory
   {
      
      public function YuanSu01(mapName:String, toName:String)
      {
         super(mapName,toName);
      }
      
      override public function onInit() : void
      {
         var r:GameRole = null;
         super.onInit();
         // var Events:Array = DataCore.getArray("poltEvents"); //
         // if(Events && Events.indexOf("元素感染事件") != -1) //
         // { //
         //    for (var i:int = Events.length - 1; i >= 0; i--) //
         //    { //
         //       if (Events[i] == "元素感染事件") //
         //       { //
         //          DataCore._saveData["poltEvents"].splice(i, 1); //
         //          trace("remove 元素感染事件 remove"); //
         //       } //
         //    } //
         // } //
         if(PoltCore.hasEvent("元素感染事件"))
         {
            r = this.getRoleFormName("cike") as GameRole;
            r.discarded();
         }
         else
         {
            auto = false;
            this.role.move("right");
         }
      }
      
      public function Boom() : void
      {
         var r:GameRole = this.getRoleFormName("cike") as GameRole;
         r.discarded();
         var guangyuansu:GameRole = new GameRole("guangyuansu",r.posx,r.posy,this);
         this.addChild(guangyuansu);
         guangyuansu.name = "cike";
         guangyuansu.ai = true;
         guangyuansu.troopid = -1;
         guangyuansu.setAi(new AiHeart(guangyuansu,DataCore.getXml("ordinary")));
         PoltCore.addEvent("元素感染事件");
         var effect:EffectDisplay = new EffectDisplay("dianshan",null,guangyuansu,2,2);
         this.addChild(effect);
         effect.posx = guangyuansu.x - 150;
         effect.posy = guangyuansu.y - 600;
         auto = true;
      }
   }
}

