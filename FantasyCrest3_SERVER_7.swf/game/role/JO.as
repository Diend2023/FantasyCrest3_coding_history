// 添加空条承太郎被动
package game.role
{
   import zygame.display.BaseRole;
   import zygame.data.BeHitData;
   import zygame.data.RoleAttributeData;
   import zygame.display.World;
   import game.world.BaseGameWorld;
   import zygame.display.EffectDisplay;
   
   public class JO extends GameRole
   {

      private var theWorldTimer:int = 0;
      
      public function JO(roleTarget:String, xz:int, yz:int, pworld:World, fps:int = 24, pscale:Number = 1, troop:int = -1, roleAttr:RoleAttributeData = null)
      {
         super(roleTarget,xz,yz,pworld,fps,pscale,troop,roleAttr);
      }

	   override public function onFrame():void
      {
         super.onFrame();
         if (this.actionName == "the world")
         {
            if (this.currentFrame == 16)
            {
               this.theWorldTimer = 300; // 5秒钟
            }
         }
         // 时停被动计时
         if (this.theWorldTimer > 0)
         {
            shitingRoleAll(2);
            shitingEffectAll(2);
            this.theWorldTimer -= 1;
         }
      }

      override public function onHitEnemy(beData:BeHitData, enemy:BaseRole) : void
      {
         super.onHitEnemy(beData,enemy);
      }

      // 时停所有角色除了自己
      public function shitingRoleAll(cardFrame:int):void
      {
         var i:int = 0;
         for(i = 0; i < this.world.getRoleList().length; i++)
         {
            if (this.world.getRoleList()[i] == this)
            {
               continue;
            }
            this.world.getRoleList()[i].cardFrame = cardFrame;
         }
      }

      // 时停所有特效包括自己
      public function shitingEffectAll(cardFrame:int):void
      {
         var j:int = 0;
         var effect:EffectDisplay = null;
         var num:int = this.world.map.roleLayer.numChildren;
         for(var j = 0; j < num; j++)
         {
            effect = this.world.map.roleLayer.getChildAt(j) as EffectDisplay;
            if (effect != null)
            {
               effect.cardFrame = cardFrame;
            }
         }
      }
   }
}

