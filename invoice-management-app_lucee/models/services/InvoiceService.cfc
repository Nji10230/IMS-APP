component singleton {

    function init(){
        return this;
    }

    function create(required struct invoiceData) {
        try {
            var invoice = entityNew("Invoice");
            
            // Validate user first
            var user = entityLoadByPK("User", invoiceData.userId);
            if (isNull(user)) {
                throw(type="ValidationException", message="User not found");
            }

            // Convert amount to numeric and validate
            var numericAmount = val(invoiceData.amount);
            if (numericAmount <= 0) {
                throw(type="ValidationException", message="Invalid amount value");
            }

            // Set invoice properties
            invoice.setInvoiceNo(invoiceData.invoiceNo);
            invoice.setAmount(numericAmount); // Now passing a properly converted numeric value
            invoice.setStatus(invoiceData.status);
            invoice.setDueDate(parseDateTime(invoiceData.dueDate));
            invoice.setUser(user);

            entitySave(invoice);
            ormFlush();

            return {
                id: invoice.getId(),
                invoiceNo: invoice.getInvoiceNo(),
                amount: invoice.getAmount(),
                status: invoice.getStatus(),
                dueDate: dateFormat(invoice.getDueDate(), "yyyy-mm-dd"),
                userId: user.getId()
            };
        }
        catch (any e) {
            throw(
                type="InvoiceService.CreateInvoiceError",
                message="Error creating invoice: " & e.message,
                detail=e.detail
            );
        }
    }
}

