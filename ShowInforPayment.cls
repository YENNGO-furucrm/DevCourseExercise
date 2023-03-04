public with sharing class ShowInforPayment {
    public static void showInforPayment() {
        OnlinePaymentCls onlinepayment = new OnlinePaymentCls();
        onlinepayment.PayInformation();
        System.debug('Ngay ' + onlinepayment.Payment_date + 'bang phuong thuc ' + onlinepayment.Payment_method);
    }
}