// 添加剧情副本世界SYZLvBu00
package game.world.story.syzlvbu
{
   import game.role.GameRole;
   import zygame.core.PoltCore;
   import zygame.data.RoleAttributeData;
   
   public class SYZLvBu00 extends SYZLvBu
   {
      
      public function SYZLvBu00(mapName:String, toName:String)
      {
         super(mapName,toName);
      }
      
      override public function onInit() : void
      {
         var r:GameRole = null;
         super.onInit();
         if(PoltCore.hasEvent("syzlb_0_吕布_击败事件"))
         {
            r = this.getRoleFormName("lvbu") as GameRole;
            r.discarded();
         }
      }
      
      // 重写检查游戏结束的方法，使得死亡会失败，胜利不结束
      override public function cheakGameOver() : int
      {
         var arr:Array = [];
         for(var i in getRoleList())
         {
            if(arr.indexOf(getRoleList()[i].troopid) == -1)
            {
               arr.push(getRoleList()[i].troopid);
            }
         }
         if(arr.length > 1)
         {
            return -1;
         }
         if(arr.length == 1 && arr.indexOf(0) == -1)
         {
            return arr[0];
         }
         return -1;
      }
      
      override public function onFrame() : void
      {
         super.onFrame();
         if(this.getRoleFormName("lvbu") && !PoltCore.hasEvent("syzlb_0_吕布_击败事件"))
         {
            var r:GameRole = this.getRoleFormName("lvbu") as GameRole;
            if(r.attribute.hp <= 0)
            {
               PoltCore.addEvent("syzlb_0_吕布_击败事件");
            }
         }
      }
   }
}

