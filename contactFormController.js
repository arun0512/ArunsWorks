({
    createContact : function(component, event, helper) {
        var validContact = component.find('contactform').reduce(function (validSoFar, inputCmp) {
            inputCmp.showHelpMessageIfInvalid();
            return validSoFar && inputCmp.get('v.validity').valid;
        }, true);
        if(validContact){
            var newContact = component.get('v.newContact');
            helper.createNewContact(component, newContact);
            component.set("v.newContact", 
                          {'sobjectType' : 'Contact',
                           'FirstName': '',
                           'LastName': '',
                           'Email': '',
                           'Phone': '',
                           'Fax': ''});
        }     
    }
})