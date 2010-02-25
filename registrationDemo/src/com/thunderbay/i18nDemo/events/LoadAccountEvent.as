package com.thunderbay.i18nDemo.events
{
	import com.universalmind.cairngorm.events.UMEvent;
	
	import mx.rpc.IResponder;

	public class LoadAccountEvent extends UMEvent {
		
		public static const EVENT_ID:String = "loadAccount";
		
		public var email	:String 	= "";
		
		public function LoadAccountEvent(email:String, handlers:IResponder=null)
		{
			super(EVENT_ID, handlers);
			this.email   = email; 
		}
		
	}
}