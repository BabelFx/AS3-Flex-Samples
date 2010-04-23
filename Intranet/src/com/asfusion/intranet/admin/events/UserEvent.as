package com.asfusion.intranet.admin.events
{
	import com.asfusion.intranet.shared.model.vos.User;
	
	import flash.events.Event;

	public class UserEvent extends Event
	{
		//--------------------------------------
		//   Public Constants
		//--------------------------------------
		public static const GET_ALL:String 	= "getAllUserEvent";
		public static const UPDATE:String  	= "updateUserEvent";
		public static const ADD:String  	= "getAllUserEvent";
		public static const DELETE:String  	= "deleteUserEvent";
		public static const SELECT:String  	= "selectUserEvent";
		
		//--------------------------------------
		//    Public Properties
		//--------------------------------------
		public var user:User;
		
		//----------------------------------------
		//     Constructor
		//----------------------------------------
		public function UserEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}