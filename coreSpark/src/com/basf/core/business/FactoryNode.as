package com.basf.core.business
{
	import flash.utils.getQualifiedClassName;
	
	import mx.collections.ArrayCollection;
	import mx.utils.ObjectUtil;
	
	public class FactoryNode
	{
		/**
		 * 	@params obj: tipo Objet, objeto targget
		 * 			path: corresponde al nodo de obj a obtener
		 *	@return tipo Object, devuelve el nodo requerido 	
		 */	
		public static function createArrayNode(obj:Object, path:String):ArrayCollection{
			
			var className:String = getQualifiedClassName( obj );
			var node:Object = ObjectUtil.copy(obj);
			
			if (className != "XMLList"&& className != "String") { 
				if(node == null) 
				{
					trace("Error datos, el objeto llego en null");
					throw new Error("objeto null");
				}
										
				for each (var name:String in path.split('.'))
				{
					if (null == node[name])
					{
						trace("No se pudo acceder hasta -> "+name);
						break;
					}
					node = node[name];				
				}
				
				if (path == "")
				{
					trace("El dataProviderNode esta vacio, CreateArrayNode devuelve el event.result");
				}
				
				if (!(node is ArrayCollection))
				{
					var collection:ArrayCollection = new ArrayCollection();
					collection.addItem(node);
					node = collection;		
				}
			}
			if (className == "String") {
				node = new ArrayCollection();
			}
			return ArrayCollection(node);
		}		
	}
}