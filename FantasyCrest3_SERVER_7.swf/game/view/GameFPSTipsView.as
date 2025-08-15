package game.view
{
   import game.uilts.GameFont;
   import starling.display.Button;
   import starling.display.Quad;
   import starling.events.Event;
   import starling.text.TextField;
   import starling.text.TextFormat;
   import starling.textures.Texture;
   import zygame.core.DataCore;
   import zygame.core.SceneCore; // 导入SceneCore用于弹出提示
   import zygame.display.DisplayObjectContainer;
   
   public class GameFPSTipsView extends DisplayObjectContainer
   {
      
      public function GameFPSTipsView()
      {
         super();
      }
      
      override public function onInit() : void
      {
         var bg:Quad;
         var text:TextField;
         var skin:Texture;
         var button:Button;
         super.onInit();
         bg = new Quad(stage.stageWidth,stage.stageHeight,0);
         this.addChild(bg);
         bg.alpha = 0.7;
         text = new TextField(stage.stageWidth - 100,stage.stageHeight - 100,"",new TextFormat(GameFont.FONT_NAME,18,16777215,"left"));
         // 原本的提示文本
         // text.text = "关于游戏会卡的解决方案：\n掉帧的原因：\n游戏没有启动硬件加速，因此导致掉帧，只要开启硬件加速或者使用默认启动硬件加速的浏览器进行游戏即可得到流畅体验。\n\n方案1：\n1、选择Internet Explorer浏览器或者其他浏览器进行游戏。\n\n方案2：\n1、右键游戏窗口，点击设置。\n2、弹出小窗口后，选择最左边的选项，开启硬件加速。\n3、刷新页面重启游戏。\n4、如果失败，请转试用方案1。";
         text.text = "幻想纹章3本地版0.4\n\n这是一个由多位幻想纹章爱好者共同协助逆向得到的版本。历时两个月的研究，我们终于得到一个可玩的版本\n\n感谢@IS 和@碎风 的指路，感谢@风吟棠华落 提供数据解密方法，感谢@忆雪 提供的角色指导，感谢@正义永无止境 提供真幻想纹章3本地版\n\n再次感谢所有幻想纹章爱好者的支持，如果你不是免费得到的该版本，请立刻举报\n\n幻想纹章3交流群：1055702064"; // 修改为版本介绍
         this.addChild(text);
         text.x = 50;
         skin = DataCore.getTextureAtlas("start_main").getTexture("btn_style_1");
         button = new Button(skin,"我知道了");
         this.addChild(button);
         button.textFormat.size = 18;
         button.x = stage.stageWidth / 2 - button.width / 2;
         button.y = stage.stageHeight - button.height * 2 - 16;
         button.addEventListener("triggered",function(e:Event):void
         {
            removeFromParent(true);
         });
         button1 = new Button(skin,"一键购买所有角色"); // 添加一键购买所有角色按钮
         this.addChild(button1); //
         button1.textFormat.size = 18; //
         button1.x = button.x - button1.width - 16; //
         button1.y = stage.stageHeight - button1.height * 2 - 16; //
         button1.addEventListener("triggered",function(e:Event):void //
         {
            removeFromParent(true);
            SceneCore.pushView(new GameTestView()); // 弹出一键购买所有角色测试视图
         }); //
         button2 = new Button(skin,"版本介绍"); // 添加版本介绍按钮
         this.addChild(button2); //
         button2.textFormat.size = 18; //
         button2.x = button.x + button2.width + 16; //
         button2.y = stage.stageHeight - button2.height * 2 - 16; //
         button2.addEventListener("triggered",function(e:Event):void //
         { //
            text.text = "幻想纹章3本地版0.4更新内容：\n\n1、添加角色：布罗利「TYRANNICAL」(纹4)(未完成)、贝吉塔、孙悟空·超级赛亚人\n\n2、添加npc：道士、翘曲传送门\n\n3、修复角色：布罗利「TYRANNICAL」(纹4) 立绘、布罗利「TYRANNICAL」(纹4) 头像、贝吉塔 立绘、贝吉塔 头像、孙悟空·超级赛亚人 立绘、孙悟空·超级赛亚人 头像、优子 立绘、优子 头像、猪人 头像、白金 立绘、赛莉卡 立绘、天之咒印·佐助 立绘、夏目麻衣 立绘、破坏神·须佐之男 立绘、琥珀响 立绘、乔瑟夫·乔斯达 立绘、pop子 立绘、pop子 头像、大魔导师-奈茵 立绘、哈扎吗 立绘、Yang Xiaolong 立绘、Ruby 立绘、志志雄真实(纹4) 被动\n\n4、添加副本：syzlb（未命名，现征集副本名称）\n\n5、添加功能：导出存档(主菜单右上角按钮)，导入存档(登录界面注册按钮)\n\n6、修复问题：pvp战绩败局不记录\n\n7、角色调整：增强如月琴恩伤害至0.65\n\n"; //
         }); //
      }
   }
}

