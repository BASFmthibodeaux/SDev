/*

Copyright (c) 2007. Adobe Systems Incorporated.
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

  * Redistributions of source code must retain the above copyright notice,
    this list of conditions and the following disclaimer.
  * Redistributions in binary form must reproduce the above copyright notice,
    this list of conditions and the following disclaimer in the documentation
    and/or other materials provided with the distribution.
  * Neither the name of Adobe Systems Incorporated nor the names of its
    contributors may be used to endorse or promote products derived from this
    software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
POSSIBILITY OF SUCH DAMAGE.

@ignore
*/
package com.adobe.cairngorm
{
	import mx.utils.StringUtil;
	//import mx.resources.ResourceBundle;
	
	/**
	 * Error class thrown when a Cairngorm error occurs.
	 * Used to substitute data in error messages.
	 */
	public class CairngormError extends Error
	{
		//[ResourceBundle("CairngormMessages")] 
	 	//private static var rb : ResourceBundle;
		
		public function CairngormError( errorCode : String, ... rest )
		{
			super( formatMessage( errorCode, rest.toString() ) );
		}
		
		private function formatMessage( errorCode : String, ... rest ) : String
		{
			var message : String;
			
			if (errorCode == "C0001E")
			{
				message = StringUtil.substitute("Only one {0} instance can be instantiated",rest);								
			}
			if (errorCode == "C0002E")
			{
				message = StringUtil.substitute("Service not found for {0}",rest);								
			}
			if (errorCode == "C0003E")
			{
				message = StringUtil.substitute("Command already registered for {0}",rest);								
			}
			if (errorCode == "C0004E")
			{
				message = StringUtil.substitute("Command not found for {0}",rest);								
			}
			if (errorCode == "C0005E")
			{
				message = StringUtil.substitute("View already registered for {0}",rest);								
			}
			if (errorCode == "C0006E")
			{
				message = StringUtil.substitute("View not found for {0}",rest);								
			}
			if (errorCode == "C0007E")
			{
				message = StringUtil.substitute("RemoteObject not found for {0}",rest);								
			}
			if (errorCode == "C0008E")
			{
				message = StringUtil.substitute("HTTPService not found for {0}",rest);								
			}
			if (errorCode == "C0009E")
			{
				message = StringUtil.substitute("WebService not found for {0}",rest);								
			}
			if (errorCode == "C00010E")
			{
				message = StringUtil.substitute("Consumer not found for {0}",rest);								
			}
			if (errorCode == "C00012E")
			{
				message = StringUtil.substitute("Producer not found for {0}",rest);								
			}
			if (errorCode == "C00013E")
			{
				message = StringUtil.substitute("DataService not found for {0}",rest);								
			}
			if (errorCode == "C00014E")
			{
				message = StringUtil.substitute("Abstract method called {0}",rest);								
			}
			if (errorCode == "C00015E")
			{
				message = StringUtil.substitute("Command not registered for {0}",rest);								
			}
			
//			var message : String =  StringUtil.substitute( resourceBundle.getString( errorCode ), rest );
			
			return StringUtil.substitute( "{0}: {1}", errorCode, message);
		}
		
	//	protected function get resourceBundle() : ResourceBundle
//		{
	//		return rb;
		//}
	}
}