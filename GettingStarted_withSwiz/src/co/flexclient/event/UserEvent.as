package co.flexclient.event 
{
	
	import co.flexclient.model.Constant;
	import flash.events.Event;
	import co.flexclient.model.domainmodel.UserVO;

	public class UserEvent extends Event {

        /**
         * Fired when the application attempts to get the user from the server.
         */
		public static const AUTHENTICATE : String = "getUser";

        /**
         * Fires when the user has been retrieved from the server.
         */
        public static const GOT_USER : String = "gotUser";

		/**
		 * The prosocUser who was retreived from the server. 
		 */
		public var prosocUser:UserVO;
		
		/**
		 * This defines how many HtDay's will be attached to each tracker that the user has. This prevents too
		 * many HtDay's being requested which would cause large bandwith calls and strain the server.
		 */
		public var _numberOfDaysToGet:int;
		
		/**
		 */
		public function UserEvent(type:String , prosocUser:UserVO = null , numberOfDaysToGet:int = 0):void {
			super(type , true);
			this._numberOfDaysToGet = numberOfDaysToGet;
			this.prosocUser = prosocUser;
		}
	}
}