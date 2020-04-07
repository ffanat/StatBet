@IsTest
public class MatchStatisticTriggerHelperTest {

    @IsTest
    static void tesTeamGoals() {
        Referee__c referee = TestDataClass.createReferee();
        Competition__c compt = TestDataClass.createCompetition();
        Team__c homeTeam = TestDataClass.createHomeTeam();
        Team__c visitorTeam = TestDataClass.createVisitorTeam();
        Match__c match = TestDataClass.createMatch(compt, referee, homeTeam, visitorTeam);
        MatchStatistic__c[] homeTeamGoals = TestDataClass.homeTeamGoalStats(match, homeTeam);
        MatchStatistic__c[] visitorTeamGoals = TestDataClass.visitorTeamGoalStats(match, visitorTeam);

        Test.startTest();
        MatchStatisticTriggerHelper.teamGoals(homeTeamGoals);
        Test.stopTest();

        List<Match__c> mch = [SELECT HomeGol__c, VisitorGol__c FROM Match__c WHERE Id =: match.Id];
        for (Match__c m: mch) {
            System.assertEquals(4, (Decimal) m.get('HomeGol__c'));
            System.assertEquals(3, (Decimal) m.get('VisitorGol__c'));            
        }
    }

}