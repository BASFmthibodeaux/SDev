package com.basf.core.vo
{
	public class ComboVO extends ServiceParameter
	{
		private var _data:Object;
		private var _label:Object;
		
		
		public function set data(obj:Object):void
		{
			_data = obj;	
		}
		
		public function set label(obj:Object):void
		{
			_label = obj;
		}
		
		public function get data():Object
		{
			return _data;
		}
		
		public function get label():Object
		{
			return _label;	
		}
	}
}