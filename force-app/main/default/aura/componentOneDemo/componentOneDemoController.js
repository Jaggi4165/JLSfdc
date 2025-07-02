({
    fireComponentEvent : function(cmp, event, helper) {
        var compEvents = cmp.getEvent("componentEventFired");// getting the Instance of event
        compEvents.setParams({ "message" : "Child Event Fired" });// setting the attribute of event
        compEvents.fire();// firing the event.
    }
})