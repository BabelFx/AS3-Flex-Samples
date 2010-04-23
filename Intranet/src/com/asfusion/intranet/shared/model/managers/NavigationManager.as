package com.asfusion.intranet.shared.model.managers
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	public class NavigationManager extends EventDispatcher
	{
		//---------------------------------------------------------
		//    Public Getters and Setters
		//---------------------------------------------------------
		[Bindable(Event="pathChanged")]
		public function get path():String
		{
			return "path";
		}
		
		//----------------------------------------------------------
		//     Constructor
		//----------------------------------------------------------
		public function NavigationManager(target:IEventDispatcher=null)
		{
			super(target);
		}
		
	}
}