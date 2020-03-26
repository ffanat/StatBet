trigger MatchStatisticTrigger on MatchStatistic__c (before insert, after insert, 
  before update, after update, 
  before delete, after delete) {
    
    if (Trigger.isBefore) {
        //Call class logic here!        
    } 
    if (Trigger.isUpdate) {
      // Call class logic here!
        
    }
    if (Trigger.isDelete) {
      // Call class logic here!
    }
  

  if (Trigger.IsAfter) {
    if (Trigger.isInsert) {
      MatchStatisticTriggerHelper.teamGoals(Trigger.new);
      //MatchStatisticTriggerHelper.refereeStatistic(Trigger.new);
    } 
    if (Trigger.isUpdate) {
      // Call class logic here!
    }
    if (Trigger.isDelete) {
      // Call class logic here!
    }
  }

}