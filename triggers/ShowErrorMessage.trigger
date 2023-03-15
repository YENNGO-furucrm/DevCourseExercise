trigger ShowErrorMessage on Payment__c (before update) {

    //Display error message when updating Status__c from Done to another status
    for( Payment__c paymentNew: trigger.new ){
        for( Payment__c paymentOld: trigger.old ){
            if(paymentOld.Status__c == 'Done' && paymentNew.Status__c != 'Done' ){
                //Show error
                paymentNew.addError('Do not update status from done to another status');
            }
        }   
    }
}