package com.asfusion.intranet.contacts.events
{
	import com.asfusion.intranet.contacts.model.vos.Contact;
	
	import flash.events.Event;

	public class ContactEvent extends Event
	{
		//--------------------------------------
		//   Public Constants
		//--------------------------------------
		public static const GET_ALL:String 			= "getAllContactEvent";
		public static const CONTACT_SELECT:String 	= "contactSelectContactEvent";
		
		//--------------------------------------
		//    Public Properties
		//--------------------------------------
		public var contact:Contact;
		
		//----------------------------------------
		//     Constructor
		//----------------------------------------
		public function ContactEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}