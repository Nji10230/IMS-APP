<cfoutput>
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Create Invoice</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 40px;
                background-color: ##f4f4f4;
            }
            .container {
                width: 400px;
                background: white;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
                margin: auto;
            }
            input, select {
                width: 100%;
                padding: 8px;
                margin: 10px 0;
                border-radius: 5px;
                border: 1px solid ##ccc;
            }
            button {
                width: 100%;
                padding: 10px;
                background: ##28a745;
                color: white;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }
            button:hover {
                background: ##218838;
            }
            .error {
                color: red;
                margin-top: 5px;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Create Invoice</h2>
            <form id="invoiceForm" method="post" action="/invoice/create">
                <label for="userId">User ID:</label>
                <input type="number" id="userId" name="userId" required>
    
                <label for="invoiceNo">Invoice Number:</label>
                <input type="text" id="invoiceNo" name="invoiceNo" required>
    
                <label for="amount">Amount:</label>
                <input type="number" id="amount" name="amount" step="0.01" required>
    
                <label for="status">Status:</label>
                <select id="status" name="status">
                    <option value="pending">Pending</option>
                    <option value="paid">Paid</option>
                    <option value="overdue">Overdue</option>
                </select>
    
                <label for="dueDate">Due Date:</label>
                <input type="date" id="dueDate" name="dueDate" required>
    
                <button type="submit">Create Invoice</button>
            </form>
    
            <p id="message" class="error"></p>
        </div>
    
        <script>
            document.getElementById("invoiceForm").onsubmit = function(event) {
                var userId = document.getElementById("userId").value.trim();
                var invoiceNo = document.getElementById("invoiceNo").value.trim();
                var amount = document.getElementById("amount").value.trim();
                var dueDate = document.getElementById("dueDate").value.trim();
    
                if (!userId || !invoiceNo || !amount || !dueDate) {
                    event.preventDefault(); 
                    document.getElementById("message").innerText = "All fields are required!";
                }
            };
        </script>
    </body>
    </html>
    </cfoutput>
    