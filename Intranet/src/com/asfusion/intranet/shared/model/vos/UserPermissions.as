package com.asfusion.intranet.shared.model.vos
{
	public class UserPermissions
	{
		
		//-------------------------------------------------------------
		//     Public Constants
		//--------------------------------------------------------------
		public static const ADMIN:UserPermissions 		= new UserPermissions( "admin",    PermissionsLock);
		public static const READ_ONLY:UserPermissions	= new UserPermissions( "readOnly", PermissionsLock);
		public static const READ_WRITE:UserPermissions	= new UserPermissions( "readWrite", PermissionsLock);
		
		//---------------------------------------------------------------
		//     Public Setters and Getters
		//---------------------------------------------------------------
		private var _permission:String;
		public function get permission( ):String
		{
			return _permission;
		}
		
		//----------------------------------------------------------------
		//      Constructor
		//----------------------------------------------------------------
		public function UserPermissions( permission:String, lock:Class )
		{
			_permission = permission;
		}
	}
}

class PermissionsLock{}