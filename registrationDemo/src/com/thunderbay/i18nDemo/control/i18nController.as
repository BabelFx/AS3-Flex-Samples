package com.thunderbay.i18nDemo.control
{
	import com.thunderbay.i18nDemo.control.commands.AccountCommand;
	import com.thunderbay.i18nDemo.events.*;
	import com.universalmind.cairngorm.control.FrontController;
	
	public class i18nController extends FrontController
	{
		public function i18nController()
		{
			super();
			
			addCommand( LoadAccountEvent.EVENT_ID, 		AccountCommand );
			addCommand( SaveAccountEvent.EVENT_ID, 	  	AccountCommand );
		}
	}
}