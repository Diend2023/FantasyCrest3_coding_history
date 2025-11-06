// 添加秩序白面被动
package game.role
{
   import zygame.data.BeHitData;
   import zygame.data.RoleAttributeData;
   import zygame.display.World;
   import feathers.data.ListCollection;
   
   public class ZhiXuBaiMian extends GameRole
   {

      private var breakDamTimer:int = 0;
      
      public function ZhiXuBaiMian(roleTarget:String, xz:int, yz:int, pworld:World, fps:int = 24, pscale:Number = 1, troop:int = -1, roleAttr:RoleAttributeData = null)
      {
         super(roleTarget,xz,yz,pworld,fps,pscale,troop,roleAttr);
         this.listData = new ListCollection([{
            "icon":"fangyu.png",
            "msg":"Ready"
         }]);
      }

	   override public function onFrame():void
      {
         super.onFrame();
         if (this.breakDamTimer > 0)
         {
            this.breakDamTimer -= 1;
            this.listData.getItemAt(0).msg = (this.breakDamTimer / 60).toFixed(1);
         }
         else
         {
            this.listData.getItemAt(0).msg = "Ready";
         }
         this.listData.updateItemAt(0);
      }

      override public function onBeHit(beData:BeHitData) : void
      {
         super.onBeHit(beData);
         // 被破防时获得1s霸体
         if (isDefense() && (beData.isBreakDam() || !isRightInFront(beData.role)) && this.breakDamTimer <= 0)
         {
            this.clearDebuffMove();
            this.golden = 60;
            this.breakDamTimer = 900;
         }
         // 每次被攻击时，增加1点水晶
         trace("this.currentMp.value:" + this.currentMp.value);
         trace("this.attribute.hpmax:" + this.mpMax);
         if (this.currentMp.value < this.mpMax)
         {
            this.currentMp.value += 1;
         }
         // 防反
         var enemy = beData.role as GameRole;
         if (this.actionName == "虛空陣 悪滅" && this.frameAt(3,20))
         {
            this.clearDebuffMove();
            this.actionName = "虛空陣 悪滅";
            this.currentFrame = 21;
            if (!enemy.isOSkill())
            {
               enemy.breakAction();
               enemy.straight = 180;
            }
         }
         if (this.actionName == "虚空阵 雪风" && this.frameAt(4,21))
         {
            this.clearDebuffMove();
            this.currentFrame = 22;
            if (!enemy.isOSkill())
            {
               enemy.breakAction();
               enemy.straight = 180;
            }
         }
      }
   }
}

