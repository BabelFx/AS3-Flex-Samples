package com.asfusion.intranet.login.events
{
	import flash.events.Event;

	public class AuthorizationEvent extends Event
	{
		//--------------------------------------
		//   Public Constants
		//--------------------------------------
		public static const LOGIN:String  	= "login_LoginEvent";
		public static const LOGOUT:String 	= "logout_LoginEvent";
		public static const FAILED:String 	= "fail_LoginEvent";
		
		//--------------------------------------
		//    Public Properties
		//--------------------------------------
		public var username:String;
		public var password:String;
		public var message:String;
		
		//----------------------------------------
		//     Constructor
		//----------------------------------------
		public function AuthorizationEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}