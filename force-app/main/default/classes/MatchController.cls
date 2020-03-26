public class MatchController {
    private Match__c match;
    public MatchController(ApexPages.StandardController stdController){
        match = (Match__c)stdController.getRecord();
    }
    // Get referee list for curent match
    public List<Referee__c> getRefereeList() {        
        List<Referee__c> refereeList = MatchDAO.refereeList(match.Id);
        return refereeList;
    }

}