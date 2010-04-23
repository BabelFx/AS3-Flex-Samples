package com.asfusion.intranet.admin.services
{
	import com.asfusion.intranet.shared.model.vos.User;
	import com.asfusion.intranet.shared.services.MockUserList;
	
	import mx.collections.ArrayCollection;
	
	public class MockAdminServices
	{
		public function getAllUsers():ArrayCollection
		{
			return MockUserList.USER_LIST;
		}
		
		public function addUser( user:User ):Boolean
		{
			var result:Boolean;
			if( user != null)
			{
				result = true;
				user.id = MockUserList.count.toString();
				MockUserList.count++;
			}
			
			return result;
		}
		
		public function updateUser( user:User ):Boolean
		{
			var result:Boolean;
			var users:ArrayCollection = getAllUsers();
			for each( var currentUser:User in users)
			{
				if( currentUser.id == user.id )
				{
					result = true;
					break;
				}
			}
			return result;
		}
		
		public function deleteUser( user:User ):Boolean
		{
			var result:Boolean;
			var users:ArrayCollection = getAllUsers();
			for each( var currentUser:User in users)
			{
				if( currentUser.id == user.id )
				{
					result = true;
					break;
				}
			}
			return result;
		}
	}
}