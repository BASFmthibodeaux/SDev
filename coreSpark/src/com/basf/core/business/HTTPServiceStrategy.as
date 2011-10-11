package com.basf.core.business
{
	import mx.rpc.http.HTTPService;
	import com.adobe.cairngorm.business.ServiceLocator;
	import mx.rpc.AsyncToken;
	import com.basf.core.vo.ServiceParameter;
	import mx.utils.ObjectUtil;
	
	public class HTTPServiceStrategy extends ServiceStrategy
	{
		
		public function HTTPServiceStrategy(serviceName:String)
		{
			super(serviceName);
		}
		
		override public function request(param:ServiceParameter=null,method:String=null,callRetrieved:Function=null,callError:Function=null):void
		{				
			var obj:Object; 
			//getService().cancel();
			if (param != null) {
				obj = ObjectUtil.copy(param.parametros);
			}
			var call:AsyncToken = getService().send(obj);
			call.resultHandler = callRetrieved;
			call.faultHandler = callError;
		}
		
		public function getService():HTTPService
		{
			if (this.service == null) {
				this.service = ServiceLocator.getInstance().getHTTPService(serviceName);
			}
			return this.service as HTTPService;
		}
	}
}