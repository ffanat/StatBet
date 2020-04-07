@isTest
public class TestDataClass {

    public static Referee__c createReferee() {
        Referee__c referee = new Referee__c(
            Name__c = 'Test', 
            Country__c = 'Ukraine', 
            Fouls__c = 0,
            YellowCards__c = 0,
            RedCards__c = 0);
        insert referee;
        return referee;
    }

    public static Competition__c createCompetition() {
        Competition__c compt = new Competition__c(
            CompetitionType__c = 'Club',
            Organizer__c = 'UEFA',
            TournamentType__c = 'Champions League',
            TournamentName__c = 'Champions League 19/20'
        );
        insert compt;
        return compt;
    }

    public static Team__c createHomeTeam() {
        Team__c homeTeam = new Team__c(Name__c = 'Home', Type__c = 'Club Team');
        insert homeTeam;
        return homeTeam;
    }

    public static Team__c createVisitorTeam() {
        Team__c visitorTeam = new Team__c(Name__c = 'Visitor', Type__c = 'Club Team');
        insert visitorTeam;
        return visitorTeam;
    }
    
    public static Match__c createMatch(Competition__c compt, Referee__c referee, Team__c homeTeam, Team__c visitorTeam) {
        Match__c match = new Match__c(
            Competition__c = compt.Id,
            Referee__c = referee.Id,
            StartDateTime__c = Datetime.newInstance(Date.parse('27/12/2019'), Time.newInstance(18, 0, 0, 0)),
            HomeTeam__c = homeTeam.Id,
            Visitors__c = visitorTeam.Id,
            MatchComplete__c = false
        );
        insert match;
        return match;
    }

    public static List<MatchStatistic__c> visitorTeamStats(Match__c match, Team__c visitorTeam) {
        List<MatchStatistic__c> statList = new List<MatchStatistic__c>();
        MatchStatistic__c stat1 = new MatchStatistic__c(
            Match__c = match.id,
            Team__c = visitorTeam.id,
            EventType__c = 'Possesion',
            EventValue__c = 40
        );
        statList.add(stat1);
        MatchStatistic__c stat2 = new MatchStatistic__c(
            Match__c = match.id,
            Team__c = visitorTeam.id,
            EventType__c = 'Fouls',
            EventValue__c = 21
        );
        statList.add(stat2);
        MatchStatistic__c stat3 = new MatchStatistic__c(
            Match__c = match.id,
            Team__c = visitorTeam.id,
            EventType__c = 'Corners',
            EventValue__c = 4
        );
        statList.add(stat3);
        insert statList;
        return statList;
    }

    public static List<MatchStatistic__c> homeTeamStats (Match__c match, Team__c homeTeam) {
        List<MatchStatistic__c> statList = new List<MatchStatistic__c>();
        MatchStatistic__c stat1 = new MatchStatistic__c(
            Match__c = match.id,
            Team__c = homeTeam.id,
            EventType__c = 'Possesion',
            EventValue__c = 60
        );
        statList.add(stat1);
        MatchStatistic__c stat2 = new MatchStatistic__c(
            Match__c = match.id,
            Team__c = homeTeam.id,
            EventType__c = 'Fouls',
            EventValue__c = 13
        );
        statList.add(stat2);
        MatchStatistic__c stat3 = new MatchStatistic__c(
            Match__c = match.id,
            Team__c = homeTeam.id,
            EventType__c = 'Corners',
            EventValue__c = 8
        );
        statList.add(stat3);
        insert statList;
        return statList;
    }

    public static List<MatchStatistic__c> refereeStats (Match__c match, Team__c homeTeam) {
        List<MatchStatistic__c> statList = new List<MatchStatistic__c>();
        MatchStatistic__c stat1 = new MatchStatistic__c(
            Match__c = match.id,
            Team__c = homeTeam.id,
            EventType__c = 'Fouls',
            EventValue__c = 12
        );
        statList.add(stat1);
        MatchStatistic__c stat2 = new MatchStatistic__c(
            Match__c = match.id,
            Team__c = homeTeam.id,
            EventType__c = 'Yellow Card',
            EventValue__c = 1
        );
        statList.add(stat2);
        MatchStatistic__c stat3 = new MatchStatistic__c(
            Match__c = match.id,
            Team__c = homeTeam.id,
            EventType__c = 'Red Card',
            EventValue__c = 0
        );
        statList.add(stat3);
        insert statList;
        return statList;
    }

    public static List<MatchStatistic__c> homeTeamGoalStats (Match__c match, Team__c homeTeam) {
        List<MatchStatistic__c> statList = new List<MatchStatistic__c>();
        MatchStatistic__c stat1 = new MatchStatistic__c(
            Match__c = match.id,
            Team__c = homeTeam.id,
            EventType__c = 'Shot',
            GoalkeeperAction__c = '3',
            Minute__c = 36,
            ShotPosition__c = 'Penalty Area',
            ShotResistance__c = 'Medium'
        );
        statList.add(stat1);
        MatchStatistic__c stat2 = new MatchStatistic__c(
            Match__c = match.id,
            Team__c = homeTeam.id,
            EventType__c = 'Shot',
            GoalkeeperAction__c = '3',
            Minute__c = 47,
            ShotPosition__c = 'Penalty Area',
            ShotResistance__c = 'Medium',
            Assist__c = true
        );
        statList.add(stat2);
        MatchStatistic__c stat3 = new MatchStatistic__c(
            Match__c = match.id,
            Team__c = homeTeam.id,
            EventType__c = 'Shot',
            GoalkeeperAction__c = '3',
            Minute__c = 68,
            ShotPosition__c = 'Penalty Area',
            ShotResistance__c = 'Medium',
            CornerOrFreeKick__c = true
        );
        statList.add(stat3);
        MatchStatistic__c stat4 = new MatchStatistic__c(
            Match__c = match.id,
            Team__c = homeTeam.id,
            EventType__c = 'Shot',
            GoalkeeperAction__c = '3',
            Minute__c = 89,
            ShotPosition__c = 'Penalty Area',
            ShotResistance__c = 'Medium',
            Penalti__c = true
        );
        statList.add(stat4);
        insert statList;
        return statList;
    }
    
    public static List<MatchStatistic__c> visitorTeamGoalStats (Match__c match, Team__c visitorTeam) {
        List<MatchStatistic__c> statList = new List<MatchStatistic__c>();
        MatchStatistic__c stat1 = new MatchStatistic__c(
            Match__c = match.id,
            Team__c = visitorTeam.id,
            EventType__c = 'Shot',
            GoalkeeperAction__c = '3',
            Minute__c = 36,
            ShotPosition__c = 'Penalty Area',
            ShotResistance__c = 'Medium'
        );
        statList.add(stat1);
        MatchStatistic__c stat2 = new MatchStatistic__c(
            Match__c = match.id,
            Team__c = visitorTeam.id,
            EventType__c = 'Shot',
            GoalkeeperAction__c = '3',
            Minute__c = 47,
            ShotPosition__c = 'Penalty Area',
            ShotResistance__c = 'Medium',
            Assist__c = true
        );
        statList.add(stat2);
        MatchStatistic__c stat3 = new MatchStatistic__c(
            Match__c = match.id,
            Team__c = visitorTeam.id,
            EventType__c = 'Shot',
            GoalkeeperAction__c = '3',
            Minute__c = 68,
            ShotPosition__c = 'Penalty Area',
            ShotResistance__c = 'Medium',
            CornerOrFreeKick__c = true
        );
        statList.add(stat3);        
        insert statList;
        return statList;
    }

    public static List<TeamStatistic__c> teamStatList(Match__c match, Team__c homeTeam, Team__c visitorTeam) {
        List<TeamStatistic__c> teamStatList = new List<TeamStatistic__c>();
        TeamStatistic__c teamStat1 = new TeamStatistic__c(
            Match__c = match.id,
            Team__c = homeTeam.id,
            Fouls__c = 36
        );
        teamStatList.add(teamStat1);
        TeamStatistic__c teamStat2 = new TeamStatistic__c(
            Match__c = match.id,
            Team__c = visitorTeam.id,
            Fouls__c = 36
        );
        teamStatList.add(teamStat2);
        insert teamStatList;
        return teamStatList;
    }
}