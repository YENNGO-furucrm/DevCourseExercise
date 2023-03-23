public class UpdateNumberOfPaymentQueueableCls implements Queueable {
    Set<Id> accountIds = new Set<Id>();
    List<Account> AccountsToUpdate = new List<Account>();
        
    public UpdateNumberOfPaymentQueueableCls (Set<Id> TriggeredAccList){
        accountIds = TriggeredAccList ;
    }

    public void execute(QueueableContext context){
        
        for(Account acc: [SELECT Id, Number_of_Payment__c, (Select Id, Name from Payments__r WHERE Status__c = 'DONE') FROM Account  WHERE Id IN: accountIds]) {

            Account accObj = new Account ();
            accObj.Id = acc.Id;
            accObj.Number_of_Payment__c = acc.Payments__r.size();

            AccountsToUpdate.add(accObj);
        }

        if(AccountsToUpdate.size() > 0){
            update AccountsToUpdate;
        }  
    }
}