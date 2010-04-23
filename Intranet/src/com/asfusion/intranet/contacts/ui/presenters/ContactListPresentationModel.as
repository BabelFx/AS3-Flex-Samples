package com.asfusion.intranet.contacts.ui.presenters
{
	import com.asfusion.intranet.contacts.events.ContactEvent;
	import com.asfusion.intranet.contacts.model.vos.Contact;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	public class ContactListPresentationModel extends EventDispatcher
	{
		//--------------------------------------------------------------------
		//    Public Constants
		//--------------------------------------------------------------------
		
		public static const LOADING_STATE:String = "loadingState";
		public static const LOADED_STATE:String  = "loadedState";
		
		//--------------------------------------------------------------------
		//    Public Setters and Getters
		//--------------------------------------------------------------------
		
		//.................state......................
		private var _state:String = LOADING_STATE;
		[Bindable(Event="stateChange")]
		public function get state():String
		{
			return _state;
		}
		
		//.................contacts......................
		private var _contacts:Array;
		[Bindable(Event="contactsChange")]
		public function get contacts():Array
		{
			return _contacts;
		}
		public function set contacts( value:Array ):void
		{
			if( value != null )
			{
				_state = LOADED_STATE;
				dispatchEvent( new Event( "stateChange" ) );
			}
			_contacts = value;
			dispatchEvent( new Event( "contactsChange" ) );
		}
		
		//.................selectedContact......................
		private var _selectedContact:Contact;
		[Bindable(Event="selectedContactChange")]
		public function get selectedContact():Contact
		{
			return _selectedContact;
		}
		public function set selectedContact( value:Contact ):void
		{
			_selectedContact = value;
			dispatchEvent( new Event( "selectedContactChange" ) );
		}
		
		//--------------------------------------------------------------------
		//    Constructor
		//--------------------------------------------------------------------
		
		private var dispatcher:IEventDispatcher;
		public function ContactListPresentationModel( dispatcher:IEventDispatcher ):void
		{
			this.dispatcher = dispatcher;
		}
		
		//--------------------------------------------------------------------
		//    Public Methods
		//--------------------------------------------------------------------
		
		public function updateSelectedContact( contact:Contact ):void
		{
			var event:ContactEvent = new ContactEvent ( ContactEvent.CONTACT_SELECT );
			event.contact = contact;
			dispatcher.dispatchEvent( event );
		}
	}
}