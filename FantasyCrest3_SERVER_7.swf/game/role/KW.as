// 添加假面骑士空我的被动
package game.role
{
   import zygame.data.RoleAttributeData;
   import feathers.data.ListCollection;
   import zygame.display.World;
   import zygame.core.GameCore;
   
   public class KW extends GameRole
   {
      private var forms:Array = ["Dragon","Pegasus","Titan"];
      private var currentForm:String;
      private var formTimer:int;
      private var formMightyUI:Object = {"icon":"liliang.png","msg":"Mighty"};
      private var formDragonUI:Object = {"icon":"shuijing.png","msg":"Dragon"};
      private var formPegasusUI:Object = {"icon":"shengcun.png","msg":"Pegasus"};
      private var formTitanUI:Object = {"icon":"mofa.png","msg":"Titan"};

      public function KW(roleTarget:String, xz:int, yz:int, pworld:World, fps:int = 24, pscale:Number = 1, troop:int = -1, roleAttr:RoleAttributeData = null)
      {
         super(roleTarget,xz,yz,pworld,fps,pscale,troop,roleAttr);
         listData = new ListCollection([{
            "icon":"liliang.png",
            "msg":"Mighty"
         }]);
      }
      
      override public function onInit() : void
      {
         super.onInit();
         formTimer = 0;
         currentForm = "Mighty";
      }

	   override public function onFrame():void
      {
         super.onFrame();
         if(actionName == "形态更换")
         {
            if (currentFrame == 0)
            {
               GameCore.soundCore.playEffect("jmqsKW45");
            }
            if (currentFrame == 5)
            {
               currentForm = forms[Math.floor(Math.random() * forms.length)];
               formTimer = 600;
               switch(currentForm)
               {
                  case "Dragon":
                     playSkill("青龙形态")
                     listData.getItemAt(0).icon = formDragonUI.icon;
                     listData.getItemAt(0).msg = formDragonUI.msg;
                     break;
                  case "Pegasus":
                     playSkill("天马形态")
                     listData.getItemAt(0).icon = formPegasusUI.icon;
                     listData.getItemAt(0).msg = formPegasusUI.msg;
                     break;
                  case "Titan":
                     playSkill("泰坦形态")
                     listData.getItemAt(0).icon = formTitanUI.icon;
                     listData.getItemAt(0).msg = formTitanUI.msg;
               }
            }
         }

         if(formTimer > 0)
         {
            formTimer--;
            if (formTimer > 0)
            {
               this.listData.getItemAt(0).msg = int(formTimer / 60) + "s";
            }
            else
            {
               currentForm = "Mighty";
               listData.getItemAt(0).icon = formMightyUI.icon;
               listData.getItemAt(0).msg = formMightyUI.msg;
            }
         }
         this.listData.updateItemAt(0);
      }

	   override public function runLockAction(str:String, canBreak:Boolean = false) : void
      {
         super.runLockAction(str, canBreak);
         if (str == "Ultimate Smash" && this.attribute.hp <= this.attribute.hpmax * 0.3)
         {
            this.actionName = "【EX】Ultimate Smash";
            return;
         }

         // 不同形态的技能替换
         if (currentForm == "Mighty")
         {
            return;
         }
         if (currentForm == "Dragon")
         {
            switch(str)
            {
               case "燃烧突击":
                  this.actionName = "青龙I";
                  break;
               case "火焰闪打":
                  this.actionName = "青龙SI";
                  break;
               case "爆裂拳击":
                  this.actionName = "青龙WI";
            }
            return;
         }
         if (currentForm == "Pegasus")
         {
            switch(str)
            {
               case "燃烧突击":
                  this.actionName = "天马I";
                  break;
               case "火焰闪打":
                  this.actionName = "天马SI";
                  break;
               case "爆裂拳击":
                  this.actionName = "天马WI";
            }
            return;
         }
         if (currentForm == "Titan")
         {
            switch(str)
            {
               case "燃烧突击":
                  this.actionName = "泰坦I";
                  break;
               case "火焰闪打":
                  this.actionName = "泰坦SI";
                  break;
               case "爆裂拳击":
                  this.actionName = "泰坦WI";
            }
            return;
         }

      }
   }
}

