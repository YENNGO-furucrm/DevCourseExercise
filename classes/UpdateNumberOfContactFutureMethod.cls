public with sharing class UpdateNumberOfContactFutureMethod {
    @future
    public static void UpdateFieldNumberOfContact(Set<Id> accountIds){
        List<Account> AccLists = new List<Account>();
        
        for(Account acc:[SELECT Id,Number_of_Contacts__c, (Select Id from Contacts) FROM Account WHERE Id IN: accountIds]){
            Account accObj = new Account ();
            accObj.Id = acc.Id;
            accObj.Number_of_Contacts__c = acc.Contacts.size();
            AccLists.add(accObj);
        }

        if(AccLists.size() > 0){
            update AccLists;
        }
    }
}