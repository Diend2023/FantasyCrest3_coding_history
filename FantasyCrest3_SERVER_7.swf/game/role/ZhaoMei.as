// 添加由岐照美被动
package game.role
{
   import flash.utils.Dictionary;
   import feathers.data.ListCollection;
   import game.buff.AttributeChangeBuff;
   import zygame.display.BaseRole;
   import zygame.data.BeHitData;
   import zygame.data.RoleAttributeData;
   import zygame.display.World;
   
   public class ZhaoMei extends GameRole
   {

      private var _otherMP:int = 0;

      private var _skillCanCountObj:Object = {"我不知道":false,"叫什么":false,"技能":false,"蛇缚封焉尘":false,"神帰来・大蛇斩头烈封饿":false,"???":false,"轰牙双天刃·滅":false,"SI":false,"boom":false,"蛇麟炼翔牙":false,"蛇境灭闪牙":false,"SJ":false,"轰牙双天刃":false,"永生蛇·拆尼斯冲冲冲":false};

      private var _oSkillCrystalObj:Object = {"蛇缚封焉尘":3,"神帰来・大蛇斩头烈封饿":3,"蛇麟炼翔牙":3,"蛇境灭闪牙":3,"轰牙双天刃":2,"永生蛇·拆尼斯冲冲冲":2};

      private var _Count:int = 0;

      private var _OUsePoint:int = 0;
      
      public function ZhaoMei(roleTarget:String, xz:int, yz:int, pworld:World, fps:int = 24, pscale:Number = 1, troop:int = -1, roleAttr:RoleAttributeData = null)
      {
         super(roleTarget,xz,yz,pworld,fps,pscale,troop,roleAttr);
         this.listData = new ListCollection([{
            "icon":"shuijing.png",
            "msg":0
         }]);
      }

      override public function onFrame():void
      {
         super.onFrame();
         var skillName:String;
         for(skillName in _skillCanCountObj)
         {
            if(this.attribute.getCD(skillName) == 0)
            {
               _skillCanCountObj[skillName] = true;
               if(skillName == "神帰来・大蛇斩头烈封饿")
               {
                  _OUsePoint = 0;
               }
            }
         }
      }

      override public function onHitEnemy(beData:BeHitData, enemy:BaseRole) : void
      {
         if(this.inFrame("神帰来・大蛇斩头烈封饿",48))
         {
            if(beData.armorScale == 0)
            {
               beData.armorScale = 1;
            }
            beData.armorScale += _OUsePoint * 0.05;
         }
         super.onHitEnemy(beData,enemy);
         if(_skillCanCountObj[this.actionName])
         {
            _Count += 1;
            _skillCanCountObj[this.actionName] = false;
         }
         if(_Count >= 3)
         {
            if(enemy.currentMp.value > 0)
            {
               enemy.currentMp.value -= 1;
               if(_otherMP < 6)
               {
                  _otherMP += 1;
                  this.currentMp.value += 1;
               }
            }
            _Count = 0;
         }
         this.attribute.setValue("crystal",6 + _otherMP);
         this.listData.getItemAt(0).msg = _otherMP;
         this.listData.updateItemAt(0);
      }

      override public function runLockAction(str:String, canBreak:Boolean = false) : void
      {
         if(_oSkillCrystalObj[str])
         {
            _otherMP -= _oSkillCrystalObj[str];
            if(_otherMP < 0)
            {
               _otherMP = 0;
            }
            if(str == "神帰来・大蛇斩头烈封饿")
            {
               _OUsePoint = this.currentMp.value;
               usePoint(this.currentMp.value);
               _otherMP = 0;
            }
            this.attribute.setValue("crystal",6 + _otherMP);
            this.listData.getItemAt(0).msg = _otherMP;
            this.listData.updateItemAt(0);
         }
         super.runLockAction(str, canBreak);
      }
   }
}

