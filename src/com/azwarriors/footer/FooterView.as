package com.azwarriors.footer
{
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