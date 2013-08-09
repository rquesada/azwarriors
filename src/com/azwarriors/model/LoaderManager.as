package com.azwarriors.model
{
	import br.com.stimuli.loading.BulkLoader;
	import br.com.stimuli.loading.BulkProgressEvent;
	import br.com.stimuli.loading.loadingtypes.ImageItem;
	import br.com.stimuli.loading.loadingtypes.LoadingItem;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	
	public class LoaderManager extends EventDispatcher{
		private var _bulkLoader:BulkLoader;
		private	var _urlLoader:URLLoader;
		private var _defaultImage:String = "images/fotosConvencion/thumbnails/imageError.jpg"
		private var _lastCallBack:Function;
		
		public function LoaderManager(bulkName:String = "azwarriors") {
			_bulkLoader = new BulkLoader(bulkName);
			_bulkLoader.logLevel = BulkLoader.LOG_ERRORS;
		}

		public function init():void{
			_bulkLoader.addEventListener(BulkProgressEvent.COMPLETE, onAssetsComplete);
			_bulkLoader.addEventListener(BulkProgressEvent.PROGRESS, onBulkProgress);
			_bulkLoader.addEventListener(BulkLoader.SECURITY_ERROR, onItemError);
			_bulkLoader.addEventListener(BulkLoader.ERROR, onError);
		}
		
		public function addAsset(url:String):void{
			_bulkLoader.add(url);
			_bulkLoader.get(url).addEventListener(BulkLoader.ERROR, onItemError);
		}
		
		public function getAsset(url:String):Object{
			var asset:Object = _bulkLoader.getContent(url, true);
			return asset;
		}
		
		public function start():void{
			if (_bulkLoader.itemsTotal > 0){
				_bulkLoader.start(3);
			} else {
				dispatchEvent(new Event(Event.COMPLETE));
			}
		}
		
		public function loadMap():void{
			//			var mapLoader:URLLoader = 
		}
		
		public function removeAll():void{
			_bulkLoader.pauseAll();
			_bulkLoader.removeAll();
		}
		
		public function clear():void{
		}
		
		public function makeRequest(url:String):void{
			var request:URLRequest = new URLRequest(url);
			request.method = URLRequestMethod.POST;
			
			_urlLoader = new URLLoader();
			_urlLoader.addEventListener(Event.COMPLETE, onAssetsComplete);
			_urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onItemError);
			_urlLoader.load(request);
			//			_bulkLoader.add(request, {type:BulkLoader.TYPE_XML, maxTries:10, context:context});
			//			_bulkLoader.start(10);
		}
		
		public function getResponse():XML{
			return new XML(_urlLoader.data);
		}
		
		public function set defaultImage(imageURL:String):void{
			_defaultImage = imageURL;
		}
		
		public function removeLastCallBack():void{
			removeEventListener(Event.COMPLETE, _lastCallBack);
		}
		
		public override function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void{
			_lastCallBack = listener;
			super.addEventListener(type, listener);
		}
		
		private function onAssetsComplete(ev:Event):void{
			//			trace(ev.target.data);
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		private function onItemError(ev:Event):void{
			//trace("onItemError- onError"+(ev.currentTarget as ImageItem).url.url);
			var wrongURL:String = (ev.currentTarget as ImageItem).url.url;
			for each(var imageItem:LoadingItem in _bulkLoader.items){
				if (imageItem is ImageItem && imageItem.url.url == wrongURL){
					imageItem.stop();
					imageItem.url.url = _defaultImage;
					imageItem.load();
				}
			}
		}
		
		private function onBulkProgress(ev:BulkProgressEvent):void{
			//			trace("onBulkProgress"+ev._weightPercent);
			dispatchEvent(ev);
		}
		
		private function onError(ev:Event):void{
			trace("LoaderManager - OnError");
		}
		
	} // end class
}