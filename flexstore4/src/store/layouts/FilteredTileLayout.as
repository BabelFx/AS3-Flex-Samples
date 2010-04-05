package store.layouts
{
	import mx.collections.ICollectionView;
	import mx.effects.Parallel;
	import mx.events.EffectEvent;
	
	import spark.components.supportClasses.GroupBase;
	import spark.components.supportClasses.ItemRenderer;
	import spark.effects.Fade;
	import spark.effects.Move;
	import spark.layouts.supportClasses.LayoutBase;

	public class FilteredTileLayout extends LayoutBase
	{
		public var filteredItems:ICollectionView;
		
		public var fadeOutDuration:Number = 400;
		
		public var moveDuration:Number = 400;
		
		public var fadeInDuration:Number = 400;

		private var _target:GroupBase;

		private var _containerWidth:Number;
		
		private var fadeOutEffects:Parallel;
		private var fadeInEffects:Parallel;
		private var moveEffects:Parallel;
		
		private var _scaling : Number = .7;
		private var _padding : Number = 10;
		
		private var _horizontalGap:Number = 20;

		private var _verticalGap:Number = 20;

		private var _tileWidth:Number = 100;

		private var _tileHeight:Number = 100;

		public function set	horizontalGap(value:Number):void
		{
			_horizontalGap = value;
			if (target)	target.invalidateDisplayList();
		}

		public function set	verticalGap(value:Number):void
		{
			_verticalGap = value;
			if (target)	target.invalidateDisplayList();
		}
		
		public function set	tileWidth(value:Number):void
		{
			_tileWidth = value;
			if (target)	target.invalidateDisplayList();
		}
		
		public function set	tileHeight(value:Number):void
		{
			_tileHeight = value;
			if (target)	target.invalidateDisplayList();
		}
		
		public function filter():void
		{
			// Prevent updateDisplayList() from being executed while we are animating tiles
			_target.autoLayout = false;

			// No filter has been applied. Keep showing all the items in the dataProvider
			if (filteredItems == null) return;
			
			var count:int = _target.numElements;
			
			// No items in the dataProvider: Nothing to show.
			if (count == 0) return;
			
			var x:int =  _padding;
			var y:int =  _padding;
			
			fadeOutEffects = new Parallel();
			fadeInEffects = new Parallel();
			moveEffects = new Parallel();

			for (var i:int = 0; i < count; i++)
			{
				var tile:ItemRenderer = _target.getElementAt(i) as ItemRenderer;
				
				if (filteredItems.contains(tile.data))
				{
					// The element is part of the selection: calculate its x and y values
					if (x + _tileWidth*_scaling > _containerWidth)
					{
						x =  _padding;
						y += _tileHeight*_scaling + _verticalGap*_scaling;
					} 

					if (tile.visible == false)
					{
						trace("FadeIn: " + tile.data.name);
						// if the element was hidden, set its new x and y values (without Move animation) and register it for FadeIn animation
						tile.visible = true;
						tile.setLayoutBoundsPosition(x, y);
						var fadeIn:Fade = new Fade(tile);
						fadeIn.alphaTo = 1;
						fadeInEffects.addChild(fadeIn);
					}  
					else
					{
						trace("Move: " + tile.data.name);
						// the element was already visible: register it for Move animation
						if (tile.x != x || tile.y != y)
						{
							var move:Move = new Move(tile);
							move.xTo = x;
							move.yTo = y;
							moveEffects.addChild(move);
						}
					}
					x += _tileWidth*_scaling + _horizontalGap*_scaling;
				}					
				else
				{
					if (tile.alpha == 1)
					{
						trace("FadeOut: " + tile.data.name);
						// the element is filtered out: register it for FadeOut animation
						var fadeOut:Fade = new Fade(tile);
						fadeOut.alphaTo = 0;
						fadeOutEffects.addChild(fadeOut);
					}
				}
			}
			fadeOutTiles();			
		}

		private function fadeOutTiles(event:EffectEvent = null):void
		{
			trace("fadeOutTiles");
			if (fadeOutEffects.children.length > 0) {
				fadeOutEffects.duration = fadeOutDuration;
				fadeOutEffects.addEventListener(EffectEvent.EFFECT_END, moveTiles)
				fadeOutEffects.play();
			}
			else
			{
				moveTiles();	
			}
		}
		
		private function moveTiles(event:EffectEvent = null):void
		{
			// Undesired behaviors may happen if we leave tiles with alpha=0 in the display list while performing other animations 
			setInvisibleTiles();
			
			trace("moveTiles");
			if (moveEffects.children.length > 0) {
				moveEffects.duration = moveDuration;
				moveEffects.addEventListener(EffectEvent.EFFECT_END, fadeInTiles)
				moveEffects.play();
			}
			else
			{
				fadeInTiles();	
			}
		}

		private function fadeInTiles(event:EffectEvent = null):void
		{
			trace("fadeInTiles");
			if (fadeInEffects.children.length > 0) {
				fadeInEffects.duration = fadeInDuration;
				fadeInEffects.addEventListener(EffectEvent.EFFECT_END, fadeInTilesEnd)
				fadeInEffects.play();
			}
			else
			{
				fadeInTilesEnd();	
			}
		}
		
		private function fadeInTilesEnd(event:EffectEvent = null):void
		{
			_target.autoLayout = true; 
		}
		
		private function setInvisibleTiles():void
		{
			var count:int = _target.numElements;
			
			if (count == 0) return;
			
			for (var i:int = 0; i < count; i++)
			{
				var itemRenderer:ItemRenderer = _target.getElementAt(i) as ItemRenderer;
				if (!filteredItems.contains(itemRenderer.data))
				{	
					trace("Removing from layout: " + itemRenderer.data.name);					
					itemRenderer.visible = false;
				}		
			}
		}
	
		override public function updateDisplayList(containerWidth:Number, containerHeight:Number):void
		{
			_target = target;
			_containerWidth = containerWidth;

			var count:int = target.numElements;
			if (count == 0) return;
			
			var x:int= _padding;
			var y:int= _padding;
			
			for (var i:int = 0; i < count; i++)
			{
				var tile:ItemRenderer = _target.getElementAt(i) as ItemRenderer;
				
				tile.scaleX = tile.scaleY = _scaling;
				tile.setLayoutBoundsSize(_tileWidth*_scaling, _tileHeight*_scaling);
				
				if (filteredItems && filteredItems.contains(tile.data))
				{
					// The element is part of the selection: calculate its x and y values
					if (x + _tileWidth*_scaling > containerWidth)
					{
						x =  _padding;
						y += _tileHeight*_scaling + _verticalGap*_scaling;
					} 
					tile.setLayoutBoundsPosition(x, y);	
					tile.alpha = 1;
					x += _tileWidth*_scaling + _horizontalGap*_scaling;
				}					
				else
				{
					tile.alpha = 0;
				}
				
			}
		}

	}
}