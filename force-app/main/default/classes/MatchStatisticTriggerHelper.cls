public class MatchStatisticTriggerHelper {

    public static void teamGoals (List<MatchStatistic__c> matchStats) {
        Set<Id> matchIds = new Set<Id>();
        Set<Id> teamIds = new Set<Id>();
        List<Match__c> matchList = new List<Match__c>();
        Map<Id, Integer> teamTotGols = new Map<Id, Integer>();
        // Build Set with Id`s of matches with statistic event
        for (MatchStatistic__c mst: matchStats) {
            if (String.isNotBlank(mst.Team__c) && mst.GoalkeeperAction__c == '3') {
                matchIds.add(mst.Match__c);
                teamIds.add(mst.Team__c);           
            }
        }
        // Return if matches not found (Set matchIds is empty)
        if(matchIds.isEmpty()) {
            return;
        }
        // Count gols for each team in matches that have statistic event
        List<AggregateResult> result = [
            SELECT count(Id) gols, Team__c team
            FROM MatchStatistic__c 
            WHERE Match__c IN :matchIds AND GoalkeeperAction__c = '3' 
            GROUP BY Team__c];
        // Create map with id and number of gols for all teams
        for(AggregateResult aggRes :result) {                
            teamTotGols.put((Id)aggRes.get('team'), (Integer) aggRes.get('gols'));
        }
        // Find matches with statistic events
        List<Match__c> matches = [
            SELECT HomeTeam__c, Visitors__c, HomeGol__c, VisitorGol__c 
            FROM Match__c 
            WHERE Id IN :matchIds];
        // Create list with updating matches
        for (Match__c m: matches) {
            for (Id tId: teamIds) {
                if (tId == m.HomeTeam__c) {
                    matchList.add(new Match__c(Id = m.Id, HomeGol__c = teamTotGols.get(tId)));   
                } else {
                    matchList.add(new Match__c(Id = m.Id, VisitorGol__c = teamTotGols.get(tId)));
                }                    
            }
        }
        // Update matches
        update matchList;
    }    
}