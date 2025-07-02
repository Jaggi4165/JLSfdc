({
	onLoad: function(component, event, helper) {
    console.log('colorCmp load');
    var sName = component.get("v.leadSource");
    if (sName != undefined) {
      // **** write picklist values in Lower Case ***** //       
      var tempLowerCase = sName.toLowerCase();
      var cRed = 'least preferred';
      var cOrange = 'average preference';
      var cGreen = 'most preferred';
      // ...add more values vaiable here 
      // set the color on based on picklist values      
      if (cOrange.indexOf(tempLowerCase) != -1) {
        component.set("v.Color", 'orange');
      } else if (cRed.indexOf(tempLowerCase) != -1) {
        component.set("v.Color", 'red');
      } else if (cGreen.indexOf(tempLowerCase) != -1) {
        component.set("v.Color", 'green');
      }
    }
  },
})