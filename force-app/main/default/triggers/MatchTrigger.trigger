trigger MatchTrigger on Match__c (before insert, after insert, 
  before update, after update, 
  before delete, after delete) {
    
    if (Trigger.isBefore) {
      MatchTriggerHelper.refereeStatistic(Trigger.new);     
    } 
    if (Trigger.isUpdate) {
      // Call class logic here!
        
    }
    if (Trigger.isDelete) {
      // Call class logic here!
    }
  

  if (Trigger.IsAfter) {
    if (Trigger.isInsert) {
      //Call class logic here!
       
      
    } 
    if (Trigger.isUpdate) {
      MatchTriggerHelper.homeTeamStatistic(Trigger.new, Trigger.oldMap);            
       // Call class logic here! 
    }
    if (Trigger.isDelete) {
      // Call class logic here!
    }
  }

}