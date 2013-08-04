package com.util
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class PlayPauseBtn extends Sprite
	{
		private var tri:Sprite;
		private var pau:Sprite;
		
		public function PlayPauseBtn()
		{
			super();
			buttonMode = true;
			
			var bg:Shape = new Shape();
			bg.graphics.beginFill(0x000000,0.8);
			bg.graphics.drawEllipse(0, 0, 82, 82);
			bg.graphics.endFill();
			addChild(bg);
			
			tri = new Sprite();
			tri.graphics.beginFill(0xffffff);
			tri.graphics.moveTo(0, 0);
			tri.graphics.lineTo(30, 18);
			tri.graphics.lineTo(0, 36);
			tri.graphics.endFill();
			tri.x = 32;
			tri.y = 23;
			addChild(tri);
			
			pau = new Sprite();
			pau.graphics.beginFill(0xffffff);
			pau.graphics.drawRect(0, 0, 11, 40);
			pau.graphics.drawRect(18, 0, 11, 40);
			pau.graphics.endFill();
			pau.x = 26;
			pau.y = 21;
			pau.visible = false;
			addChild(pau);
			
			addEventListener(MouseEvent.CLICK, clicked);
		}
		
		public function clicked(e:MouseEvent=null):void 
		{
			tri.visible = !tri.visible;
			pau.visible = !pau.visible;
		}
	}
}