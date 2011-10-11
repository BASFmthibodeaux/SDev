package com.basf.core.business
{
	import com.basf.core.vo.ServiceParameter;
	
	public class ServiceStrategy
	{
		[Bindable]
		public var serviceName:String;
		[Bindable]
		public var service:Object;
		
		public function ServiceStrategy(serviceName:String)
		{
			this.serviceName = serviceName;
		}
		
		public function request(param:ServiceParameter=null,method:String=null,callRetrieved:Function=null,callError:Function=null):void{}
		
	}
}