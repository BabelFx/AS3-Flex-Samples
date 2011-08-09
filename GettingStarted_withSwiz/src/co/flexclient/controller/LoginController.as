package co.flexclient.controller {

	import co.flexclient.event.LoginEvent;
	import co.flexclient.model.UserModel;
	import co.flexclient.model.domainmodel.UserVO;
	
	import mx.logging.ILogger;
	import mx.rpc.events.ResultEvent;
	
	import org.swizframework.controller.AbstractController;

	public class LoginController extends AbstractController	{

        [Log] 											public var log:ILogger = null;
		
		[Inject(source = "userModel")]					public var model : UserModel;
		
		
		
        [EventHandler(event="UserEvent.AUTHENTICATE")]
		/**
		 * Perform a server request to get the currently logged in user.
		 */
		public function authenticateSession():void {
			log.debug("authenticateSession(.)");
			checkCurrentUser();
		}

		
		
		[EventHandler(event="LoginEvent.LOGIN")]
		/**
		 */
		public function login(event:LoginEvent):void {
			log.debug("Entered function login({0})",event.username);
			
			// Simulate login
			model.user.username = event.username;
			model.user.password = event.password;
			
			dispatcher.dispatchEvent( new LoginEvent(LoginEvent.LOGIN_SUCCESS, model.user.username, model.user.password) );
			
		}
		
		// ************************************************************************************************************
		// Private Methods
		// ************************************************************************************************************
		
		/**
		 */
		private function checkCurrentUser(event:ResultEvent=null):void { // event:ResultEvent - ADD THIS PARAMETER BACK IN!
			log.debug("handleGetCurrentlyLoggedInUserResult()");
			
			// Check to see if the returned user was null
			dispatcher.dispatchEvent( new LoginEvent(LoginEvent.LOGIN_REQUIRED) );
			
			model.user = new UserVO();
		}
		
	}
}