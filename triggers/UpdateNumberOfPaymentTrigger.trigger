trigger UpdateNumberOfPaymentTrigger on Payment__c (after update) {

    Set<Id> accountIds = new Set<Id>();

    for(Payment__c payment : trigger.new){

        accountIds.add(payment.Account__c);
    }
    
    // call queueable class
    System.enqueuejob(new UpdateNumberOfPaymentQueueableCls(accountIds));

}