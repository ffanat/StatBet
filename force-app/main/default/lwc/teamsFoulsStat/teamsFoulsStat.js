import { LightningElement, wire, track, api } from 'lwc';
import getTeamFouls from '@salesforce/apex/teamDiscipline.getTeamFoulsStat';

const COLUMNS = [
    { label: 'Match', fieldName: 'Match', type: 'text'},
    { label: 'Team', fieldName: 'Team', type: 'text'},
    { label: 'Fouls', fieldName: 'Fouls', type: 'number'},
    { label: 'Yellow Cards', fieldName: 'YellowCard', type: 'number'},
    { label: 'Red Cards', fieldName: 'RedCard', type: 'number'}
];

export default class teamsFoulsStat extends LightningElement {
    @track data = [];
    @track columns = COLUMNS;
    @api recordId;
    

    @wire(getTeamFouls, {matchId:'$recordId'})
    teamStats({error, data}) {
        if(data) {
            let currentData = [];
            data.forEach((row) => {
                let rowData = {};
                rowData.Fouls = row.Fouls__c;
                rowData.YellowCard = row.YellowCard__c;
                rowData.RedCard = row.RedCard__c;
                if (row.Match__c) {
                    rowData.Match = row.Match__r.Name;
                }
                if (row.Team__c) {
                    rowData.Team = row.Team__r.Name;
                }
                currentData.push(rowData);
            });
            this.data = currentData;
        }
        else if(error) {
            window.console.log(error);
        }
    }
}
