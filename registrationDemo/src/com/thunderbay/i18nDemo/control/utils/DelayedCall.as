package com.thunderbay.i18nDemo.control.utils
{
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	
	public class DelayedCall
	{
		private static var scheduledCalls : Dictionary = new Dictionary();

		private var func  : Function = null;
		private var args  : Array    = null;
		
		public function DelayedCall()
		{
		}
		
		/**
		 * Schedule a delayed function or method call.
		 * 
		 * @param func  The function or class method to call.
		 * @param args  The parameters to pass to the function / class method.
		 * @param delay The time in milliseconds to delay before making the function / class method call.
		 */
		public static function schedule(func : Function, args : Array, delay : Number) : void
		{
			var call : DelayedCall = new DelayedCall();
			
			call.initiate(func, args, delay);
			
			// grab a reference so the call doesn't get prematurely garbage-collected
			scheduledCalls[call] = call;
		}
		
		/**
		 * Called to release references to a completed DelayedCall instance.
		 */
		private static function release(call : DelayedCall) : void
		{
			// release reference so that call can be garbage-collected
			delete scheduledCalls[call];
		}
		
		/**
		 * Initiates a delayed call.
		 */
		private function initiate(func : Function, args : Array, delay : Number) : void
		{
			this.func  = func;
			this.args  = args;

			// create and start a timer
			var timer : Timer = new Timer(delay, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, timerCompleteHandler);
			
			timer.start();		
		}
		
		/**
		 * TimerEvent.TIMER_COMPLETE handler - executes the delayed call.
		 */
		private function timerCompleteHandler(event : TimerEvent) : void
		{
			var timer : Timer = event.target as Timer;
			timer.removeEventListener(TimerEvent.TIMER_COMPLETE, timerCompleteHandler);

			// make the delayed call			
			if (func != null)
				func.apply(null, args);
			
			release(this);
		}
	}
}