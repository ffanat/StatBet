@IsTest
public class TeamStatisticTriggerHelperTest {

    @IsTest
    static void testTeamGoals() {
        Referee__c referee = TestDataClass.createReferee();
        Competition__c compt = TestDataClass.createCompetition();
        Team__c homeTeam = TestDataClass.createHomeTeam();
        Team__c visitorTeam = TestDataClass.createVisitorTeam();
        Match__c match = TestDataClass.createMatch(compt, referee, homeTeam, visitorTeam);
        MatchStatistic__c[] homeTeamGoals = TestDataClass.homeTeamGoalStats(match, homeTeam);
        TeamStatistic__c[] teamStatList = TestDataClass.teamStatList(match, homeTeam, visitorTeam);
        
        Test.startTest();
        TeamStatisticTriggerHelper.teamGoals(teamStatList);
        Test.stopTest();

        List<TeamGoals__c> teamGoals = [
            SELECT Minute__c, PlayerPosition__c, OpponentResistance__c 
            FROM TeamGoals__c 
            WHERE Match__c = :match.id AND Team__c = :homeTeam.id AND Minute__c = 36];
        for (TeamGoals__c tgs: teamGoals) {
            System.assertEquals('Penalty Area', (String) tgs.get('PlayerPosition__c'));
            System.assertEquals('Medium', (String) tgs.get('OpponentResistance__c'));            
        }
        
        List<TeamGoals__c> teamGoalsAssist = [
            SELECT Minute__c, PlayerPosition__c, OpponentResistance__c, GoalDetails__c 
            FROM TeamGoals__c 
            WHERE Match__c = :match.id AND Team__c = :homeTeam.id  AND Minute__c = 47];
        for (TeamGoals__c tgs: teamGoalsAssist) {
            System.assertEquals('Goal After Teammate Pass', (String) tgs.get('GoalDetails__c'));
        }
        List<TeamGoals__c> teamGoalsCorner = [
            SELECT Minute__c, PlayerPosition__c, OpponentResistance__c, GoalDetails__c 
            FROM TeamGoals__c 
            WHERE Match__c = :match.id AND Team__c = :homeTeam.id  AND Minute__c = 58];
        for (TeamGoals__c tgs: teamGoalsCorner) {
            System.assertEquals('Goal After Corner Or Fre Kick', (String) tgs.get('GoalDetails__c'));         
        }
        List<TeamGoals__c> teamGoalsPenalty = [
            SELECT Minute__c, PlayerPosition__c, OpponentResistance__c, GoalDetails__c 
            FROM TeamGoals__c 
            WHERE Match__c = :match.id AND Team__c = :homeTeam.id  AND Minute__c = 89];
        for (TeamGoals__c tgs: teamGoalsPenalty) {
            System.assertEquals('Goal After Penalty Kick', (String) tgs.get('GoalDetails__c'));       
        }
    }
}