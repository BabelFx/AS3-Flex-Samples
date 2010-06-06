package com.cafetownsend.controller
{
	import com.cafetownsend.domain.Employee;
	import com.cafetownsend.event.EmployeeEvent;
	import com.cafetownsend.event.NavigationEvent;
	import com.cafetownsend.model.AppModel;
	import com.cafetownsend.model.Constants;
	import com.cafetownsend.model.EmployeeModel;
	import com.cafetownsend.model.NavigationModel;
	import com.cafetownsend.service.IEmployeeDelegate;
	import com.cafetownsend.util.EmployeeUtil;
	import com.cafetownsend.util.ErrorUtil;
	
	import ext.swizframework.utils.AsyncInterceptor;
	
	import flash.display.Sprite;
	import flash.events.IEventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.collections.IList;
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.events.CloseEvent;
	import mx.logging.ILogger;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.utils.StringUtil;
	
	import org.swizframework.utils.services.ServiceHelper;
	
	public class EmployeeController {

		[Log]			public var log  	 : ILogger 			= null;		
		[Dispatcher]	public var dispatcher: IEventDispatcher = null;
		
		[Inject]		public var model	 : EmployeeModel	= null;
		[Inject]		public var delegate	 : IEmployeeDelegate= null;
		
		[Inject]		public var serviceRequestUtil:ServiceHelper = null;
		
		//--------------------------------------------------------------------------
		//
		// Loading employees
		//
		//--------------------------------------------------------------------------
		
		[Mediate(event="LoginEvent.COMPLETE")]
		public function loadEmployees():void {
			if (log != null) log.debug("loadEmployees()");
			
			var agent : AsyncInterceptor = new AsyncInterceptor(parseEmployeesData);
			serviceRequestUtil.executeServiceCall(agent.intercept(delegate.loadEmployees()), onResults_loadEmployees);
		}
		
		private function parseEmployeesData(data:XML):XML {
			try {
				if (log != null) log.debug("parseEmployeesData()");
			} catch( error: Error ) {
				ErrorUtil.showError( StringUtil.substitute(Constants.EMPLOYEE_LOAD_ERROR,[error.message]) );
			}
			
			return data;
		}
		
		protected function onResults_loadEmployees(data:XML ):void  {
			if (log != null) log.debug("EmployeeUtil.getEmployeesFromXML()");
			var employees: Array = EmployeeUtil.getEmployeesFromXML( data );
			
			if (log != null) log.debug("onResults_loadEmployees(): employees={0}",employees.length);
			model.employees = new ArrayCollection( employees );
		}

		//--------------------------------------------------------------------------
		//
		// Create employee
		//
		//--------------------------------------------------------------------------
		
		
		[Mediate(event="EmployeeEvent.CREATE")]
		public function createEmployee():void {
			if (log != null) log.debug("createEmployee()");

			model.selectedEmployee = new Employee();
			dispatcher.dispatchEvent( new NavigationEvent( NavigationEvent.UPDATE_PATH, NavigationModel.PATH_EMPLOYEE_DETAIL ) );
		}

		//--------------------------------------------------------------------------
		//
		// Update employee
		//
		//--------------------------------------------------------------------------
		

		[Mediate(event="EmployeeEvent.UPDATE",properties="employee")]
		public function updateEmployee( employee: Employee ):void {
			if (log != null) log.debug("updateEmployee({0})", employee.fullName);
			
			var agent : AsyncInterceptor = new AsyncInterceptor(parseEmployeeData);
			serviceRequestUtil.executeServiceCall(agent.intercept(delegate.updateEmployee(employee)), onResult_updateEmployee);
		}
		
		private function parseEmployeeData(event:*):Employee {
			try {
				if (log != null) log.debug("parseEmployeeData()");
				var emp : Employee = (event is ResultEvent) ? event.result as Employee : event as Employee;
			}
			catch( error: Error )
			{
				ErrorUtil.showError( error.message );
			}
			
			return emp;
		}
		
		protected function onResult_updateEmployee( person:Employee ):void {
			if (log != null) log.debug("updateEmployee({0})", person.fullName);
			
			model.addEmployee(person);
			dispatcher.dispatchEvent( new NavigationEvent( NavigationEvent.UPDATE_PATH, NavigationModel.PATH_EMPLOYEE_LIST ) );
		}
		
		//--------------------------------------------------------------------------
		//
		// Delete employee
		//
		//--------------------------------------------------------------------------
		
		[Mediate(event="EmployeeEvent.DELETE")]
		public function confirmDeleteEmployee( ) : void  {			
			var employee: Employee = model.selectedEmployee;
			
			if (log != null) log.debug("confirmDeleteEmployee({0})", employee.fullName);
			
			Alert.show(	StringUtil.substitute(Constants.EMPLOYEE_CONFIRM_DELETE,[employee.firstName,employee.lastName]),
				null,
				Alert.OK | Alert.CANCEL,
				FlexGlobals.topLevelApplication as Sprite,
				deleteEmployee,
				null,
				Alert.OK );
		}
		
		
		protected function deleteEmployee ( event: CloseEvent ):void  {
			// was the Alert event an OK
			if ( event.detail == Alert.OK ) {
				var who   : Employee         = model.selectedEmployee;
				var agent : AsyncInterceptor = new AsyncInterceptor(parseEmployeeData);
				
				if (log != null) log.debug("deleteEmployee({0})", who);
				
				serviceRequestUtil.executeServiceCall( agent.intercept(delegate.deleteEmployee(who)), onResult_deleteEmployee );
			}
		}
		
			private function parseDeleteEmployeeResult(data:*):Employee {
				try {
					var deleted : Employee = (data is ResultEvent) ? data.result as Employee : data as Employee;
					if (log != null) log.debug("parseDeleteEmployeeResult({0})", deleted ? deleted.fullName : "");
				}
				catch( error: Error )
				{
					ErrorUtil.showError( error.message );
				}
				
				return deleted;
			}
		
		
		protected function onResult_deleteEmployee(who:Employee):void {
			if (log != null) log.debug("onResult_deleteEmployee({0})", who ? who.fullName : "");
			
			// change view state back to employee list
			model.removeEmployee(who);
			dispatcher.dispatchEvent( new NavigationEvent( NavigationEvent.UPDATE_PATH, NavigationModel.PATH_EMPLOYEE_LIST ) );
		}

		

		//--------------------------------------------------------------------------
		//
		// select employee
		//
		//--------------------------------------------------------------------------
		
		[Mediate(event="EmployeeEvent.SELECT", properties="employee")]
		public function selectEmployee(who:Employee):void {
			if (log != null) log.debug("selectEmployee({0})", who.fullName);
			
			model.selectedEmployee = who;
		}
	
		
		//--------------------------------------------------------------------------
		//
		// Cancel editing employee
		//
		//--------------------------------------------------------------------------
		
		[Mediate(event="EmployeeEvent.CANCEL")]
		public function cancelEditingEmployee( event:EmployeeEvent ):void {
			if (log != null) log.debug("cancelEditingEmployee()");
			
			model.selectedEmployee = null;
			dispatcher.dispatchEvent( new NavigationEvent( NavigationEvent.UPDATE_PATH, NavigationModel.PATH_EMPLOYEE_LIST ) );
		}
	
	}
}