package com.asfusion.intranet.admin.model.managers
{
	import com.asfusion.intranet.shared.model.vos.User;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;

	public class UserManager extends EventDispatcher
	{
		
		//--------------------------------------------------------------------
		//    Public Setters and Getters
		//--------------------------------------------------------------------
		
		//.................selectedUser......................
		private var _selectedUser:User;
		[Bindable(Event="selectedUserChange")]
		public function get selectedUser():User
		{
			return _selectedUser;
		}
		
		//.................users......................
		private var _users:ArrayCollection;
		[Bindable(Event="usersChange")]
		public function get users():ArrayCollection
		{
			return _users;
		}
		
		
		//--------------------------------------------------------------------
		//    Public Methods
		//--------------------------------------------------------------------
		
		//.................storeUsers......................
		public function storeUsers( value:ArrayCollection ):void
		{
			_users = value;
			dispatchEvent( new Event("usersChange") );
		}
		
		//.................setSelectedUser......................
		public function setSelectedUser( user:User ):void
		{
			_selectedUser = user;
			dispatchEvent( new Event("selectedUserChange") );
		}
		
		//.................addUser......................
		public function addUser( user:User, confirmation:Boolean ):void
		{
			if( confirmation && users)
			{
				users.addItem( user );
				_selectedUser = user;
				dispatchEvent( new Event("selectedUserChange") );
			}
		}
		
		//.................updateUser......................
		public function updateUser( user:User, confirmation:Boolean ):void
		{
			if( confirmation && users)
			{
				var userToUpdate:User = ( selectedUser.id == user.id ) ? selectedUser : findUser( user.id );
				userToUpdate.copyFrom( user );
				dispatchEvent( new Event("selectedUserChange") );
			}
		}
		
		//.................deleteUser......................
		public function deleteUser( user:User, confirmation:Boolean ):void
		{
			if( confirmation && users)
			{
				var userToDelete:User = ( selectedUser.id == user.id ) ? selectedUser : findUser( user.id );
				users.removeItemAt( users.getItemIndex( userToDelete ) );
			}
		}
		
		//.................findUser......................
		public function findUser( id:String ):User
		{
			var userFound:User;
			for each( var currentUser:User in users)
			{
				if( id == currentUser.id )
				{
					userFound = currentUser;
					break;
				}
			}
			return userFound;
		}
	}
}