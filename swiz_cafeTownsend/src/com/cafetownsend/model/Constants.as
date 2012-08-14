package com.cafetownsend.model
{
	import com.cafetownsend.domain.Employee;
	
	import flash.events.Event;
	
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	
	import spark.effects.easing.IEaser;
	import spark.effects.easing.Power;

	// ***********************************************************
	// MetaData - BabelFx Localization tags
	// ***********************************************************
	
	[ l10n (  bundle="login", 	property="LOGIN_FAILED_MESSAGE", 		key="login.error.noMatch" 			)]
	[ l10n (  bundle="login", 	property="LOGIN_FAILED_TITLE", 			key="login.error.title"			 	)]
	[ l10n (  bundle="login", 	property="LOGIN_INVALID_USERNAME", 		key="login.error.usernameRequired" 	)]
	[ l10n (  bundle="login", 	property="LOGIN_INVALID_PASSWORD", 		key="login.error.passwordRequired" 	)]
	       
	[ l10n (  bundle="employees", property="EMPLOYEE_LOAD_ERROR", 		key="users.unableToLoad"			)]
	[ l10n (  bundle="employees", property="EMPLOYEE_INVALID_FIRSTNAME", 	key="editor.invalid.firstName" 	 	)]
	[ l10n (  bundle="employees", property="EMPLOYEE_INVALID_LASTNAME", 	key="editor.invalid.lastName"	 	)]
	[ l10n (  bundle="employees", property="EMPLOYEE_CONFIRM_DELETE", 	key="users.confirmDelete",	 parameters="employee.firstName, employee.lastName"  )]
	
	
	[Bindable]
	public class Constants
	{
		public var LOGIN_FAILED_TITLE 		    : String = "Login Failed!";
		public var LOGIN_FAILED_MESSAGE 	   	: String = "Username/Password do not match!";
		public var LOGIN_INVALID_USERNAME 	    : String = "Please enter your username!";
		public var LOGIN_INVALID_PASSWORD 	    : String = "Please enter your password!";
		                                        
		public var EMPLOYEE_LOAD_ERROR 		    : String = "Unable to get loaded data of employees: {0}";
		public var EMPLOYEE_INVALID_FIRSTNAME   : String = "Please enter first name.";
		public var EMPLOYEE_INVALID_LASTNAME    : String = "Please enter last name.";
		public var EMPLOYEE_CONFIRM_DELETE 	    : String = 'Are you sure you want to delete "{0} {1}"?';

		
		// effects
		public const EFFECT_DURATION			: int = 400;	
		public const EFFECT_EASE				: IEaser = new Power( 0.30 );
		
		
		[Inject("employeeModel.selectedEmployee")]
		public var employee : Employee;

	}
}