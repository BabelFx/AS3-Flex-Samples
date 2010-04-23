package com.asfusion.intranet.login.ui.presenters
{
	import com.asfusion.intranet.login.events.AuthorizationEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	public class LoginPresentationModel extends EventDispatcher
	{
		
		public var errorMessages : Array = [
			{text:"Username is a required field."},
			{text:"Password is a required field."},
			{text:"Username and Password are required fields."},
			{text:"Login Failed please make sure that the username and password are correct."}
											];
		
		//-----------------------------------------------------------------
		//   Public static Constants
		//-----------------------------------------------------------------
		public static const LOGIN_STATE:String 		= "loginState";
		public static const LOADING_STATE:String 	= "loadingState";
		public static const ERROR_STATE:String 		= "errorState";
		
		//-----------------------------------------------------------------
		//   Public Getters and Setters
		//-----------------------------------------------------------------
		
		//------------passwordErrorString--------------------
		private var _passwordErrorString:String;
		[Bindable(Event="validationChange")]
		public function get passwordErrorString():String
		{
			return _passwordErrorString;
		}
		
		//-------------usernameErrorString--------------------
		private var _usernameErrorString:String;
		[Bindable(Event="validationChange")]
		public function get usernameErrorString():String
		{
			return _usernameErrorString;
		}
		
		//--------------errorMessage--------------------
		private var _errorMessage:String;
		[Bindable(Event="errorMessageChange")]
		public function get errorMessage():String
		{
			return _errorMessage;
		}
		
		//-------------state--------------------
		private var _state:String = LOGIN_STATE;
		[Bindable(Event="stateChange")]
		public function get state():String
		{
			return _state;
		}
		
		//-------------------------------------------
		//   Contructor
		//-------------------------------------------
		private var dispatcher:IEventDispatcher;
		public function LoginPresentationModel( dispatcher:IEventDispatcher )
		{
			this.dispatcher = dispatcher;
		}
		
		
		//----------------------------------------------------
		//    Public Methods
		//----------------------------------------------------
		
		//..................login............................
		public function login( username:String, password:String):void
		{
			this.username = username;
			this.password = password;
			var isValid:Boolean = validate();
			
			if( isValid )
			{
				var event:AuthorizationEvent = new AuthorizationEvent( AuthorizationEvent.LOGIN );
				event.username = username;
				event.password = password;
				dispatcher.dispatchEvent( event );
				_errorMessage = "";
				_state = LOADING_STATE;
			}
			else
			{
				if( _passwordErrorString &&  _usernameErrorString )
				{
					_errorMessage = errorMessages[2].text;
				}
				else
				{
					_errorMessage = ( _usernameErrorString ) ? _usernameErrorString : _passwordErrorString;
				}
				_state = ERROR_STATE;
			}
			dispatchEvent( new Event( "stateChange" ) );
			dispatchEvent( new Event( "errorMessageChange" ) );
		}
		
		//..................updateUsername....................
		private var username:String;
		public function updateUsername( value:String ):void
		{
			if( username != null)
			{
				username = value;
				validate();
			}
		}
		
		//..................updatePassword....................
		private var password:String;
		public function updatePassword( value:String ):void
		{
			if( password != null)
			{
				password = value;
				validate();
			}
		}
		
		//..................clearSession....................
		public function clearSession( event:Event = null):void
		{
			_state = LOGIN_STATE;
			dispatchEvent( new Event( "stateChange" ) );
		}
		
		//-----------------------------------------------------------------
		//                   Private Methods
		//-----------------------------------------------------------------
		
		//..................validate....................
		internal function validate():Boolean
		{
			_state = LOGIN_STATE;
			dispatchEvent( new Event( "stateChange" ) );
			
			var isValid:Boolean = true;
			_usernameErrorString = "";
			_passwordErrorString = "";
			if( username != null )
			{
				isValid = username.length != 0;
				_usernameErrorString = ( isValid ) ? "" : errorMessages[0].text;
			}
			if( password != null )
			{
				isValid = ( !isValid ) ? isValid : password.length != 0;
				_passwordErrorString = ( password.length != 0 ) ? "" : errorMessages[1].text;
			}
			dispatchEvent( new Event( "validationChange" ) );
			return isValid;
		}
		
		//-----------------------------------------------------------------
		//                   Event Handler
		//-----------------------------------------------------------------
	
		//..................loginFailedHandler....................
		public function loginFailedHandler( event:AuthorizationEvent ):void
		{
			_errorMessage = errorMessages[3].text;
			_state = ERROR_STATE;
			dispatchEvent( new Event( "errorMessageChange" ) );
			dispatchEvent( new Event( "stateChange" ) );
		}
		
		
	}
}