package com.asfusion.intranet.shared.ui.presenters
{
	import com.asfusion.intranet.shared.model.vos.User;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;

	public class MainUIPresentationModel extends EventDispatcher
	{
		//--------------------------------------------------------------------
		//    Public Constants
		//--------------------------------------------------------------------
		public static const LOGGED_IN_STATE:String  = "loggedInState";
		public static const LOGGED_OUT_STATE:String = "loggedOutState";
		
		//--------------------------------------------------------------------
		//    Public Setters and Getters
		//--------------------------------------------------------------------
		
		//...........................state......................
		private var _state:String = LOGGED_OUT_STATE;
		[Bindable(Event="stateChange")]
		public function get state( ):String
		{
			return _state;
		}
		
		//............................user........................
		public function set user( user:User ):void
		{
			if( user != null)
			{
				_state = LOGGED_IN_STATE;
			}
			else
			{
				_state = LOGGED_OUT_STATE;
			}
			dispatchEvent( new Event( "stateChange" ) );
		}
	}
}