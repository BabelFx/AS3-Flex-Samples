package com.cafetownsend.presentation
{
	import com.cafetownsend.domain.User;
	import com.cafetownsend.event.LoginEvent;
	import com.cafetownsend.model.Constants;
	
	import flash.events.IEventDispatcher;
	
	import mx.events.ValidationResultEvent;
	import mx.logging.ILogger;
	import mx.rpc.Fault;
	import mx.validators.StringValidator;
	
	public class LoginPresentationModel
	{
		public static const STATE_DEFAULT	 :String 			= "default";
		public static const STATE_ERROR	 	 :String 			= "error";
		
		[Bindable]	public var currentState	:String  			= STATE_DEFAULT;
		
		[Log]			public var log  	 : ILogger 			= null;		
		[Dispatcher]	public var dispatcher:IEventDispatcher  = null;
		
		[Inject("appModel.lastUsername")]
		[Bindable]	public var lastUsername	:String 			= "";
		
		[Bindable]	public var password		:String 			= "";
		[Bindable]	public var usernameError:String 			= "";
		[Bindable]	public var passwordError:String 			= "";
		[Bindable]	public var loginError	:String 			= "";
		
		[Bindable]	public var loginPending	:Boolean 			= false;
		
		public function login(username:String, password:String):void {
			if (log != null) log.debug("login(username:{0}, password:{1})",username,password);
			
			currentState = STATE_DEFAULT;		
			
			if( validateLogin(username, password) )
			{
				var user:User = new User(NaN, username, password);
				dispatcher.dispatchEvent(new LoginEvent(LoginEvent.LOGIN, user));

				loginPending = true;
			}
		}
		
		protected var stringValidator:StringValidator;
		
		public function validateLogin(username: String, password: String):Boolean 
		{
			var valid: Boolean = false;
			
			// create stringValidator if not created yet
			stringValidator ||= new StringValidator();
			
			var stringValidation: ValidationResultEvent = stringValidator.validate( username );
			var validUserName:Boolean = stringValidation.results == null;
			usernameError = ( validUserName ) ? "" : Constants.LOGIN_INVALID_USERNAME;

			stringValidation = stringValidator.validate( password );
			var validPassword:Boolean = stringValidation.results == null;
			passwordError = ( validPassword ) ? "" : Constants.LOGIN_INVALID_PASSWORD;
			
			if (log != null) log.debug("validateLogin(): validUserName:{0}, validPassword:{1}",validUserName,validPassword);
			
			return validUserName && validPassword;
		}

		[EventHandler(event="LoginErrorEvent.LOGIN_ERROR", properties="fault")]
		public function handleLoginError(fault:Fault):void {
			loginError = fault.faultString + ": " + fault.faultDetail;
			currentState = STATE_ERROR;
			
			loginPending = false;
			
			if (log != null) log.debug("handleLoginError(fault:{0})",loginError);
		}

		[EventHandler(event="LoginEvent.COMPLETE")]
		public function handleLoginComplete( event: LoginEvent ):void {
			loginPending = false;
			
			if (log != null) log.debug("handleLoginComplete(user:{0})",event.user.username);
		}
	
	}
}