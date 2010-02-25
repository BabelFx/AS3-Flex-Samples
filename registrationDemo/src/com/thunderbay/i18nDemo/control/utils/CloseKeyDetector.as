package com.thunderbay.i18nDemo.control.utils
{
	import flash.events.IEventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import mx.collections.ArrayCollection;
	import mx.core.UIComponent;
	
	public class CloseKeyDetector
	{
		// ************************************************************************************
		// Public Methods 
		// ************************************************************************************
		
		public function watch(src:UIComponent,handler:Function):void {
			if (src && (handler!=null)) {
				
				if (findBy(src) == null) {
					var item : AttachItem = new AttachItem(src,handler);
					 
					_watching.addItem(item);
					attachListener(item.attachedTo,true);
				}				

				src.setFocus();
			}
		}
		
		public function release(src:UIComponent):void {
			var item : AttachItem = findBy(src);
			if (item != null) {
				attachListener(item.attachedTo,false);
				_watching.removeItemAt(_watching.getItemIndex(item));
			}
		}
		
		// ************************************************************************************
		// Private Event Handler Methods 
		// ************************************************************************************
		
		private function onKeyDown(event:KeyboardEvent):void {
			if (event.keyCode == Keyboard.ESCAPE) {
				
				// Only notify the "most recent" added
				var notify : AttachItem = getTopWatch();
				if (notify != null) notify.handler();	
			}
		}
		
		
		// ************************************************************************************
		// Private Methods 
		// ************************************************************************************
		
		private function attachListener(target:UIComponent,active:Boolean = true):void {
			// @FIXME: must also use ADD_TO_STAGE detector if "stage == null"
			// @TODO: assumes all watched items have the same stage
			
			if (!target || !target.stage) 	return;
			if (_dispatcher == null) 		_dispatcher = target.stage;
			
			if (_dispatcher != null) {
				if      (active == true)  {
					 _dispatcher.addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown,true);	
				}   
				else if (_watching.length==0) {
					_dispatcher.removeEventListener(KeyboardEvent.KEY_DOWN,onKeyDown,true);
					_dispatcher = null;
				} 	
			}
		}
		
		
		private function findBy(target:UIComponent):AttachItem {
			var results : AttachItem = null;
			
			// Search topmost
			for (var j:int=_watching.length-1; j>=0; j--) {
				var item : AttachItem = _watching.getItemAt(j) as AttachItem;
				if (item.attachedTo == target) {
					results = item;
					break;
				}
			}
			
			return results;
		}
		
		
		private function getTopWatch():AttachItem {
			return (_watching.length > 0) ? _watching.getItemAt(_watching.length-1) as AttachItem : null;
		}
		
		
		// ************************************************************************************
		// Private Constructor Methods 
		// ************************************************************************************
		
		public function CloseKeyDetector(ref:Class) {
			if (_instance == null) _instance = this;
		}		
		
		// ************************************************************************************
		// Singleton Methods 
		// ************************************************************************************
		
		static public function get instance():CloseKeyDetector {
			if (_instance == null) _instance = new CloseKeyDetector(ConstructorLock);
			return _instance;
		}
		
		       private var _dispatcher : IEventDispatcher = null;
		       private var _watching   : ArrayCollection  = new ArrayCollection();
		static private var _instance   : CloseKeyDetector    = null;
	}
}


import flash.events.IEventDispatcher;
import mx.core.UIComponent;
	

class AttachItem {
	public var attachedTo : UIComponent = null;
	public var handler    : Function    = null;
	
	public function AttachItem(src:UIComponent,handler:Function) {
		this.attachedTo = src;
		this.handler    = handler;	
	}
}

class ConstructorLock {   }

