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

	/**
	 * --------------------------------------------------------------------------
	 * Location Mappings
	 * --------------------------------------------------------------------------
	 * - cbApp : Quick reference to root application
	 * - coldbox : Where ColdBox library is installed
	 */
	this.mappings[ "/cbapp" ]   = COLDBOX_APP_ROOT_PATH;
	this.mappings[ "/coldbox" ] = COLDBOX_APP_ROOT_PATH & "coldbox";
	this.mappings[ "/logbox" ] = COLDBOX_APP_ROOT_PATH & "logbox";
	this.mappings[ "/models" ] = COLDBOX_APP_ROOT_PATH & "models";
	this.mappings["/"] = getDirectoryFromPath(getCurrentTemplatePath());
	this.mappings[ "/cborm" ] = COLDBOX_APP_ROOT_PATH & "modules/cborm";

	/**
	 * --------------------------------------------------------------------------
	 * ORM + Datasource Settings
	 * --------------------------------------------------------------------------
	 */
	this.datasource = "coldbox";
	this.datasources["coldbox"] = {
		class: "com.mysql.cj.jdbc.Driver", 
		bundleName: "com.mysql.cj", 
		bundleVersion: "9.1.0",
		connectionString: "jdbc:mysql://localhost:3306/imsdb_lucee?useUnicode=true&characterEncoding=UTF-8&tinyInt1isBit=true&serverTimezone=Asia/Calcutta&autoReconnect=true&useSSL=true&maxReconnects=12&useOldAliasMetadataBehavior=true&allowMultiQueries=true&useLegacyDatetimeCode=true",
		username: "root",
		password: "0000",
		
		// optional settings
		blob:true, // default: false
		clob:true, // default: false
		connectionLimit:4, // default:-1
		liveTimeout:15, // default: -1; unit: minutes
		alwaysSetTimeout:true, // default: false
		validate:true  // default: false
	};

	this.ormEnabled = "true";
   this.ormSettings = {
	cfclocation = [ "models" ], // Where our entities exist
	logSQL = true, // Remove after development to false.
	dbcreate = "update",
	dialect = "MySQL", // Generate our DB
	automanageSession = false, // Let cborm manage it
	flushAtRequestEnd = false, // Never do this! Let cborm manage itG
	eventhandling = true, // Enable events
	 // Who handles the events
	skipcfcWithError = true // Yes, because we must work in all CFML engines
};


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

		if( application.cbBootstrap.isFWReinit() )
			ormReload();
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
