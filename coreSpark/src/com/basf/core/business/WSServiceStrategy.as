package com.basf.core.business
{
	import com.adobe.cairngorm.business.ServiceLocator;
	import com.basf.core.vo.ServiceParameter;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.soap.WebService;
	
	public class WSServiceStrategy extends ServiceStrategy
	{
		
		public function WSServiceStrategy(serviceName:String)
		{
			super(serviceName);
		}
		
		override public function request(param:ServiceParameter=null,method:String=null,callRetrieved:Function=null,callError:Function=null):void
		{
			//getService().logout();
			//			var call:AsyncToken = getService().getOperation(method).send (param.toXML4(param.parametros));
			var ws:WebService = getService();
			var call:AsyncToken = ws.operations[method].send (param.toXML4(param.parametros));
			call.resultHandler = callRetrieved;
			call.faultHandler = callError;
		}
		
		public function getService():WebService
		{
			return ServiceLocator.getInstance().getWebService(serviceName);
		}
	}
}