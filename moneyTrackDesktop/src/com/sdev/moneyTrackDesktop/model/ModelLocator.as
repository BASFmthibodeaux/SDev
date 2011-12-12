//Model Locator
package com.sdev.moneyTrackDesktop.model {
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.adobe.cairngorm.model.ModelLocator;
//	import com.basf.core.business.ActivityMonitor;
	
	import mx.collections.ArrayCollection;
	
	[Event(name="selectedCompanyChanged",type="*")]
	
	[Bindable] 
	public class ModelLocator implements com.adobe.cairngorm.model.ModelLocator {
		
		private static var modelLocatorInstance:com.sdev.moneyTrackDesktop.model.ModelLocator;
		
		public var accesoBaseDatos:String = "http://sourceserver.basf-arg.com.ar/source_informatica/pls/db";
		//  public var accesoBaseDatos:String = "sampledata";
		public var accesoBaseDatos2:String = "sampledata";
		public var videoService:String;
		public var maildocUploadFile:String;
		public var maildocRepository:String;	    
		public var selectedApplicationContainer:Number = 0;
		public var selectedApplicationState:String="";
		public var R3Instance:String = "BC3";
		public var defaultLanguage:String = "SP"; 	
		public var selectedCia:String ='AR01';
		public var language:String ='ES'; 	    
		public var sisId:String ='SYMPHONY';
		
		
		
		//		private static var modelLocatorInstance:com.basf.ldap.model.ModelLocator;
		
		// esta 'harcodeada' sirve para los test.
		// http://sourceserver.basf-arg.com.ar/source_informatica/pls/db
		//		public var accesoBaseDatos:String = "http://sourceserver.basf-arg.com.ar/source_informatica/pls/db";
		
		public var selectedLateralMenu:Number = 1;
		//public var topMenuDataProvider:Object;
		public var topMenuDataProvider:ArrayCollection;		
		public var profileDataLoaded:Boolean = false;
		
		
		public var systemLanguage:Object;
		public var systemLanguageDataProvider:Object = new Object();
		
		public var userProfileXml:Object;
		public var username:String;
		public var nombreUsuario:String;
		public var userProfile:XMLList;
		public var userNegocio:String;
		
		
		public var topMenu:Object = new Object();		
		
		
		public var mainView:Object;
		
		
		public var amURL:String;
		
		public var createRequestReport:CreateRequest;
		
		public var isAdmin:Boolean = false;
		
		
		//Constructor
		public function ModelLocator ():void 
		{
			if (com.sdev.moneyTrackDesktop.model.ModelLocator.modelLocatorInstance != null ) {
				throw new Error ("Solamente se puede levantar una sesion del ModelLocator");
			}
		}
		
		public static function getInstance ():com.sdev.moneyTrackDesktop.model.ModelLocator { 
			
			//si no esta creado lo instancia por primera vez
			if (modelLocatorInstance == null ) {
				modelLocatorInstance = new com.sdev.moneyTrackDesktop.model.ModelLocator();
			}
			return modelLocatorInstance;
		}
		
		public function getConfiguration():void {
			var event:GetConfigEvent = new GetConfigEvent();
			CairngormEventDispatcher.getInstance().dispatchEvent(event);
			
		}
		public function configurationLoaded():void {
			this.dispatchEvent(new Event("configurationLoaded",true));
		}
		public function selectedCompanyChanged():void {
			this.dispatchEvent(new Event("selectedCompanyChanged",true));
		}
		
	}
	
}
// ActionScript file