package game.data
{
   import flash.net.SharedObject;
   import zygame.server.Service;
   
   public class ServiceHold
   {
      
      public var isLog:Object;
      
      public function ServiceHold()
      {
         super();
         if(!Service.userData)
         {
            Service.userData = {_4399userData:[]};
         }
         isLog = Service.userData._4399userData;
      }
      
      public function getData(bul:Boolean, index:int) : Object
      {
         isLog = Service.userData._4399userData;
         if(isLog)
         {
            return isLog[index];
         }
         return {};
      }
      
      public function saveData(name:String, data:Object, bul:Boolean, index:int) : void
      {
         if(name == "幻想纹章存档")
         {
            isLog = Service.userData._4399userData;
            isLog[index].allFight = data.allFight;
            Service.userData.userData.allFight = data.allFight;
            isLog[index].fight = data.fight;
            Service.userData.userData.fight = data.fight;
            isLog[index].vip = data.vip;
            Service.userData.userData.vip = data.vip;
            isLog[index].version = data.version;
            Service.userData.userData.version = data.version;
            isLog[index].fbs = data.fbs;
            Service.userData.userData.fbs = data.fbs;
            Service.userData._4399userData[index] = isLog[index];
            SharedObject.getLocal("net.zygame.hxwz.air").data.userData = Service.userData;
         }
      }
      
      public function submitScoreToRankLists(index:int, scores:Array) : void
      {
      }
      
      public function getRankListsData(rankid:int, pageSize:int, page:int) : void
      {
      }
      
      public function getOneRankInfo(rankid:int, userName:String) : void
      {
      }
   }
}

