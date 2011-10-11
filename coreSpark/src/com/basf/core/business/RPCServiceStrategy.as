package com.basf.core.business
{
	import mx.rpc.remoting.RemoteObject;
	import com.adobe.cairngorm.business.ServiceLocator;
	import com.basf.core.vo.ServiceParameter;
	import mx.rpc.AsyncToken;
	
	public class RPCServiceStrategy extends ServiceStrategy
	{

		public function RPCServiceStrategy(serviceName:String)
		{
			super(serviceName);
		}

		override public function request(param:ServiceParameter=null,method:String=null,callRetrieved:Function=null,callError:Function=null):void
		{
			getService().logout();
			var call:AsyncToken = getService().getOperation(method).send([param]);
			call.resultHandler = callRetrieved;
			call.faultHandler = callError;
		}
		
		public function getService():RemoteObject
		{
			return ServiceLocator.getInstance().getRemoteObject(serviceName);
		}
	}
}