public class MatchTriggerHelper {

    public static void refereeStatistic (List<Match__c> matches) {
        Set<Id> refIds = new Set<Id>();
        List<Referee__c> refList = new List<Referee__c>();
        Map<Id, Decimal> avgRefFouls = new Map<Id, Decimal>();
        Map<Id, Decimal> avgRefYellows = new Map<Id, Decimal>();
        Map<Id, Decimal> avgRefReds = new Map<Id, Decimal>();
        // Build Set with Id`s of referees
        for (Match__c match: matches) {
            refIds.add(match.Referee__c);
        }
        // Return if referees not found (Set refIds is empty)
        if(refIds.isEmpty()) {
            return;
        }
        // List of matches in which referee participate
        List<Match__c> matchList = [
            SELECT StartDateTime__c
            FROM Match__c
            WHERE Referee__c IN :refIds];
        // Count total fouls commited in matches which referee participate
        List<AggregateResult> refFouls = [
            SELECT SUM(EventValue__c) fouls, Match__r.Referee__c ref
            FROM MatchStatistic__c 
            WHERE Match__r.Referee__c IN :refIds AND EventType__c = 'Fouls'
            GROUP BY Match__r.Referee__c];
            // Add referee Id and average fouls to map
            for(AggregateResult aggRes :refFouls) {
                avgRefFouls.put((Id)aggRes.get('ref'), (Decimal) aggRes.get('fouls') / matchList.size());
            }
        // Count total yellow cards show in matches which referee participate 
        List<AggregateResult> refYellows = [
            SELECT SUM(EventValue__c) yellows, Match__r.Referee__c ref
            FROM MatchStatistic__c 
            WHERE Match__r.Referee__c IN :refIds AND EventType__c = 'Yellow Card'
            GROUP BY Match__r.Referee__c];
            // Add referee Id and average yellow cards to map
            for(AggregateResult aggRes :refYellows) {
                avgRefYellows.put((Id)aggRes.get('ref'), (Decimal) aggRes.get('yellows') / matchList.size());
            }
        // Count total red cards show in matches which referee participate
        List<AggregateResult> refReds = [
            SELECT SUM(EventValue__c) reds, Match__r.Referee__c ref
            FROM MatchStatistic__c 
            WHERE Match__r.Referee__c IN :refIds AND EventType__c = 'Red Card'
            GROUP BY Match__r.Referee__c];
            // Add referee Id and average red cards to map
            for(AggregateResult aggRes :refReds) {
                avgRefReds.put((Id)aggRes.get('ref'), (Decimal) aggRes.get('reds') / matchList.size());
            }
        // Create list with updating referees
        for (Id rId: refIds) {
            refList.add(new Referee__c(Id = rId, 
            Fouls__c = avgRefFouls.get(rId), YellowCards__c = avgRefYellows.get(rId), RedCards__c = avgRefReds.get(rId)));
        }
        // Update referees
        update refList;
    }

    public static void homeTeamStatistic (List<Match__c> matches, Map<Id, Match__c> oldMap) {
        List<TeamStatistic__c> teamStat = new List<TeamStatistic__c>();
        Map<String,Decimal> homeTeamStatistic = new Map<String,Decimal>();
        Map<String,Decimal> visitorTeamStatistic = new Map<String,Decimal>();
        List<Id> matchIds = new List<Id>();
        List<Id> homeTeamIds = new List<Id>();
        List<Id> visitorTeamIds = new List<Id>();
        // Build Set with Id`s of matches, home teams and visitor teams when Match__c record update
        for (Match__c match :matches) {
            if (match.MatchComplete__c == true) {
                matchIds.add(match.Id);
                homeTeamIds.add(match.HomeTeam__c);
                visitorTeamIds.add(match.Visitors__c);
            }
        }
        // Find home team statistics for selected matches
        List<MatchStatistic__c> homeTeamStats = [
            SELECT EventType__c, EventValue__c
            FROM MatchStatistic__c
            WHERE Match__c IN :matchIds AND Team__c IN :homeTeamIds AND EventType__c != 'Shot'
        ];
        // Create map with type and value of statistic indexes for home teams
        for (MatchStatistic__c homeStat: homeTeamStats) {
            homeTeamStatistic.put((String)homeStat.get('EventType__c'), (Decimal)homeStat.get('EventValue__c'));
        }
        // Find visitor team statistics for selected matches
        List<MatchStatistic__c> visitorTeamStats = [
            SELECT EventType__c, EventValue__c
            FROM MatchStatistic__c
            WHERE Match__c IN :matchIds AND Team__c IN :visitorTeamIds AND EventType__c != 'Shot'
        ];
        // Create map with type and value of statistic indexes for home teams
        for (MatchStatistic__c visitorStat: visitorTeamStats) {
            visitorTeamStatistic.put((String)visitorStat.get('EventType__c'), (Decimal)visitorStat.get('EventValue__c'));
        }
        // Create list with inserting team statistic if the MatchComplete__c field set to true
        for (Match__c m :matches) {        
            if (m.MatchComplete__c == true && oldMap.get(m.Id).MatchComplete__c == false) {
                // Add statistic for match home team
                teamStat.add(new TeamStatistic__c(
                Match__c = m.Id, Team__c = m.HomeTeam__c, Possesion__c = homeTeamStatistic.get('Possesion'), 
                TotalShots__c = homeTeamStatistic.get('Total Shots'), ShotsOnTarget__c = homeTeamStatistic.get('Shots On Target'),
                Fouls__c = homeTeamStatistic.get('Fouls'), Corners__c = homeTeamStatistic.get('Corners'),
                TotalPasses__c = homeTeamStatistic.get('Total Passes'), CompletedPasses__c = homeTeamStatistic.get('Completed Passes'),
                YellowCard__c = homeTeamStatistic.get('Yellow Card'), RedCard__c = homeTeamStatistic.get('Red Card'),
                Offsides__c = homeTeamStatistic.get('Offsides'), TeamGoals__c = m.HomeGol__c, OpponentGoals__c = m.VisitorGol__c));
                // Add statistic for match visior team
                teamStat.add(new TeamStatistic__c(
                Match__c = m.Id, Team__c = m.Visitors__c, Possesion__c = visitorTeamStatistic.get('Possesion'), 
                TotalShots__c = visitorTeamStatistic.get('Total Shots'), ShotsOnTarget__c = visitorTeamStatistic.get('Shots On Target'),
                Fouls__c = visitorTeamStatistic.get('Fouls'), Corners__c = visitorTeamStatistic.get('Corners'),
                TotalPasses__c = visitorTeamStatistic.get('Total Passes'), CompletedPasses__c = visitorTeamStatistic.get('Completed Passes'),
                YellowCard__c = visitorTeamStatistic.get('Yellow Card'), RedCard__c = visitorTeamStatistic.get('Red Card'),
                Offsides__c = visitorTeamStatistic.get('Offsides'), TeamGoals__c = m.VisitorGol__c, OpponentGoals__c = m.HomeGol__c));
            }        
        }
        // Insert list with statistic for teams participated in match
        insert teamStat;
    }
    
}