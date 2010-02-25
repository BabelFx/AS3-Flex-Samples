package com.thunderbay.i18nDemo.views.preloader
{
	import assets.i18nDemoAssets;
	import tb.preloader.RSLPreloader;

	public class Preloader extends RSLPreloader
	{
		public function Preloader()
		{
			super(i18nDemoAssets.SPLASH);
			
			vOffset_Bar 	= 165;
			vOffset_Status 	= 150;
		}
	}
}