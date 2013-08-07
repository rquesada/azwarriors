package com.azwarriors.view {
	import com.azwarriors.model.MainModel;
	import flash.events.FullScreenEvent;
	import flash.geom.Matrix;
	import flash.display.BitmapData;
	import flash.text.TextFormat;
	import com.azwarriors.fonts.ArialFont;
	import flash.text.TextField;
	import com.azwarriors.assets.closeBtnFC;
	import flash.events.Event;
	import com.azwarriors.assets.arrowBtnWhite_FC;
	import com.greensock.TweenLite;
	import com.greensock.easing.Back;

	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class FotosConvencionImageDisplayer extends Sprite
	{
		public static const EVENT_NEXT_IMAGE:String = "nextImageEvent";
		public static const EVENT_PREVIOUS_IMAGE:String = "previousImageEvent";
		
		
		private var arrowBtnRight:arrowBtnWhite_FC;
		private var arrowBtnLeft:arrowBtnWhite_FC;
		
		private var image:Bitmap;
		
		private var background:Sprite;
		private var frameImage:Sprite;
		
		private var imagesNumberText:TextField;
		private var closeBtn:closeBtnFC;
		
		public var totalImages:int;
		
		private var arialFont:ArialFont;
		
		//private var half_width:Number;
		//private var half_height:Number;
		
		public function FotosConvencionImageDisplayer()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);	
		}
		
		public function init():void {
			
			
			background = new Sprite();
			background.graphics.beginFill(0x000000,0.5);
			background.graphics.drawRect(0, 0,(MainModel.getInstance().half_width*2), (MainModel.getInstance().half_height*2));
			background.graphics.endFill();
			background.addEventListener(MouseEvent.CLICK, onBackgroundClickHandler);
			addChild(background);
			
			frameImage = new Sprite();
			frameImage.graphics.beginFill(0x000000,1);
			frameImage.graphics.drawRect(0, 0,10, 10);
			frameImage.graphics.endFill();
			
			var tf:TextFormat = new TextFormat();
			tf.font = "Arial";
			tf.size = 12;
			//tf.bold = true;
			
			imagesNumberText = new TextField();
			imagesNumberText.text = "1 of " + totalImages;
			imagesNumberText.textColor = 0xffffff;
			imagesNumberText.selectable = false;
			imagesNumberText.setTextFormat(tf);
			imagesNumberText.embedFonts = true;
			
			closeBtn = new closeBtnFC();
			
			arrowBtnRight = new arrowBtnWhite_FC();
			arrowBtnRight.scaleX = -1;
			
			arrowBtnLeft = new arrowBtnWhite_FC();
			
			arrowBtnLeft.x = frameImage.x;
			arrowBtnLeft.y = frameImage.y;//(302/2) - (arrowBtnLeft.height/2);
			
			arrowBtnRight.x = frameImage.x;
			arrowBtnRight.y = frameImage.y;
			
			closeBtn.x = frameImage.x;
			closeBtn.y = frameImage.y;
			
			imagesNumberText.x = frameImage.x;
			imagesNumberText.y = frameImage.y;
			
			addChild(imagesNumberText);
			addChild(closeBtn);
			addChild(arrowBtnRight);
			addChild(arrowBtnLeft);
			addChild(frameImage);
			
			image = new Bitmap();
			image.x = arrowBtnLeft.width + 20;
			image.smoothing = true;
			
			//var dropShadow : DropShadowFilter = new DropShadowFilter(10,45,0,0.5,10,10,1,1);
			
			//image.filters = [dropShadow];
			
			
			
			arrowBtnRight.addEventListener(MouseEvent.CLICK, onNextImageClikedHandler);
			arrowBtnLeft.addEventListener(MouseEvent.CLICK, onPreviousImageClikedHandler);
			closeBtn.addEventListener(MouseEvent.CLICK, onCloseClickHandler);
			arrowBtnRight.alpha =0;
			arrowBtnLeft.alpha = 0;
			closeBtn.alpha = 0;
			imagesNumberText.alpha = 0;
			addChild(image);
		}

		private function onAddedToStage(event : Event) : void {
			//half_height = (stage.stageHeight/ 2);
			//half_width = (stage.stageWidth /2);
			stage.addEventListener(FullScreenEvent.FULL_SCREEN, onStageFullScreenHandler);
		}

		private function onStageFullScreenHandler(event : FullScreenEvent) : void {
			/*if(half_height > stage.stageHeight){
				half_height = (stage.stageHeight) / 2;
				half_width = (stage.stageWidth) / 2;
			}else{
				half_height = 0;//((stage.stageHeight - half_height) / 2) - (stage.stageHeight - half_height);
				half_width = 0;//((stage.stageWidth - half_width) / 2) - (stage.stageWidth - half_width);	
			}*/
			
		}

		
		private function onCloseClickHandler(event:MouseEvent):void{
			onBackgroundClickHandler(null);
		}
		
		private function onNextImageClikedHandler(event:MouseEvent):void{
			presentNextImage();
		}
		
		private function onPreviousImageClikedHandler(event:MouseEvent):void{
			presentPreviuosImage();
		}
		
		
		
		private function presentNextImage():void{
			dispatchEvent(new Event(FotosConvencionImageDisplayer.EVENT_NEXT_IMAGE));
		}

		private function presentPreviuosImage():void{
			dispatchEvent(new Event(FotosConvencionImageDisplayer.EVENT_PREVIOUS_IMAGE));
		}
		
		private function onBackgroundClickHandler(event:MouseEvent):void{
			TweenLite.to(this,0.5,{alpha:0,ease:Back.easeOut,onComplete:removeFromParent});
		}
		
		private function removeFromParent():void{
			parent.removeChild(this);
		}
		
		public function presentImage(_image:Bitmap):void {
			//_image.width = 600;
			//_image.height= 393;
			background.graphics.clear();
			background.graphics.beginFill(0x000000,0.5);
			background.graphics.drawRect(MainModel.getInstance().modalX, MainModel.getInstance().modalY, (MainModel.getInstance().modalWidth), (MainModel.getInstance().modalHeight));
			background.graphics.endFill();
			//background.addEventListener(MouseEvent.CLICK, onBackgroundClickHandler);
			
			var imageScaled:Bitmap = new Bitmap(scaleBitmapData(_image.bitmapData, 0.5));
			
			TweenLite.to(arrowBtnRight,0.3,{y:arrowBtnRight.y-20,delay:0,onComplete:hideControls});
			TweenLite.to(arrowBtnLeft, 0.3, {y:arrowBtnLeft.y-20,delay:0});
			TweenLite.to(closeBtn, 0.3, {y:closeBtn.y - 20, delay:0});
			TweenLite.to(imagesNumberText, 0.3, {y:imagesNumberText.y - 20, delay:0});
			//imagesNumberText.y = imagesNumberText.y - 20;
			
			TweenLite.to(image,0.3,{alpha:0,delay:0});
			//var xPos:int = (stage.stageWidth / 2) - (imageScaled.width/ 2);
			//var yPos:int  = (stage.stageHeight / 2) - (imageScaled.height/ 2);
			var xPos : int = MainModel.getInstance().half_width  - (imageScaled.width/ 2);
			var yPos: int = MainModel.getInstance().half_height - (imageScaled.height/ 2);
			
			//frameImage.x = (stage.stageWidth/2) - (frameImage.width/2);
			//frameImage.y = (stage.stageHeight/2) - (frameImage.height/2);
			frameImage.x = MainModel.getInstance().half_width  - (frameImage.width/2);
			frameImage.y = MainModel.getInstance().half_height - (frameImage.height/2);
			
			
			//TweenLite.to(frameImage, 0.5, {alpha:0,height:0,width:0});
			TweenLite.to(frameImage, 0.5, {alpha:1,width:imageScaled.width, height:imageScaled.height, x:xPos, y:yPos,delay:0.7,onComplete:showImage,onCompleteParams:[imageScaled]});

			
			
		}
		
		function scaleBitmapData(bitmapData:BitmapData, scale:Number):BitmapData {
            scale = Math.abs(scale);
            var width:int = (bitmapData.width * scale) || 1;
            var height:int = (bitmapData.height * scale) || 1;
            var transparent:Boolean = bitmapData.transparent;
            var result:BitmapData = new BitmapData(width, height, transparent);
            var matrix:Matrix = new Matrix();
            matrix.scale(scale, scale);
            result.draw(bitmapData, matrix);
            return result;
        }
		
		private function showImage(_image:Bitmap):void {
			
			//var xPos:int = (stage.stageWidth / 2) - (_image.width/ 2);
			var xPos : int = MainModel.getInstance().half_width  - (_image.width/ 2);
			image.x = xPos;
			
			//var yPos:int  = (stage.stageHeight / 2) - (_image.height/ 2);
			var yPos: int = MainModel.getInstance().half_height - (_image.height/ 2);
			image.y = yPos;
			TweenLite.to(image, 0.5, {alpha:1,delay:0,onComplete:showControls});
			image.bitmapData = _image.bitmapData;
		}
		
		private function showControls():void {
			arrowBtnRight.y = image.y + image.height + 5 - 20;
			arrowBtnLeft.y = image.y + image.height + 5 - 20;
			closeBtn.y = image.y + image.height + 5 - 20;
			imagesNumberText.y = image.y + image.height + 5 - 20;
			
			arrowBtnRight.x = image.x + image.width - 20;
			arrowBtnLeft.x = image.x + image.width - 60;
			closeBtn.x = image.x + image.width - 10;
			imagesNumberText.x = image.x;
			
			arrowBtnRight.alpha =1;
			arrowBtnLeft.alpha = 1;
			closeBtn.alpha = 1;
			imagesNumberText.alpha = 1;
			
			TweenLite.to(arrowBtnRight, 0.3, {y:arrowBtnRight.y + 20, delay:0});
			TweenLite.to(arrowBtnLeft, 0.3, {y:arrowBtnLeft.y+20,delay:0});
			TweenLite.to(closeBtn, 0.3, {y:closeBtn.y + 20, delay:0});
			TweenLite.to(imagesNumberText, 0.3, {y:imagesNumberText.y + 20, delay:0});
			//imagesNumberText.y = imagesNumberText.y + 20;
		}

		private function hideControls():void{
			arrowBtnRight.alpha =0;
			arrowBtnLeft.alpha = 0;
			closeBtn.alpha = 0;
			imagesNumberText.alpha = 0;
		}
		
		public function setCurrentImageText(imageNumber:int):void {
			var tf:TextFormat = new TextFormat();
			tf.font = "Arial";
			tf.size = 12;
			
			imagesNumberText.text = imageNumber + " of " + totalImages;
			imagesNumberText.embedFonts =  true;
			imagesNumberText.setTextFormat(tf);
		}
	}
}