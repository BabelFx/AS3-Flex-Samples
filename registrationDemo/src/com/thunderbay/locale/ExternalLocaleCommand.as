package com.thunderbay.locale
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.thunderbay.i18nDemo.model.Model;
	import com.thunderbay.utils.FlashVars;
	import com.universalmind.cairngorm.commands.Command;
	
	import flash.events.IEventDispatcher;
	import flash.net.*;
	import flash.system.Capabilities;
	
	import mx.events.ResourceEvent;
	import mx.managers.*;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceBundle;
	import mx.resources.ResourceManager;
	import mx.utils.StringUtil;
	
	public class ExternalLocaleCommand extends Command
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
			var qryMngr  : com.thunderbay.utils.FlashVars = new FlashVars();
			var startup  : String    = qryMngr.keyValue("localeChain","");
			
			_model.resourcePath = qryMngr.keyValue("resourcePath",_model.resourcePath);
			
			if (startup == "") {
				// Nothing specified from the server/html wrapper, so look at OS Locale
				switch(String(Capabilities.language)) {
					case "en":			loadLocale("en_US");	break;
					case "es":			loadLocale("es_ES");	break;
					case "fr":			loadLocale("fr_FR");	break;
					case "ja":			loadLocale("ja_JP");	break;
					case "zh-CN":		loadLocale("zh_CN");	break;
				}
			} else {
				loadLocale(startup);
			}
		}
		
		/**
		 * Load locale specified. If already loaded, then simply trigger ResourceManger "change" event so
		 * databindings fire to update with locale settings. If not loaded, then load from "locale/Resource_{locale}.swf" file 
		 *  
		 * @param locale String specifing request locale; e.g. en_US, en_NZ, es_MX, etc.
		 * 
		 *  ******************************************************************************************
		 *  !!Important: before the locale resourcebundles are assigned (after loading) we must FIRST load (1) & (2):
		 *  ******************************************************************************************
		 * 
		 *   1) StyleSheets for locale
		 *   2) Runtime fonts for StyleSheets
		 *   3) Localized ResourceBundles
		 *   4) Dynamic Runtime Text
		 * 
		 */
		protected function loadLocale(locale:String):void {
			var allKnown      : Array   = _localeMngr.getLocales();
			var alreadyLoaded : Boolean = (locale == "en_US") ? false : (allKnown.indexOf(locale) > -1) || (allKnown.indexOf(locale.toLowerCase()) > -1);
			
			// Cache for result handler
			_locale = locale;
			
			if (alreadyLoaded != true) {
				 
				var dispatcher : IEventDispatcher = _localeMngr.loadResourceModule(this.localeURL,false);
				    dispatcher.addEventListener(ResourceEvent.COMPLETE,onResult_localeLoaded);
				    dispatcher.addEventListener(ResourceEvent.ERROR,onError_localeLoaded);
				    
			} else {
				// Just set it as the first in the list... which fires "change" events also
				onResult_localeLoaded();
			} 
		}
		
		// ************************************************************************
		// Private DataService Handlers
		// ************************************************************************

		private function onResult_localeLoaded(event:ResourceEvent=null):void {
			
			 if (((_locale != "") && !event) || (event.type == ResourceEvent.COMPLETE)) {
				// Note: ResourceManager searches bundles for locales from first (0-index) to last
				//       the last locale is the "fallback" bundle. As such, en_US should always be the last.
				var fallback : Array = ["en_US"];
				
				_localeMngr.localeChain = (_locale == fallback[0]) ? fallback : [_locale].concat(fallback);		// ["es_ES","en_US"]
				_model.locale = _localeMngr.localeChain[0];
				
				var msg : String = _localeMngr.getString("registration","signin.title");
				if (msg && msg.length > 0) {
					var code: Number = msg.charCodeAt(0);
					var code2 : Number = '¿'.charCodeAt();
				}
			} 
			
			// Cleanup
			_localeMngr.removeEventListener(ResourceEvent.COMPLETE,onResult_localeLoaded);
			
			notifyCaller();
		}
		
		private function onError_localeLoaded(event:ResourceEvent):void {
			trace(StringUtil.substitute("Resource load failed for url='{0}'",[this.localeURL]));
			// @FIXME Throw a FaultEvent to the FaultCommand for global alerts.
			
			notifyCaller();
		}
		
		
		// ************************************************************************
		// Private  Properties
		// ************************************************************************
		
		
		/**
		 * Build app-relative url to the compiled locale resource bundles 
		 * @return 
		 * 
		 */
		private function get localeURL():String {
			
			return StringUtil.substitute(_model.resourcePath,[_locale]);
		}
		
		private var _locale     : String          = "";
		
		private var _model		:Model 			  =  Model.instance;
		private var _localeMngr	:IResourceManager = ResourceManager.getInstance();
	}
}