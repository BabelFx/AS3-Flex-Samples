package com.asfusion.intranet.shared.services
{
	import com.asfusion.intranet.shared.model.vos.User;
	import com.asfusion.intranet.shared.model.vos.UserPermissions;
	
	import mx.collections.ArrayCollection;
	
	public class MockUserList
	{
		public static const USER_LIST:ArrayCollection = populateUsers();
		
		public static var count:int;
		
		public static function populateUsers():ArrayCollection
		{
			var users:Array = new Array();
			var user:User = new User();
			user.userName = "admin";
			user.permissions = UserPermissions.ADMIN;
			user.password = "mate";
			user.firstName = "Eric";
			user.lastName = "Brown";
			user.id = count.toString();
			count++;
			users.push( user );
			
			var regularUser:User = new User();
			regularUser.userName = "guest";
			regularUser.permissions = UserPermissions.READ_ONLY;
			regularUser.password = "mate";
			regularUser.firstName = "Mark";
			regularUser.lastName = "Brown";
			user.id = count.toString();
			count++;
			users.push( regularUser );
			
			return new ArrayCollection( users );
		}
	}
}