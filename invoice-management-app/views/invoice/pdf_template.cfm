<cfoutput>
  <!DOCTYPE html>
  <html>
  <head>
      <meta charset="UTF-8">
      <title>Invoice</title>
      <style>
          body {
              font-family: Arial, sans-serif;
              margin: 40px;
              color: ##333;
          }
          .header {
              text-align: center;
              margin-bottom: 30px;
          }
          .invoice-details {
              margin-bottom: 30px;
          }
          .invoice-table {
              width: 100%;
              border-collapse: collapse;
              margin-bottom: 30px;
          }
          .invoice-table th, .invoice-table td {
              border: 1px solid ##ddd;
              padding: 8px;
          }
          .total {
              text-align: right;
              font-weight: bold;
          }
      </style>
  </head>
  <body>
      <div class="header">
          <h1>INVOICE</h1>
      </div>
  
      <div class="invoice-details">
          <p><strong>Invoice No:</strong> #args.invoice.getInvoiceNo()#</p>
          <p><strong>Date:</strong> #dateFormat(now(), "mmmm dd, yyyy")#</p>
          <p><strong>Due Date:</strong> #dateFormat(args.invoice.getDueDate(), "mmmm dd, yyyy")#</p>
          <p><strong>Status:</strong> #args.invoice.getStatus()#</p>
      </div>
  
      <div class="invoice-details">
          <h3>Customer Details</h3>
          <p><strong>Name:</strong> #args.invoice.getUser().getName()#</p>
          <p><strong>Email:</strong> #args.invoice.getUser().getEmail()#</p>
      </div>
  
      <table class="invoice-table">
          <tr>
              <th>Description</th>
              <th>Amount</th>
          </tr>
          <tr>
              <td>Invoice Amount</td>
              <td>$#numberFormat(args.invoice.getAmount(), ",.2f")#</td>
          </tr>
      </table>
  
      <div class="total">
          <p>Total Amount: $#numberFormat(args.invoice.getAmount(), ",.2f")#</p>
      </div>
  
      <cfset local.payment = entityLoad("Payment", { invoice: args.invoice }, true)>
      <cfif !isNull(local.payment)>
          <div class="invoice-details">
              <h3>Payment Details</h3>
              <p><strong>Amount Paid:</strong> $#numberFormat(local.payment.getAmountPaid(), ",.2f")#</p>
              <p><strong>Payment Date:</strong> #dateFormat(local.payment.getPaymentDate(), "mmmm dd, yyyy")#</p>
              <p><strong>Payment Method:</strong> #local.payment.getMethod()#</p>
          </div>
      </cfif>
  
      <p>Thank you for your business!</p>
  </body>
  </html>
  </cfoutput>