package com.cafetownsend.controller
{
	import com.cafetownsend.model.NavigationModel;
	
	import mx.logging.ILogger;

	
	public class NavigationController
	{
		[Inject]		public var model	 : NavigationModel	= null;
		[Log]			public var log  	 : ILogger 			= null;
		
		
		//--------------------------------------------------------------------------
		//
		// view state handling
		//
		//--------------------------------------------------------------------------
		
		
		[EventHandler(event="NavigationEvent.UPDATE_PATH",properties="path")]
		public function changeStateHandler( path: String ):void {
			if (log != null) log.debug("changeStateHandler({0})",path);
			model.path = path;
		}

		[EventHandler(event="LoginEvent.COMPLETE")]
		public function logInCompleteHandler():void {
			if (log != null) log.debug("logInCompleteHandler()");
			
			model.path = NavigationModel.PATH_LOGGED_IN;
		}
		

	}
}