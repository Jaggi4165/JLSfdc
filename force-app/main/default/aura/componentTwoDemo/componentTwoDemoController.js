({
    handleEvent : function(component, event, helper) {
        var name =event.getParam("message");// getting the value of event attribute
        console.log('name:::'+JSON.stringify(name));
        component.set("v.ParentAttribute",name); // Setting the value of parent attribute with event attribute value
    }
})