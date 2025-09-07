// 添加剧情副本世界YuanSu05
package game.world.story.yuansu
{
   import game.role.GameRole;
   import zygame.core.PoltCore;
   import zygame.data.RoleAttributeData;

   public class YuanSu05 extends YuanSu
   {
      
      public function YuanSu05(mapName:String, toName:String)
      {
         super(mapName,toName);
      }
      
      override public function onInit() : void
      {
         var anheimolong:GameRole = null;
         var guanggong:GameRole = null;
         super.onInit();
         if(PoltCore.hasEvent("dnf_yuansu_5_暗黑魔龙_击败事件"))
         {
            anheimolong = this.getRoleFormName("anheimolong") as GameRole;
            anheimolong.discarded();
         }
         if(PoltCore.hasEvent("dnf_yuansu_5_光之弓箭手_击败事件"))
         {
            guanggong = this.getRoleFormName("guanggong") as GameRole;
            guanggong.discarded();
         }
      }
      
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

      override public function onFrame() : void //
      { //
         super.onFrame(); //
         if(this.getRoleFormName("anheimolong") && !PoltCore.hasEvent("dnf_yuansu_5_暗黑魔龙_击败事件")) //
         { //
            var anheimolong:GameRole = this.getRoleFormName("anheimolong") as GameRole; //
            if(anheimolong.attribute.hp <= 0) //
            { //
               PoltCore.addEvent("dnf_yuansu_5_暗黑魔龙_击败事件"); //
            } //
         } //
         if(this.getRoleFormName("guanggong") && !PoltCore.hasEvent("dnf_yuansu_5_光之弓箭手_击败事件")) //
         { //
            var guanggong:GameRole = this.getRoleFormName("guanggong") as GameRole; //
            if(guanggong.attribute.hp <= 0) //
            { //
               PoltCore.addEvent("dnf_yuansu_5_光之弓箭手_击败事件"); //
            } //
         } //
      } //

   }
}

