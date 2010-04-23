package com.asfusion.intranet.shared.ui.controls
{
	import mx.controls.List;

	public class ExpandableList extends List
	{
		
		
		//-----------------------------------------------------
		//     Public Setters and Getters
		//-----------------------------------------------------
		
		//.....................dataProvider.............................
		override public function set dataProvider( value:Object ):void
		{
			super.dataProvider = value;
			invalidateSize();
		}
		
		//..................maxExpandHeight............................
		private var _maxExpandHeight:int;
		public function get maxExpandHeight( ):int
		{
			return _maxExpandHeight;
		}
		public function set maxExpandHeight( value:int):void
		{
			_maxExpandHeight = value;
			invalidateSize();
		}
		
		//------------------------------------------------------------
		//    Constructor
		//------------------------------------------------------------
		public function ExpandableList()
		{
			super();
		}
		
		//---------------------------------------------------------------
		//    Override protected methods
		//---------------------------------------------------------------
	    override protected function measure():void
	    {
	        super.measure();
	
	        measuredMinWidth = DEFAULT_MEASURED_MIN_WIDTH; // room for scrollbar and room for some of the renderer
	
	        // collectionChangeHandler
	        if( collection )
	        {
	        	if( !explicitHeight )
	        	{
	        		measuredHeight = ( collection ) ? rowHeight * collection.length + 2 : 0;
	        		if( maxExpandHeight < measuredHeight)
	        		{
	        			measuredHeight = maxExpandHeight;
	        		}
	        	}
	        	else
	        	{
	        		measuredHeight = explicitHeight;
	        	}
	        }
	        else
	        {
	        	measuredHeight = 0;
	        }
	    }
		
	}
}