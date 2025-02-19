<cfmail to="#recipientEmail#"
        from="pulukuriabhiram2024@gmail.com"
        subject="Invoice #invoiceNo#"
        type="html"
        server="smtp.gmail.com"
        username="pulukuriabhiram2024@gmail.com"
        password="tebb sidt iyjd aket"
        port="587"
        useTLS="true">
    
    <cfmailparam file="#pdfPath#" type="application/pdf" disposition="attachment" name="Invoice_#invoiceNo#.pdf">

    <p>Hello #recipientName#,</p>
    <p>Please find attached your invoice (#invoiceNo#) for the amount of $#invoiceAmount#.</p>
    <p><strong>Due Date:</strong> #dueDate#</p>
    <p>Thank you for your business!</p>
    <p>Best Regards,<br>Your Company</p>
</cfmail>
