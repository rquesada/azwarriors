package com.azwarriors.view {
	import com.azwarriors.assets.mcScrollDownArrow_FC;
	import flash.events.Event;
	import com.azwarriors.assets.mcScrollArrowUp_FC;
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
		
		private var percentage:Number;
		public var arrowPercentage;
		public function Scroll() {
		
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
			
			var upArrow:mcScrollArrowUp_FC = new mcScrollArrowUp_FC();
			upArrow.x = line.x;
			upArrow.y = -upArrow.height - 5;
			
			upArrow.addEventListener(MouseEvent.MOUSE_DOWN, onUpArrowMouseDownHandler);
			
			var downArrow:mcScrollDownArrow_FC = new mcScrollDownArrow_FC();
			downArrow.x = line.x;
			downArrow.y = line.y + line.height + 5;
			downArrow.addEventListener(MouseEvent.MOUSE_DOWN, onDownArrowMouseDownHandler);
			
			addChild(content);
			addChild(maskSp);
			addChild(line);
			addChild(scroller);
			
			addChild(upArrow);
			addChild(downArrow);
			content.mask = maskSp;
			content.x = 1;
			
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStageHandler);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedToStageHandler);
			arrowPercentage =1;
			//var scrollbar:VerticalScrollbar = new VerticalScrollbar(stage, line, scroller, maskSp, content);
		}

		private function onRemovedToStageHandler(event : Event) : void {
			stage.removeEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheelHandler);
		}

		private function onAddedToStageHandler(event : Event) : void {
			stage.addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheelHandler);
		}

		private function onMouseWheelHandler(event : MouseEvent) : void {
			trace("onMouseWheelHandler");	
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


		
		
		private function onDownArrowMouseDownHandler(event:MouseEvent):void{
			addEventListener(Event.ENTER_FRAME, onDownEnterFrameHandler);
			stage.addEventListener(MouseEvent.MOUSE_UP, onArrowDownMouseUpHandler);
		}

		private function onArrowDownMouseUpHandler(event : MouseEvent) : void {
			removeEventListener(Event.ENTER_FRAME, onDownEnterFrameHandler);
			stage.removeEventListener(MouseEvent.MOUSE_UP, onArrowDownMouseUpHandler);			
		}

		private function onDownEnterFrameHandler(event : Event) : void {
			percentage = (scroller.y * 100) / (line.height - scroller.height);
			percentage += arrowPercentage;
			if(percentage>100) {
				percentage = 100;
			}
			var yPos:Number = (percentage * (line.height - scroller.height))/100;
			if (scroller.y < (line.height - scroller.height)) {
				updatePosition(yPos);
			}
		}
		
		
		private function onUpArrowMouseDownHandler(event:MouseEvent):void{
			addEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
			stage.addEventListener(MouseEvent.MOUSE_UP, onArrowUpMouseUpHandler);
		}

		private function onArrowUpMouseUpHandler(event : MouseEvent) : void {
			removeEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
			stage.removeEventListener(MouseEvent.MOUSE_UP, onArrowUpMouseUpHandler);			
		}

		private function onEnterFrameHandler(event : Event) : void {
			percentage = (scroller.y * 100) / (line.height - scroller.height);
			percentage -= arrowPercentage;
			if(percentage<0) {
				percentage = 0;
			}
			var yPos:Number = (percentage * (line.height - scroller.height))/100;
			//trace("scroller.y: "+scroller.y);
			//trace("yPos: "+yPos);
			if (scroller.y > 0) {
				updatePosition(yPos);
			}
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
