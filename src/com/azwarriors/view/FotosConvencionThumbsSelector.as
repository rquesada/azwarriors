package com.azwarriors.view
{
	import com.azwarriors.vo.FotoConvencionVO;
	import com.azwarriors.vo.FotosConvencionVO;
	
	import flash.display.Sprite;
	
	public class FotosConvencionThumbsSelector extends Sprite
	{
		private var container:Sprite;
		private var data:FotosConvencionVO;
		private var thumbsArray:Array;
		public function FotosConvencionThumbsSelector()
		{
			
		}
		
		public function init(vo:FotosConvencionVO):void{
			container = new Sprite();
			addChild(container);
			data = vo;
			createThumbs();
		}
		
		private function createThumbs():void{
			thumbsArray = new Array();
			var xPos:int = 0;
			var yPos:int = 0;
			for (var i:int = 0; i < data.fotosConvencionArray.length; i++){
				trace(i);
				var fotoConvencionVO:FotoConvencionVO = data.fotosConvencionArray[i];
				var thumbView:FotoConvencionThumbView = new FotoConvencionThumbView(fotoConvencionVO.thumb);
				thumbView.x = xPos;
				thumbView.y = yPos;
				container.addChild(thumbView);
				thumbsArray.push(thumbView);
				
				xPos += thumbView.width + 10;
				if(((i+1)%2) == 0){
					xPos = 0;
					yPos += thumbView.height + 10;
				}
			}
		}
	}
}