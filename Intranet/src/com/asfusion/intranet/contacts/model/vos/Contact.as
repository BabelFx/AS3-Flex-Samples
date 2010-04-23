package com.asfusion.intranet.contacts.model.vos
{
	public class Contact
	{
		[Bindable]
		public var firstName:String;
		
		[Bindable]
		public var lastName:String;
		
		[Bindable]
		public var picture:String;
		
		public var title:String;
		public var company:String;
		public var addresses:Array;
		public var emails:Array;
		public var phones:Array;
		public var instantMessengers:Array;
	}
}