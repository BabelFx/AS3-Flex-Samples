package com.asfusion.intranet.shared.model.managers
{
	import com.asfusion.intranet.shared.model.vos.User;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;

	public class SessionManager extends EventDispatcher
	{
		
		//---------------------------------------------------
		//    Public Setters and Getters
		//---------------------------------------------------
		
		//.......................user.....................
		private var _user:User;
		[Bindable(Event="userChange")]
		public function get user():User
		{
			return _user;
		}
		
		
		//---------------------------------------------------
		//     Public Methods
		//---------------------------------------------------
		
		//...................openSession..............
		public function openSession( user:User):void
		{
			_user = user;
			dispatchEvent( new Event( "userChange" ) );
		}
		
		//......................closeSession.............
		public function closeSession( ):void
		{
			_user = null;
			dispatchEvent( new Event( "userChange" ) );
		}
	}
}