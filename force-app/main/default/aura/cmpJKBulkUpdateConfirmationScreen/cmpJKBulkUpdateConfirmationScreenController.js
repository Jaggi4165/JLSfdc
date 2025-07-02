({
	fireOkEvent: function (component, event, helper) {
        var navigate = component.get("v.navigateFlow");
      	navigate("NEXT");
    },
    fireCancelEvent: function (component, event, helper) {
        var navigate = component.get("v.navigateFlow");
      	navigate("BACK");
    }
})