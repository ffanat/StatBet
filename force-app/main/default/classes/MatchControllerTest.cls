@IsTest
public class MatchControllerTest {

    @IsTest
    static void testList() {
        Test.setCurrentPage(Page.refereeInfo);
        Referee__c referee = TestDataClass.createReferee();
        Competition__c compt = TestDataClass.createCompetition();
        Team__c homeTeam = TestDataClass.createHomeTeam();
        Team__c visitorTeam = TestDataClass.createVisitorTeam();
        Match__c match = TestDataClass.createMatch(compt, referee, homeTeam, visitorTeam);

        ApexPages.StandardController stdController = new ApexPages.StandardController(match);
        MatchController matchController = new MatchController(stdController);
        
        Test.startTest();
        	List<Referee__c> refList = matchController.getRefereeList();
        Test.stopTest();
        
        System.assertEquals(1, refList.size());
    }
}