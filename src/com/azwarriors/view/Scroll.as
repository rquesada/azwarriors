package com.azwarriors.view {
	import com.greensock.TweenLite;
	import flash.events.MouseEvent;
	import flash.display.Sprite;

	/**
	 * @author EstebanChavarria
	 */
	public class Scroll extends Sprite {
		private var maskSp:Sprite;
		private var scroller:Sprite;
		private var line:Sprite;
		private var content:Sprite;
		public function Scroll() {
		}
		
		public function init(maskWidth:int, maskHeight:int, content:Sprite):void {
			this.content = content;
			
			
			maskSp = new Sprite();
			maskSp.graphics.beginFill(0x000000);
			maskSp.graphics.drawRect(0, 0, maskWidth, maskHeight);
			maskSp.graphics.endFill();
			
			line = new Sprite();
			line.graphics.beginFill(0x000000);
			line.graphics.drawRect(0, 0, 3, maskHeight);
			line.graphics.endFill();
			
			scroller = new Sprite();
			scroller.graphics.beginFill(0xff0000);
			scroller.graphics.drawRect(0, 0, 15, 15);
			scroller.graphics.endFill();
			scroller.addEventListener(MouseEvent.MOUSE_DOWN, onScrollerMouseDownHandler);
			
			line.x = maskSp.x + maskSp.width + 5;
			scroller.x =  maskSp.x + maskSp.width + 5;
			
			addChild(content);
			addChild(maskSp);
			addChild(line);
			addChild(scroller);
			
			content.mask = maskSp;
			content.x = 1;
		}

		private function onScrollerMouseDownHandler(evenr:MouseEvent):void {
			scroller.startDrag();
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMoveHandler);
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUpHandler);
		}
		
		private function onMouseMoveHandler(event:MouseEvent):void {
			scroller.x =  maskSp.x + maskSp.width + 5;
			if(scroller.y > (line.y + line.height - scroller.height)) {
				scroller.y  = (line.y + line.height - scroller.height);
			}
			if(scroller.y < line.y ) {
				scroller.y  = line.y ;
			}
			updateContentPosition();	
		}
		
		private function onMouseUpHandler(event:MouseEvent):void {
			onMouseMoveHandler(null);
			scroller.stopDrag();
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMoveHandler);
			stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUpHandler);
		}
		
		private function updateContentPosition():void{
			//var yPos:Number = (scroller.y * (content.height - maskSp.height)) / line.height;
			var yPos:Number = (scroller.y * (content.height)) / line.height;
			
			//yPos = yPos * -1 ;
			//trace("yPos: " + yPos);
			if(yPos == 0){
				yPos = 5;
				TweenLite.to(content, 0.3, {y:yPos});
			}else{
				TweenLite.to(content, 0.3, {y:-yPos});
			}
		}
		
		public function updatePosition(yPos:Number):void{
			//yPos = yPos * -1 ;
			//trace("yPos: " + yPos);
			if(yPos == 0){
				yPos = 5;
				TweenLite.to(scroller, 0.3, {y:0});
				TweenLite.to(content, 0.3, {y:yPos});
			}else{
				TweenLite.to(content, 0.3, {y:-yPos});
			}
		}
	}
}
