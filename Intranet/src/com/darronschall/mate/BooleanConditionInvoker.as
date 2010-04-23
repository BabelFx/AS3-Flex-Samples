package com.darronschall.mate
{
	import com.asfusion.mate.actionLists.IScope;
	import com.asfusion.mate.actions.IAction;
	import com.asfusion.mate.actions.builders.ObjectBuilder;
	import com.asfusion.mate.core.SmartObject;
	import com.asfusion.mate.utils.debug.LogInfo;
	import com.asfusion.mate.utils.debug.LogTypes;
	
	import mx.logging.ILogger;

	/**
	 * @example <listing version="3.0">
	 * &lt;EventHandlers type="{XXXXX}"&gt;
	 * ....
	 * 	&lt;extentions:BooleanConditionInvoker condition="{ lastReturn }"&gt;
	 * 		&lt;extentions:trueHandlers&gt;
	 * 			............
	 * 		&lt;/extentions:trueHandlers&gt;
	 * 		&lt;extentions:falseHandlers&gt;
	 * 			............
	 * 		&lt;/extentions:falseHandlers&gt;
	 * 	&lt;/extentions:BooleanConditionInvoker&gt;
	 * &lt;/EventHandelrs&gt;
	 * </listing>
	 */
	public class BooleanConditionInvoker extends ObjectBuilder implements IAction
	{
		
		// ------------------------------------------------------
		//  condition property
		// ------------------------------------------------------
		
		private var _condition:*;
		
		public function get condition():*
		{
			return _condition;
		}
		
		/**
		 * @param value Boolean or SmartObject
		 */
		public function set condition( value:* ):void
		{
			if ( value is Boolean || value is SmartObject )
			{
				_condition = value;
			}
			else
			{
				throw new Error( "BooleanConditionInvoker condition must be Boolean or SmartObject" );
			}
		}
		
		// ------------------------------------------------------
		//  trueHandlers property
		// ------------------------------------------------------
		
		private var _trueHandlers:Array;
		
		public function get trueHandlers():Array
		{
			return _trueHandlers;
		}
		
		[ArrayElementType( "com.asfusion.mate.actions.IAction" )]
		public function set trueHandlers( value:Array ):void
		{
			_trueHandlers = value;
		}
		
		// ------------------------------------------------------
		//  falseHandlers property
		// ------------------------------------------------------
		
		private var _falseHandlers:Array;
		
		public function get falseHandlers():Array
		{
			return _falseHandlers;
		}
		
		[ArrayElementType( "com.asfusion.mate.actions.IAction" )]
		public function set falseHandlers( value:Array ):void
		{
			_falseHandlers = value;
		}
		
		/**
		 * Constructor
		 */
		public function BooleanConditionInvoker()
		{
			super();
		}
		
		/**
		 * 
		 */
		override protected function prepare( scope:IScope ):void
		{
			currentInstance = this;
		}
		
		/**
		 * 
		 */
		override protected function run( scope:IScope ):void
		{
			// Evaluate condition and run appropriate handlers
			if ( condition is Boolean 
						? condition 
						: SmartObject( condition ).getValue( scope ) )
			{
				if ( trueHandlers && trueHandlers.length )
				{
					runSequence( scope, trueHandlers );
				}
			}
			else
			{
				if ( falseHandlers && falseHandlers.length )
				{
					runSequence( scope, falseHandlers );
				}
			}
			
		}
		
		/**
		 * 
		 */
		protected function runSequence( scope:IScope, actionList:Array ):void
		{
			var logger:ILogger = scope.getLogger();
			logger.info( LogTypes.SEQUENCE_START, new LogInfo( scope, null ) );
				
			for each ( var action:IAction in actionList )
			{
				if ( scope.isRunning() )
				{
					scope.currentTarget = action;
					logger.info( LogTypes.SEQUENCE_TRIGGER, new LogInfo( scope, null ) );
					action.trigger( scope );
				}
			}
			
			logger.info( LogTypes.SEQUENCE_END, new LogInfo( scope, null ) );
		}
	}

}