package com.basf.core.business
{
	import com.basf.core.vo.ServiceParameter;
	
	import flash.events.Event;
	import flash.utils.getQualifiedClassName;
	
	import mx.collections.ArrayCollection;
	import mx.collections.XMLListCollection;
	import mx.rpc.events.ResultEvent;
	
	[Bindable]
	public class ComponentDAO extends Dao
	{
		
		public var dataProvider:Object;
		public var dataProviderNode:String = "";
		
		
		public function ComponentDAO(serviceName:String, serviceType:String,view:Object=null,dataProviderNode:String="")
		{
			this.dataProviderNode = dataProviderNode;
			super(serviceName, serviceType,view);
		}
		
		//Ejecuta la consulta al back - end
		public function loadData(param:ServiceParameter,method:String=null):void
		{
			request(param,method,loadResult,loadError);
		}
		
		//Obtiene la consulta del back-end.
		//Despues de que la factory construye el objeto, se despacha el evento dataRetrieved
		public function loadResult(event:ResultEvent):void
		{
			trace ("ComponentDao result: "+ this.serviceStrategy.serviceName);
			//this.serviceResult = event.result;

			var className:String = getQualifiedClassName( event.result );
			if (className != "XMLList") { 
				dataProvider = ArrayCollection(FactoryNode.createArrayNode(event.result,dataProviderNode));
			}
			else{
				dataProvider=new XMLListCollection(XML(event.result).dataProviderNode);
				
			}
			/**
			 * Aca puedo utilizar la vista para agregarle un comportamiento especifico
			 * /ok
			/* if (null != view) 
				view.dataRetrieved(); */
		}
		
		//Obtengo el error del back-end. sedespacha el evento dataError.
		//En caso de ser necesario puedo realizar alguna accion en este metodo.
		public function loadError(event:*):void
		{
			dispatchEvent(event);
			
	
			/*dispatchEvent(new Event("dataRetrieved"));*/
			/* if (null != view)
				view.dataError(); */
		}
	}
}