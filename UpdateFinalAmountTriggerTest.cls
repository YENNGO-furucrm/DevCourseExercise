@isTest
public class UpdateFinalAmountTriggerTest {
    @isTest static void TestUpdateFinalAmount(){
        // Test data setup
        // Create an Payment, and then try to update it
        Payment__c payment = new Payment__c(
            Name='Test Payment',
            Amount__c = 1300,
            Status__c = 'New');

        insert payment;

        //update payment
        payment.Payment_date__c = Date.parse('2023/04/19');
        payment.Payment_method__c = 'Chuyển khoản';
        payment.Status__c = 'Done';

        // Perform test
        Test.startTest();
        Database.SaveResult saveresult = Database.update(payment, false);
        Test.stopTest();

        // Verify 
        System.assert(saveresult.isSuccess());
        Payment__c result = [Select Id,Name,Amount__c,Final_Amount__c from Payment__c WHERE Name='Test Payment' limit 1];
        System.assertEquals(result.Amount__c,result.Final_Amount__c);
    }
}