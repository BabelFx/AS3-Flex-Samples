package com.cafetownsend.presentation
{
	
	import com.cafetownsend.domain.Employee;
	import com.cafetownsend.event.EmployeeEvent;
	import com.cafetownsend.model.Constants;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import mx.events.ValidationResultEvent;
	import mx.logging.ILogger;
	import mx.validators.EmailValidator;
	import mx.validators.StringValidator;
	
	import spark.components.Application;
	
	public class EmployeeDetailPresentationModel extends EventDispatcher
	{
		[Log]			public var log  	 : ILogger 			= null;		
		[Dispatcher]	public var dispatcher:IEventDispatcher  = null;
		
		//--------------------------------------------------------------------------
		//
		// selected employee
		//
		//--------------------------------------------------------------------------
		
		
		private var _selectedEmployee:Employee = null;
		
		
		[Bindable]
		[Inject("employeeModel.selectedEmployee")]
		public function get selectedEmployee( ):Employee {
			return _selectedEmployee;
		}

		public function set selectedEmployee( employee:Employee ):void {
			if( employee != null && (_selectedEmployee !== employee) ) {
				if (log != null) log.debug("set selectedEmployee({0})",employee.fullName);
				
				_selectedEmployee = employee;
				
				if( employee != null )
					tempEmployee = _selectedEmployee.clone();

			}
		}
		
		
		//--------------------------------------------------------------------------
		//
		// temp. employee
		//
		//--------------------------------------------------------------------------
		
		private var _tempEmployee:Employee = new Employee();
		
		public static const TEMP_EMPLOYEE_CHANGED:String = "tempEmployeeChanged";
		
		
		[Bindable(Event="tempEmployeeChanged")]	
		public function get tempEmployee( ):Employee
		{
			return _tempEmployee;
		}
		
		public function set tempEmployee( employee:Employee ):void {
			if( _tempEmployee !== employee ) {
				if (log != null) log.debug("set tempEmployee({0})",employee.fullName);
				
				_tempEmployee = employee;
				this.dispatchEvent( new Event( TEMP_EMPLOYEE_CHANGED ) );
			}
		}



		[Bindable(Event="tempEmployeeChanged")]	
		public function get selectedEmployeeCanBeDeleted( ):Boolean
		{
			return !selectedEmployee.isEmpty();
		}

		
		
		//--------------------------------------------------------------------------
		//
		// Cancel editing
		//
		//--------------------------------------------------------------------------
		
		public function cancelEmployeeEdits() : void  {
			if (log != null) log.debug("cancelEmployeeEdits()");
			
			clearValidationMessages();
			
			dispatcher.dispatchEvent( new EmployeeEvent( EmployeeEvent.CANCEL ) );
		}
		
		//--------------------------------------------------------------------------
		//
		// update employee
		//
		//--------------------------------------------------------------------------
		
		public function updateEmployee( ):void {
			if (log != null) log.debug("updateEmployee()");
			
			if( validateEmployee( tempEmployee ) )
			{
				clearValidationMessages();
				
				var event:EmployeeEvent = new EmployeeEvent( EmployeeEvent.UPDATE, _tempEmployee.clone() );
				
				dispatcher.dispatchEvent(event);				
			}
			else
			{
				this.dispatchEvent( new Event( VALIDATION_CHANGED ) );
			}
			
		}
		
		//--------------------------------------------------------------------------
		//
		// delete employee
		//
		//--------------------------------------------------------------------------
		
		
		public function deleteEmployee() : void  {
			if (log != null) log.debug("deleteEmployee()");
			
			dispatcher.dispatchEvent( new EmployeeEvent( EmployeeEvent.DELETE ) );	
		}
		
		
		//--------------------------------------------------------------------------
		//
		// validation
		//
		//--------------------------------------------------------------------------
		
		
		protected var emailValidator:EmailValidator;
		protected var stringValidator:StringValidator;
		

		public function validateEmployee( employee:Employee ):Boolean {
			// create stringValidator if not created yet
			stringValidator ||= new StringValidator();
			
			var stringValidation: ValidationResultEvent = stringValidator.validate( employee.firstName );
			var validFirstname:Boolean = stringValidation.results == null;
			_firstNameError = ( validFirstname ) ? "" : Constants.EMPLOYEE_INVALID_FIRSTNAME;

			stringValidation = stringValidator.validate( employee.lastName );
			var validLastname:Boolean = stringValidation.results == null;
			_lastNameError = ( validLastname ) ? "" : Constants.EMPLOYEE_INVALID_LASTNAME;
			
			// create emailValidator if not created yet
			emailValidator ||= new EmailValidator();
			
			var emailValidation:ValidationResultEvent = emailValidator.validate( employee.email);
			var validEmail:Boolean = emailValidation.results == null;
			_emailError = ( validEmail ) ? "" : emailValidation.message;

			if (log != null) log.debug("validateEmployee({0}): validFirstname={1},validLastname={2},validEmail={3}", employee.fullName,validFirstname,validLastname,validEmail);
			
			return ( validFirstname  &&  validLastname && validEmail );
		}
		
		
		public static const VALIDATION_CHANGED:String = "validationChanged";
		
		
		protected function clearValidationMessages():void  {
			_firstNameError
			= _lastNameError
			= _emailError
			= '';
			
			if (log != null) log.debug("clearValidationMessages()");
			
			dispatchEvent( new Event( VALIDATION_CHANGED ) );
		}
		
		
		
		private var _firstNameError:String = "";
		
		[Bindable(Event="validationChanged")]
		public function get firstNameError():String
		{
			return _firstNameError;
		}
		
		
		private var _lastNameError:String = "";
		
		[Bindable(Event="validationChanged")]
		public function get lastNameError():String
		{
			return _lastNameError;
		}
		
		
		private var _emailError:String = "";
		
		[Bindable(Event="validationChanged")]
		public function get emailError():String
		{
			return _emailError;
		}
	}
}