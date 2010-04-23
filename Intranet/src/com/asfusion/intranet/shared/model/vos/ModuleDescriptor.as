package com.asfusion.intranet.shared.model.vos
{
	public class ModuleDescriptor
	{
		public var label:String;
		public var url:String;
		
		public function ModuleDescriptor( label:String, url:String )
		{
			this.label = label;
			this.url = url;
		}
	}
}