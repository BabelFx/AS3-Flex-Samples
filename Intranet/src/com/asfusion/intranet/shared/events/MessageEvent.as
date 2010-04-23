package com.asfusion.intranet.shared.events
{
	import flash.events.Event;

	public class MessageEvent extends Event
	{
		//--------------------------------------
		//   Public Constants
		//--------------------------------------
		public static const ERROR:String = "error_MessageEvent";
		
		//--------------------------------------
		//    Public Properties
		//--------------------------------------
		public var message:String;
		
		
		//----------------------------------------
		//     Constructor
		//----------------------------------------
		public function MessageEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}