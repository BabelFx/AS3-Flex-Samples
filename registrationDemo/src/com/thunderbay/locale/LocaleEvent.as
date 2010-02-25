package com.thunderbay.locale
{
	import com.universalmind.cairngorm.events.UMEvent;
	
	import mx.rpc.IResponder;

	public class LocaleEvent extends UMEvent
	{	
		public static const INITIALIZE  :String = "initStartupLocalization";
		public static const LOAD_LOCALE :String = "loadLocale";

		public static const EVENT_ID    :String = "localeAction";
		
		public var locale:String = "";
		
		public function LocaleEvent(action:String="", locale:String="en_US", handlers:IResponder=null, data:Object=null) {
			super(EVENT_ID, handlers, false, false, data);
			
			this.locale = locale;
			this.action = (action == "") ? INITIALIZE : action;
		}
		
		public var action : String = INITIALIZE;
		
	}
}