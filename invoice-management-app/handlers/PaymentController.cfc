
component extends="coldbox.system.EventHandler" {

    property name="paymentService" inject="models:services.PaymentService";

    function create(event, rc, prc) {
        // Create payment data structure
        var paymentData = {
            invoiceId: rc.invoiceId ?: "",
            amountPaid: rc.amountPaid ?: "",
            paymentDate: rc.paymentDate ?: "",
            method: rc.method ?: ""
        };

        // Process payment through service
        var result = paymentService.createPayment(paymentData);

        // Return appropriate response
        if (result.success) {
            event.renderData(type="json", data=result, statusCode=201);
        } else {
            var statusCode = (result.type == "validation") ? 400 : 500;
            event.renderData(type="json", data=result, statusCode=statusCode);
        }
    }
    
    function getPaymentsByInvoice(event, rc, prc) {
        if (!structKeyExists(rc, "invoiceId")) {
            event.renderData(type="json", data={ 
                "success": false, 
                "error": "Missing invoiceId" 
            }, statusCode=400);
            return;
        }

        var payments = paymentService.getPaymentsByInvoice(rc.invoiceId);
        event.renderData(type="json", data={ 
            "success": true, 
            "payments": payments 
        }, statusCode=200);
    }
}