package com.basf.core.vo
{
	import com.basf.core.vo.ServiceParameter;
	
	import flash.xml.*;
	
	public class UserProfileSAPServiceParameter2 extends ServiceParameter
	{	
	
		public override function toXML4 (obj:Object):XML  {
	    	var xml4:XML =
  				<urn:YSA_RFC_CORE_USER_PROFILE xmlns:urn="urn:sap-com:document:sap:rfc:functions">
				</urn:YSA_RFC_CORE_USER_PROFILE>;
				

			if (obj.cUser != null)xml4.IP_USUARIO = obj.cUser; 			
			if (obj.cSistema != null) xml4.IP_SIST_ID = obj.cSistema;			
			
			return xml4;
	    }	

    }
}
