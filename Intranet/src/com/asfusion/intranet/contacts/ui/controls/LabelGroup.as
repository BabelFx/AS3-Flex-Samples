package com.asfusion.intranet.contacts.ui.controls
{
	import mx.controls.HRule;
	import mx.controls.Label;
	import mx.core.UIComponent;

	public class LabelGroup extends UIComponent
	{
		private var titleLabel:Label;
		private var hRule:HRule;
		private var fields:Array = new Array();
		private var paddingTop:int = 5;
		private var paddingBottom:int = 5;
		private var paddingLeft:int = 15;
		private var verticalGap:int = 3;
		
		//--------------------------------------------------------------------
		//    Public Setters and Getters
		//--------------------------------------------------------------------
		
		//.................dataProvider......................
		private var dataProviderChanged:Boolean
		private var _dataProvider:Array;
		public function get dataProvider():Array
		{
			return _dataProvider;
		}
		public function set dataProvider( value:Array ):void
		{
			_dataProvider = value;
			dataProviderChanged = true;
			invalidateProperties();
			invalidateDisplayList();
		}
		
		//.................title......................
		private var _title:String;
		public function get title():String
		{
			return _title;
		}
		public function set title( value:String ):void
		{
			_title = value;
			if (titleLabel != null) titleLabel.text = _title;
		}
		
		//--------------------------------------------------------------------
		//    Constructor
		//--------------------------------------------------------------------
		
		public function LabelGroup()
		{
			super();
			visible = includeInLayout = false;
		}
		
		//--------------------------------------------------------------------
		//    Override Protected Methods
		//--------------------------------------------------------------------
		
		//.................createChildren......................
		override protected function createChildren():void
		{
			titleLabel = new Label();
			titleLabel.text =  title;
			titleLabel.setStyle( "fontSize", 14);
			addChild( titleLabel );
			
			hRule = new HRule();
			addChild( hRule );
		}
		
		//.................updateDisplayList......................
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			var fieldX:int;
			var fieldY:int = paddingTop;
			var maxLabelWidth:int = calculateMaxLabelWidth();
			
			titleLabel.setActualSize( unscaledWidth, titleLabel.getExplicitOrMeasuredHeight() );
			titleLabel.move( 0, fieldY );
			hRule.setActualSize( unscaledWidth, hRule.getExplicitOrMeasuredHeight() );
			fieldY += titleLabel.height;
			hRule.move( fieldX, fieldY);
			
			fieldX += paddingLeft;
			fieldY += hRule.height + verticalGap;
			
			for each( var labelRenderer:LabelRenderer in fields )
			{
				labelRenderer.labelField.setActualSize( maxLabelWidth, labelRenderer.labelField.getExplicitOrMeasuredHeight() );
				labelRenderer.valueField.setActualSize( labelRenderer.valueField.getExplicitOrMeasuredWidth(), labelRenderer.valueField.getExplicitOrMeasuredHeight() );
				labelRenderer.labelField.move( fieldX, fieldY );
				labelRenderer.valueField.move( maxLabelWidth + fieldX, fieldY );
				fieldY += labelRenderer.labelField.height + verticalGap;
			}
		}
		
		//.................commitProperties......................
		override protected function commitProperties():void
		{
			if( dataProviderChanged )
			{
				dataProviderChanged = false;
				if( _dataProvider != null && _dataProvider.length > 0 )
				{
					visible = includeInLayout = true;
					createFields( _dataProvider.length );
					populateFields();
				}
				else
				{
					visible = includeInLayout = false;
				}
			}
		}
		
		//.................measure......................
		override protected function measure():void
		{
			if( fields.length > 0 )
			{
				var labelHeight:int = Label( fields[ 0 ].labelField ).getExplicitOrMeasuredHeight();
				var minHeight:int = paddingTop + titleLabel.getExplicitOrMeasuredHeight() + verticalGap;
				minHeight += ( labelHeight + verticalGap ) * fields.length;
				minHeight += paddingBottom;
				measuredHeight = measuredMinHeight = minHeight;
			}
		}
		
		
		//--------------------------------------------------------------------
		//    Private Methods
		//--------------------------------------------------------------------
		
		//.................calculateMaxLabelWidth......................
		private function calculateMaxLabelWidth():int
		{
			var maxLabelWidth:int;
			for each( var labelRenderer:LabelRenderer in fields )
			{
				var labelWidth:int = labelRenderer.labelField.getExplicitOrMeasuredWidth();
				if( labelWidth > maxLabelWidth )
				{
					maxLabelWidth = labelWidth;
				}
			}
			return maxLabelWidth;
		}
		
		//.................createFields......................
		private function createFields( count:int ):void
		{
			var fieldsNeed:int = count - fields.length;
			
			if( fieldsNeed > 0)
			{
				for( var i:int = 0; i < fieldsNeed; i++ )
				{
					var labelRenderer:LabelRenderer = new LabelRenderer();
					labelRenderer.labelField = new Label();;
					labelRenderer.labelField.setStyle( "fontWeight", "bold" );
					labelRenderer.valueField = new Label();
					addChild( labelRenderer.labelField );
					addChild( labelRenderer.valueField );
					fields.push( labelRenderer );
				}
				invalidateSize();
			}
			else if( fieldsNeed < 0 )
			{
				var fieldsToRemove:int = fields.length - count;
				while( fieldsToRemove > 0 )
				{
					var removedRenderer:LabelRenderer = fields.shift();
					removeChild( removedRenderer.labelField );
					removeChild( removedRenderer.valueField );
					fieldsToRemove--;
				}
				invalidateSize();
			}
		}
		
		//.................populateFields......................
		private function populateFields():void
		{
			var i:int = 0;
			for each( var labelRenderer:LabelRenderer in fields )
			{
				labelRenderer.labelField.text = dataProvider[ i ].label + ":";
				labelRenderer.valueField.text = dataProvider[ i ].value;
				i++;
			}
		}
	}
}

import mx.controls.Label;	

class LabelRenderer
{
	public var labelField:Label;
	public var valueField:Label;
}