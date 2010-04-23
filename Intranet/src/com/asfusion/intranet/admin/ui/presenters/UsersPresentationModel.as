package com.asfusion.intranet.admin.ui.presenters
{
	import com.asfusion.intranet.admin.events.UserEvent;
	import com.asfusion.intranet.shared.model.vos.User;
	import com.asfusion.intranet.shared.model.vos.UserPermissions;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.utils.StringUtil;

	public class UsersPresentationModel extends EventDispatcher
	{
		
		public var codes:Array = [
			{buttonTitle:"Save Changes", viewTitle:"Editing '{0}'"},
			{buttonTitle:"Submit", 		 viewTitle:"New User"}
				
		];
		//--------------------------------------------------------------------
		//    Public Constants
		//--------------------------------------------------------------------
		public static const UNSELECTED:String 	= "unselected";
		public static const SELECTED:String 	= "selected";
		public static const ADD_NEW:String 		= "addNew";
		public static const LOADING:String 	= "addLoading";
		public static const SAVE_LOADING:String = "saveLoading";
		
		//--------------------------------------------------------------------
		//    Public Setters and Getters
		//--------------------------------------------------------------------
		
		//.................state......................
		private var _state:String = UNSELECTED;
		[Bindable(Event="stateChange")]
		public function get state():String
		{
			return _state;
		}
		
		//.................title......................
		private var _title:String;
		[Bindable(Event="selectedUserChange")]
		public function get title():String
		{
			return _title;
		}
		
		//.................submitLabel......................
		private var _submitLabel:String;
		[Bindable(Event="selectedUserChange")]
		public function get submitLabel():String
		{
			return _submitLabel;
		}
		
		//.................selectedUser......................
		private var _tempUser:User;
		private var _selectedUser:User;
		[Bindable(Event="selectedUserChange")]
		public function get selectedUser():User
		{
			return _selectedUser;
		}
		public function set selectedUser( value:User ):void
		{
			 if( state == LOADING)
			 {
			 	selectUser( value );
			 }
		}
		
		//.................users......................
		private var _users:ArrayCollection;
		[Bindable(Event="usersChange")]
		public function get users():ArrayCollection
		{
			return _users;
		}
		public function set users( value:ArrayCollection ):void
		{
			_users = value;
			dispatchEvent( new Event( "usersChange" ) );
		}
		
		//--------------------------------------------------------------------
		//    Constructor
		//--------------------------------------------------------------------
		
		private var dispatcher:IEventDispatcher;
		public function UsersPresentationModel( dispatcher:IEventDispatcher ):void
		{
			this.dispatcher = dispatcher;
		}
		
		//--------------------------------------------------------------------
		//    Public Methods
		//--------------------------------------------------------------------
		
		//.................selectUser......................
		public function selectUser( user:User ):void
		{
			_submitLabel = codes[1].buttonTitle;
			_title = StringUtil.substitute(codes[0].viewTitle,[user.userName]);
			_state = SELECTED;
			_tempUser = new User( user );
			_selectedUser = user;
			dispatchEvent( new Event( "stateChange" ) );
			dispatchEvent( new Event( "selectedUserChange" ) );
			
			var event:UserEvent = new UserEvent( UserEvent.SELECT );
			event.user = user;
			dispatcher.dispatchEvent( event );
		}
		
		//.................addNewUser......................
		public function addNewUser():void
		{
			_submitLabel = codes[0].buttonTitle;
			_title = codes[0].viewTitle;
			_state = ADD_NEW;
			_tempUser = new User( );
			_selectedUser = null;
			dispatchEvent( new Event( "stateChange" ) );
			dispatchEvent( new Event( "selectedUserChange" ) );
		}
		
		//.................save......................
		public function save():void
		{
			var type:String = ( state == ADD_NEW ) ? UserEvent.ADD : UserEvent.UPDATE;
			var event:UserEvent = new UserEvent( type );
			event.user = _tempUser;
			dispatcher.dispatchEvent( event );
			
			_state = LOADING;
			dispatchEvent( new Event( "stateChange" ) );
		}
		
		//.................updateUsername......................
		public function updateUsername(  value:String):void
		{
			_tempUser.userName = value;
		}
		
		//.................updateFirstName......................
		public function updateFirstName( value:String ):void
		{
			_tempUser.firstName = value;
		}
		
		//.................updateLastName......................
		public function updateLastName( value:String ):void
		{
			_tempUser.lastName = value;
		}
		
		//.................updatePassword......................
		public function updatePassword( value:String ):void
		{
			_tempUser.password = value;
		}
		
		//.................updatePermissions......................
		public function updatePermissions( value:UserPermissions ):void
		{
			_tempUser.permissions = value;
		}
	}
}