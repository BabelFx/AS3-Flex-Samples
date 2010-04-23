package com.asfusion.intranet.shared.model.managers
{
	import com.asfusion.intranet.shared.model.vos.ModuleDescriptor;
	import com.asfusion.intranet.shared.model.vos.User;
	import com.asfusion.intranet.shared.model.vos.UserPermissions;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;

	public class PermissionsManager extends EventDispatcher
	{
		
		//-------------------------------------------------------------------------------------------
		//      Public Setters and Getters
		//-------------------------------------------------------------------------------------------
		
		//.........................................modulesAllowed....................................
		private var _modulesAllowed:Array;
		[Bindable(Event="permissionsChange")]
		public function get modulesAllowed():Array
		{
			return _modulesAllowed;
		}
		
		//.........................................isAdmin..........................................
		private var _isAdmin:Boolean;
		[Bindable(Event="permissionsChange")]
		public function get isAdmin():Boolean
		{
			return _isAdmin;
		}
		
		
		//---------------------------------------------------------------------------------------------------
		//     Public Methods
		//---------------------------------------------------------------------------------------------------
		
		//.........................................setPermissions..........................................
		public function setPermissions( user:User ):void
		{
			_modulesAllowed = new Array();
			_modulesAllowed.push( new ModuleDescriptor( "Contacts", "com/asfusion/intranet/contacts/Contacts.swf" ) );
			if( user.permissions == UserPermissions.ADMIN )
			{
				_modulesAllowed.push( new ModuleDescriptor( "Admin", "com/asfusion/intranet/admin/Admin.swf" ) );
			}
			_isAdmin = ( user.permissions == UserPermissions.ADMIN );
			dispatchEvent( new Event( "permissionsChange" ) );
		}
	}
}