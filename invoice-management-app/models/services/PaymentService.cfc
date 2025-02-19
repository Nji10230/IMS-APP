

component singleton {
    
    property name="entitySave";
    property name="transaction";

    function init(){
        return this;
    }

    function createPayment(required struct paymentData) {
        transaction action="begin" {
            try {
                // Validate and create payment object
                var payment = createPaymentObject(arguments.paymentData);
                
                // Save the payment
                entitySave(payment);

                // Get the related invoice
                var invoice = payment.getInvoice();
                
                // Get total payments
                var totalPayments = getTotalPayments(invoice.getId());
                var totalPaid = isNull(totalPayments) ? 0 : totalPayments;

                // Check if invoice is fully paid
                if (invoice.getAmount() <= totalPaid) {
                    invoice.setStatus("paid");
                    entitySave(invoice);
                }

                transaction action="commit";
                return { 
                    "success": true, 
                    "message": "Payment saved successfully", 
                    "paymentId": payment.getId()
                };
            } catch (ValidationException e) {
                transaction action="rollback";
                return { 
                    "success": false, 
                    "message": e.message,
                    "type": "validation"
                };
            } catch (any e) {
                transaction action="rollback";
                return { 
                    "success": false, 
                    "message": e.message,
                    "type": "error"
                };
            }
        }
    }

    private function createPaymentObject(required struct paymentData) {
        // Validate required fields
        if (!structKeyExists(arguments.paymentData, "invoiceId") || 
            !structKeyExists(arguments.paymentData, "amountPaid") || 
            !structKeyExists(arguments.paymentData, "method")) {
            throw(
                type="ValidationException",
                message="Missing required fields"
            );
        }

        // Load invoice
        var invoice = entityLoadByPK("Invoice", arguments.paymentData.invoiceId);
        if (!isObject(invoice)) {
            throw(
                type="ValidationException",
                message="Invoice not found"
            );
        }

        // Create and populate payment object
        var payment = entityNew("Payment");
        payment.setInvoice(invoice);
        payment.setAmountPaid(arguments.paymentData.amountPaid);
        payment.setPaymentDate(ParseDateTime(arguments.paymentData.paymentDate));
        payment.setMethod(arguments.paymentData.method);

        return payment;
    }

    function getTotalPayments(required numeric invoiceId) {
        var result = ORMExecuteQuery(
            "SELECT COALESCE(SUM(p.amountPaid), 0) as total FROM Payment p WHERE p.invoice.id = :invoiceId",
            { invoiceId: arguments.invoiceId },
            true
        );
        return isNull(result) ? 0 : result;
    }

    function getPaymentsByInvoice(required numeric invoiceId) {
        return entityLoad("Payment", { invoice: arguments.invoiceId });
    }
}
