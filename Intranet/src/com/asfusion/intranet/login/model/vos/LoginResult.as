package com.asfusion.intranet.login.model.vos
{
	import com.asfusion.intranet.shared.model.vos.User;

	[Bindable]
	public class LoginResult
	{

		public var message:String = "";
		public var status:Boolean = false;
		public var user:User = null;
	}
}