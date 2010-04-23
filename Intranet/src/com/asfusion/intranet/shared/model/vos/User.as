package com.asfusion.intranet.shared.model.vos
{
	[Bindable]
	public class User
	{
		public var firstName:String;
		public var lastName:String;
		public var userName:String;
		public var password:String;

		public var permissions:UserPermissions;
		
		public var id:String;
		
		public function User( user:User = null )
		{
			if( user ) copyFrom( user );
		}
		
		public function copyFrom( user:User ):void
		{
			firstName 	= user.firstName;
			lastName 	= user.lastName;
			userName 	= user.userName;
			password	= user.password;
			permissions = user.permissions;
			id			= user.id;
		}
	}
}