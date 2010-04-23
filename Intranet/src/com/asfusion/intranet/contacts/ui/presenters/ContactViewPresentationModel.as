package com.asfusion.intranet.contacts.ui.presenters
{
	import com.asfusion.intranet.contacts.model.vos.Address;
	import com.asfusion.intranet.contacts.model.vos.Contact;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;

	public class ContactViewPresentationModel extends EventDispatcher
	{
		//--------------------------------------------------------------------
		//    Public Setters and Getters
		//--------------------------------------------------------------------
		
		//.................header......................
		private var _header:String;
		[Bindable(Event="contactChange")]
		public function get header():String
		{
			return _header;
		}
		
		//.................body......................
		private var _body:String;
		[Bindable(Event="contactChange")]
		public function get body():String
		{
			return _body;
		}
		
		//.................picture......................
		private var _picture:String;
		[Bindable(Event="contactChange")]
		public function get picture():String
		{
			return _picture;
		}
		
		//.................emails......................
		private var _emails:Array;
		[Bindable(Event="contactChange")]
		public function get emails():Array
		{
			return _emails;
		}
		
		//.................phones......................
		private var _phones:Array;
		[Bindable(Event="contactChange")]
		public function get phones():Array
		{
			return _phones;
		}
		
		//.................instantMessengers......................
		private var _instantMessengers:Array;
		[Bindable(Event="contactChange")]
		public function get instantMessengers():Array
		{
			return _instantMessengers;
		}
		
		//.................showPicture......................
		private var _showPicture:Boolean;
		[Bindable(Event="contactChange")]
		public function get showPicture():Boolean
		{
			return _showPicture;
		}
		
		//.................showAddresses......................
		private var _showAddresses:Boolean;
		[Bindable(Event="contactChange")]
		public function get showAddresses():Boolean
		{
			return _showAddresses;
		}
		
		//.................addresses......................
		private var _addresses:String;
		[Bindable(Event="contactChange")]
		public function get addresses():String
		{
			return _addresses;
		}
		
		//.................contact......................
		private var _contact:Contact;
		[Bindable(Event="contactChange")]
		public function get contact():Contact
		{
			return _contact;
		}
		public function set contact( value:Contact ):void
		{
			_contact = value;
			if( _contact != null )
			{
				//html = "<p><font size='22'><b>{0} {1}</b></font></p>";
				
				_header = "<p><font size='22'><b>";
				_header += _contact.firstName + " " + _contact.lastName;
				_header += "</b></font></p>";
				if( _contact.company )
				{
					_header += "<p><font size='16'>" + _contact.company + "</font></p>";
				}
				if( _contact.title )
				{
					_header += "<p>" + _contact.title  + "</p>";
				}
				_picture = "assets/images/" + _contact.picture;
				
				_emails = _contact.emails;
				_phones = _contact.phones;
				_instantMessengers = _contact.instantMessengers;
				
				_addresses = "";
				
				if( _contact.addresses && _contact.addresses.length > 0 )
				{
					_showAddresses = true;
					
					
					for each( var address:Address in _contact.addresses )
					{
						_addresses += "<p><b>Street: </b>" + address.street;
						if( address.suite ) _addresses +=  "     <b>Suite: </b>" + address.suite + "</p>";
						
						_addresses += "<b>City: </b>" + address.city + "     <b>State: </b>" + address.state;
						_addresses += "     <b>Zip: </b>" + address.zipcode;
					}
				}
				else
				{
					_showAddresses = false;
				}
				
				_showPicture = true;
			}
			else
			{
				_header = "";
				_picture = "";
				_addresses = "";
				_emails = null;
				_phones = null;
				_instantMessengers = null;
				_showPicture = false;
				_showAddresses = false;
			}
			
			
			dispatchEvent( new Event( "contactChange" ) );
		}
		
		
	}
}