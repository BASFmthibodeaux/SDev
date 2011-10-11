package com.basf.core.business
{
	import com.basf.core.vo.ServiceParameter;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.rpc.events.ResultEvent;
	
	public class Dao extends EventDispatcher
	{
		
		public static const HTTP:String = "http";

		public static const WSDL:String = "wsdl";
		
		public static const RPC:String = "rpc";

		
		private var serviceName:String;
		
		private var serviceType:String;
		
		private var dataRetrivedFunctionCall:Function;
		
		private var dataErrorFuncionCall:Function;
		
		[Bindable]
		public var serviceStrategy:ServiceStrategy;
		
		[Bindable]
		public var serviceRunning:Boolean = false;
		
		public var view:Object;		
		
		[Bindable]
		public var serviceResult:*;
		
		[Bindable]
		public var clearResultOnRequest:Boolean = true;
		
		[Bindable]
		public var errorString:String;
		[Bindable]
		public var dataRetrieved:Boolean=false;
		
		public function Dao(serviceName:String,serviceType:String,view:Object)
		{
			this.view = view;
			trace ("Strategy "+ serviceType+"-"+serviceName);
			serviceStrategy = ServiceStrategyFactory.createStrategy(serviceType,serviceName);
		}
		
				  
		public function request(param:ServiceParameter=null,method:String=null,callRetrieved:Function=null,callError:Function=null):void
		{
			serviceRunning = true;
			this.dataRetrieved = false;
			this.errorString = "";
			dataRetrivedFunctionCall = callRetrieved;
			dataErrorFuncionCall = callError;
			if (this.clearResultOnRequest) {
				this.serviceResult = null;
			}
			serviceStrategy.request(param,method,result,fault);
		}
		
	
		private function result(event:ResultEvent):void
		{
			trace ("dao result: "+ this.serviceStrategy.serviceName);
			this.errorString = "";
			this.serviceRunning = false;
			this.serviceResult = event.result;
			this.dataRetrieved = true;
			if (dataRetrivedFunctionCall != null) {
				dataRetrivedFunctionCall.call(null,event);
			}
			dispatchEvent(new Event("dataRetrieved"));
			
		}
		
		private function fault(event:*):void
		{
			this.errorString = event.fault;
			serviceRunning = false;
			this.dataRetrieved = false;
			if (dataErrorFuncionCall != null) {
				dataErrorFuncionCall.call(null,event);
			}
			dispatchEvent(new Event("dataError"));
		}
		
	}
}