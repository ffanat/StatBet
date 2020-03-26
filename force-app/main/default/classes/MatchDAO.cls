public class MatchDAO {
    // Method return list of referee for curent match
    public static List<Referee__c> refereeList(Id matchId) {
        // Find referee for curent match
        Match__c m = [
            SELECT Referee__c
            FROM Match__c
            WHERE Id = :matchId 
        ];
        // Get the referee Id
        Id refId = m.Referee__c;
        // Find referee information and statistic 
        List<Referee__c> ref = [
            SELECT Name__c, Fouls__c, YellowCards__c, RedCards__c
            FROM Referee__c
            WHERE Id = :refId 
        ];
        return ref;
    }

    // Method return type of statisic indexes for curent match
    @AuraEnabled
    public static List<MatchStatistic__c> getEventTypeList(Id matchId) {
        Match__c match = [
            SELECT Visitors__c 
            FROM Match__c 
            WHERE Id = :matchId];        
        String team = match.Visitors__c;
        // Find type of statistic index for curent match
        List<MatchStatistic__c> eventTypeList = [
            SELECT EventType__c
            FROM MatchStatistic__c
            WHERE Match__c = :matchId AND Team__c = :team AND EventType__c != 'Shot'
            ORDER BY EventType__c ASC
        ];
        return eventTypeList;
    }

    // Method return value of statisic indexes for home team
    @AuraEnabled
    public static List<MatchStatistic__c> getHomeStat(Id matchId) {
        // Find home team for curent match
        Match__c match = [
            SELECT HomeTeam__c 
            FROM Match__c 
            WHERE Id = :matchId];
        // Get Id of match home team    
        String team = match.HomeTeam__c;
        // Find type and value of statistic indexes of home team for curent match
        List<MatchStatistic__c> stat = [
            SELECT EventType__c, EventValue__c
            FROM MatchStatistic__c
            WHERE Match__c = :matchId AND Team__c = :team AND EventType__c != 'Shot'
            ORDER BY EventType__c ASC
        ];
        return stat;
    }

    // Method return value of statisic indexes for visitor team 
    @AuraEnabled
    public static List<MatchStatistic__c> getVisitorStat(Id matchId) {
        // Find visitor team for curent match
        Match__c match = [
            SELECT Visitors__c 
            FROM Match__c 
            WHERE Id = :matchId];
        // Get Id of match visitor team
        String team = match.Visitors__c;
        // Find type and value of statistic indexes of visitor team for curent match
        List<MatchStatistic__c> stat = [
            SELECT EventType__c, EventValue__c
            FROM MatchStatistic__c
            WHERE Match__c = :matchId AND Team__c = :team AND EventType__c != 'Shot'
            ORDER BY EventType__c ASC
        ];
        return stat;
    }

    // Method return names of match participated teams for aura component header
    @AuraEnabled
    public static List<Match__c> getMatchTeams(Id matchId) {
        // Find names of match participated teams
        List<Match__c> matchTeams = [
            SELECT Name, HomeTeam__r.Name, Visitors__r.Name
            FROM Match__c
            WHERE Id = :matchId
        ];
        return matchTeams;
    }

}