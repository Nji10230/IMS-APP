<cfoutput>
    <!DOCTYPE html>
    <html>
    <head>
        <title>Generate Invoice PDF</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 40px;
                color: ##333;
                background-color: ##f8f9fa;
            }
            .container {
                max-width: 500px;
                margin: 30px auto;
                padding: 20px;
                background: white;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
            }
            h2 {
                text-align: center;
                color: ##007bff;
            }
            .form-group {
                margin-bottom: 15px;
            }
            label {
                display: block;
                font-weight: bold;
                margin-bottom: 5px;
            }
            input {
                width: 100%;
                padding: 8px;
                border: 1px solid ##ddd;
                border-radius: 4px;
                box-sizing: border-box;
            }
            .btn-submit {
                background-color: ##007bff;
                color: white;
                padding: 10px 15px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                width: 100%;
            }
            .btn-submit:hover {
                background-color: ##0056b3;
            }
            .error {
                color: red;
                font-size: 0.9em;
                margin-top: 5px;
                display: none;
            }
            .success-message {
                color: green;
                font-weight: bold;
                text-align: center;
                margin-top: 10px;
            }
            .download-link {
                text-align: center;
                margin-top: 10px;
            }
        </style>
    </head>
    <body>
    
        <div class="container">
            <h2>Generate Invoice PDF</h2>
            <form id="invoiceForm" onsubmit="return handleSubmit(event)">
                <div class="form-group">
                    <label for="invoiceId">Invoice ID:</label>
                    <input type="number" id="invoiceId" name="invoiceId" required>
                    <div id="invoiceIdError" class="error">Invoice ID is required</div>
                </div>
                <button type="submit" class="btn-submit">Generate PDF</button>
            </form>
            
            <div id="message" class="success-message"></div>
            <div id="pdfLink" class="download-link"></div>
        </div>
    
        <script>
            function handleSubmit(event) {
                event.preventDefault();
                document.querySelectorAll('.error').forEach(error => error.style.display = 'none');
    
                const invoiceId = document.getElementById('invoiceId').value.trim();
                let isValid = true;
    
                if (!invoiceId) {
                    document.getElementById('invoiceIdError').style.display = 'block';
                    isValid = false;
                }
    
                if (isValid) {
                    // Create form and submit data
                    const formData = new FormData();
                    formData.append("invoiceId", invoiceId);
    
                    fetch("/invoice/generate", {
                        method: "POST",
                        body: formData
                    })
                    .then(response => response.json())
                    .then(data => {
                        if (data.success) {
                            document.getElementById("message").innerHTML = "Invoice PDF generated successfully!";
                            document.getElementById("pdfLink").innerHTML = `
                                <a href="${data.pdfPath}" target="_blank" download>Download PDF</a>
                            `;
                        } else {
                            throw new Error(data.message || "Failed to generate invoice PDF");
                        }
                    })
                    .catch(error => {
                        console.error("Error:", error);
                        document.getElementById("message").innerHTML = "Error: " + error.message;
                    });
                }
                return false;
            }
        </script>
    
    </body>
    </html>
    </cfoutput>
    