package com.asfusion.intranet.contacts.model.managers
{
	import com.asfusion.intranet.contacts.model.vos.Contact;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;

	public class ContactManager extends EventDispatcher
	{
		//--------------------------------------------------------------------
		//    Public Setters and Getters
		//--------------------------------------------------------------------
		
		//.................contacts......................
		private var _contacts:Array;
		[Bindable(Event="contactsChange")]
		public function get contacts():Array
		{
			return _contacts;
		}
		
		//.................selectedContact......................
		private var _selectedContat:Contact;
		[Bindable(Event="selectedContactChange")]
		public function get selectedContact():Contact
		{
			return _selectedContat;
		}
		
		
		//--------------------------------------------------------------------
		//    Public Methods
		//--------------------------------------------------------------------
		
		//.................storeContacts......................
		public function storeContacts( contacts:Array ):void
		{
			_contacts = contacts;
			dispatchEvent( new Event( "contactsChange" ) );
		}
		
		//.................selectContact......................
		public function selectContact( contact:Contact ):void
		{
			_selectedContat = contact;
			dispatchEvent( new Event( "selectedContactChange" ) );
		}
	}
}