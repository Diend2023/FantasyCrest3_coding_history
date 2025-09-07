package game.view
{
   import game.data.Game;
   import game.uilts.GameFont;
   import starling.core.Starling;
   import starling.display.Quad;
   import starling.text.TextField;
   import starling.text.TextFormat;
   import zygame.core.DataCore;
   import zygame.core.SceneCore; // 添加成功购买所有角色提示
   import zygame.display.KeyDisplayObject;
   import zygame.server.Service; // 导入Service用于更新用户数据
   import flash.net.SharedObject; // 导入SharedObject用于更新缓存的用户数据

   
   public class GameTestView extends KeyDisplayObject
   {
      
      private var _title:TextField;
      
      private var _abcd:TextField;
      
      private var _tips:TextField;
      
      private var _isReady:Boolean = true;
      
      private var _arr:Array;
      
      private var _error:int = 0;
      
      private var _right:int;
      
      public function GameTestView()
      {
         super();
      }
      
      override public function onInit() : void
      {
         var i:int = 0;
         var i2:int = 0;
         var index:int = 0;
         super.onInit();
         var bg:Quad = new Quad(stage.stageWidth,stage.stageHeight,0);
         this.addChild(bg);
         bg.alpha = 0.7;
         // 原本的考试标题文本
         // _title = new TextField(stage.stageWidth,64,"游戏内测前考试，合格(80分以上)就可以进入游戏，是否准备好？",new TextFormat(GameFont.FONT_NAME,20,16777215));
         _title = new TextField(stage.stageWidth,64,"一键购买全角色考试(笑)，合格(80分以上)就可以一键解锁全部商店角色，是否准备好？",new TextFormat(GameFont.FONT_NAME,20,16777215)); // 用于一键购买全角色考试
         this.addChild(_title);
         _title.y = 50;
         _abcd = new TextField(stage.stageWidth - 300,300,"【A】开始吧！",new TextFormat(GameFont.FONT_NAME,16,16777215,"left"));
         this.addChild(_abcd);
         _abcd.x = 150;
         _abcd.y = 100;
         _tips = new TextField(stage.stageWidth,64,"已回答0/24 已答错0题 剩余分100分",new TextFormat(GameFont.FONT_NAME,20,16777215));
         this.addChild(_tips);
         _tips.y = stage.stageHeight - 64;
         this.openKey();
         _arr = [];
         var array:Array = [];
         var xmllist:XMLList = DataCore.getXml("problem").children();
         for(i = 0; i < xmllist.length(); )
         {
            array.push(xmllist[i]);
            i++;
         }
         for(i2 = 0; i2 < 24; )
         {
            index = array.length * Math.random();
            _arr.push(array[index]);
            array.splice(index,1);
            i2++;
         }
      }
      
      public function next(i:int) : Boolean
      {
         var score:int = 0;
         var str:String = null;
         var buys:Array = ["jianxin","anotherJX","zzx","weizhi","suolong","lufei","shanzhi","kawendixu","AS","hzluo","telankesi","wukong","BLUEGOKU","xiaolin","shalu","fls","jianxin","jianxin","anotherJX","zzx","weizhi","suolong","lufei","shanzhi","kawendixu","AS","hzluo","telankesi","wukong","BLUEGOKU","xiaolin","shalu","fls","buluoli","jianhun","bingjieshi","axiuluo","guijianshi","heianwushi","cike","manyou","mixieer","lanquan","Damotwo","shengzhidashu","huolongaisi","hfh","HML","yumingfangshoushi","JS","tongrendandao","yasina","youzi","xiaomeiyan","wbbd","shenzi","hchq","meihong","BL","Marisa","YL","yihushi","dongshilang","TOF","baimian","Twelve","Naruto","yuzhiboyou","anyou","jiaojiao","Kaixa","KW","shourenjialulu","SUN","naci","penhuolong","Tom","lvbu","anheimolong","qiyu","xiaoguai1","guangyuansu","guanggong","DCR","saber","CTZS","paojie","XC","Gudazi","RG","Ruimu","zhaomei","MH","LX","LXF","Ruler","KKR","baijin","SLK","xiaoli","zhouzuo","mayi","Es","AFTERdragon","heimian","HTZR","Hibiki","erqiao","pop","Nine","zhixubaimian","HZ","YXL","Ruby","ziwan","lian","JIN","Weiss","Blake","devilman","JO","NN","AZ","huajy","Linne","Yuz","Hyde","MJman","GFN","zhizhixiong","doge","huaji","hongguaiwu","JIN_old","BLL","beijita","wukongS","jifengzuo","jiuwei"]; // 一键购买所有角色的角色列表
         if(!_isReady)
         {
            if(_right != i && _right != -1)
            {
               _error++;
            }
            score = (24 - _error) / 24 * 100;
            this._tips.text = "已回答" + (24 - _arr.length) + "/24题  已答错" + _error + "题  还剩" + score + "分";
            if(score < 80)
            {
               this._title.text = "挑战失败，3秒后自动关闭窗口";
               this._abcd.text = "";
               Starling.juggler.delayCall(removeFromParent,3);
               this.clearKey();
               Service.userData.userData.buys = buys; // 购买所有角色
               SharedObject.getLocal("net.zygame.hxwz.air").data.userData = Service.userData; // 更新缓存的用户数据
               SharedObject.getLocal("net.zygame.hxwz.air").flush(); //
               SceneCore.pushView(new GameTipsView("已购买所有角色")); // 弹出提示
               return false;
            }
         }
         if(_arr.length > 0)
         {
            _isReady = false;
            _title.text = _arr[0].@title;
            str = "[A]" + _arr[0].@a + "\n" + "[B]" + _arr[0].@b + "\n" + "[C]" + _arr[0].@c + "\n" + "[D]" + _arr[0].@d;
            _abcd.text = str;
            _right = int(_arr[0].@value);
            _arr.shift();
            return true;
         }
         trace("合格");
         Game.vip.value = 1;
         Game.save();
         this._title.text = "挑战成功，3秒后自动关闭窗口";
         this._abcd.text = "";
         Starling.juggler.delayCall(removeFromParent,3);
         this.clearKey();
         Service.userData.userData.buys = buys; // 购买所有角色
         SharedObject.getLocal("net.zygame.hxwz.air").data.userData = Service.userData; // 更新缓存的用户数据
         SharedObject.getLocal("net.zygame.hxwz.air").flush(); //
         SceneCore.pushView(new GameTipsView("已购买所有角色")); // 弹出提示
         return false;
      }
      
      override public function onDown(key:int) : void
      {
         super.onDown(key);
         switch(key - 65)
         {
            case 0:
               next(0);
               break;
            case 1:
               next(1);
               break;
            case 2:
               next(2);
               break;
            case 3:
               next(3);
         }
      }
   }
}

