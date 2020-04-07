@IsTest
public class teamDisciplineTest {

    @IsTest
    static void testTeamFoulsStat() {
        Referee__c referee = TestDataClass.createReferee();
        Competition__c compt = TestDataClass.createCompetition();
        Team__c homeTeam = TestDataClass.createHomeTeam();
        Team__c visitorTeam = TestDataClass.createVisitorTeam();
        Match__c match = TestDataClass.createMatch(compt, referee, homeTeam, visitorTeam);
        TeamStatistic__c[] teamStatList = TestDataClass.teamStatList(match, homeTeam, visitorTeam);
        String str = match.id;

        Test.startTest();
        List<TeamStatistic__c> teamStat = teamDiscipline.getTeamFoulsStat(str);
        Test.stopTest();
        
        System.assertEquals(2, teamStat.size());


    }
}