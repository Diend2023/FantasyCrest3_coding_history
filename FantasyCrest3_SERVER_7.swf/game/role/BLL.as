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
   import zygame.core.GameCore;
   import feathers.controls.List;
   import game.uilts.GameFont;
   
   public class BLL extends GameRole
   {
      public var flag:int;
      public var time:int;
      public var cgData:EffectDisplay;
      public var baseAtk:int;
      public var timeAddAtk:int;
      public var baseMAtk:int;
      public var timeAddMAtk:int;
      public var baseDef:int;
      public var timeAddDef:int;
      public var baseMDef:int;
      public var timeAddMDef:int;

      public function BLL(roleTarget:String, xz:int, yz:int, pworld:World, fps:int = 24, pscale:Number = 1, troop:int = -1, roleAttr:RoleAttributeData = null)
      {
         super(roleTarget,xz,yz,pworld,fps,pscale,troop,roleAttr);
         this.listData = new ListCollection([{
            "icon":"liliang.png",
            "msg":0
         },
         {
            "icon":"mofa.png",
            "msg":0
         },
         {
            "icon":"fangyu.png",
            "msg":0
         },
         {
            "icon":"fangyu.png",
            "msg":0
         }]);
      }
      
      override public function onInit() : void
      {
         super.onInit();
         var addAtk:int = 0;
         var addMAtk:int = 0;
         var addDef:int = 0;
         var addMDef:int = 0;
         baseAtk = this.attribute.power;
         baseMAtk = this.attribute.magic;
         baseDef = this.attribute.armorDefense;
         baseMDef = this.attribute.magicDefense;
         timeAddAtk = 0;
         timeAddMAtk = 0;
         timeAddDef = 0;
         timeAddMDef = 0;
         hitEnemyNumAddAtk = 0;
         hitEnemyNumAddMAtk = 0;
         beHitAddDef = 0;
         beHitAddMDef = 0;
         beHitNum = 0;
         hitEnemyNum = 0;
      }

	   override public function onFrame():void
      {
         super.onFrame();
         // 被动代码随时间加伤和防御代码实现
         var stateList:List = this.hpmpDisplay.stateList;
         if (stateList.width != listData.length * 100)
         {
            stateList.width = listData.length * 100;
         }
         var count:int = (world as BaseGameWorld).frameCount;
			timeAddAtk = int(count * 0.00232 + baseAtk);
			timeAddMAtk = int(count * 0.00286 + baseMAtk);
			timeAddDef = int(count * 0.00002 + baseDef);
			timeAddMDef = int(count * 0.00002 + baseMDef);
         atk = timeAddAtk + hitEnemyNumAddAtk;
         matk = timeAddMAtk + hitEnemyNumAddMAtk;
         def = timeAddDef + beHitAddDef;
         mdef = timeAddMDef + beHitAddMDef;
         this.attribute.power = atk;
         this.attribute.magic = matk;
         this.attribute.armorDefense = def;
         this.attribute.magicDefense = mdef;
         this.listData.getItemAt(0).msg = this.attribute.power;
         this.listData.updateItemAt(0);
         this.listData.getItemAt(1).msg = this.attribute.magic;
         this.listData.updateItemAt(1);
         this.listData.getItemAt(2).msg = this.attribute.armorDefense;
         this.listData.updateItemAt(2);
         this.listData.getItemAt(3).msg = this.attribute.magicDefense;
         this.listData.updateItemAt(3);

         // oEffect = this.world.getEffectFormName("wuya",this);

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
            hand(150, 150, 150, 150, 100, 25);
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
                  shiting(3, role);
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
               for(var i in this.world.getRoleList())
               {
                  if (this.world.getRoleList()[i] != this)
                  {
                     shiting(90, this.world.getRoleList()[i]);
                  }
               }
               (world as BaseGameWorld).founcDisplay = this;
            }
            if (currentFrame == 31)
            {
               (world as BaseGameWorld).founcDisplay = (world as BaseGameWorld).centerSprite;
            }
         }

         // KO巨量流星时停和cg实现
         if (actionName == "巨量流星")
         {
            if (currentFrame == 0)
            {
               for(var i in this.world.getRoleList())
               {
                  if (this.world.getRoleList()[i] != this && this.world.getRoleList()[i].isJump())
                  {
                     shiting(30, this.world.getRoleList()[i]);
                  }
               }
            }
            if (currentFrame == 4)
            {
               for(var i in this.world.getRoleList())
               {
                  shiting(150, this.world.getRoleList()[i]);
               }
               currentFrame = 5;
            }
            if (currentFrame == 5)
            {
               var cgData = new EffectDisplay("BLL13",{blendMode:"normal"},this,2,2);
               cgData.fps = 15;
               (world as BaseGameWorld).addChild(cgData);
               GameCore.soundCore.playEffect("BLL1");
               cgData.posx = (world as BaseGameWorld).centerSprite.x - 640;
               cgData.posy = (world as BaseGameWorld).centerSprite.y - 360;
               cgData.alpha = 1;
		         cgData.unhit = true;
               currentFrame = 6;
               cgData.blendMode = "normal";
               trace("blendMode",cgData.blendMode);
               trace("blendModeString",cgData.blendModeString);
            }
         }
      }

      override public function onHitEnemy(beData:BeHitData, enemy:BaseRole) : void
      {
         // 被动当攻击敌人1hit后增加攻击代码实现
         hitEnemyNumAddAtk = int(++hitEnemyNum * 0.464);
         hitEnemyNumAddmAtk = int(++hitEnemyNum * 0.572);
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
         beHitAddDef = int(++beHitNum * 0.05);
         beHitAddmDef = int(++beHitNum * 0.05);
         super.onBeHit(beData);
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

      public function shiting(cardFrame:int, role:BaseRole):void
      {
         for(var i in this.world.getRoleList())
         {
            if(this.world.getRoleList()[i] == role)
            {
               this.world.getRoleList()[i].cardFrame = cardFrame;
            }
         }
      }

   }
}

