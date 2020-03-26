trigger TeamStatisticTrigger on TeamStatistic__c (before insert, after insert, 
  before update, after update, 
  before delete, after delete) {
    
    if (Trigger.isBefore) {
        // Call class logic here!  
    } 
    if (Trigger.isUpdate) {
      // Call class logic here!
        
    }
    if (Trigger.isDelete) {
      // Call class logic here!
    }
  

  if (Trigger.IsAfter) {
    if (Trigger.isInsert) {
        TeamStatisticTriggerHelper.teamGoals(Trigger.new);
      //Call class logic here!
       
      
    } 
    if (Trigger.isUpdate) {       
       // Call class logic here! 
    }
    if (Trigger.isDelete) {
      // Call class logic here!
    }
  }

}