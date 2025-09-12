package game.role
{
   import zygame.data.RoleAttributeData;
   import zygame.display.World;
   
   public class BaiJin extends GameRole
   {

      public var fiveHitNum:int = 0;
      public var fiveHitCount:int = 0;
      
      public function BaiJin(roleTarget:String, xz:int, yz:int, pworld:World, fps:int = 24, pscale:Number = 1, troop:int = -1, roleAttr:RoleAttributeData = null)
      {
         super(roleTarget,xz,yz,pworld,fps,pscale,troop,roleAttr);
      }
      
      override public function onHitEnemy(beData:BeHitData, enemy:BaseRole) : void
      {
         super.onHitEnemy(beData,enemy);
         fiveHitCount++;
         if(fiveHitCount == 5)
         {
            fiveHitCount = 0;
            fiveHitNum++;
            this.attribute.power += 50;
         }
      }
   }
}

