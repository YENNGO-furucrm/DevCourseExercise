trigger UpdateFinalAmount on Payment__c (after update) {
    
    List<String> paymentListID = new List<String>();
    
    for (Payment__c p : trigger.new) {
        if(p.Final_Amount__c == null && p.Status__c == 'Done'){
            paymentListID.add(p.Id);
        }		
    }

    // List Payment__c to update
    List<Payment__c> paymentIDs = new List<Payment__c>();

    for(Payment__c payment : [SELECT Id, Amount__c, Final_Amount__c  FROM Payment__c  WHERE Id in :paymentListID]){          
        payment.Final_Amount__c = payment.Amount__c;
        paymentIDs.add(payment);
    }

    // call method update
    update paymentIDs;
    
}