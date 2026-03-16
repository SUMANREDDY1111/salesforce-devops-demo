@IsTest
private class CustomerFeedbackTriggerHandlerTest {
    @IsTest
    static void testFeedbackDefaultsAreSet() {
        Customer_Feedback__c feedback = new Customer_Feedback__c(
            Customer_Name__c = 'Rahul',
            Email__c = 'rahul@example.com',
            Rating__c = 5,
            Comments__c = 'Great support experience'
        );

        Test.startTest();
        insert feedback;
        Test.stopTest();

        Customer_Feedback__c saved = [
            SELECT Id, Submitted_On__c, Status__c
            FROM Customer_Feedback__c
            WHERE Id = :feedback.Id
        ];

        System.assertEquals(Date.today(), saved.Submitted_On__c);
        System.assertEquals('New', saved.Status__c);
    }

    @IsTest
    static void testLowRatingSetsReviewedStatus() {
        Customer_Feedback__c feedback = new Customer_Feedback__c(
            Customer_Name__c = 'Anil',
            Email__c = 'anil@example.com',
            Rating__c = 2,
            Comments__c = 'Issue not resolved'
        );

        Test.startTest();
        insert feedback;
        Test.stopTest();

        Customer_Feedback__c saved = [
            SELECT Id, Submitted_On__c, Status__c, Rating__c
            FROM Customer_Feedback__c
            WHERE Id = :feedback.Id
        ];

        System.assertEquals(Date.today(), saved.Submitted_On__c);
        System.assertEquals('Reviewed', saved.Status__c);
        System.assertEquals(2, saved.Rating__c);
    }
}