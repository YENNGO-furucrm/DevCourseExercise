@isTest
private class UpdateNumberOfContactsTriggerTest {
    /*
     * Test Insert
     */
    @isTest static void test_create() {
        // Create data test
        Account insAcc = CreateAccount();
        insert insAcc;

        Contact inscont = CreateContact(insAcc.Id);

        // start test
        Test.startTest();
        Database.SaveResult result = Database.insert(inscont, false);
        Test.stopTest();

        // verify
        Account accResult = [Select Id,Name,Number_of_Contacts__c from Account WHERE  Name = 'Test Account'];
        System.assertEquals(1, accResult.Number_of_Contacts__c);
    }

    /*
     * Test delete
     */
    @isTest static void test_update() {
        // Create data test
        Account insAcc = CreateAccount();
        insert insAcc;

        Contact inscont = CreateContact(insAcc.Id);
        insert inscont;

        Test.startTest();
        Database.DeleteResult result = Database.delete(inscont, false);
        Test.stopTest();

        // verify
        Account accResult = [Select Id,Name,Number_of_Contacts__c from Account WHERE  Name = 'Test Account'];
        System.assertEquals(0, accResult.Number_of_Contacts__c);
    }

    /*
     * Create Account and Contact
     */
    private static Account CreateAccount() {

        Account acc = new Account(
          Name = 'Test Account'
        );
        return acc;      
    }

    private static Contact CreateContact(string Id){
        Contact cont = new Contact(
          LastName = 'Test Contact',
          AccountId = Id
        );
        return cont;
    }

}