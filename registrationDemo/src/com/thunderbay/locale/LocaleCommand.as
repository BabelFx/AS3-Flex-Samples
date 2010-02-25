package com.thunderbay.locale
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.thunderbay.i18nDemo.model.Model;
	import com.universalmind.cairngorm.commands.Command;
	
	import flash.net.*;
	import flash.system.Capabilities;
	
	import mx.managers.*;
	import mx.resources.IResourceBundle;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	
	public class LocaleCommand extends Command
	{	
		override public function execute( event:CairngormEvent ):void {
			super.execute(event);
			
			if (event is LocaleEvent) {
				switch(LocaleEvent(event).action) {
					case LocaleEvent.INITIALIZE   : initStartupLocale();						break;
					case LocaleEvent.LOAD_LOCALE  : loadLocale(LocaleEvent(event).locale);		break;
				}
			}
		}
		
		// ************************************************************************
		// Protected Methods
		// ************************************************************************

		/**
		 * Loads the startup locale based on current OS Locale preferences; 
		 * unless overriden by FlashVars "localeChain" 
		 * 
		 */
		protected function initStartupLocale():void {
				// Nothing specified from the server/html wrapper, so look at OS Locale
				switch(String(Capabilities.language)) {
					case "es":			loadLocale("es_ES");	break;

					case "en":			
					default  :          loadLocale("en_US");	break;
				}
		}
		
		/**
		 * Switch to another embedded locale as specified. 
		 */
		protected function loadLocale(locale:String):void {
			_localeMngr.localeChain = [locale];
			notifyCaller();
		}
		
		
		private var _model		:Model 			  =  Model.instance;
		private var _localeMngr	:IResourceManager = ResourceManager.getInstance();
	}
}