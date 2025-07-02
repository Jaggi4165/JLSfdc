({
    handleClick : function(component, event, helper) {
        // create a one-time use instance of the serverEcho action
        // in the server-side controller
        console.log('You have clicked on Button');
         var value1 = component.find('input1').get('v.value');
        var value2 = component.find('input2').get('v.value');
        
        var newVal = value1+' - '+value2;
        console.log('Entered value===>',newVal);
        var action = component.get("c.createRecords");
        action.setParams({ name : newVal });
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log(state);
            if (state === 'SUCCESS') {
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title":"Success",
                    "type":"success",
                    "message":"Record created successfully.",                        
                });
                toastEvent.fire();

            }
            else if (state === 'INCOMPLETE') {
                alert('Incomplete From server: ');
            }
            else if (state === 'ERROR') {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log('Error message: ' + 
                                 errors[0].message);
                    }
                } else {
                    console.log('Unknown error');
                }
            }
        });

        $A.enqueueAction(action);
    }
})