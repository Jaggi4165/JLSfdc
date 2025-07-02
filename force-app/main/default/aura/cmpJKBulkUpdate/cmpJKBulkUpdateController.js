({
    init: function (component, event, helper) {
        helper.getObjectName(component, event, helper);
        helper.getAllFields(component, event, helper);
        if(component.get("v.flowStatus") == true){
            var SuccessMessage = 'All the Records has been updated successfully.';
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                "title": "Success!",
                "message":SuccessMessage,
                "type" : "Success"
            });
            toastEvent.fire();
            helper.resetValues(component, event, helper);
            $A.get('e.force:refreshView').fire();
        }
        
    },
    onChangeField: function (component, event, helper) {
        var selectedOptionValue = event.getSource().get("v.value");
        component.set("v.fieldName",selectedOptionValue);
        helper.getFieldDatatype(component, event, helper);
        
    },
    OnPicklistFieldValueChange: function (component, event, helper) {
        var selectedPicklistValue = event.getSource().get("v.value");
        component.set("v.inputPicklistFieldValue",selectedPicklistValue);
        if(component.get("v.fieldName")!=null && component.get("v.inputPicklistFieldValue")!=null){
            component.set("v.isNotValid",false);
        }
        else{
            component.set("v.isNotValid",true);
        }
    },
    
    fireSaveEvent: function (component, event, helper) {
        if(component.get("v.fieldName")!=null && component.get("v.inputPicklistFieldValue")!=null){
            component.set("v.isNotValid",false);
            var navigate = component.get("v.navigateFlow");
            navigate("NEXT");
        }
        else{
            component.set("v.isNotValid",true);
        }
        
    },
    fireCancelEvent: function (component, event, helper) {
        var navigate = component.get("v.navigateFlow");
        navigate("BACK");
    },
    getToggleButtonValue :function (component, event, helper) {
        var checkCmp = component.find("tglbtn").get("v.checked");
        component.set("v.toggleValue",checkCmp);
    }
});