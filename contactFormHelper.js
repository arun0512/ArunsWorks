({
    createNewContact : function(component,newContact) {
        var action = component.get('c.saveContact');
        action.setParams({
            "contactToSave": newContact
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                var contact = component.get('v.savedContact');
                contact = response.getReturnValue();
                component.set('v.savedContact', contact);
                component.set('v.result', true);
            }else {
                component.set('v.result', false);
            }
        });
        
        $A.enqueueAction(action);
    }
})