component extends="coldbox.system.EventHandler" {
    
    property name="invoiceService" inject="models:services.InvoiceService";

    function create(event, rc, prc) {
        // Disable layout for API requests
      
        
        var invoiceData = {};
        
        // Parse the request data
        if (event.getHTTPHeader("Content-Type") == "application/json") {
            // Handle JSON API request
            invoiceData = deserializeJSON(event.getHTTPContent());
        } else {
            // Handle form submission
            invoiceData = {
                userId = rc.userId ?: "",
                invoiceNo = rc.invoiceNo ?: "",
                amount = rc.amount ?: "",
                status = rc.status ?: "pending",
                dueDate = rc.dueDate ?: ""
            };
        }

        // Validate required fields
        if (!structKeyExists(invoiceData, "userId") || !len(trim(invoiceData.userId))) {
            event.renderData(type="json", data={
                "success": false,
                "message": "User ID is required"
            }, statusCode=400);
            return;
        }

        try {
            var invoice = invoiceService.create(invoiceData);
            
            event.renderData(type="json", data={
                "success": true,
                "message": "Invoice created successfully",
                "invoice": invoice
            }, statusCode=201);
        } catch(any e) {
            event.renderData(type="json", data={
                "success": false,
                "message": e.message
            }, statusCode=500);
        }
    }

    function new(event, rc, prc) {
        // Disable layout for API requests
        event.setView("invoice/create");
    }
}