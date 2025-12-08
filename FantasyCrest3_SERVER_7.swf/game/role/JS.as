// 添加空条承太郎被动
package game.role
{
   import zygame.display.BaseRole;
   import zygame.data.BeHitData;
   import zygame.data.RoleAttributeData;
   import zygame.display.World;
   import zygame.display.EffectDisplay;
   
   public class JS extends GameRole
   {

      effectSuChuanTimer:int = 0;
      
      public function JS(roleTarget:String, xz:int, yz:int, pworld:World, fps:int = 24, pscale:Number = 1, troop:int = -1, roleAttr:RoleAttributeData = null)
      {
         super(roleTarget,xz,yz,pworld,fps,pscale,troop,roleAttr);
      }

      override public function onFrame():void
      {
         super.onFrame();
         var effectSuChuan:EffectDisplay = this.world.getEffectFormName("SuChuan",this);
         if(effectSuChuan )
         {
            if(effectSuChuan.currentFrame == 0)
            {
               effectSuChuanTimer = 250;
               trace("effectSuChuan.isGravMode: " + effectSuChuan.isGravMode);
               effectSuChuan.isGravMode = false;
            }
            if(effectSuChuan.currentFrame == 2 && effectSuChuanTimer > 0)
            {

               if(effectSuChuan.body)
               {
                  // 清除速度和作用力
                  if(effectSuChuan.body.velocity) effectSuChuan.body.velocity.setxy(0,0);
                  if(effectSuChuan.body.force) effectSuChuan.body.force.setxy(0,0);
                  // 强制同步刚体位置到显示位置，覆盖被推动结果
                  effectSuChuan.body.position.setxy(effectSuChuan.x,effectSuChuan.y);
               }

               effectSuChuan.xMove(0.0);
               effectSuChuan.yMove(0.0);
               effectSuChuanTimer -= 1;
               effectSuChuan.cardFrame = 2;
            }
         }
      }
   }
}

