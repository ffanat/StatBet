({
	doInit : function(component, event, helper) {
        var action =  component.get("c.getEventTypeList");
        action.setParams({
			matchId: component.get("v.recordId")
        });
        var result;
        action.setCallback(this, function(response){
            var name = response.getState();
            if (name === "SUCCESS") {
                result = response.getReturnValue();
                
                component.set("v.eventTypeList", Object.values(result));
                console.log(Object.values(result));
            }
        });
        $A.enqueueAction(action);
        
        var action =  component.get("c.getHomeStat");
		action.setParams({
			matchId: component.get("v.recordId")
        });
        var result;        
        action.setCallback(this, function(response){
            var name = response.getState();
            if (name === "SUCCESS") {
                result = response.getReturnValue();
                
                component.set("v.homeTeamStat", Object.values(result));
                console.log(Object.values(result));
            }
        });        
        $A.enqueueAction(action);

        var action =  component.get("c.getVisitorStat");
		action.setParams({
			matchId: component.get("v.recordId")
        });
        var result;        
        action.setCallback(this, function(response){
            var name = response.getState();
            if (name === "SUCCESS") {
                result = response.getReturnValue();
                
                component.set("v.visitorTeamStat", Object.values(result));
                console.log(Object.values(result));
            }
        });        
        $A.enqueueAction(action);

        var action =  component.get("c.getMatchTeams");
		action.setParams({
			matchId: component.get("v.recordId")
        });
        var result;        
        action.setCallback(this, function(response){
            var name = response.getState();
            if (name === "SUCCESS") {
                result = response.getReturnValue();
                
                component.set("v.matchTeams", Object.values(result));
                console.log(Object.values(result));
            }
        });        
        $A.enqueueAction(action);
    }
})