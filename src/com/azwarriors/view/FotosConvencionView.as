package com.azwarriors.view
{
	import com.azwarriors.vo.FotoConvencionVO;
	import com.azwarriors.vo.FotosConvencionVO;
	
	import flash.display.Sprite;
	
	public class FotosConvencionView extends Sprite
	{
		private var fotosConvencion:FotosConvencionVO;
		private var imageDisplayer:FotosConvencionImageDisplayer;
		private var thumbsSelector:FotosConvencionThumbsSelector;
		public function FotosConvencionView()
		{
			imageDisplayer = new FotosConvencionImageDisplayer();
			imageDisplayer.y = 160;
			imageDisplayer.x = 40;
			addChild(imageDisplayer);
		}
		
		public function init(vo:FotosConvencionVO):void{
			fotosConvencion = vo;
			imageDisplayer.presentImage((fotosConvencion.fotosConvencionArray[0] as FotoConvencionVO).image);
			thumbsSelector = new FotosConvencionThumbsSelector();
			thumbsSelector.init(vo);
			thumbsSelector.x = 720;
			thumbsSelector.y = 155;
			addChild(thumbsSelector);
		}
	}
}