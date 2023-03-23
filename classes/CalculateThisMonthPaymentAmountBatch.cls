global  class CalculateThisMonthPaymentAmountBatch implements Database.Batchable<sObject>, Database.Stateful{

    //total Amount
    public Decimal totalAmount = 0;

    //update Accout list
    List<Account> updateAccoutList = new List<Account>();

    //Start method
    global  Database.QueryLocator start(Database.BatchableContext BC){
        String query = 'SELECT Id, This_Month_Total_Payment_Amount__c, (SELECT Id , Final_Amount__c, Payment_date__c  from Payments__r WHERE Payment_date__c = THIS_MONTH) FROM Account ';
        return Database.getQueryLocator(query);
    }
 
    //Execute method
    global  void execute(Database.BatchableContext BC, List<Account> scope){
        // process each batch of records

        for (Account acc : scope) {
            Account accObj = new Account ();
            
            for (Payment__c payment : acc.Payments__r){
                if(payment.Final_Amount__c > 0){
                    totalAmount += payment.Final_Amount__c;
                }  
            }

            accObj.Id = acc.Id;
            accObj.This_Month_Total_Payment_Amount__c = totalAmount;

            // add to update list
            updateAccoutList.add(accObj);
        }
    }
 
    //Finish method 
    global  void finish(Database.BatchableContext BC){
        if(updateAccoutList.size() > 0){
            update updateAccoutList;
        }
    }
 }