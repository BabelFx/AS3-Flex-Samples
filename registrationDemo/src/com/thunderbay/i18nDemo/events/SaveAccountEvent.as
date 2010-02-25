package com.thunderbay.i18nDemo.events
{
	import com.universalmind.cairngorm.events.UMEvent;
	import mx.rpc.IResponder;
	import com.thunderbay.i18nDemo.vo.AccountVO;

	public class SaveAccountEvent extends UMEvent {
		
			public static const EVENT_ID:String = "saveAccount";
			
			public var account : AccountVO = null;
			
			public function SaveAccountEvent(account:AccountVO, handlers:IResponder=null) {
				super(EVENT_ID, handlers);
				this.account = account; 
			}
		
	}
}