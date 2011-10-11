package com.basf.core.vo
{

	public class ServiceParameter implements ServiceParameterAbstract	
	{
		public var parametros:Object = new Object();	
		
		public function toXML4 (obj:Object):XML {
	    	var xml4:XML = <nodo></nodo>;
		
			return xml4;
		} 	

	}
}