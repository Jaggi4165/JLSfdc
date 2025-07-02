({
    clickCreateContact: function(component, event, helper) {
        // Simplistic error checking
        var validExpense = true;

        // Name must not be blank
        var firstnameField = component.find("fstname");
        var frtname = firstnameField.get("v.value");
        
        if ($A.util.isEmpty(frtname)){
            validExpense = false;
            firstnameField.set("v.errors", [{message:"First name can't be blank."}]);
        }
        else {
            firstnameField.set("v.errors", null);
        }
        
        var lastnameField = component.find("lstname");
        var larname = lastnameField.get("v.value");
        if ($A.util.isEmpty(larname)){
            validExpense = false;
            lastnameField.set("v.errors", [{message:"Last Name can't be blank."}]);
        }
        else {
            // If the amount looks good, unset any errors...
            lastnameField.set("v.errors", null);
        }
        
       if(validExpense){
            // Create the new expense
            var newContact = component.get("v.newContact");
            //var newAccount = component.get("v.newAccount");
            console.log("Create Contact: " + JSON.stringify(newContact));
           // console.log("Create Account: " + JSON.stringify(newAccount));

           //helper.createAccount(component, newAccount);
           helper.createContact(component, newContact);
           
       }
    },
})