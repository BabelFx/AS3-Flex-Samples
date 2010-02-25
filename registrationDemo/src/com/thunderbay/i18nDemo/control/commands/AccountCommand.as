package com.thunderbay.i18nDemo.control.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.thunderbay.i18nDemo.events.LoadAccountEvent;
	import com.thunderbay.i18nDemo.events.SaveAccountEvent;
	import com.thunderbay.i18nDemo.model.Model;
	import com.thunderbay.i18nDemo.vo.AccountVO;
	import com.universalmind.cairngorm.commands.Command;
	
	import mx.controls.Alert;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	public class AccountCommand extends Command
	{
		override public function execute( event:CairngormEvent ):void {
			super.execute(event);
			
			switch(event.type) {
				
				case LoadAccountEvent.EVENT_ID	:  loadAccount(event as LoadAccountEvent);	break;
				case SaveAccountEvent.EVENT_ID  :  saveAccount(event as SaveAccountEvent);	break;
			}
		}
		
		
		// ************************************************************************************
		// Public Methods invoked by BaseCommand::execute()
		// ************************************************************************************
	
		public function loadAccount( event:LoadAccountEvent ):void
		{
			var data     : Object      = new AccountVO({email:event.email});
			var response : ResultEvent = new ResultEvent(ResultEvent.RESULT,false,false,data);

			onResults_loadAccount(response);
		}
		
		public function saveAccount( event:SaveAccountEvent ):void
		{	
			var data     : Object      = event.account.clone();
			var response : ResultEvent = new ResultEvent(ResultEvent.RESULT,false,false,data);
			
			onResults_loadAccount(response);
		}
		
		
		// ************************************************************************************
		// Private Dataservice Handlers
		// ************************************************************************************
	
		private function onResults_loadAccount( event:ResultEvent ):void {
			// Clear lockcode when loading from server...
			var loaded  : Boolean = parseAccount(event);
			var isValid : Boolean = _model.account && (_model.account.email != "");
			
			if ( loaded && isValid  ) 		afterAccountLoad();
			else							Alert.show(_rbMngr.getString("registration","error.profile.notFound",[_account.email]));
			
			notifyCaller(Model.instance.account);
		}
		
		private function onResults_saveAccount( event:ResultEvent ):void	{
			if ( parseAccount(event) == true ) 		afterAccountLoad();
			else								    Alert.show(_rbMngr.getString("registration","error.profile.notSaved",[_account.email]));
			
			notifyCaller(Model.instance.account);
		}
		
		
		// ************************************************************************************
		// Private Methods
		// ************************************************************************************
	
		private function parseAccount(event:ResultEvent):Boolean {
			var result : Boolean   = false;
			var src    : AccountVO = (event.result as AccountVO);
			
			if (src != null) {
				result = true;
				// Update instance in ModelLocator and ALSO the original reference;
				// Do this so current databinding references update
				Model.instance.account = src;
				if (_account != null) _account.copyFrom(src);
			} 
			
			return result;
		}
		
		private function afterAccountLoad():void {
			 // If registered for campaign access (currently pending)
			 if (_model.account.country == "") {
			 	// This can only happen for Already Registered  signins for downloads
			 	// Need to throw alert...
			 	Alert.show(_rbMngr.getString("registration","error.profile.notFound",[_model.account.email]));
			 	return;
			 }
		}
		
		
		// ************************************************************************************
		// Private Attribute to hold profile reference during handleLoadAccountEvent()
		// ************************************************************************************
		private var _account : AccountVO 		= null;
		private var _model   : Model     		= Model.instance;
		private var _rbMngr  : IResourceManager = ResourceManager.getInstance();
	}
}