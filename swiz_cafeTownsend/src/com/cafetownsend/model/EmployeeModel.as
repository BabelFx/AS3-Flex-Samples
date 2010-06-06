package com.cafetownsend.model
{
	import com.cafetownsend.domain.Employee;
	
	import mx.collections.IList;
	
	public class EmployeeModel
	{
		
		[Bindable]
		public var employees:IList;
		
		[Bindable]
		public var selectedEmployee:Employee;
		

		public function addEmployee(who:Employee):void {
			var found : Boolean = false;
			
			for each (var it:Employee in employees) {
				if (it == null) continue;
				if (it.id == who.id) {
					it.copyFrom(who);
					
					found = true;
					break;
				}
			}
			
			if (found != true) employees.addItem(who);
		}
		
		public function removeEmployee(who:Employee):Boolean {
			var found : Boolean = false;
			
			for (var j:int=0; j<employees.length; j++) {
				var it:Employee = employees.getItemAt(j) as Employee;
				if (it == null) continue;
				
				if (it.id == who.id) {
					employees.removeItemAt(j);
					
					found = true;
					break;
				}
			}
			
			if (found == true) selectedEmployee = null;
			
			return found;
		}
		
	}
}