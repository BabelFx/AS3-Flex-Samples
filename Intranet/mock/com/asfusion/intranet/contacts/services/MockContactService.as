package com.asfusion.intranet.contacts.services
{
	import com.asfusion.intranet.contacts.model.vos.Address;
	import com.asfusion.intranet.contacts.model.vos.Contact;
	import com.asfusion.intranet.contacts.model.vos.LabelValue;
	
	import flash.events.EventDispatcher;

	public class MockContactService extends EventDispatcher
	{
		public function getAll(data:String):Array
		{
			var contactsXML:XML = new XML( data );
			var contacts:Array = new Array();
			for each( var contactXML:XML in contactsXML..contact ) 
			{
				var contact:Contact = new Contact();
				contact.firstName = contactXML.firstName;
				contact.lastName = contactXML.lastName;
				contact.picture = contactXML.picture;
				contact.company = contactXML.company;
				contact.title = contactXML.title;
				
				contact.phones = new Array();
				for each( var phoneXML:XML in contactXML..phone ) 
				{
					var phone:LabelValue = new LabelValue();
					phone.label = phoneXML.@label;
					phone.value = phoneXML;
					contact.phones.push( phone );
				}
				
				contact.emails = new Array();
				for each( var emailXML:XML in contactXML..email ) 
				{
					var email:LabelValue = new LabelValue();
					email.label = emailXML.@label;
					email.value = emailXML;
					contact.emails.push( email );
				}
				
				contact.instantMessengers = new Array();
				for each( var instantMessengerXML:XML in contactXML..instantMessenger ) 
				{
					var instantMessenger:LabelValue = new LabelValue();
					instantMessenger.label = instantMessengerXML.@label;
					instantMessenger.value = instantMessengerXML;
					contact.instantMessengers.push( instantMessenger );
				}
				
				contact.addresses = new Array();
				for each( var addressXML:XML in contactXML..address ) 
				{
					var address:Address = new Address();
					address.street 	= addressXML.street;
					address.suite 	= addressXML.suite;
					address.city 	= addressXML.city;
					address.state 	= addressXML.state;
					address.zipcode = addressXML.zipcode;
					contact.addresses.push( address );
				}
				
				contacts.push( contact );
			}
			return contacts;
		}
	}
}