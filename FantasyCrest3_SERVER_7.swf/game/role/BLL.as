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
   import flash.geom.Rectangle; // 抓取用
   import game.server.HostRun2Model; // 时停用
   import starling.animation.Tween;// cg用
   
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
            worldFouncDisplay = world.centerSprite;
            // cgData = new EffectDisplay("BLL13",null,this,3,3);
            // cgData.go(0);
            // cgData.x = this.x - 500;
            // cgData.y = this.y + 300;
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
         listData.getItemAt(0).msg = attribute.power;
         listData.updateItemAt(0);

         // 普通攻击后续
         if (actionName == "普通攻击" && frameAt(8,14))
         {
            if (isKeyDown(74))
            {
               mandatorySkill = 1;
               playSkill("[隐藏]普通攻击后续");
               mandatorySkill = 1;
            }
         }
         if (actionName == "[隐藏]普通攻击后续" && frameAt(15,20))
         {
            if (isKeyDown(74))
            {
               mandatorySkill = 1;
               playSkill("[隐藏]普通攻击后续2");
            }
         }
         // 普通攻击后续2抓取实现
         if (actionName == "[隐藏]普通攻击后续2")
         {
            if (frameAt(5, 17))
            {
               isHand = hand(200, 100, 100, 200, 100, 0);
               if (!isHand && currentFrame == 16)
               {
                  breakAction();
               }
            }
            else if (currentFrame == 22)
            {
               hand(200, 100, 100, 200, 0, 200);
            }
         }

         // I套索传送后续
         if (actionName == "套索传送" && frameAt(18, 51))
         {
            if (isKeyDown(73))
            {
               mandatorySkill = 1;
               playSkill("[隐藏]套索后续");
               mandatorySkill = 1;
            }
         }

         // SU巨爪击抓取后续
         if (actionName == "[隐藏][抓取]抓取后续" && frameAt(-1, 9))
         {
            hand(150, 150, 150, 150, 100, 0);
         }

         // KI浩瀚重击取后续
         if (actionName == "[隐藏][抓取]浩瀚重击后续" && frameAt(-1, 5))
         {
            hand(150, 150, 150, 150, 75, 50);
         }

         // WL超级冲击实现
         if (isKeyDown(87) && isKeyDown(76))
         {
            playSkill("超级冲击");
         }

         // SJ龙冲击抓取以及跳转实现
         if (actionName == "[无十二刀]龙冲击" && frameAt(3, 9))
         {
            isHand = hand(100, 100, 200, 200, 90, 10);
            if (isHand)
            {
               mandatorySkill = 1;
               playSkill("[抓取][无十二刀][隐藏]龙冲击后续");
               mandatorySkill = 1;
            }
         }

         // SJ龙冲击后续
         if (actionName == "[抓取][无十二刀][隐藏]龙冲击后续" && frameAt(-1, 29))
         {
            hand(100, 100, 200, 200, 90, 10);
         }

         // P抹杀风暴抓取
         if (actionName == "[抓取][无十二刀]抹杀风暴")
         {
            if (currentFrame == 14)
            {
               isHand = hand(200, 200, 200, 250, 100, 0);
               if (!isHand)
               {
                  breakAction();
               }
            }
            else if (frameAt(14, 34))
            {
               hand(200, 200, 200, 200, 100, 100);
            }
            else if (frameAt(52, 64))
            {
               hand(200, 200, 200, 200, 100, 25);
            }
         }

         // KSU重砸抓取
         if (actionName == "[抓取]重砸")
         {
            if (currentFrame == 20)
            {
               isHand = hand(200, 300, 200, 300, 100, -80);
               if (!isHand)
               {
                  breakAction();
               }
            }
            else if (frameAt(23, 31))
            {
               hand(200, 200, 200, 200, 100, -80);
            }
         }

         // SL消失移动实现
         if (isKeyDown(83) && isKeyDown(76))
         {
            playSkill("消失移动");
         }

         // 消失移动时停瞬移实现
         if (actionName == "消失移动")
         {
            role = this.findRole(new Rectangle(0,0,world.map.getWidth(),world.map.getHeight()));
            if(role)
            {
               if(frameAt(3, 19) && role.isJump())
               {
                  shiting(3);
               }
               if (currentFrame == 11)
               {
                  this.posx = role.x - 100 * role.scaleX;
                  this.posy = role.y;
                  this.scaleX = role.scaleX > 0 ? 1 : -1;
               }
            }
         }

         // O抹杀加农炮镜头锁定实现
         if (actionName == "抹杀加农炮")
         {
            if (currentFrame == 0)
            {
               shiting(90);
               world.founcDisplay = this;
            }
            if (currentFrame == 31)
            {
               world.founcDisplay = world.centerSprite;
            }
         }
      }

      override public function onHitEnemy(beData:BeHitData, enemy:BaseRole) : void
      {
         // 被动当攻击敌人1hit后增加攻击代码实现
         addAtk2 = int(++hit2 * 0.464);
         addmAtk2 = int(++hit2 * 0.572);
         super.onHitEnemy(beData,enemy);

         // SU巨爪击破防和跳转后续和调整敌方位置实现
         if (actionName == "[抓取]巨抓击" && frameAt(8,16))
         {
            isHand = hand(300, 300, 200, 200, 100, 0);
            if (isHand)
            {
               mandatorySkill = 1;
               playSkill("[隐藏][抓取]抓取后续");
               mandatorySkill = 1;
            }
         }

         // KI浩瀚重击抓取以及跳转实现
         if (actionName == "[抓取]浩瀚重击")
         {
            isHand = hand(400, 400, 400, 400, 100, 100);
            if (isHand)
            {
               mandatorySkill = 1;
               playSkill("[隐藏][抓取]浩瀚重击后续");
               mandatorySkill = 1;
            }
         }

         // WL超级冲击停止
         if (actionName == "超级冲击" && frameAt(6, 23))
         {
            currentFrame = 23;
         }
      }

      override public function onBeHit(beData:BeHitData) : void
      {
         // 被动当收到一hit攻击后增加防御代码实现
         super.onBeHit(beData);
         addDef2 = int(++hit * 0.05);
         addmDef2 = int(++hit * 0.05);
      }

      public function hand(topRange:int = 200, bottomRange:int = 200, backRange:int = 100, frontRange:int = 200,  toX:int = 0, toY:int = 0):Boolean
      {
          var rect:Rectangle = this.body.bounds.toRect();
          // 横向判定
          if(this.scaleX > 0)
          {
              rect.width += frontRange;
              rect.x -= backRange;
              rect.width += backRange;
          }
          else
          {
              rect.x -= frontRange;
              rect.width += frontRange;
              rect.width += backRange;
          }
          // 纵向判定
          rect.y -= topRange;
          rect.height += topRange;
          rect.height += bottomRange;
      
          // 修正左边界
          if(rect.x < 0)
          {
              rect.width += rect.x; // 把溢出的部分减掉
              rect.x = 0;
              toX = 0;
          }
          // 修正右边界
          if(rect.x + rect.width > world.map.getWidth())
          {
              rect.width = world.map.getWidth() - rect.x;
              toX = 0;
          }
      
          if(rect.width > 0 && rect.height > 0)
          {
              var role:BaseRole = findRole(rect);
              if(role)
              {
                  role.clearDebuffMove();
                  role.straight = 30;
                  role.setX(this.x + toX * this.scaleX);
                  role.setY(this.y - toY);
                  return true;
              }
          }
          return false;
      }

      public function shiting(cardFrame:int):void
      {
         for(var i in this.world.getRoleList())
         {
            if(this.world.getRoleList()[i] != this)
            {
               this.world.getRoleList()[i].cardFrame = cardFrame;
            }
         }
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

