// 添加布罗利(纹4)
package game.role
{
   import zygame.data.RoleAttributeData;
   import zygame.display.World;
   import zygame.display.EffectDisplay;
   import feathers.data.ListCollection;
   import game.world.BaseGameWorld;
   import zygame.data.BeHitData;
   import zygame.display.BaseRole;
   import starling.core.Starling;
   import flash.geom.Rectangle; //抓取用
   
   public class BLL extends GameRole
   {
      public var _Data:Object;
      public var flag:int;
      public var time:int;
      public var cgData:EffectDisplay;
      public var atk:int;
      public var addAtk:int;
      public var matk:int;
      public var addmAtk:int;
      public var def:int;
      public var addDef:int;
      public var mdef:int;
      public var addmDef:int;
      
      public function BLL(roleTarget:String, xz:int, yz:int, pworld:World, fps:int = 24, pscale:Number = 1, troop:int = -1, roleAttr:RoleAttributeData = null)
      {
         super(roleTarget,xz,yz,pworld,fps,pscale,troop,roleAttr);
         listData = new ListCollection([{
            "icon":"liliang.png",
            "msg":0
         }]);
      }
      
      override public function onInit() : void
      {
         super.onInit();
         trace("BLL initialized");
         try
         {
            this.setRoleValue("atk", attribute.power);
            this.setRoleValue("matk", attribute.magic);
            this.setRoleValue("def", attribute.armorDefense);
            this.setRoleValue("mdef", attribute.magicDefense);
            addmDef = 0;
            addDef = 0;
            addAtk = 0;
            addmAtk = 0;
            addmDef2 = 0;
            addDef2 = 0;
            addAtk2 = 0;
            addmAtk2 = 0;
            atk = this.getRoleValue("atk", 232);
            matk = this.getRoleValue("matk", 286);
            def = this.getRoleValue("def", 36);
            mdef = this.getRoleValue("mdef", 36);
            viual = 0;
            hit = 0;
            hit2 = 0;
            // cgData = new EffectDisplay();
            // cgData.name = "BLL13";
            // cgData.findName = "cg";
            // cgData.scaleX = 1;
            // cgData.scaleY = 1;
            // cgData.fps = 15;
            // cgData.blendMode = null;
            // cgData.native = true;
            // cgData.unhit = true;
         }
         catch (error:Error)
         {
            trace("Error initializing BLL: " + error.message);
         }
      }

	   override public function onFrame():void
      {
         super.onFrame();
         // 被动代码随时间加伤和防御代码实现
         var count:int = (world as BaseGameWorld).frameCount;
         var atk = this.getRoleValue("atk", 232);
         var matk = this.getRoleValue("matk", 286);
         var def = this.getRoleValue("def", 36);
         var mdef = this.getRoleValue("mdef", 36);
			addAtk = int(count * 0.00232 + atk);
			addmAtk = int(count * 0.00286 + matk);
			addDef = int(count * 0.00002 + def);
			addmDef = int(count * 0.00002 + mdef);
         atk = addAtk + addAtk2;
         matk = addmAtk + addmAtk2;
         def = addDef + addDef2;
         mdef = addmDef + addmDef2;
         attribute.power = atk;
         attribute.magic = matk;
         attribute.armorDefense = def;
         attribute.magicDefense = mdef;
         // trace("BLL updated with Frame",count,attribute.power,attribute.magic,attribute.armorDefense,attribute.magicDefense);
         listData.getItemAt(0).msg = attribute.power;
         listData.updateItemAt(0);

         // 普通攻击后续
         if (actionName == "普通攻击" && frameAt(9,13))
         {
            trace("BLL onAction 0");
            if (isKeyDown(74))
            {
               trace("KeyDown(74)");
               Starling.juggler.delayCall(function():void
               {
                  mandatorySkill = 0;
                  playSkill("[隐藏]普通攻击后续");
                  mandatorySkill = 1;
                  trace("playSkill 1");
               },0.1);
            }
         }
         if (actionName == "[隐藏]普通攻击后续" && frameAt(16,19))
         {
            trace("BLL onAction 1");
            if (isKeyDown(74))
            {
               trace("KeyDown(74)");
               playSkill("[隐藏]普通攻击后续2");
               trace("playSkill 2");
            }
         }
      }

      override public function onBeHit(beData:BeHitData) : void
      {
         super.onBeHit(beData);
         addDef2 = int(++hit * 0.05);
         addmDef2 = int(++hit * 0.05);
         trace("BLL updated with BeHit",addDef2,addmDef2);
      }

      override public function onHitEnemy(beData:BeHitData, enemy:BaseRole) : void
      {
         addAtk2 = int(++hit2 * 0.464);
         addmAtk2 = int(++hit2 * 0.572);
         trace("BLL updated with HitEnemy",addAtk2,addmAtk2);
         if(actionName == "[隐藏]普通攻击后续2")
         {
            var rect:Rectangle = null;
            var role:BaseRole = null;
            rect = this.body.bounds.toRect();
            if(this.scaleX > 0)
            {
               rect.width += 250;
            }
            else
            {
               rect.x -= 250;
               rect.width += 250;
            }
            if(rect.x + rect.width < world.map.getWidth() && rect.x > 0)
            {
               role = findRole(rect);
               if(role)
               {
                  trace("BLL onAction 2");
                  role.clearDebuffMove();
                  role.straight = 30;
                  role.setX(this.x + 32 * this.scaleX);
                  role.setY(this.y - 32);
               }
            }
         }
         super.onHitEnemy(beData,enemy);
      }

      public function setRoleValue(key:String, value:*):void
      {
         if (!_Data) _Data = {};
         _Data[key] = value;
         if (this.hasOwnProperty(key)) {
            this[key] = value;
         }
      }
      
      public function getRoleValue(key:String, defaultValue:* = null):*
      {
         if (_Data && _Data.hasOwnProperty(key)) {
            return _Data[key];
         }
         if (this.hasOwnProperty(key)) {
            return this[key];
         }
         return defaultValue;
      }
   }
}

