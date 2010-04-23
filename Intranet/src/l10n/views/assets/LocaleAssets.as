package l10n.views.assets
{
    public class LocaleAssets
    {
				/**
				 * This array allows us to auto-assign build order (and possibly display order)
				 * for all supported flags/locales 
				 */
				static public function get allFlags():Array {
					return [FLAG_USA, FLAG_GERMANY]; 
				}
				
				/**
				 * Using the locale's flag Class, lookup the locale's shortcode
				 * 
				 * @param flag Class Embedded bitmapAsset class associated with locale code
				 * @return String Locale code (e.g. en_US, fr_FR, es_ES, zh_CN, etc.)
				 * 
				 */
				static public function getLocaleFor(flag:Class):String {
					var locale : String = "en_US";
					
					for each (var it:Object in _locales) {
						if (it.flag == flag) {
							locale = it.locale;
							break;
						}
					}
					
					return locale;
				}
				
				/**
				 * Using the locale's flag Class, lookup the locale's associated title text
				 * 
				 * @param flag Class Embedded bitmapAsset class associated with locale code
				 * @return String English title associated with locale code 
				 * 
				 */
				static public function getTitleFor(flag:Class):String {
					var tip : String = "";
					
					for each (var it:Object in _locales) {
						if (it.flag == flag) {
							tip = it.title;
							break;
						}
					}
					
					return tip;
				}
				
				[Embed(source='/l10n/views/assets/images/flags/de_DE_30x19.jpg')]
				public static const  FLAG_GERMANY : Class;

				[Embed(source='/l10n/views/assets/images/flags/en_US_30x19.jpg')]
				public static const  FLAG_USA : Class;

				
				/**
				 * Build list of supported Flag data items. This will be used to dynamically
				 * construct Flag buttons in the LanguageBar or other UI needs. To add more flags
				 * simply add more records.
				 * 
				 * Note: The title properties should be localized (at runtime) via injection...
				 * 
				 */
				private static var _locales : Array = [
														{ flag:FLAG_GERMANY,locale:"de_DE", title:"German" },
														{ flag:FLAG_USA, 	locale:"en_US", title:"English (USA)" }
													  ];

					
				
	}
    

}