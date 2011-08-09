package co.flexclient.model {
	
	import co.flexclient.model.domainmodel.UserVO;
	
	[Bindable] 
	/**
	 * 
	 * @author gavin
	 */
	public class UserModel {
		
		/**
		 * The user that is logged into the application
		 */
		public var user			:UserVO = new UserVO(Constant.DEVELOPER_USERNAME, Constant.DEVELOPER_PASSWORD);
		
		public var readOnly		:Boolean	= false;
		
	}
}