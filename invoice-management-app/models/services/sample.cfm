 
 /**function sendInvoiceEmail(required any invoice, required string pdfPath) {
        var recipientEmail = invoice.getUser().getEmail();
        var recipientName = invoice.getUser().getName();
        var invoiceNo = invoice.getInvoiceNo();
        var invoiceAmount = numberFormat(invoice.getAmount(), '999,999.99');
        var dueDate = dateFormat(invoice.getDueDate(), 'mmmm d, yyyy');
    
        log.info("Sending invoice email to: #recipientEmail# with PDF: #pdfPath#");
    
        try {
            // Use tag-based cfmail inside cfoutput
            writeOutput("
                <cfmail to='#recipientEmail#' 
                        from='pabhiram2001@gmail.com'  
                        subject='Invoice #invoiceNo#' 
                        type='html'>
                    <cfmailparam file='#pdfPath#' type='application/pdf' name='Invoice_#invoiceNo#.pdf'>
                    
                    <p>Hello #recipientName#,</p>
                    <p>Please find attached your invoice (#invoiceNo#) for the amount of 
                    $#invoiceAmount#.</p>
    
                    <p>Due Date: #dueDate#</p>
    
                    <p>Thank you for your business!</p>
                    <p>Best Regards,<br>Your Company</p>
                </cfmail>
            ");
    
            log.info("Invoice email sent successfully to: #recipientEmail#");
        } catch (any e) {
            log.error("Error sending email: " & e.message);
            throw(type="EmailException", message="Error sending email: #e.message#");
        }
    }

    function sendInvoiceEmail(required any invoice, required string pdfPath) {
        var recipientEmail = invoice.getUser().getEmail();
        var recipientName = invoice.getUser().getName();
        var invoiceNo = invoice.getInvoiceNo();
        var invoiceAmount = numberFormat(invoice.getAmount(), '999,999.99');
        var dueDate = dateFormat(invoice.getDueDate(), 'mmmm d, yyyy');
    
        log.info("Sending invoice email to: #recipientEmail# with PDF: #pdfPath#");
    
        try {
            writeOutput("
                <cfmail to='#recipientEmail#'
                        from='pulukuriabhiram2024@gmail.com'
                        subject='Invoice #invoiceNo#'
                        type='html'
                        server='smtp.gmail.com'
                        username='pulukuriabhiram2024@gmail.com'
                        password='tebb sidt iyjd aket'
                        port='587'
                        useTLS='true'
                        logFile='C:\Users\abhiram.pulukuri\.CommandBox\server\7F4D2197584D0940D315C7663FA5B400-Invoice Management System\adobe-2023.0.12.330713\WEB-INF\cfusion\logs\mail.log'>
    
                    <cfmailparam file='#pdfPath#' type='application/pdf'  name='Invoice_#invoiceNo#.pdf'>
    
                    <p>Hello #recipientName#,</p>
                    <p>Please find attached your invoice (#invoiceNo#) for the amount of $#invoiceAmount#.</p>
                    <p><strong>Due Date:</strong> #dueDate#</p>
                    <p>Thank you for your business!</p>
                    <p>Best Regards,<br>Your Company</p>
    
                </cfmail>
            ");
            log.info("Invoice email sent successfully to: #recipientEmail#");
        } catch (any e) {
            log.error("Error sending email: " & e.message);
            throw(type="EmailException", message="Error sending email: #e.message#");
        }
    }
    }
    **/
    

