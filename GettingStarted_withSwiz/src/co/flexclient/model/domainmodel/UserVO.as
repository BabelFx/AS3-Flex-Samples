package co.flexclient.model.domainmodel {

    [Bindable] [RemoteClass(alias="uk.co.prodia.prosoc.domainmodel.ProsocUser")]

    public class UserVO{

        import mx.collections.ArrayCollection;

        public var userId:int;
        public var username:String;
        public var forename:String;
        public var surname:String;
        public var avatar:String;
        public var htUserTrackerDataMappers:ArrayCollection = new ArrayCollection();
        public var emailToBeConfirmed:String;
        public var email:String;
        public var firstEmail:String;
        public var activationCode:String;
        public var loginEnabled:Boolean;
        public var gender:String;
        public var birthday:Date;
        public var coolLink1:String;
        public var coolLink2:String;
        public var joinDate:Date;
        public var lastLoginDate:Date;
        public var lastLoginIpAddress:String;
        public var placeholderBlogNumberEnteries:int;
        public var prosocUnsuitableContents:ArrayCollection = new ArrayCollection();
        public var prosocPermissions:ArrayCollection = new ArrayCollection();

		/**
		 * This is replaced on the server, so the client will never have the real password.
		 */
        public var password:String;

        /**
          * Required for ASM/BlazeDS to work
          */
        public function UserVO(username:String=null, password:String=null)  
		{
			this.username = username;
			this.password = password;
		}
    }
}