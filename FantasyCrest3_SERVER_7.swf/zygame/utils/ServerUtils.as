package zygame.utils
{
   import flash.net.Socket;
   import flash.net.SharedObject; //
   import zygame.server.BaseSocketClient;
   import zygame.server.Service;
   
   public class ServerUtils
   {
      
      public static var ip:String = "";
      
      public static var sending:Boolean = false;
      
      public function ServerUtils()
      {
         super();
      }
      
      public static function updateRoleData(userName:String, userCode:String, userData:Object, onUpdate:Function) : void
      {
         onUpdate(Service.userData); //
         // var clinet:BaseSocketClient;
         // if(sending)
         // {
         //    return;
         // }
         // sending = true;
         // clinet = createSocket(userName,userCode,onUpdate);
         // clinet.dataFunc = function(data:Object):void
         // {
         //    if(data.type == "handed")
         //    {
         //       clinet.send({
         //          "type":"update_user_data",
         //          "userData":userData
         //       });
         //    }
         //    else if(data.type == "user_data")
         //    {
         //       sending = false;
         //       onUpdate(data.data);
         //       clinet.close();
         //    }
         // };
      }
      
      public static function buyRole(userName:String, userCode:String, roleName:String, target:String, coin:int, type:int, onUpdate:Function, mail:String = null) : void
      {
         if(type) //
         { //
            // if(Service.userData.crystal + coin >= 0) //
            if(true) //
            { //
               Service.userData.crystal += coin; //
               Service.userData.userData.buys.push(target) //
               onUpdate(Service.userData); //
            } //
            else //
            { //
               onUpdate(null); //
            } //
         }
         else
         {
            // if(Service.userData.coin + coin >= 0) //
            if(true) //
            { //
               Service.userData.coin += coin; //
               Service.userData.userData.buys.push(target) //
               onUpdate(Service.userData); //
            } //
            else //
            { //
               onUpdate(null); //
            } //
         } //
         SharedObject.getLocal("net.zygame.hxwz.air").data.userData = Service.userData; //缓存userData
         // var clinet:BaseSocketClient;
         // if(sending)
         // {
         //    return;
         // }
         // sending = true;
         // clinet = createSocket(userName,userCode,onUpdate);
         // clinet.dataFunc = function(data:Object):void
         // {
         //    if(data.type == "handed")
         //    {
         //       clinet.send({
         //          "type":"buyRole",
         //          "coin":coin,
         //          "coinType":type,
         //          "roleTarget":target,
         //          "roleName":target,
         //          "mail":mail
         //       });
         //    }
         //    else if(data.type == "user_data")
         //    {
         //       sending = false;
         //       onUpdate(data.data);
         //       clinet.close();
         //    }
         // };
      }
      
      public static function transferMoney(userName:String, userCode:String, coin:int, coinType:int, mail:String, onUpdate:Function) : void
      {
         onUpdate(Service.userData); //
         // var clinet:BaseSocketClient;
         // if(sending)
         // {
         //    return;
         // }
         // sending = true;
         // clinet = createSocket(userName,userCode,onUpdate);
         // clinet.dataFunc = function(data:Object):void
         // {
         //    if(data.type == "handed")
         //    {
         //       clinet.send({
         //          "type":"transferMoney",
         //          "coin":coin,
         //          "mail":mail,
         //          "coinType":coinType
         //       });
         //    }
         //    else if(data.type == "user_data")
         //    {
         //       sending = false;
         //       onUpdate(data.data);
         //       clinet.close();
         //    }
         // };
      }
      
      public static function addCoin(userName:String, userCode:String, coin:int, onUpdate:Function, codeType:String = "addCoin") : void
      {
         Service.userData.coin += coin; //
         SharedObject.getLocal("net.zygame.hxwz.air").data.userData = Service.userData; //缓存userData
         onUpdate(Service.userData); //
         // var clinet:BaseSocketClient;
         // if(sending)
         // {
         //    return;
         // }
         // sending = true;
         // clinet = createSocket(userName,userCode,onUpdate);
         // clinet.dataFunc = function(data:Object):void
         // {
         //    if(data.type == "handed")
         //    {
         //       clinet.send({
         //          "type":codeType,
         //          "coin":coin
         //       });
         //    }
         //    else if(data.type == "user_data")
         //    {
         //       sending = false;
         //       onUpdate(data.data);
         //       clinet.close();
         //    }
         // };
      }
      
      private static function createSocket(userName:String, userCode:String, onUpdate:Function) : BaseSocketClient
      {
         onUpdate(Service.userData); //
         return null; //
         // var socket:Socket = new Socket(ip,4888);
         // var clinet:BaseSocketClient = new BaseSocketClient(socket);
         // clinet.handFunc = function():void
         // {
         //    trace("握手");
         //    clinet.send(SendDataUtils.handData(userName,userCode));
         // };
         // clinet.ioerrorFunc = function():void
         // {
         //    trace("登录失败");
         //    sending = false;
         //    onUpdate(null);
         // };
         // clinet.closeFunc = function():void
         // {
         //    trace("登录失败");
         //    sending = false;
         //    onUpdate(null);
         // };
         // return clinet;
      }
   }
}

