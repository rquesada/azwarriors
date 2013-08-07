package com.azwarriors.view {
	import com.greensock.TweenLite;

	import flash.display.Sprite;
	import flash.events.MouseEvent;

	/**
	 * @author EstebanChavarria
	 */
	public class Scroll extends Sprite {
		private var maskSp:Sprite;
		private var scroller:Sprite;
		private var line:Sprite;
		private var content:Sprite;
		
		
		
		public function Scroll() {
			trace("SCROLL");
		}
		
		public function init(maskWidth:int, maskHeight:int, content:Sprite):void {
			this.content = content;
			
			
			maskSp = new Sprite();
			maskSp.graphics.beginFill(0x000000);
			maskSp.graphics.drawRect(0, 0, maskWidth, maskHeight);
			maskSp.graphics.endFill();
			
			line = new Sprite();
			line.graphics.beginFill(0xbb8501);
			line.graphics.drawRect(0 , 0, 21, maskHeight);
			line.graphics.endFill();
			
			scroller = new Sprite();
			scroller.graphics.beginFill(0x791b4f);
			scroller.graphics.drawRect(0, 0, 21, 15);
			scroller.graphics.endFill();
			scroller.addEventListener(MouseEvent.MOUSE_DOWN, onScrollerMouseDownHandler);
			
			line.x = maskSp.x + maskSp.width + 5;
			scroller.x = (line.x + (line.width/2)) - (scroller.width / 2);
			
			addChild(content);
			addChild(maskSp);
			addChild(line);
			addChild(scroller);
			
			content.mask = maskSp;
			content.x = 1;
			
			//var scrollbar:VerticalScrollbar = new VerticalScrollbar(stage, line, scroller, maskSp, content);
			
		}

		private function onScrollerMouseDownHandler(evenr:MouseEvent):void {
			scroller.startDrag();
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMoveHandler);
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUpHandler);
		}
		
		private function onMouseMoveHandler(event:MouseEvent):void {
			scroller.x = (line.x + (line.width/2)) - (scroller.width / 2);
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
			var scrollPercent:Number = scroller.y / (line.height-scroller.height);
			var contentY:Number = maskSp.y - ((content.height - maskSp.height) * scrollPercent);
			TweenLite.to(content, 0.3, {y:contentY});
		}

		public function updatePosition(yPos:Number):void{
			//yPos = yPos * -1 ;
			TweenLite.to(scroller, 0.5, {y:yPos});
			var scrollPercent:Number = yPos / (line.height-scroller.height);
			var contentY:Number = maskSp.y - ((content.height - maskSp.height) * scrollPercent);
			TweenLite.to(content, 0.5, {y:contentY});
			
			
		}
	}
}
