package com.azwarriors.footer
{
	import com.azwarriors.model.MainModel;
	import flash.events.FullScreenEvent;
	import com.azwarriors.events.MenuEve;
	
	import dev.home.FooterBackground;
	import dev.menu.BotonInicio;
	import dev.menu.GaleriaButton;
	import dev.menu.GuerreroBoton;
	import dev.menu.VideosBoton;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class FooterView extends Sprite
	{
		private var backgroudFooter:FooterBackground;
		private var botonInicio:BotonInicio;
		private var botonConvencion:GaleriaButton;
		private var botonFotoGuerrero:GuerreroBoton;
		private var botonVideos:VideosBoton;
		
		public function FooterView()
		{
			super();
			create();
		}
		
		private function create():void{
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			//Background
			backgroudFooter = new FooterBackground();
			addChild(backgroudFooter);
			
			// Boton Inicio
			botonInicio = new BotonInicio();
			botonInicio.y = (173-botonInicio.height)/2;
			botonInicio.x = 100;
			botonInicio.buttonMode= true;
			botonInicio.addEventListener(MouseEvent.MOUSE_OVER, mouseOverInicio);
			botonInicio.addEventListener(MouseEvent.MOUSE_OUT, mouseOutInicio);
			botonInicio.addEventListener(MouseEvent.CLICK, mouseClickInicio);
			addChild(botonInicio);
			
			//Boton Foto Guerrero
			botonFotoGuerrero = new GuerreroBoton();
			botonFotoGuerrero.y = (143-botonInicio.height)/2;
			botonFotoGuerrero.x = 170;
			botonFotoGuerrero.buttonMode= true;
			botonFotoGuerrero.addEventListener(MouseEvent.MOUSE_OVER, mouseOverGuerrero);
			botonFotoGuerrero.addEventListener(MouseEvent.MOUSE_OUT, mouseOutGuerrero);
			botonFotoGuerrero.addEventListener(MouseEvent.CLICK, mouseClickGuerrero);
			addChild(botonFotoGuerrero);
			
			
			//Boton Galeria
			botonConvencion = new GaleriaButton();
			botonConvencion.y = (163-botonConvencion.height)/2;
			botonConvencion.x = 275;
			botonConvencion.buttonMode= true;
			botonConvencion.addEventListener(MouseEvent.MOUSE_OVER, mouseOverGaleria);
			botonConvencion.addEventListener(MouseEvent.MOUSE_OUT, mouseOutGaleria);
			botonConvencion.addEventListener(MouseEvent.CLICK, mouseClickGaleria);
			addChild(botonConvencion);
			
			//Boton Videos
			botonVideos = new VideosBoton();
			botonVideos.y = (163-botonVideos.height)/2;
			botonVideos.x = 400;
			botonVideos.buttonMode= true;
			botonVideos.addEventListener(MouseEvent.MOUSE_OVER, mouseOverVideos);
			botonVideos.addEventListener(MouseEvent.MOUSE_OUT, mouseOutVideos);
			botonVideos.addEventListener(MouseEvent.CLICK, mouseClickVideos);
			addChild(botonVideos);
		}

		private function onAddedToStage(event : Event) : void {
			stage.addEventListener(FullScreenEvent.FULL_SCREEN, onFullScreenHandler);
		}

		private function onFullScreenHandler(event : Event) : void {
			//trace("onResizeHandler");
			//removeChild(backgroudFooter);
			var posX:Number;
			if(backgroudFooter.mcBg.width > stage.stageWidth){
				posX = 0;
				MainModel.getInstance().half_height = (stage.stageHeight/2);
				MainModel.getInstance().half_width = (stage.stageWidth/2);
				MainModel.getInstance().modalWidth = stage.stageWidth;
				MainModel.getInstance().modalHeight = stage.stageHeight;
				MainModel.getInstance().modalX = 0;
				MainModel.getInstance().modalY = 0
			}else{
				posX = (stage.stageWidth - backgroudFooter.mcBg.width)/2;
				MainModel.getInstance().half_height = ((stage.stageHeight - MainModel.getInstance().half_height ) / 2) ;
				MainModel.getInstance().half_width = ((stage.stageWidth - MainModel.getInstance().half_width) / 2);
				MainModel.getInstance().modalX = - (stage.stageWidth - MainModel.getInstance().modalWidth) ;
				MainModel.getInstance().modalY = - (stage.stageHeight - MainModel.getInstance().modalHeight);
				MainModel.getInstance().modalWidth = stage.stageWidth *2;
				MainModel.getInstance().modalHeight = stage.stageHeight*2;
				
			}
			
			backgroudFooter.mcBg.width = stage.stageWidth;
			
			backgroudFooter.mcBg.x = -posX;
		}

		//Events Videos
		private function mouseOverVideos(event:MouseEvent):void{
			botonVideos.gotoAndStop(2);
		}
		
		private function mouseOutVideos(event:MouseEvent):void{
			botonVideos.gotoAndStop(1);
		}
		
		private function mouseClickVideos(event:MouseEvent):void{
			var menuEvent:MenuEve= new MenuEve("goVideos",true,true);
			dispatchEvent(menuEvent);
		}
		
		//Events Guerrero
		private function mouseOverGuerrero(event:MouseEvent):void{
			botonFotoGuerrero.gotoAndStop(2);
		}
		
		private function mouseOutGuerrero(event:MouseEvent):void{
			botonFotoGuerrero.gotoAndStop(1);
		}
		
		private function mouseClickGuerrero(event:MouseEvent):void{
			var menuEvent:MenuEve= new MenuEve("goGuerrero",true,true);
			dispatchEvent(menuEvent);
		}
		
		
		//Events Inicio
		private function mouseOverInicio(event:MouseEvent):void{
			botonInicio.gotoAndStop(2);
		}
		
		private function mouseOutInicio(event:MouseEvent):void{
			botonInicio.gotoAndStop(1);
		}
		
		private function mouseClickInicio(event:MouseEvent):void{
			var menuEvent:MenuEve= new MenuEve("goInicio",true,true);
			dispatchEvent(menuEvent);
		}
		
		//Events Galeria
		private function mouseOverGaleria(event:MouseEvent):void{
			botonConvencion.gotoAndStop(2);
		}
		
		private function mouseOutGaleria(event:MouseEvent):void{
			botonConvencion.gotoAndStop(1);
		}
		
		private function mouseClickGaleria(event:MouseEvent):void{
			var menuEvent:MenuEve= new MenuEve("goGaleria",true,true);
			dispatchEvent(menuEvent);
		}
	}
}