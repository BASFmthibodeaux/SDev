package com.basf.core.business
{
	import com.basf.core.vo.ServiceParameter;
	
	public class ActivityMonitor
	{
		[Bindable]
		public var serviceName:String 
		
		private var dao:Dao;
		
		public function ActivityMonitor(serviceName:String)
		{
			this.serviceName = serviceName;
			this.dao = new Dao (this.serviceName,"http",this);
		}
		
		public function send(system:String,username:String,module:String,comment:String,environment:String=null,isError:Boolean=false):void {
			var sp:ServiceParameter = new ServiceParameter();
			sp.parametros.cSYSID = system;
			sp.parametros.cEnvironment = environment;
			sp.parametros.cModule = module;
			sp.parametros.nError = (isError)? 1:0;
			sp.parametros.cUsername = username;
			sp.parametros.cComment = comment;
			
			dao.request(sp,null,onOK,onError); 
		}
		
		private function onOK(event:*=null):void {

		}
		
		private function onError(event:*=null):void {
			trace("ACTIVITY MONITOR: "+dao.errorString);			
		}

	}
}