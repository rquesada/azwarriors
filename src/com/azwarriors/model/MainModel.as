package com.azwarriors.model
{
	import com.azwarriors.vo.FotoGuerreroItemVO;
	import com.azwarriors.vo.FotoGuerreroVO;
	import com.azwarriors.model.LoaderManager;
	import com.azwarriors.vo.FotoConvencionVO;
	import com.azwarriors.vo.FotosConvencionVO;
	import com.azwarriors.vo.VO;
	
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.flash_proxy;
	
	public class MainModel extends EventDispatcher
	{
		public static const MODEL_READY:String = "onModelReady";
		
		private static var _instance:MainModel;
		private var _loaderManager:LoaderManager;
		
		//public var fotosConvencionVO:FotosConvencionVO;
		
		public var data:VO;
		
		public function MainModel(singleton:SingletonEnforcer)
		{
			_loaderManager = new LoaderManager();
			_loaderManager.init();
		}
		
		public static function getInstance():MainModel{
			if (!_instance) {
				_instance = new MainModel(new SingletonEnforcer());
			}
			return _instance;
		}
		
		public function loadFotoGuerreroVO():void {
			_loaderManager.removeAll();
			_loaderManager.addEventListener(Event.COMPLETE,onFotoGuerreroXmlCompleteHandler);
			_loaderManager.addAsset("xml/fotoGuerrero.xml");
			_loaderManager.start();
		}

		private function onFotoGuerreroXmlCompleteHandler(event:Event):void{
			_loaderManager.removeEventListener(Event.COMPLETE,onFotoGuerreroXmlCompleteHandler);
			data = new FotoGuerreroVO();
			var xml:XML = (_loaderManager.getAsset("xml/fotoGuerrero.xml") as XML);
			(data as FotoGuerreroVO).fotoGuerrerosArray = new Array();
			_loaderManager.removeAll();
			for each(var fotoGuerreroXML:XML in xml.fotosConvencion.children()){
				var fotoGuerrero:FotoGuerreroItemVO = new FotoGuerreroItemVO();
				fotoGuerrero.imageUrl = fotoGuerreroXML.image;
				fotoGuerrero.guerreroName = fotoGuerreroXML.nameGuerrero;
				(data as FotoGuerreroVO).fotoGuerrerosArray.push(fotoGuerrero);
				_loaderManager.addAsset(fotoGuerrero.imageUrl);
				
				//trace("fotoConvencionVO.thumbUrl: "+fotoConvencionVO.thumbUrl);
			}
			_loaderManager.addEventListener(Event.COMPLETE, onFotosGuerreroImagesLoadedHandler);
			_loaderManager.start();
		}
		
		private function onFotosGuerreroImagesLoadedHandler(event:Event):void{
			_loaderManager.removeEventListener(Event.COMPLETE, onFotosGuerreroImagesLoadedHandler);	
			for each(var fotoGuerrerVO:FotoGuerreroItemVO in (data as FotoGuerreroVO).fotoGuerrerosArray) {
				//trace(fotoConvencionVO.imageUrl);
				//trace(fotoConvencionVO.thumbUrl);
				fotoGuerrerVO.image = _loaderManager.getAsset(fotoGuerrerVO.imageUrl) as Bitmap;
			}	
			dispatchEvent(new Event(MainModel.MODEL_READY));
		
		}

		public function loadFotosConvencionVO():void{
			trace("MainModel - loadFotosConvencionVO");
			_loaderManager.removeAll();
			_loaderManager.addEventListener(Event.COMPLETE,onFotosConvencionXmlCompleteHandler);
			_loaderManager.addAsset("xml/fotosConvencion.xml");
			_loaderManager.start();
		}
		
		private function onFotosConvencionXmlCompleteHandler(event:Event):void{
			trace("MainModel - onFotosConvencionXmlCompleteHandler");
			_loaderManager.removeEventListener(Event.COMPLETE,onFotosConvencionXmlCompleteHandler);
			data = new FotosConvencionVO();
			var xml:XML = (_loaderManager.getAsset("xml/fotosConvencion.xml") as XML);
			(data as FotosConvencionVO).fotosConvencionArray = new Array();
			_loaderManager.removeAll();
			for each(var fotoXML:XML in xml.fotosConvencion.children()){
				var fotoConvencionVO:FotoConvencionVO = new FotoConvencionVO();
				fotoConvencionVO.imageUrl = fotoXML.image;
				fotoConvencionVO.thumbUrl = fotoXML.thumb;
				(data as FotosConvencionVO).fotosConvencionArray.push(fotoConvencionVO);
				_loaderManager.addAsset(fotoConvencionVO.imageUrl);
				_loaderManager.addAsset(fotoConvencionVO.thumbUrl);
				//trace("fotoConvencionVO.thumbUrl: "+fotoConvencionVO.thumbUrl);
			}
			_loaderManager.addEventListener(Event.COMPLETE, onFotosConvencionImagesLoadedHandler);
			_loaderManager.start();
		}
		
		private function onFotosConvencionImagesLoadedHandler(event:Event):void{
			
			_loaderManager.removeEventListener(Event.COMPLETE, onFotosConvencionImagesLoadedHandler);
			for each(var fotoConvencionVO:FotoConvencionVO in (data as FotosConvencionVO).fotosConvencionArray){
				//trace(fotoConvencionVO.imageUrl);
				//trace(fotoConvencionVO.thumbUrl);
				fotoConvencionVO.image = _loaderManager.getAsset(fotoConvencionVO.imageUrl) as Bitmap;
				fotoConvencionVO.thumb = _loaderManager.getAsset(fotoConvencionVO.thumbUrl) as Bitmap;
			}	
			dispatchEvent(new Event(MainModel.MODEL_READY));
		}
		
		public override function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void{
			super.removeEventListener(type, listener, useCapture);
			_loaderManager.removeLastCallBack();
		}
	}
}

class SingletonEnforcer{}