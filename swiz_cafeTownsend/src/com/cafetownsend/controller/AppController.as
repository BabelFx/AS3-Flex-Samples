package com.cafetownsend.controller
{
	import com.cafetownsend.domain.User;
	import com.cafetownsend.event.EmployeeEvent;
	import com.cafetownsend.event.LoginErrorEvent;
	import com.cafetownsend.event.LoginEvent;
	import com.cafetownsend.event.NavigationEvent;
	import com.cafetownsend.model.AppModel;
	import com.cafetownsend.model.NavigationModel;
	import com.cafetownsend.service.IUserDelegate;
	
	import flash.events.IEventDispatcher;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.swizframework.storage.SharedObjectBean;
	import org.swizframework.utils.services.ServiceHelper;
	
	public class AppController
	{
		[Inject]
		public var model:AppModel;
		
		[Inject]
		public var userDelegate:IUserDelegate;
		
		[Inject]
		public var serviceHelper:ServiceHelper;
		
		[Inject]
		public var soBean:SharedObjectBean;
		
		[Dispatcher]
		public var dispatcher:IEventDispatcher;
		
		public function AppController()
		{
		}
		
		[PostConstruct]
		public function init():void{
			var lastUsername:String = soBean.getString("lastUsername");
			if(lastUsername != null){
				model.lastUsername = lastUsername;
			}
		}
		
		
		//--------------------------------------------------------------------------
		//
		// login / logout handling
		//
		//--------------------------------------------------------------------------
		
		
		[Mediate(event="LoginEvent.LOGOUT")]
		public function logout():void
		{
			model.user = null;
			dispatcher.dispatchEvent( new NavigationEvent( NavigationEvent.UPDATE_PATH, NavigationModel.PATH_LOGGED_OUT ) );
		}
		
		[Mediate(event="LoginEvent.LOGIN", properties="user")]
		public function login(user:User):void
		{
			var call:AsyncToken = userDelegate.login(user.username, user.password);
			serviceHelper.executeServiceCall(call, loginResultHandler, loginFaultHandler);
		}
		
		protected function loginResultHandler(event:ResultEvent):void
		{
			var user:User = event.result as User;
			
			model.lastUsername = user.username; 
			soBean.setString("lastUsername", user.username);
				
			model.user = user;
			
			dispatcher.dispatchEvent( new LoginEvent( LoginEvent.COMPLETE ) );
		}
		
		protected function loginFaultHandler(event:FaultEvent):void
		{
			dispatcher.dispatchEvent(new LoginErrorEvent(LoginErrorEvent.LOGIN_ERROR, event.fault));
		}
	}
}