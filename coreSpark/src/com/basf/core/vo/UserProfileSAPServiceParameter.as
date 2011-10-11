package com.basf.core.vo
{
	import com.basf.core.vo.ServiceParameter;
	
	import flash.xml.*;
	
	public class UserProfileSAPServiceParameter extends ServiceParameter
	{	
		
		public override function toXML4 (obj:Object):XML  {
	    	var xml4:XML =
  				<urn:YSP_RFC_GETUSER_PROFILE xmlns:urn="urn:sap-com:document:sap:rfc:functions">
				</urn:YSP_RFC_GETUSER_PROFILE>;
				

			if (obj.cUser != null) xml4.E_SIST_ID = obj.cSistema;			
			if (obj.cSistema != null) xml4.E_USUARIO = obj.cUser;			
			
			return xml4;
	    }	
    }
}
