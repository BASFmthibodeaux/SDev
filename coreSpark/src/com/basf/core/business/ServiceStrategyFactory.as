package com.basf.core.business
{
	
	
	public class ServiceStrategyFactory
	{
			
		public static function createStrategy(serviceType:String,serviceName:String):ServiceStrategy
		{
			var service:ServiceStrategy;
			
			
			switch(serviceType)
			{
				case Dao.HTTP: service = new HTTPServiceStrategy(serviceName);break;
				case Dao.WSDL: service = new WSServiceStrategy(serviceName);break;
				case Dao.RPC: service = new RPCServiceStrategy(serviceName);break;
			}
			
			return service;
		}
	}
}