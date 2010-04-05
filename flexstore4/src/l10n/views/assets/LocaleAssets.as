package l10n.views.assets
{
    public class LocaleAssets
    {
				[Embed(source='/l10n/views/assets/images/flags/china32x32.png')]
				public static const  FLAG_CHINA : Class;

				[Embed(source='/l10n/views/assets/images/flags/france32x32.png')]
				public static const  FLAG_FRANCE : Class;

				[Embed(source='/l10n/views/assets/images/flags/spain32x32.png')]
				public static const  FLAG_SPAIN : Class;

				[Embed(source='/l10n/views/assets/images/flags/us32x32.png')]
				public static const  FLAG_USA : Class;
				
				
				
				static public function get allFlags():Array {
					return [FLAG_USA, FLAG_SPAIN, FLAG_FRANCE, FLAG_CHINA]; 
				}
				
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
				
				static public function getToolTip(flag:Class):String {
					var tip : String = "";
					
					for each (var it:Object in _locales) {
						if (it.flag == flag) {
							tip = it.title;
							break;
						}
					}
					
					return tip;
				}
				
				private static var _locales : Array = [
														{ flag:FLAG_CHINA, 	locale:"zh_CN", title:"Simplified Chinese" },
														{ flag:FLAG_USA, 	locale:"en_US", title:"English (USA)" },
														{ flag:FLAG_SPAIN, 	locale:"es_ES", title:"Spanish" },
														{ flag:FLAG_FRANCE, locale:"fr_FR", title:"French" }
													  ];
					
					
	}
    

}