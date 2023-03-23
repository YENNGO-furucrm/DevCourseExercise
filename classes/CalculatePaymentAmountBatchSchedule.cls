global class CalculatePaymentAmountBatchSchedule implements Schedulable {

    global void execute(SchedulableContext ctx) {
        CalculateThisMonthPaymentAmountBatch p = new CalculateThisMonthPaymentAmountBatch();
         database.executeBatch(p);
    }   
 }