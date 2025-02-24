/**
 * This is your application router.  From here you can controll all the incoming routes to your application.
 *
 * https://coldbox.ortusbooks.com/the-basics/routing
 */
component {

	function configure(){
		/**
		 * --------------------------------------------------------------------------
		 * Router Configuration Directives
		 * --------------------------------------------------------------------------
		 * https://coldbox.ortusbooks.com/the-basics/routing/application-router#configuration-methods
		 */
		setFullRewrites( true );

		/**
		 * --------------------------------------------------------------------------
		 * App Routes
		 * --------------------------------------------------------------------------
		 * Here is where you can register the routes for your web application!
		 * Go get Funky!
		 */

		// A nice healthcheck route example
		route( "/healthcheck", function( event, rc, prc ){
			return "Ok!";
		} );

		// A nice RESTFul Route example
		route( "/api/echo", function( event, rc, prc ){
			return { "error" : false, "data" : "Welcome to my awesome API!" };
		} );


		route("/user/new").to("UserController.new");
		route("/invoice/new").to("InvoiceController.new");
		route("/invoice/generating").to("InvoicePdfController.generated");

		route("/user/create")
        .withAction({POST: "create"})
        .toHandler("UserController");

		route("/invoice/create")
		.withAction({POST: "create"})
		.toHandler("InvoiceController");
		
		route("/payment/create")
		.withAction({POST: "create"})
		.toHandler("PaymentController");

		route("/invoice/generate").
		withAction({POST: "generate"}).
		toHandler("InvoicePdfController");


		route("/invoice/download/:invoiceId")
		.withAction({GET: "download"})
		.toHandler("InvoicePdfController");

     
	
		// @app_routes@

		// Conventions-Based Routing
		route( ":handler/:action?" ).end();
	}

}
