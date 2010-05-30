package com.cafetownsend.model
{
	import spark.effects.easing.IEaser;
	import spark.effects.easing.Power;

	final public class Constants
	{
		public static var EMPLOYEE_INVALID_FIRSTNAME : String = "Please enter first name.";
		public static var EMPLOYEE_INVALID_LASTNAME  : String = "Please enter last name.";

		public static var LOGIN_INVALID_USERNAME 	: String = "Please enter your username!";
		public static var LOGIN_INVALID_PASSWORD 	: String = "Please enter your password!";
		
		public static var LOGIN_FAILED_TITLE 		: String = "Login Failed!";
		public static var LOGIN_FAILED_MESSAGE 		: String = "Username/Password do not match!";
		
		public static var EMPLOYEE_LOAD_ERROR 		: String = "Unable to get loaded data of employees: {0}";
		public static var EMPLOYEE_CONFIRM_DELETE 	: String = 'Are you sure you want to delete "{0} {1}"?';
		
		// effects
		public static const EFFECT_DURATION			: int = 400;	
		public static const EFFECT_EASE				: IEaser = new Power( 0.30 );
	}
}