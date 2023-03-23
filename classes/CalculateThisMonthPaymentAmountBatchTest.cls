@isTest
private class CalculateThisMonthPaymentAmountBatchTest {
    @testSetup
    static void setup() {
        List<Account> accounts = new List<Account>();
        List<Payment__c> payments = new List<Payment__c>();

        // insert 1 accounts
        accounts.add(new Account(Name='Account test 1234'));
    
        insert accounts;

        // find the account just inserted. add contact for each
        for (Account account : [select id from account where Name='Account test 1234']) {
            payments.add(new Payment__c(Name='payment test',
            Amount__c=1200,Final_Amount__c = 1300,Payment_date__c = date.parse('2023/03/15'), Account__c=account.id));
        }
        insert payments;
    }
    @isTest static void test() {
        Test.startTest();
        CalculateThisMonthPaymentAmountBatch uca = new CalculateThisMonthPaymentAmountBatch();
        Id batchId = Database.executeBatch(uca);
        Test.stopTest();

        List<Account> accounts = [select 	This_Month_Total_Payment_Amount__c from Account where Name='Account test 1234'];

        // after the testing stops, assert records were updated properly
        System.assertEquals(1300, accounts[0].This_Month_Total_Payment_Amount__c);
    } 
}