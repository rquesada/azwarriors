package com.azwarriors.controller
{
	import com.azwarriors.view.GaleriaView;
	
	import flash.events.EventDispatcher;
	
	public class GaleriaController extends EventDispatcher
	{
		public var view:GaleriaView;
		public function GaleriaController()
		{
			
			create();
	 	}
		
		private function create():void{
			view = new GaleriaView();
			//view.init();
		}
		
	}
}