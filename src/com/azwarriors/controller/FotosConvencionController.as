package com.azwarriors.controller
{
	import com.azwarriors.model.MainModel;
	import com.azwarriors.view.FotosConvencionView;
	import com.azwarriors.vo.FotosConvencionVO;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class FotosConvencionController extends EventDispatcher
	{
		public var view:FotosConvencionView;
		public function FotosConvencionController()
		{
			trace("FotosConvencionController - Created");	
		}
		
		public function init():void{
			MainModel.getInstance().addEventListener(MainModel.MODEL_READY,onModelReadyHandler);
			MainModel.getInstance().loadFotosConvencionVO();
			view = new FotosConvencionView();
		}
		
		private function onModelReadyHandler(event:Event):void{
			view.init(MainModel.getInstance().data as FotosConvencionVO);
		}
	}
}