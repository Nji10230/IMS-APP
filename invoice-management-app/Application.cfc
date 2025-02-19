/**
 * Copyright 2005-2007 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
 * www.ortussolutions.com
 * ---
 * Application Bootstrap
 */
component {

	/**
	 * --------------------------------------------------------------------------
	 * Application Properties: Modify as you see fit!
	 * --------------------------------------------------------------------------
	 */
	this.name                 = "My ColdBox Application";
	this.sessionManagement    = true;
	this.sessionTimeout       = createTimespan( 0, 1, 0, 0 );
	this.setClientCookies     = true;
	this.setDomainCookies     = true;
	this.scriptProtect        = false;
	this.secureJSON           = false;
	this.timezone             = "UTC";
	this.whiteSpaceManagement = "smart";

	/**
	 * --------------------------------------------------------------------------
	 * Java Integration
	 * --------------------------------------------------------------------------
	 * Modify only if you need to, else default them: https://cfdocs.org/application-cfc
	 */
	this.javaSettings = {
		loadPaths               : [ expandPath( "./lib/java" ) ],
		loadColdFusionClassPath : true,
		reloadOnChange          : false
	};

	/**
	 * --------------------------------------------------------------------------
	 * ColdBox Bootstrap Settings
	 * --------------------------------------------------------------------------
	 * Modify only if you need to, else default them.
	 * https://coldbox.ortusbooks.com/getting-started/configuration/bootstrapper-application.cfc
	 */
	// COLDBOX STATIC PROPERTY, DO NOT CHANGE UNLESS THIS IS NOT THE ROOT OF YOUR COLDBOX APP
	COLDBOX_APP_ROOT_PATH = getDirectoryFromPath( getCurrentTemplatePath() );
	// The web server mapping to this application. Used for remote purposes or static purposes
	COLDBOX_APP_MAPPING   = "";
	// COLDBOX PROPERTIES
	COLDBOX_CONFIG_FILE   = "";
	// COLDBOX APPLICATION KEY OVERRIDE
	COLDBOX_APP_KEY       = "";
	// By default if a reinit is issued, other requests fail and wait.
	COLDBOX_FAIL_FAST     = true;

	this.mappings[ "/logbox" ] = COLDBOX_APP_ROOT_PATH & "logbox";


	/**
	 * --------------------------------------------------------------------------
	 * Location Mappings
	 * --------------------------------------------------------------------------
	 * - cbApp : Quick reference to root application
	 * - coldbox : Where ColdBox library is installed
	 */
	this.mappings[ "/cbapp" ]   = COLDBOX_APP_ROOT_PATH;
	this.mappings[ "/coldbox" ] = COLDBOX_APP_ROOT_PATH & "coldbox";
	this.mappings["/views"] = "C:\IMS\invoice-management-app\views";
	this.mappings[ "/logbox" ] = COLDBOX_APP_ROOT_PATH & "logbox";
// In Application.cfc
this.mappings["/"] = getDirectoryFromPath(getCurrentTemplatePath());


	/**
	 * --------------------------------------------------------------------------
	 * ORM + Datasource Settings
	 * --------------------------------------------------------------------------
	 */
	this.datasource = {
		name      = "coldbox",
		dbtype    = "mysql",
		host      = "localhost",
		database  = "imsdb",
		username  = "root",
		password  = "0000",
		port      = "3306",
		class     = "com.mysql.cj.jdbc.Driver"
	};

	// ORM Configuration
	this.ormEnabled        = true;
	this.ormSettings = {
		cfclocation = [ "models" ], // Where our entities exist
		logSQL = true, // Remove after development to false.
		dbcreate = "update",
        dialect = "MySQL5InnoDB", // Specifically using InnoDB
		automanageSession = false, // Let cborm manage it
		flushAtRequestEnd = false, // Never do this! Let cborm manage it
		eventhandling = true, // Enable events
		skipcfcWithError = true // Yes, because we must work in all CFML engines
	};
	this.mailSettings = {
		server = "smtp.gmail.com",
		username = "pulukuriabhiram2024@gmail.com",
		password = "tebb sidt iyjd aket",  // Use the 16-character App Password here
		port = 587,
		tls = true,
		logFile="C:\Users\abhiram.pulukuri\.CommandBox\server\7F4D2197584D0940D315C7663FA5B400-Invoice Management System\adobe-2023.0.12.330713\WEB-INF\cfusion\logs\mail.log"
	};
	

	//this.logbox=

	/**
	 * Fires when the application starts
	 */
	public boolean function onApplicationStart(){
		setting requestTimeout ="300";
		application.cbBootstrap= new coldbox.system.Bootstrap(
			COLDBOX_CONFIG_FILE,
			COLDBOX_APP_ROOT_PATH,
			COLDBOX_APP_KEY,
			COLDBOX_APP_MAPPING
		);
		application.cbBootstrap.loadColdbox();
		ormReload();
		return true;
	}

	/**
	 * Fires when the application ends
	 *
	 * @appScope The app scope
	 */
	public void function onApplicationEnd( struct appScope ){
		arguments.appScope.cbBootstrap.onApplicationEnd( arguments.appScope );
	}

	/**
	 * Fires on every request
	 *
	 * @targetPage The requested page
	 */
	public boolean function onRequestStart( string targetPage ){
		// Process ColdBox Request
		application.cbBootstrap.onRequestStart( arguments.targetPage );
		return true;
	}

	/**
	 * Fires on every session start
	 */
	public void function onSessionStart(){
		if ( !isNull( application.cbBootstrap ) ) {
			application.cbBootStrap.onSessionStart();
		}
	}

	/**
	 * Fires on session end
	 *
	 * @sessionScope The session scope
	 * @appScope     The app scope
	 */
	public void function onSessionEnd( struct sessionScope, struct appScope ){
		arguments.appScope.cbBootStrap.onSessionEnd( argumentCollection = arguments );
	}

	/**
	 * On missing template handler
	 *
	 * @template
	 */
	public boolean function onMissingTemplate( template ){
		return application.cbBootstrap.onMissingTemplate( argumentCollection = arguments );
	}

}
