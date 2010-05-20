package com.thunderbay.i18nDemo.vo
{
	import mx.utils.StringUtil;
	
	[Bindable]
	[RemoteClass(alias="AccountVO")]
	public class AccountVO
	{
		public var id:int = 0;
		
		public var fullName :String = "";		// 'firstName lastName' format
		public var company	:String = "";
		public var email	:String = "";

		public var postal	:String = "";
		public var phone	:String = "";		
		public var country	:String = "";
		public var state    :String = "";		// Full US state name; empty if non-US country
		
		public function get firstName() : String { return _firstName; }
		public function set firstName( val : String ) : void {
			if (val != _firstName) {
				_firstName = val;
				buildFullName();
			}
		}
		
		public function get lastName() : String { return _lastName; }
		public function set lastName( val : String ) : void {
			if (val != _lastName) {
				_lastName = val;
				buildFullName();
			}
		}
	
		// ****************************************
		// Constructor
		// ****************************************

		public function AccountVO(data:Object=null) {
			init(data);
		}

		// ****************************************
		// Public Methods
		// ****************************************
		
		/**
		 * Override to allow default data to be assigned; this supports a "reset" functionality
		 *  
		 * @param data
		 * @return 
		 * 
		 */		
		public function init( data:* = null) : * {
			var src : AccountVO = data as AccountVO;
			
			if (src != null) {
				this.firstName = src.firstName;
				this.lastName  = src.lastName;
				this.email     = src.email;
				this.company   = src.company;
				this.country   = src.country;
				this.state     = src.state;
				this.postal    = src.postal;
				this.phone     = src.phone;
			} else {
				if (data == null) data = {};
				for (var key:String in data) {
					if (this.hasOwnProperty(key)) this[key] = data[key];
				}
			}
			
			return this;
		}

		public function clone():AccountVO {
			return (new AccountVO().copyFrom(this));
		}
		
		public function copyFrom(src:Object):AccountVO {
			return (init(src) as AccountVO);	
		}

		// ****************************************
		// Private Util method
		// ****************************************

		private function buildFullName() : void {
			var format : String = "{0} {1}";
			
			fullName = StringUtil.trim(StringUtil.substitute(format, [_firstName,_lastName]));
		}
		
		private var _firstName : String = "";
		private var _lastName  : String = "";
	}
}