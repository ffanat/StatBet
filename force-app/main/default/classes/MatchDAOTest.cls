@IsTest
public class MatchDAOTest {

    @IsTest
    static void testRefereeList() {
        Referee__c referee = TestDataClass.createReferee();
        Competition__c compt = TestDataClass.createCompetition();
        Team__c homeTeam = TestDataClass.createHomeTeam();
        Team__c visitorTeam = TestDataClass.createVisitorTeam();
        Match__c match = TestDataClass.createMatch(compt, referee, homeTeam, visitorTeam);
            
        Test.startTest();
        	List<Referee__c> refList = MatchDAO.refereeList(match.id);
        Test.stopTest();
        
        System.assertEquals(1, refList.size());

    }

    @IsTest
    static void testEventTypeList() {
        Referee__c referee = TestDataClass.createReferee();
        Competition__c compt = TestDataClass.createCompetition();
        Team__c homeTeam = TestDataClass.createHomeTeam();
        Team__c visitorTeam = TestDataClass.createVisitorTeam();
        Match__c match = TestDataClass.createMatch(compt, referee, homeTeam, visitorTeam);
        List<MatchStatistic__c> statList = TestDataClass.visitorTeamStats(match, visitorTeam);

        Test.startTest();
        	List<MatchStatistic__c> matchStatList = MatchDAO.getEventTypeList(match.Id);
        Test.stopTest();
        
        System.assertEquals(3, matchStatList.size());
    }

    @IsTest
    static void testHomeStatList() {
        Referee__c referee = TestDataClass.createReferee();
        Competition__c compt = TestDataClass.createCompetition();
        Team__c homeTeam = TestDataClass.createHomeTeam();
        Team__c visitorTeam = TestDataClass.createVisitorTeam();
        Match__c match = TestDataClass.createMatch(compt, referee, homeTeam, visitorTeam);
        MatchStatistic__c[] statList = TestDataClass.homeTeamStats(match, homeTeam);

        Test.startTest();
        	List<MatchStatistic__c> matchStatList = MatchDAO.getHomeStat(match.Id);
        Test.stopTest();
        
        System.assertEquals(3, matchStatList.size());
    }

    @IsTest
    static void testVisitorStatList() {
        Referee__c referee = TestDataClass.createReferee();
        Competition__c compt = TestDataClass.createCompetition();
        Team__c homeTeam = TestDataClass.createHomeTeam();
        Team__c visitorTeam = TestDataClass.createVisitorTeam();
        Match__c match = TestDataClass.createMatch(compt, referee, homeTeam, visitorTeam);
        MatchStatistic__c[] statList = TestDataClass.visitorTeamStats(match, visitorTeam);

        Test.startTest();
        	List<MatchStatistic__c> matchStatList = MatchDAO.getVisitorStat(match.Id);
        Test.stopTest();
        
        System.assertEquals(3, matchStatList.size());
    }

    @IsTest
    static void testMatchTeamsList() {      
        Referee__c referee = TestDataClass.createReferee();
        Competition__c compt = TestDataClass.createCompetition();
        Team__c homeTeam = TestDataClass.createHomeTeam();
        Team__c visitorTeam = TestDataClass.createVisitorTeam();
        Match__c match = TestDataClass.createMatch(compt, referee, homeTeam, visitorTeam);

        Test.startTest();
        	List<Match__c> matchList = MatchDAO.getMatchTeams(match.Id);
        Test.stopTest();
        
        System.assertEquals(1, matchList.size());
    }
}
