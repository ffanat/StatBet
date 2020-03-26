public class TeamStatisticTriggerHelper {

    public static void teamGoals (List<TeamStatistic__c> teamStats) {
        Set<Id> matchIds = new Set<Id>();
        List<TeamGoals__c> teamGoalsList = new List<TeamGoals__c>();
        // Build Set with Id`s of matches to which tne new team statistic refer
        for (TeamStatistic__c ts: teamStats) {
            if (String.isNotBlank(ts.Match__c) && String.isNotBlank(ts.Team__c)) {
                matchIds.add(ts.Match__c);
            }
        }
        // Return if matches not found (Set matchIds is empty)
        if(matchIds.isEmpty()) {
            return;
        }
        // Find goal statistics for selected matches
        List<MatchStatistic__c> goalStats = [
            SELECT Match__c, Team__c, ShotPosition__c, ShotResistance__c, Minute__c, Assist__c, CornerOrFreeKick__c, Penalti__c
            FROM MatchStatistic__c
            WHERE Match__c IN :matchIds AND EventType__c = 'Shot'
        ];
        // Create list with inserting statistic of team goals
        for (MatchStatistic__c ms: goalStats) {
            // Add details of goal if it scored after teammates pass
            if (ms.Assist__c) {
                teamGoalsList.add(new TeamGoals__c(
                    Match__c = ms.Match__c, Team__c = ms.Team__c, Minute__c = ms.Minute__c, OpponentResistance__c = ms.ShotResistance__c,
                    PlayerPosition__c = ms.ShotPosition__c, GoalDetails__c = 'Goal After Teammate Pass'));
            }
            // Add details of goal if it scored after corner or free kick
            if (ms.CornerOrFreeKick__c) {
                teamGoalsList.add(new TeamGoals__c(
                    Match__c = ms.Match__c, Team__c = ms.Team__c, Minute__c = ms.Minute__c, OpponentResistance__c = ms.ShotResistance__c,
                    PlayerPosition__c = ms.ShotPosition__c, GoalDetails__c = 'Goal After Corner Or Fre Kick'));
            }
            // Add details of goal if it scored after penalty 
            if (ms.Penalti__c) {
                teamGoalsList.add(new TeamGoals__c(
                    Match__c = ms.Match__c, Team__c = ms.Team__c, Minute__c = ms.Minute__c, OpponentResistance__c = ms.ShotResistance__c,
                    PlayerPosition__c = ms.ShotPosition__c, GoalDetails__c = 'Goal After Penalty Kick'));
            } if(ms.Assist__c == false && ms.CornerOrFreeKick__c == false && ms.Penalti__c == false) {
                teamGoalsList.add(new TeamGoals__c(
                Match__c = ms.Match__c, Team__c = ms.Team__c, Minute__c = ms.Minute__c, OpponentResistance__c = ms.ShotResistance__c,
                PlayerPosition__c = ms.ShotPosition__c));
            } 
        }
        // Insert team goals statistic
        insert teamGoalsList;
    }
}