({
    getTicketNumbers: function(component) {
        var action = component.get("c.getHousieTicketNumbers");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.ticketNumbers", response.getReturnValue());
            } else {
                console.error(response.getError());
            }
        });
        $A.enqueueAction(action);
    },
    generateTicketNumbers: function(component) {
        var action = component.get("c.generateHousieTicketNumbers");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.ticketNumbers", response.getReturnValue());
            } else {
                console.error(response.getError());
            }
        });
        $A.enqueueAction(action);
    }
})