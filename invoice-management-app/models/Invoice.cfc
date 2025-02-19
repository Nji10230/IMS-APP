component persistent="true" table="invoice" entityname="Invoice"  {
    
    property name="id" column="id" fieldtype="id" generator="native" setter="false";
    property name="user" fieldtype="many-to-one" cfc="User" fkcolumn="user_id";
    property name="invoiceNo" column="invoice_no" ormtype="string" unique="true";
    property name="amount" column="amount" ormtype="double";
    property name="status" column="status" ormtype="string"; // pending, paid, overdue
    property name="dueDate" column="due_date" ormtype="date";
    //property name="createdAt" column="created_at" ormtype="timestamp";

    function init(){
        return this;
    }

    function isLoaded(){
        return !isNull( id ) && id > 0;
    }

    // Getters
    function getId(){ return variables.id; }
    function getUser(){ return variables.user; }

    function getInvoiceNo(){ return variables.invoiceNo; }
    function getAmount(){ return variables.amount; }
    function getStatus(){ return variables.status; }
    function getDueDate(){ return variables.dueDate; }
    function getCreatedAt(){ return variables.createdAt; }
    
    // Setters
    function setInvoiceNo(required string invoiceNo){ variables.invoiceNo = invoiceNo; }
// In Invoice.cfc
function setAmount(required any amount){
    // Convert to numeric and validate
    var numericAmount = val(arguments.amount);
    if (numericAmount <= 0) {
        throw(type="ValidationException", message="Amount must be greater than 0");
    }
    variables.amount = numericAmount;
}    function setStatus(required string status){ variables.status = status; }
    function setDueDate(required date dueDate){ variables.dueDate = dueDate; }
    function setUser(required User user){ variables.user = arguments.user; }

}
