package assets
{
    public class i18nDemoAssets
    {
				// *****************************************
				// Preloader and Loading Indicator
				// Note: change mimeType so loadAsset() can be used on rawBytes during preload process
				// *****************************************
					
				/* static public const SPLASH_WIDTH 	: int = 344;
				static public const SPLASH_HEIGHT : int = 184; */
				[Embed(source='/assets/images/splash.png', mimeType='application/octet-stream')]
				public static const  SPLASH : Class;

				[Embed(source='/assets/images/flags/spain32x32.png')]
				public static const  FLAG_SPAIN : Class;

				[Embed(source='/assets/images/flags/us32x32.png')]
				public static const  FLAG_USA : Class;
	}
    

}