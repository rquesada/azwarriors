package com.azwarriors.controller {
	import com.azwarriors.vo.FotoGuerreroVO;
	import com.azwarriors.view.FotoGuerreroView;
	import flash.events.Event;
	import com.azwarriors.model.MainModel;
	import flash.events.EventDispatcher;
	/**
	 * @author EstebanChavarria
	 */
	public class FotoGuerreroController extends EventDispatcher {
		public var view:FotoGuerreroView;
		
		public function FotoGuerreroController(){
			view = new FotoGuerreroView();
		}
		
		public function init():void{
			//trace("FotoGuerreroController - init");
			MainModel.getInstance().addEventListener(MainModel.MODEL_READY, onModelDataReady);
			MainModel.getInstance().loadFotoGuerreroVO();
			//view = new FotoGuerreroView();
		}
		
		public function onModelDataReady(event:Event):void{
			MainModel.getInstance().removeEventListener(MainModel.MODEL_READY, onModelDataReady);	
			view.init(MainModel.getInstance().data as FotoGuerreroVO);
			//trace("FotoGuerreroController - onModelDataReady");
		}
		
		public function stopView():void{
			view.stopSong();
		}
		
	}
}
