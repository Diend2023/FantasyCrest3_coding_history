// 添加李洛克被动
package game.role
{
   import flash.geom.Point;
   import zygame.data.BeHitData;
   import zygame.data.RoleAttributeData;
   import zygame.display.BaseRole;
   import zygame.display.World;
   import feathers.data.ListCollection;
   
   public class XiaoLi extends GameRole
   {

      public var beHurtNum:int = 0;

      public function XiaoLi(roleTarget:String, xz:int, yz:int, pworld:World, fps:int = 24, pscale:Number = 1, troop:int = -1, roleAttr:RoleAttributeData = null)
      {
         super(roleTarget,xz,yz,pworld,fps,pscale,troop,roleAttr);
         this.listData = new ListCollection([{
            "icon":"liliang.png",
            "msg":0
         }]);
      }

      override public function onHitEnemy(beData:BeHitData, enemy:BaseRole) : void
      {
         super.onHitEnemy(beData, enemy);
         if(inFrame("杜门！爆发连段！",51))
         {
            enemy.hurtNumber(beHurtNum,null,new Point(beData.role.x,beData.role.y));
            this.beHurtNum = 0;
            this.listData.getItemAt(0).msg = this.beHurtNum;
            this.listData.updateItemAt(0);
         }
      }
      
      override public function hurtNumber(beHurt:int, beData:BeHitData, pos:Point) : void
      {
         this.beHurtNum += beHurt * 0.25;
         this.listData.getItemAt(0).msg = this.beHurtNum;
         this.listData.updateItemAt(0);
         super.hurtNumber(beHurt,beData,pos);
      }
   }
}

