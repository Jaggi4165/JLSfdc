({
	loadContactList: function(component, event, helper) {
      //call apex class method
      var action = component.get('c.fetchHubs');
 
      action.setCallback(this, function(response) {
        //store state of response
        var state = response.getState();
        if (state === "SUCCESS") {
          //set response value in ListOfContact attribute on component.
          component.set('v.ListOfHubs', response.getReturnValue());
        }
      });
      $A.enqueueAction(action);
    },
});