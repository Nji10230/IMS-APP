


component persistent="true" table="payment"  entityname="Payment" {
    
    property name="id" column="id" fieldtype="id" generator="native" setter="false";
    property name="invoice" fieldtype="many-to-one" cfc="Invoice" fkcolumn="invoice_id";
    property name="amountPaid" column="amount_paid" ormtype="double";
    property name="paymentDate" column="payment_date" ormtype="timestamp";
    property name="method" column="method" ormtype="string"; // Credit, Debit, Bank Transfer

    function init(){
        return this;
    }

    function isLoaded(){
        return !isNull( id ) && id > 0;
    }

    // Getters
    function getId(){ return variables.id; }
    function getAmountPaid(){ return variables.amountPaid; }
    function getPaymentDate(){ return variables.paymentDate; }
    function getMethod(){ return variables.method; }

    function getInvoice() {
        return variables.invoice;
    }
    
    // Setters
    function setAmountPaid(required any amountPaid) {
        if (!isNumeric(arguments.amountPaid)) {
            throw(type="ValidationException", message="Amount Paid must be a valid number.");
        }
    
        var numericAmountPaid = val(arguments.amountPaid);
        
        if (numericAmountPaid <= 0) {
            throw(type="ValidationException", message="Amount must be greater than 0");
        }
    
        variables.amountPaid = numericAmountPaid;
    }
    
    function setPaymentDate(required date paymentDate){ variables.paymentDate = paymentDate; }
    function setMethod(required string method){ variables.method = method; }
    function setInvoice(required any invoice) {
    
        variables.invoice = arguments.invoice;
    }
    
    
    


}
