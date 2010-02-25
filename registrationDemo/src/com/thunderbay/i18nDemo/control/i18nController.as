package com.thunderbay.i18nDemo.control
{
	import com.thunderbay.i18nDemo.control.commands.AccountCommand;
	import com.thunderbay.i18nDemo.events.*;
	import com.thunderbay.locale.LocaleEvent;
	import com.thunderbay.locale.*;
	import com.universalmind.cairngorm.control.FrontController;
	
	public class i18nController extends FrontController
	{
		public function i18nController()
		{
			super();
			
			addCommand( LoadAccountEvent.EVENT_ID, 		AccountCommand );
			addCommand( SaveAccountEvent.EVENT_ID, 	  	AccountCommand );
		 	

			addCommand( LocaleEvent.EVENT_ID,			LocaleCommand);
		}
	}
}