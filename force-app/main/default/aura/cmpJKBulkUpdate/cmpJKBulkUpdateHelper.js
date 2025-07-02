({
    getObjectName: function (component, event, helper) {
        
        var action = component.get("c.getObjectInfo");
        action.setParams({recordId : component.get("v.recordId")});
        action.setCallback(this,function(response){
            var state = response.getState();
            if (state === 'SUCCESS') {
                const myArray = response.getReturnValue().split("|");
				let objectName = myArray[0];
                let objectAPIName = myArray[1];
                component.set("v.objectName",objectName);
                component.set("v.objectAPIName",objectAPIName);
            } 
        });
        $A.enqueueAction(action);
        
    },
    getAllFields: function (component, event, helper) {
        
        var action = component.get("c.getObjectsFieldsInfo");
        action.setParams({recordId : component.get("v.recordId")});
        action.setCallback(this,function(response){
            var state = response.getState();
            if (state === 'SUCCESS') {
                console.log('length==>',response.getReturnValue().length);
                console.log('values',response.getReturnValue());
                //component.set("v.objectName",response.getReturnValue());
                var result = response.getReturnValue();  
                if(result == null){
                    component.set("v.dontHaveAccessOnThisField",true);
                    //return;
                }
                var values = [];
                for (var key in result ) {
                    values.push({value:result[key], key:key});
                }
                component.set("v.allFields",values);
                console.log(component.get("v.allFields"));
            } 
        });
        $A.enqueueAction(action);
        
    },
    
    getFieldDatatype: function (component, event, helper) {
        
        var action = component.get("c.getFieldDataType");
        action.setParams({objectAPIName : component.get("v.objectAPIName"),fieldName : component.get("v.fieldName")});
        action.setCallback(this,function(response){
            var state = response.getState();
            if (state === 'SUCCESS') {
                component.set("v.fieldDatatype",response.getReturnValue());
                console.log('fieldDatatype',(component.get("v.fieldDatatype")));
                if(response.getReturnValue().includes("Text")){ component.set("v.isTextField",true);}
                else{component.set("v.isTextField",false);}
                if(response.getReturnValue() == "Checkbox"){ component.set("v.isCheckboxField",true);}
                else{component.set("v.isCheckboxField",false);}
                if(response.getReturnValue() == "Picklist"){ component.set("v.isPicklistField",true);
                                                           helper.getPicklistFieldValues(component, event, helper);
                                                           }
                else{component.set("v.isPicklistField",false);}
                
            } 
        });
        $A.enqueueAction(action);
        
    },
    
    getPicklistFieldValues :function (component, event, helper) {
        
        var action = component.get("c.getPicklistValues");
        action.setParams({objectAPIName : component.get("v.objectAPIName"),fieldName : component.get("v.fieldName")});
        action.setCallback(this,function(response){
            var state = response.getState();
            if (state === 'SUCCESS') {
                var result = response.getReturnValue();
                var values = [];
                for (var key in result ) {
                    values.push({value:result[key], key:key});
                }
                component.set("v.picklistValues",values);
            } 
        });
        $A.enqueueAction(action);
        
    },
    
    resetValues : function (component, event, helper){
        component.set("v.fieldName",null);
        component.set("v.inputPicklistFieldValue",null);
    },
});