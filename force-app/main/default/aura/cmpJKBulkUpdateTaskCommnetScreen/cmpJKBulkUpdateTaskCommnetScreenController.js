({
    onCommentChange: function (component, event, helper) {
        var selectedValue=  event.getSource().get("v.value");
        component.set("v.comments",selectedValue);
        if(selectedValue!=null){
            component.set("v.showError",false);
        }
        else{
            component.set("v.showError",true);
        }
        
    },
	fireSubmitEvent: function (component, event, helper) {
        if(component.get("v.comments")!='' && component.get("v.comments")!=null){
            component.set("v.showError",false);
            var navigate = component.get("v.navigateFlow");
      		navigate("NEXT");
        }
        else{
            component.set("v.showError",true);
        }
        
    },
    fireCancelEvent: function (component, event, helper) {
        var navigate = component.get("v.navigateFlow");
      	navigate("BACK");
    },
})