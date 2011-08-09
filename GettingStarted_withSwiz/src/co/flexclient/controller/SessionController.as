package co.flexclient.controller {

	import mx.logging.ILogger;
	
	import org.swizframework.controller.AbstractController;
	
	import co.flexclient.model.AppModel;
	import co.flexclient.model.Constant;

	public class SessionController extends AbstractController	{

        [Log] 											public var log:ILogger = null;
		
		[Inject(source = "appModel")]					public var model : AppModel;
		

        [EventHandler(event="LoginEvent.LOGIN_REQUIRED")]
		[EventHandler(event="LoginEvent.LOGOUT")]
		/**
		 * Show the Login view
		 */
		public function showUserLogin():void {
			log.debug("showUserLogin()");
			
			model.appState = Constant.APP_SHOW_LOGIN;
		}
		
		
		[EventHandler(event="LoginEvent.LOGIN_SUCCESS")]
		/**
		 * Hide the Login dialog and continue...
		 */
		public function showMainView():void {
			log.debug("showMainView()");
			
			model.appState = Constant.APP_AUTHENTICATED;
		}
	}
}