package com.thunderbay.utils
{
	import com.asual.swfaddress.SWFAddress;
	
	import flash.external.ExternalInterface;
	
	import mx.core.Application;
	
	public class FlashVars {
		
			public function get url():String {
				return _url;
			}
			
			/**
			 * Load key from Flex Application.application.parameters, from the browser url, or using SWFAddress
			 *  
			 * @param key
			 * @return String value for specified key 
			 * 
			 */
			public function keyValue(key:String, defaultVal:String=null):String {
				var results : String = 	isValidParam(key,_params) 				? _params[key] 			:
				          				isValidParam(key,_browserParams)		? _browserParams[key]	:	
				          				SWFAddress.getParameter(key) as String;
				          				 
				return results ? results : defaultVal;
			}

			// ****************************************************************************************************
			// Private Methods
			// ****************************************************************************************************

			/**
			 * Determin if the specified key is contained within the specified hashmap
			 *  
			 * @param key			String to use as the key lookup
			 * @param parameters	Hashmap of key-value pairs
			 * @return 				True - if the key exists
			 * 
			 */
			private function isValidParam(key:String, parameters:Object):Boolean {
				return (parameters[ key ]  && (parameters[ key ] != ""));
			}
			
			/**
			 * Use ExternalInterface in order to retrieve the full url [with query params] from the current
			 * browser.
			 *  
			 * @return Hashmap of key-value pairs for all query params [as listed in the url] 
			 * 
			 */
			private function browserURLParams():Object {
				var results : Object = {};
				try 
				{	
					if (ExternalInterface.available == true) {
						_url =  ExternalInterface.call("window.location.href.toString");
						
						var querySection : String = ExternalInterface.call("window.location.search.substring", 1);
						if(querySection != null) {
						
							var params:Array = querySection.split('&');
							var length:uint = params.length;
							
							for (var i:uint=0,index:int=-1; i<length; i++) 
							{
								var kvPair:String = params[i];
								if((index = kvPair.indexOf("=")) > 0)
								{
									var key:String = kvPair.substring(0,index);
									var value:String = kvPair.substring(index+1);
									results[key] = value;
								}
							}
						}
						
					}
				} catch(e:Error) { 
						trace("Some error occured. ExternalInterface doesn't work in Standalone player."); 
				}
					
				return results;
			}
			
			private var _url            : String = "";
			private var _params 		: Object = (Application.application as Application).parameters;
			private var _browserParams 	: Object = browserURLParams();
	}
}