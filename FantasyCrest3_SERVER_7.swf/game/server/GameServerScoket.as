package game.server
{
   import zygame.server.GameServer;
   import zygame.utils.IPUtils;
   
   public class GameServerScoket
   {
      private static var _server:GameServer; //
      
      public function GameServerScoket()
      {
         super();
      }
      
      public static function init() : void
      {
         // var server:GameServer = new GameServer(ip,4888);
         if (!_server) //
         { //
            _server = new GameServer(ip, 4888); //
         } //
      }

      public static function get ip() : String
      {
         return "127.0.0.1"; //
         return IPUtils.currentIP;
      }

      public static function get server():GameServer //
      { //
         return _server; //
      } //
   }
}

