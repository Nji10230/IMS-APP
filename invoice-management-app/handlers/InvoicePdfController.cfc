
component extends="coldbox.system.EventHandler" {

    property name="invoicePDFService" inject="model:services.InvoicePdfService";
    property name="log" inject="logbox:logger"; // Inject Logger

    function generate(event, rc, prc) {
        log.info("Entered generate function with invoiceId: #rc.invoiceId#");

        if (!structKeyExists(rc, "invoiceId")) {
            log.warn("Invoice ID is missing in the request.");
            event.renderData(type="json", data={ "success": false, "message": "Invoice ID is required" }, statusCode=400);
            return;
        }

        try {
            var result = invoicePDFService.generatePDF(rc.invoiceId);
            log.info("PDF generated successfully for Invoice ID: #rc.invoiceId# at path: #result.pdfPath#");
            event.renderData(type="json", data={ "success": true, "message": "PDF generated successfully", "pdfPath": result.pdfPath });
        } catch (any e) {
            log.error("Error generating PDF for Invoice ID: #rc.invoiceId# - " & e.message);
            event.renderData(type="json", data={ "success": false, "message": e.message }, statusCode=500);
        }
    }

    function download(event, rc, prc) {
        log.info("Entered download function with invoiceId: #rc.invoiceId#");

        if (!structKeyExists(rc, "invoiceId")) {
            log.warn("Invoice ID is missing in the request.");
            event.renderData(type="json", data={ "success": false, "message": "Invoice ID is required" }, statusCode=400);
            return;
        }

        try {
            var pdfInfo = invoicePDFService.getPDFPath(rc.invoiceId);
            log.info("Retrieved PDF path for Invoice ID: #rc.invoiceId# - Path: #pdfInfo.pdfPath#");

            if (fileExists(pdfInfo.pdfPath)) {
                log.info("PDF file exists. Initiating download for Invoice ID: #rc.invoiceId#");
                event.sendFile(
                    file = pdfInfo.pdfPath, 
                    disposition = "attachment", 
                    contentType = "application/pdf",
                    filename = "invoice-#rc.invoiceId#.pdf"
                );
            } else {
                log.warn("PDF file not found for Invoice ID: #rc.invoiceId# at path: #pdfInfo.pdfPath#");
                event.renderData(type="json", data={ "success": false, "message": "PDF not found" }, statusCode=404);
            }
        } catch (any e) {
            log.error("Error downloading PDF for Invoice ID: #rc.invoiceId# - " & e.message);
            event.renderData(type="json", data={ "success": false, "message": e.message }, statusCode=500);
        }
    }
}
