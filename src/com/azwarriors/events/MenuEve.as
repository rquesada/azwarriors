package com.azwarriors.events
{
	import flash.events.Event;
	
	public class MenuEve extends Event
	{
		public function MenuEve(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}