@IsTest
public class MatchTriggerHelperTest {
    
    @IsTest
    static void testRefereeStat() {
        Referee__c referee = TestDataClass.createReferee();
        Competition__c compt = TestDataClass.createCompetition();
        Team__c homeTeam = TestDataClass.createHomeTeam();
        Team__c visitorTeam = TestDataClass.createVisitorTeam();
        Match__c match = TestDataClass.createMatch(compt, referee, homeTeam, visitorTeam);
        Map<Id,Match__c> oldMap = new Map<Id,Match__c>{match.id => match};
        MatchStatistic__c[] statList = TestDataClass.refereeStats(match, homeTeam);
        List<Match__c> matches = new List<Match__c>();
        match.MatchComplete__c = true;
        matches.add(match);        
        update match;

        Test.startTest();
        MatchTriggerHelper.refereeStatistic(matches, oldMap);
        Test.stopTest();

        List<Referee__c> refList = [SELECT Fouls__c, YellowCards__c, RedCards__c FROM Referee__c WHERE Id = :referee.Id];
        for (Referee__c r: refList) {
            System.assertEquals(12, (Decimal) r.get('Fouls__c'));
            System.assertEquals(1, (Decimal) r.get('YellowCards__c'));
            System.assertEquals(0, (Decimal) r.get('RedCards__c'));
        }
    }
    
    @IsTest
    static void testTeamsStatistic() {
        Referee__c referee = TestDataClass.createReferee();
        Competition__c compt = TestDataClass.createCompetition();
        Team__c homeTeam = TestDataClass.createHomeTeam();
        Team__c visitorTeam = TestDataClass.createVisitorTeam();
        Match__c match = TestDataClass.createMatch(compt, referee, homeTeam, visitorTeam);
        Map<Id,Match__c> oldMap = new Map<Id,Match__c>{match.id => match};
        MatchStatistic__c[] homeTeamStats = TestDataClass.homeTeamStats(match, homeTeam);
        MatchStatistic__c[] visitorTeamStats = TestDataClass.visitorTeamStats(match, visitorTeam);
        List<Match__c> matches = new List<Match__c>();
        match.MatchComplete__c = true;
        matches.add(match);        
        update match;

        Test.startTest();
        MatchTriggerHelper.teamsStatistic(matches, oldMap);
        Test.stopTest();

        List<TeamStatistic__c> homeStatList = [SELECT Possesion__c FROM TeamStatistic__c WHERE Match__c = :match.Id AND Team__c = :homeTeam.id];
        for (TeamStatistic__c hs: homeStatList) {
            System.assertEquals(60, (Decimal) hs.get('Possesion__c'));
        }
        List<TeamStatistic__c> visitorStatList = [SELECT Possesion__c FROM TeamStatistic__c WHERE Match__c = :match.Id AND Team__c = :visitorTeam.id];
        for (TeamStatistic__c vs: visitorStatList) {
            System.assertEquals(40, (Decimal) vs.get('Possesion__c'));
        }
    }
}

   