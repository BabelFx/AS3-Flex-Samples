package co.flexclient.event
{
	
	import flash.events.Event;
	
	/**
	 * @author Gavin Donald
	 */
	public class LoginEvent extends Event {
		
		/**
         * Fired when the server does not recognise the logged in user (maybe due to a session timeout),
		 * and requires that the user login to the server.
         */
		public static const LOGIN_REQUIRED:String = "loginRequired";
		
		/**
         * Fired when the user presses the login button.
         */
		public static const LOGIN:String = "login";
		
		/**
		 * Fired when a successful login occurs.
		 */
		public static const LOGIN_SUCCESS:String = "loginSuccess";
		
		/**
		 * Fired when a failed login occurs.
		 */
		public static const LOGIN_FAILED:String = "loginFailed";
		
		/**
		 * Fired when the DialogLogin should be closed.
		 */
		public static const LOGOUT:String = "logoutCurrentUser";
		
		/**
		 * The name that the user is using to attempt the login.
		 */
		public var username:String = "UNKNOWN";
		
		/**
		 * The password that the user is using to attempt the login
		 */
		public var password:String = "UNKNOWN";
		
		/**
		 * The fault code for a failed login attempt
		 */
		public var faultCode:String;
		
		/**
		 * The constructor for this event.
		 */
		public function LoginEvent(type:String , username:String = null , password:String = null , faultCode:String = null):void {
			super(type , true);
			this.username = username;
			this.password = password;
			this.faultCode = faultCode;
		}
		
		override public function clone():Event {
			return new LoginEvent(type,username,password,faultCode);
		}
	}
}