package com.thunderbay.i18nDemo.model
{
	import flash.events.EventDispatcher;
	
	import com.thunderbay.i18nDemo.vo.AccountVO;
	
	
	[Bindable]
	public class Model extends EventDispatcher
	{
		// ******************************************************************
		// Public attributes
		// ******************************************************************

		/**
		 * Read-only property to check in visitor has signedIn succesfully.
		 * 
		 * @return true/false
		 * 
		 */
		[Event('isSignedInChanged')]
		public function get isSignedIn() : Boolean {
			return (account.id != 0);
		}   

		/**
		 * VO to manage information for the current visitor, if the ID != 0,
		 * then the server has successfully looked-up the visitor and the sign-in is
		 * complete 
		 */
		public var account			 :	AccountVO 		= null;
		
		/**
		 * Templates for URL for runtime, dynamic resource bundles and localized CSS files 
		 */
		public var resourcePath : String = "assets/locale/bundles/{0}.swf";
		public var cssPath      : String = "assets/locale/{0}/assets/css/{1}.css";
		public var locale       : String = "en_US";	 // default locale at startup...
		
		// These should also be in property files
		public var supportedLocales : Array = [
			{label:"English",  code:"en_US"},
			{label:"Spanish",  code:"es_ES"},
		];
		

		// ******************************************************************
		// Constructor and Public Methods
		// ******************************************************************

		public function Model() {
			super();

			if (_instance == null) {
				_cache = new LocalProfile(this);
				_instance = this;
			}
			else {
				throw new Error("Model instance already constructed!");
			}
		}


		
		
		
		// ******************************************************************
		// Singleton Methods
		// ******************************************************************

		static public function get instance():Model {
			if (_instance == null) _instance = new Model();
			return _instance;
		}
		static 	private var _instance : Model        = null; 

				private var _cache    : LocalProfile = null;
	}	
	
}



	import flash.events.Event;
	import flash.net.SharedObject;
	
	import mx.events.PropertyChangeEvent;
	
	import com.thunderbay.i18nDemo.vo.AccountVO;
    import com.thunderbay.i18nDemo.model.Model;
	

class LocalProfile {
	
	public function LocalProfile(src:Model) {
		_model = src;
		
		loadFromCache();	

		// Internal listeners so changes are "auto-saved"
		_model.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE,updateCache,false,0,true);
	}
	
	public function clear():void {
		_model.account    = new AccountVO();

		var so:SharedObject = SharedObject.getLocal( LSO_KEY );
			so.clear();
			so.flush();
	}
	
	private function updateCache(event:PropertyChangeEvent) : void {
		if (event.property == "account") {
			var so:SharedObject = SharedObject.getLocal( LSO_KEY );
			
			if (so && so.data) {	
				so.data.account 			= _model.account;
			
				so.flush();
			}
			
			announceChanges(event);
		}
	}

	private function loadFromCache():void {
		try {
			var so:SharedObject = SharedObject.getLocal( LSO_KEY );
			
			if (so && so.data) {			
				if( so.data.account != null ) 			_model.account 				= so.data.account as AccountVO;
				
				if (_model != null) _model.account.id = 0; // clear signedIn flag... just loading for now!
				announceChanges();
			} else {
				_model.account = new AccountVO();
			}
		} catch (e:Error) {
			_model.account = new AccountVO();
		}
	}
	
	private function announceChanges(event:PropertyChangeEvent=null):void {
		if ((event == null) || (event.property=="account")) {
			// Hack to auto-announce potential account changes...
			_model.dispatchEvent(new Event("isSignedInChanged"));
		}
	}
	
	private const LSO_KEY : String  = "varianExperience.localAccount";
	private var   _model  : Model   = null;	
}


