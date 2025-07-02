({
   
    createContact: function(component, contact) {
    var action = component.get("c.saveContact");
    action.setParams({
        "First_Name__c": frtname,
        "Last_Name__c" : lstname       
    });
        
    action.setCallback(this, function(response){
        var state = response.getState();
        if (component.isValid() && state === "SUCCESS") {
            var contacts = component.get("v.contacts");
            contacts.push(response.getReturnValue());
            component.set("v.contacts", contacts);
            alert('wooow child contact with parent account insert successfully'); 
        }
    });
    $A.enqueueAction(action);
},
    
})