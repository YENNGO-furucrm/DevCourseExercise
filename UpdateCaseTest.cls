@isTest
public class UpdateCaseTest {
    @testSetup 
    static void setup() {
        // Create test cases
        List<Case> testCases = new List<Case>();

        for(Integer i=0; i<200; i++) {
            testCases.add(new Case(Subject = 'Subject'+i, Status = 'New'));
        }
        insert testCases;        
    }

    @isTest
    static void  testUpdateCase(){
        Decimal updateSuccesRecord = UpdateCase.updateCase();
        System.assertEquals(updateSuccesRecord,200);
    }
}