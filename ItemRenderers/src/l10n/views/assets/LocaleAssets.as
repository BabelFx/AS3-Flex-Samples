package l10n.views.assets
{
    public class LocaleAssets
    {
				/**
				 * This array allows us to auto-assign build order (and possibly display order)
				 * for all supported flags/locales 
				 */
				static public function get allFlags():Array {
					return [FLAG_USA, FLAG_GERMANY];		// [FLAG_USA, FLAG_FRANCE, FLAG_SPAIN, FLAG_CHINA]; 
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
				
				[Embed(source='/l10n/views/assets/images/flags/china32x32.png')]
				public static const  FLAG_CHINA : Class;

				[Embed(source='/l10n/views/assets/images/flags/france32x32.png')]
				public  static const  FLAG_FRANCE : Class;

				[Embed(source='/l10n/views/assets/images/flags/spain32x32.png')]
				public static const  FLAG_SPAIN : Class;

				[Embed(source='/l10n/views/assets/images/flags/us32x32.png')]
				public static const  FLAG_USA : Class;
				
				[Embed(source='/l10n/views/assets/images/flags/germany32x32.png')]
				public static const  FLAG_GERMANY : Class;

				
				/**
				 * Build list of supported Flag data items. This will be used to dynamically
				 * construct Flag buttons in the LanguageBar or other UI needs. To add more flags
				 * simply add more records.
				 * 
				 * Note: The title properties should be localized (at runtime) via injection...
				 * 
				 */
				private static var _locales : Array = [
														{ flag:FLAG_USA, 	locale:"en_US", title:"English (USA)" },
														{ flag:FLAG_GERMANY, locale:"de_DE", title:"Germany" }
														/*
														{ flag:FLAG_SPAIN, 	locale:"es_ES", title:"Spanish" },
														{ flag:FLAG_FRANCE, locale:"fr_FR", title:"French" }
														{ flag:FLAG_CHINA, 	locale:"zh_CN", title:"Simplified Chinese" },
														{ flag:null, locale:"da_DK", title:"Belgium" },
														{ flag:null, locale:"fi_FL", title:"Finland" },
														{ flag:null, locale:"it_IT", title:"Italy" },
														{ flag:null, locale:"ja_JP", title:"Japan" },
														{ flag:null, locale:"ko_KR", title:"Korea" },
														{ flag:null, locale:"nl_NL", title:"Netherlands" },
														{ flag:null, locale:"nb_NO", title:"Norway" },
														{ flag:null, locale:"pt_BR", title:"Portugal" },
														{ flag:null, locale:"ru_RU", title:"Russia" },
														{ flag:null, locale:"sv_SE", title:"Sweden" },
														{ flag:null, locale:"zh_tw", title:"India" },
														{ flag:null, locale:"zh_tw", title:"Ireland" },
														{ flag:null, locale:"zh_tw", title:"Norway" },
														{ flag:null, locale:"zh_tw", title:"Poland" },
														{ flag:null, locale:"zh_tw", title:"Australia" },
														{ flag:null, locale:"zh_tw", title:"New Zealand" },
														{ flag:null, locale:"zh_tw", title:"Mexico" },
														{ flag:null, locale:"zh_tw", title:"Brazil" },
														{ flag:null, locale:"zh_tw", title:"Turkey" },
														{ flag:null, locale:"zh_tw", title:"United Kingdom" },
														*/
													  ];

					
				
	}
    

}