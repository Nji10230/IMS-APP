
    // component singleton accessors="true" {

    //     property name="invoiceService" inject="model:services.InvoiceService";
    //     property name="userService" inject="model:services.UserService";
    //     property name="log" inject="logbox:logger:InvoicePdfService";

    //     function init() {
    //         // Initialize PDF directory
    //         variables.pdfDirectory = expandPath("/pdfs/invoices/");
    //         return this;
    //     }

    //     function generatePDF(required numeric invoiceId) {
    //         log.info("Generating PDF for Invoice ID: #invoiceId#");

    //         // Load invoice
    //         var invoice = entityLoadByPK("Invoice", invoiceId);
    //         if (isNull(invoice)) {
    //             log.warn("Invoice not found for ID: #invoiceId#");
    //             throw(type="ValidationException", message="Invoice not found");
    //         }

    //         var filename = "invoice_#invoiceId#_#dateFormat(now(), 'yyyymmdd')#_#timeFormat(now(), 'HHmmss')#.pdf";
    //         var fullPath = variables.pdfDirectory & filename;

    //         // Generate PDF with improved styling
    //         try {
    //             cfdocument(format="PDF", filename=fullPath, overwrite="true", marginbottom=1, margintop=1, marginleft=1, marginright=1) {
    //                 writeOutput("
    //                     <html>
    //                     <head>
    //                         <style>
    //                             body { font-family: Arial, sans-serif; margin: 40px; background-color: ##f8f9fa; }
    //                             .container { padding: 20px; background: white; border-radius: 10px; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
    //                             .header { text-align: center; margin-bottom: 30px; }
    //                             .header h1 { color: ##007bff; }
    //                             .invoice-details, .customer-details { margin-bottom: 20px; padding: 15px; background: ##e9ecef; border-radius: 5px; }
    //                             .amount { font-size: 20px; font-weight: bold; color: ##28a745; text-align: right; margin: 20px 0; }
    //                             .footer { margin-top: 40px; text-align: center; font-style: italic; color: ##6c757d; }
    //                             .label { font-weight: bold; color: ##343a40; }
    //                         </style>
    //                     </head>
    //                     <body>
    //                         <div class='container'>
    //                             <div class='header'>
    //                                 <h1>INVOICE</h1>
    //                                 <h2>Invoice ## : #invoice.getInvoiceNo()#</h2>
    //                             </div>
                                
    //                             <div class='invoice-details'>
    //                                 <p><span class='label'>Date:</span> #dateFormat(now(), 'mmmm d, yyyy')#</p>
    //                                 <p><span class='label'>Due Date:</span> #dateFormat(invoice.getDueDate(), 'mmmm d, yyyy')#</p>
    //                                 <p><span class='label'>Status:</span> #invoice.getStatus()#</p>
    //                             </div>
                                
    //                             <div class='customer-details'>
    //                                 <h3>Bill To:</h3>
    //                                 <p>#invoice.getUser().getName()#</p>
    //                                 <p>#invoice.getUser().getEmail()#</p>
    //                             </div>
                                
    //                             <div class='amount'>
    //                                 Amount Due: $#numberFormat(invoice.getAmount(), '999,999.99')#
    //                             </div>
                                
    //                             <div class='footer'>
    //                                 <p>Thank you for your business!</p>
    //                             </div>
    //                         </div>
    //                     </body>
    //                     </html>
    //                 ");
    //             }
    //             log.info("PDF generated successfully at: #fullPath#");
    //         } catch (any e) {
            
    //             throw(type="PDFGenerationException", message="Error generating PDF: #e.message#");
    //         }

    //         // Save PDF record to database
    //         try {
    //             var pdfRecord = entityNew("InvoicePdfs");
    //             pdfRecord.setInvoice(invoice);
    //             pdfRecord.setPdfPath(filename);
    //             entitySave(pdfRecord);
    //             log.info("PDF record saved to database");
    //         } catch (any e) {
    //             log.error("Error saving PDF record: #e.message#");
    //             if (fileExists(fullPath)) {
    //                 fileDelete(fullPath);
    //             }
    //             throw(type="DatabaseException", message="Error saving PDF record: #e.message#");
    //         }


    //         sendInvoiceEmail(invoice, fullPath);



    //         return {
    //             "success": true,
    //             "pdfPath": fullPath
    //         };
    //     }

    //     function getPDFPath(required numeric invoiceId) {
    //         log.info("Fetching PDF path for Invoice ID: #invoiceId#");

    //         var invoice = entityLoadByPK("Invoice", arguments.invoiceId);
    //         if (isNull(invoice)) {
    //             log.warn("Invoice not found for ID: #invoiceId#");
    //             throw(type="ValidationException", message="Invoice not found");
    //         }

    //         var pdfRecord = entityLoad("InvoicePdfs", { invoice: invoice }, true);
    //         if (isNull(pdfRecord)) {
    //             log.warn("PDF record not found for Invoice ID: #invoiceId#");
    //             throw(type="ValidationException", message="PDF record not found");
    //         }

    //         var fullPath = variables.pdfDirectory & pdfRecord.getPdfPath();
    //         if (!fileExists(fullPath)) {
    //             log.warn("PDF file not found at: #fullPath#");
    //             throw(type="FileNotFoundException", message="PDF file not found on disk");
    //         }

    //         log.info("PDF path found: #fullPath#");
    //         return { "pdfPath": fullPath };
    //     }
    //     function sendInvoiceEmail(required any invoice, required string pdfPath) {
    //         var recipientEmail = invoice.getUser().getEmail();
    //         var recipientName = invoice.getUser().getName();
    //         var invoiceNo = invoice.getInvoiceNo();
    //         var invoiceAmount = numberFormat(invoice.getAmount(), '999,999.99');
    //         var dueDate = dateFormat(invoice.getDueDate(), 'mmmm d, yyyy');
        
    //         log.info("Sending invoice email to: #recipientEmail# with PDF: #pdfPath#");
        
    //         try {
    //             // Using cfmail in a separate included template
    //             include "sendEmail.cfm";
    //             log.info("Invoice email sent successfully to: #recipientEmail#");
        
    //         } catch (any e) {
    //             log.error("Error sending email: " & e.message);
    //             throw(type="EmailException", message="Error sending email: #e.message#");
    //         }
    //     }
        
        
        
    // }


    component singleton accessors="true" {

        property name="invoiceService" inject="model:services.InvoiceService";
        property name="userService" inject="model:services.UserService";
        property name="log" inject="logbox:logger:InvoicePdfService";
    
        // Email configuration
        variables.SMTP_SERVER = "smtp.gmail.com";
        variables.SMTP_PORT = "587";
        variables.SMTP_USERNAME = "pulukuriabhiram2024@gmail.com";
        variables.SMTP_PASSWORD = "tebb sidt iyjd aket"; // Replace with actual app password
        variables.FROM_EMAIL = "pulukuriabhiram2024@gmail.com";
    
        function init() {
            variables.pdfDirectory = expandPath("/pdfs/invoices/");
            return this;
        }
    
        // Your existing generatePDF function remains the same until the email sending part
        function generatePDF(required numeric invoiceId) {
            log.info("Generating PDF for Invoice ID: #invoiceId#");
    
            // Load invoice
            var invoice = entityLoadByPK("Invoice", invoiceId);
            if (isNull(invoice)) {
                log.warn("Invoice not found for ID: #invoiceId#");
                throw(type="ValidationException", message="Invoice not found");
            }
    
            var filename = "invoice_#invoiceId#_#dateFormat(now(), 'yyyymmdd')#_#timeFormat(now(), 'HHmmss')#.pdf";
            var fullPath = variables.pdfDirectory & filename;
    
            // Generate PDF with improved styling
            try {
                cfdocument(format="PDF", filename=fullPath, overwrite="true", marginbottom=1, margintop=1, marginleft=1, marginright=1) {
                    writeOutput("
                        <html>
                        <head>
                            <style>
                                body { font-family: Arial, sans-serif; margin: 40px; background-color: ##f8f9fa; }
                                .container { padding: 20px; background: white; border-radius: 10px; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
                                .header { text-align: center; margin-bottom: 30px; }
                                .header h1 { color: ##007bff; }
                                .invoice-details, .customer-details { margin-bottom: 20px; padding: 15px; background: ##e9ecef; border-radius: 5px; }
                                .amount { font-size: 20px; font-weight: bold; color: ##28a745; text-align: right; margin: 20px 0; }
                                .footer { margin-top: 40px; text-align: center; font-style: italic; color: ##6c757d; }
                                .label { font-weight: bold; color: ##343a40; }
                            </style>
                        </head>
                        <body>
                            <div class='container'>
                                <div class='header'>
                                    <h1>INVOICE</h1>
                                    <h2>Invoice ## : #invoice.getInvoiceNo()#</h2>
                                </div>
                                
                                <div class='invoice-details'>
                                    <p><span class='label'>Date:</span> #dateFormat(now(), 'mmmm d, yyyy')#</p>
                                    <p><span class='label'>Due Date:</span> #dateFormat(invoice.getDueDate(), 'mmmm d, yyyy')#</p>
                                    <p><span class='label'>Status:</span> #invoice.getStatus()#</p>
                                </div>
                                
                                <div class='customer-details'>
                                    <h3>Bill To:</h3>
                                    <p>#invoice.getUser().getName()#</p>
                                    <p>#invoice.getUser().getEmail()#</p>
                                </div>
                                
                                <div class='amount'>
                                    Amount Due: $#numberFormat(invoice.getAmount(), '999,999.99')#
                                </div>
                                
                                <div class='footer'>
                                    <p>Thank you for your business!</p>
                                </div>
                            </div>
                        </body>
                        </html>
                    ");
                }
                log.info("PDF generated successfully at: #fullPath#");
            } catch (any e) {
                throw(type="PDFGenerationException", message="Error generating PDF: #e.message#");
            }
    
            // Save PDF record to database
            try {
                var pdfRecord = entityNew("InvoicePdfs");
                pdfRecord.setInvoice(invoice);
                pdfRecord.setPdfPath(filename);
                entitySave(pdfRecord);
                log.info("PDF record saved to database");
            } catch (any e) {
                log.error("Error saving PDF record: #e.message#");
                if (fileExists(fullPath)) {
                    fileDelete(fullPath);
                }
                throw(type="DatabaseException", message="Error saving PDF record: #e.message#");
            }
    
            // Send email with the generated PDF
            var emailResult = sendInvoiceEmail(invoice, fullPath);
            if (!emailResult.success) {
                log.warn("Email sending failed but PDF was generated: #emailResult.message#");
            }
    
            return {
                "success": true,
                "pdfPath": fullPath,
                "emailStatus": emailResult.success,
                "emailMessage": emailResult.message
            };
        }
    
        // Your existing getPDFPath function remains the same
    
        function sendInvoiceEmail(required any invoice, required string pdfPath) {
            var recipientEmail = invoice.getUser().getEmail();
            var recipientName = invoice.getUser().getName();
            var invoiceNo = invoice.getInvoiceNo();
            var invoiceAmount = numberFormat(invoice.getAmount(), '999,999.99');
            var dueDate = dateFormat(invoice.getDueDate(), 'mmmm d, yyyy');
        
            log.info("Sending invoice email to: #recipientEmail# with PDF: #pdfPath#");
        
            try {
                savecontent variable="emailBody" {
                    writeOutput('
                        <p>Hello #recipientName#,</p>
                        <p>Please find attached your invoice (###invoiceNo#) for the amount of $#invoiceAmount#.</p>
                        <p><strong>Due Date:</strong> #dueDate#</p>
                        <p>Thank you for your business!</p>
                        <p>Best Regards,<br>Your Company</p>
                    ');
                }
    
                cfmail(
                    to = recipientEmail,
                    from = variables.FROM_EMAIL,
                    subject = "Invoice ##" & invoiceNo,
                    type = "html",
                    server = variables.SMTP_SERVER,
                    username = variables.SMTP_USERNAME,
                    password = variables.SMTP_PASSWORD,
                    port = variables.SMTP_PORT,
                    useTLS = true
                ) {
                    // Add the PDF attachment
                    cfmailparam(
                        file = pdfPath,
                        type = "application/pdf",
                        disposition = "attachment"
                    );
                    
                    writeOutput(emailBody);
                }
                
                log.info("Invoice email sent successfully to: #recipientEmail#");
                return { 
                    "success": true, 
                    "message": "Email sent successfully" 
                };
                
            } catch (any e) {
                log.error("Error sending email: #e.message#");
                return { 
                    "success": false, 
                    "message": "Error sending email: #e.message#" 
                };
            }
        }
    }






