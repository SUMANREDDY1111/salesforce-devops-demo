public class CustomerFeedbackTriggerHandler {
    public static void handleBefore(List<Customer_Feedback__c> newRecords, Map<Id, Customer_Feedback__c> oldMap) {
        for (Customer_Feedback__c feedback : newRecords) {
            if (feedback.Submitted_On__c == null) {
                feedback.Submitted_On__c = Date.today();
            }

            if (String.isBlank(feedback.Status__c)) {
                feedback.Status__c = 'New';
            }

            if (feedback.Rating__c != null && feedback.Rating__c <= 2) {
                feedback.Status__c = 'Reviewed';
            }
        }
    }
}