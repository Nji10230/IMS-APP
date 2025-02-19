<cfoutput>
    <!DOCTYPE html>
    <html>
    <head>
        <style>
            body { font-family: Arial, sans-serif; margin: 20px; }
            .header { text-align: center; margin-bottom: 30px; }
            .invoice-details { margin-bottom: 20px; }
            table { width: 100%; border-collapse: collapse; margin: 20px 0; }
            th, td { border: 1px solid ##ddd; padding: 8px; }
            th { background-color: ##f5f5f5; }
            .amount { text-align: right; }
            .balance { font-size: 18px; font-weight: bold; margin-top: 20px; }
        </style>
    </head>
    <body>
        <div class="header">
            <h1>Invoice ###invoice.getInvoiceNo()#</h1>
        </div>
        
        <div class="invoice-details">
            <p><strong>Client:</strong> #invoice.getUser().getFullName()#</p>
            <p><strong>Due Date:</strong> #dateFormat(invoice.getDueDate(), 'mmmm d, yyyy')#</p>
            <p><strong>Total Amount:</strong> $#numberFormat(invoice.getAmount(), ',.##')#</p>
        </div>
    
        <h2>Payment History</h2>
        <table>
            <thead>
                <tr>
                    <th>Date</th>
                    <th>Method</th>
                    <th>Amount</th>
                </tr>
            </thead>
            <tbody>
                #paymentInfo.paymentDetails#
            </tbody>
        </table>
    
        <div class="balance">
            <p>Total Paid: $#numberFormat(paymentInfo.totalPaid, ',.##')#</p>
            <p>Balance Due: $#numberFormat(paymentInfo.balance, ',.##')#</p>
        </div>
    </body>
    </html>
    </cfoutput>