public inherited sharing class teamDiscipline {
    @AuraEnabled(cacheable=true)
    public static List<TeamStatistic__c> getTeamFoulsStat(String matchId) {
        // Find home team and visitor team for curent match
        Match__c match = [
            SELECT HomeTeam__c, Visitors__c
            FROM Match__c
            WHERE Id = :matchId
        ];
        // Get Id`s of match participated teams
        String homeTeam = match.HomeTeam__c;
        String visitorTeam = match.Visitors__c;
        // Find statistic of fouls and cards for each team
        List<TeamStatistic__c> teamStats = [
            SELECT Id, Team__r.Name, Match__r.Name, Fouls__c, YellowCard__c, RedCard__c 
            FROM TeamStatistic__c
            WHERE Team__c = :homeTeam OR Team__c = :visitorTeam
            ORDER BY Team__c DESC
            LIMIT 10
        ];        
        return teamStats;
    }
}