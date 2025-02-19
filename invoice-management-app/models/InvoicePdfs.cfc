    // component persistent="true" table="invoice_pdfs" entityname="InvoicePdfs"  {
        
    //     property name="id" column="id" fieldtype="id" generator="native" setter="false";
    //     property name="invoice" fieldtype="one-to-one" cfc="Invoice" fkcolumn="invoice_id";
    //     property name="pdfPath" column="pdf_path" ormtype="string";
    //     property name="createdAt" column="created_at" ormtype="timestamp";

    //     function init(){
    //         return this;
    //     }

    //     function isLoaded(){
    //         return !isNull( id ) && id > 0;
    //     }

    //     // Getters
    //     function getId(){ return variables.id; }
    //     function getPdfPath(){ return variables.pdfPath; }
    //     function getCreatedAt(){ return variables.createdAt; }

    //     // Setters
    //     function setPdfPath(required string pdfPath){ variables.pdfPath = pdfPath; }
        
    // }

    component persistent="true" table="invoice_pdfs" entityname="InvoicePdfs" {
    
        property name="id" column="id" fieldtype="id" generator="native" setter="false";
        property name="invoice" fieldtype="one-to-one" cfc="Invoice" fkcolumn="invoice_id";
        property name="pdfPath" column="pdf_path" ormtype="string";
        property name="createdAt" column="created_at" ormtype="timestamp";
    
        function init(){
            return this;
        }
    
        function isLoaded(){
            return !isNull(id) && id > 0;
        }
    
        // Getters
        function getId(){ return variables.id; }
        function getPdfPath(){ return variables.pdfPath; }
        function getCreatedAt(){ return variables.createdAt; }

        
        function setInvoice(required any invoice) { variables.invoice = arguments.invoice; }

        // Setters
        function setPdfPath(required string pdfPath){ variables.pdfPath = pdfPath; }
    }
    
