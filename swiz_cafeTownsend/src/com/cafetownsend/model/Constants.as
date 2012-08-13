package com.cafetownsend.model
{
	import com.cafetownsend.domain.Employee;
	
	import ext.babelfx.events.BabelEvent;
	
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	
	import spark.effects.easing.IEaser;
	import spark.effects.easing.Power;

	[l10n(change="onLocaleChanged")]
	
	[Bindable]
	public class Constants
	{
		public var EMPLOYEE_INVALID_FIRSTNAME : String = "Please enter first name.";
		public var EMPLOYEE_INVALID_LASTNAME  : String = "Please enter last name.";

		public var LOGIN_INVALID_USERNAME 	: String = "Please enter your username!";
		public var LOGIN_INVALID_PASSWORD 	: String = "Please enter your password!";
		
		public var LOGIN_FAILED_TITLE 		: String = "Login Failed!";
		public var LOGIN_FAILED_MESSAGE 		: String = "Username/Password do not match!";
		
		public var EMPLOYEE_LOAD_ERROR 		: String = "Unable to get loaded data of employees: {0}";
		public var EMPLOYEE_CONFIRM_DELETE 	: String = 'Are you sure you want to delete "{0} {1}"?';
		
		// effects
		public const EFFECT_DURATION			: int = 400;	
		public const EFFECT_EASE				: IEaser = new Power( 0.30 );
		
		/**
		 * To support l10n injection into non-displayObjects (e.g. data models)
		 * the LocaleMap must have instance references. So we use Swiz to inject
		 * a reference to each model bean instance that will be used or modified
		 * when locales change.
		 * 
		 */			
		[Inject("employeeModel.selectedEmployee")]
		public function set selectedEmployee(value:Employee):void {
			_selectedEmployee = value;
			EMPLOYEE_CONFIRM_DELETE = buildConfirmMessage();
		}

		
		/**
		 * Whenever the locale changes
		 */
		public function onLocaleChanged(event:BabelEvent):void
		{
			/**
			 * l10nInjection supports injection into both GUI and non-GUI instances (data models, 
			 * controllers, etc). But static variables cannot be directly modifed with injection.
			 * We must hook into the localeChanged event and then manually update the static globals 
			 * with current locale value [shown below]:
			 */
			LOGIN_FAILED_MESSAGE   		= rMngr.getString("login","login.error.noMatch");
			LOGIN_FAILED_TITLE     		= rMngr.getString("login","login.error.title");
			LOGIN_INVALID_USERNAME 		= rMngr.getString("login","login.error.usernameRequired");
			LOGIN_INVALID_PASSWORD 		= rMngr.getString("login","login.error.passwordRequired");
			
			EMPLOYEE_LOAD_ERROR 		= rMngr.getString("employees","users.unableToLoad");
			EMPLOYEE_INVALID_FIRSTNAME 	= rMngr.getString("employees","editor.invalid.firstName");
			EMPLOYEE_INVALID_LASTNAME  	= rMngr.getString("employees","editor.invalid.lastName") ;
			EMPLOYEE_CONFIRM_DELETE 	= buildConfirmMessage();
		}
		
		private function buildConfirmMessage():String {
			var params : Array = _selectedEmployee ? [_selectedEmployee.firstName, _selectedEmployee.lastName] : ["",""]; 
			return 	rMngr.getString("employees","users.confirmDelete",params);
		}
		
		private function get rMngr() : IResourceManager 
		{
			return ResourceManager.getInstance();
		}
		
		private var _selectedEmployee : Employee;
	}
}