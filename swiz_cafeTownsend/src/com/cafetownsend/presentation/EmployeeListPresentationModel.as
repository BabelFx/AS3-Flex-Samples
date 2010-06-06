package com.cafetownsend.presentation
{

	import com.cafetownsend.domain.Employee;
	import com.cafetownsend.event.EmployeeEvent;
	import com.cafetownsend.event.NavigationEvent;
	import com.cafetownsend.model.NavigationModel;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.events.CloseEvent;
	import mx.logging.ILogger;
	
	
	public class EmployeeListPresentationModel extends EventDispatcher
	{
		[Log]			public var log  	 : ILogger 			= null;		
		[Dispatcher]	public var dispatcher: IEventDispatcher	= null;
		
		//--------------------------------------------------------------------------
		//
		// employee list
		//
		//--------------------------------------------------------------------------
		
		private var _employees:ArrayCollection = null;
		public static const EMPLOYEES_CHANGED:String = "employeesChanged";
		
		[Inject("employeeModel.employees")]
		[Bindable(Event="employeesChanged")]		
		public function get employees( ):ArrayCollection {
			return _employees;
		}
		public function set employees( list:ArrayCollection ):void {
			if (log != null) log.debug("set employees(); len={0}",list ? list.length : 0);
			
			_employees = list;
			dispatchEvent( new Event( EMPLOYEES_CHANGED ) );
		}
		
	
		
		//--------------------------------------------------------------------------
		//
		// selected Employee
		//
		//--------------------------------------------------------------------------
			
		
		private var _selectedEmployee:Employee = null;
		
		public static const SELECTED_EMPLOYEE_CHANGED:String = "selectedEmployeeChanged";
		
		
		[Inject("employeeModel.selectedEmployee")]
		[Bindable(event="selectedEmployeeChanged")]
		public function set selectedEmployee(value:Employee):void
		{
			if ( _selectedEmployee != value ) {
				if (log != null) log.debug("set selectedEmployee({0})",value ? value.fullName : "");
				
				_selectedEmployee = value;
				dispatchEvent( new Event( SELECTED_EMPLOYEE_CHANGED ) );
			}
		}		

		public function get selectedEmployee(): Employee
		{
			return _selectedEmployee;
		}

		
		[Bindable(Event="selectedEmployeeChanged")]
		public function get hasSelectedEmployee():Boolean {
			//if (log != null) log.debug("get hasSelectedEmployee() == {0}",selectedEmployee != null);
			return selectedEmployee != null;
		}
		
		[Bindable(Event="selectedEmployeeChanged")]
		public function get selectedEmployeeIndex():int {
			var results : int = -1;
			
			if( selectedEmployee != null ) {
				var storedEmployee	: Employee;
				var max				: int = employees.length;
				var id				: int = selectedEmployee.id;
				
				for (var i:int=0; i < max; i++)  {
					storedEmployee = employees.getItemAt( i ) as Employee;
					
					if( storedEmployee.id == id ) {
						results = i;
						break;
					}
				}
			}
			
			if (log != null) log.debug("selectedEmployeeIndex == {0}",results);
			
			return results;
		}
		
		
		//--------------------------------------------------------------------------
		//
		// public methods called by its view
		//
		//--------------------------------------------------------------------------
		
		public function selectEmployee( employee:Employee ) : void  {
			if (log != null) log.debug("selectEmployee({0})",employee.fullName);
			
			dispatcher.dispatchEvent( new EmployeeEvent( EmployeeEvent.SELECT, employee ) );
		}	
		
		public function createEmployee() : void  {
			if (log != null) log.debug("createEmployee()");
			
			dispatcher.dispatchEvent( new EmployeeEvent( EmployeeEvent.CREATE ) );			
		}
		
		
		public function updateEmployee() : void  {
			if (log != null) log.debug("updateEmployee()");
			
			dispatcher.dispatchEvent( new NavigationEvent( NavigationEvent.UPDATE_PATH, NavigationModel.PATH_EMPLOYEE_DETAIL ) );			
		}
		

		public function deleteEmployee() : void {
			if (log != null) log.debug("deleteEmployee()");
			
			dispatcher.dispatchEvent( new EmployeeEvent( EmployeeEvent.DELETE ) );
		}

		
	}
}