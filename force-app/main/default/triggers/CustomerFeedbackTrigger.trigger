trigger CustomerFeedbackTrigger on Customer_Feedback__c (before insert, before update) {
    if (Trigger.isBefore) {
        CustomerFeedbackTriggerHandler.handleBefore(Trigger.new, Trigger.oldMap);
    }
}