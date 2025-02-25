﻿/**
 * Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
 * www.ortussolutions.com
 * ---
 * Console Appender
 */
component accessors="true" extends="wirebox.system.logging.AbstractAppender" {

	/**
	 * Constructor
	 *
	 * @name       The unique name for this appender.
	 * @properties A map of configuration properties for the appender"
	 * @layout     The layout class to use in this appender for custom message rendering.
	 * @levelMin   The default log level for this appender, by default it is 0. Optional. ex: LogBox.logLevels.WARN
	 * @levelMax   The default log level for this appender, by default it is 5. Optional. ex: LogBox.logLevels.WARN
	 */
	function init(
		required name,
		struct properties = {},
		layout            = "",
		levelMin          = 0,
		levelMax          = 4
	){
		super.init( argumentCollection = arguments );

		// Output Streams
		variables.stdout = createObject( "java", "java.lang.System" ).out;
		variables.stderr = createObject( "java", "java.lang.System" ).err;

		return this;
	}

	/**
	 * Write an entry into the appender.
	 *
	 * @logEvent The logging event to log
	 *
	 * @return ConsoleAppender
	 */
	function logMessage( required wirebox.system.logging.LogEvent logEvent ){
		var timestamp = arguments.logEvent.getTimestamp();
		var message   = arguments.logEvent.getMessage();
		var entry     = "";

		// Message Layout
		if ( hasCustomLayout() ) {
			entry = getCustomLayout().format( arguments.logEvent );
		} else {
			// Cleanup main message
			if ( len( arguments.logEvent.getExtraInfoAsString() ) ) {
				message &= " | ExtraInfo: " & arguments.logEvent.getExtraInfoAsString();
			}

			// Entry string
			entry = "#dateFormat( timestamp, "yyyy-mm-dd" )# #timeFormat( timestamp, "HH:MM:SS" )# #arguments.logEvent.getCategory()# #message#";
		}

		// Log it
		switch ( logEvent.getSeverity() ) {
			// Fatal + Error go to error stream
			case "0":
			case "1": {
				// log message
				queueMessage( { message : entry, isError : true } );
				break;
			}
			// Warning and above go to info stream
			default: {
				// log message
				queueMessage( { message : entry, isError : false } );
				break;
			}
		}

		return this;
	}

	/**
	 * Processes a queue element to a destination
	 * This method is called by the log listeners asynchronously.
	 *
	 * @data         The data element the queue needs processing
	 * @queueContext The queue context in process
	 *
	 * @return ConsoleAppender
	 */
	function processQueueElement( required data, required queueContext ){
		if ( arguments.data.isError ) {
			variables.stderr.println( arguments.data.message );
		} else {
			variables.stdout.println( arguments.data.message );
		}
		return this;
	}

}
