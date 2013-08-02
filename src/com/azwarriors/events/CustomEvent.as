package com.azwarriors.events {
	import com.azwarriors.vo.VO;
	import flash.events.Event;

	/**
	 * @author EstebanChavarria
	 */
	public class CustomEvent extends Event {
		public var data:VO;
		public function CustomEvent(type : String,data:VO, bubbles : Boolean = false, cancelable : Boolean = false) {
			this.data = data;
			super(type, bubbles, cancelable);
		}
	}
}
