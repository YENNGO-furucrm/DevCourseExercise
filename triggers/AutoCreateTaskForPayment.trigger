trigger AutoCreateTaskForPayment on Payment__c (after insert) {

    List<String> paymentListID = new List<String>();
    List<Task> taskList = new List<Task>();
    Task task = new Task();

    for( Payment__c payment: trigger.new ){
        if(payment.Payment_method__c == 'Chuyển khoản'){
            paymentListID.add(payment.ID);
        }
    }

    for ( Payment__c pm : [SELECT Id,Name , OwnerId,Payment_date__c FROM Payment__c  WHERE Id in :paymentListID]){

        task.Subject = '' + pm.Name;
        task.Priority = 'High';
        task.OwnerId = pm.OwnerId;
        if(pm.Payment_date__c != null){
            task.ActivityDate = pm.Payment_date__c.addDays(-1);
        }
        task.Status = 'Not Started';
        task.WhatId = pm.Id;

        taskList.add(task);
    }

    // call method insert Task
    insert taskList;


}