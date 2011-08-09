package co.flexclient.model 
{
	/**
	 * Defines the constants that are used within the application.
	 * 
	 * @author Gavin Donald
	 */
	public class Constant {
		
		/**
		 * This variable should be set so that the standalone flash player can connect to the AMF service.
		 * If this is set to false (as it should be when deployed on live), then the standalone flash player
		 * will not be able to log in.
		 */
		static public const IS_DEVELOPMENT_ENVIRONMENT:Boolean = true;
		
		/**
		 * The username of the developer. This is used in places such as the login dialog so that the developer
		 * does not need to continually type their name in. This is only used if IS_DEVELOPMENT_ENVIRONMENT is true.
		 */
		static public const DEVELOPER_USERNAME:String = "gavin";
		
		/**
		 * The password of the developer. This is used in places such as the login dialog so that the developer
		 * does not need to continually type their password in. This is only used if IS_DEVELOPMENT_ENVIRONMENT is true.
		 */
		static public const DEVELOPER_PASSWORD:String = "tester";
		
		/**
		 * This defines how many HtDay objects should be retreived for each HtTracker that the
		 * user has. This prevents too much bandwith being consumed as the user may have thousands 
		 * of these, but we will only show a small amount on the screen at any one time.
		 */
		static public const NUMBER_OF_DAYS_TO_GET:int = 30;
		
		// NOTE: these must match the viewstates in HabittrackerClient.mxml
		
		static public const APP_SHOW_LOGIN 		: String = "showLogin";
		static public const APP_AUTHENTICATED	: String = "authenticated"
		
	}
}