/**
 * 
 */

function ListApprovals() {
	this.GetListApprovals = function () {
		var symbol = "MSFT"; 
		var xmlhttp = new XMLHttpRequest();
		xmlhttp.open("POST", "http://www.webservicex.net/stockquote.asmx?op=GetQuote",true);
		xmlhttp.onreadystatechange=function() {
		 if (xmlhttp.readyState == 4) {
		  alert(xmlhttp.responseText);
		  // http://www.terracoder.com convert XML to JSON 
		  var json = XMLObjectifier.xmlToJSON(xmlhttp.responseXML);
		  var result = json.Body[0].GetQuoteResponse[0].GetQuoteResult[0].Text;
		  // Result text is escaped XML string, convert string to XML object then convert to JSON object
		  json = XMLObjectifier.xmlToJSON(XMLObjectifier.textToXML(result));
		  alert(symbol + ' Stock Quote: $' + json.Stock[0].Last[0].Text); 
		 }
		}
		xmlhttp.setRequestHeader("SOAPAction", "http://www.webserviceX.NET/GetQuote");
		xmlhttp.setRequestHeader("Content-Type", "text/xml");
		var xml = '<?xml version="1.0" encoding="utf-8"?>' +
		 '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
		                'xmlns:xsd="http://www.w3.org/2001/XMLSchema" ' +
		                'xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">' + 
		   '<soap:Body> ' +
		     '<GetQuote xmlns="http://www.webserviceX.NET/"> ' +
		       '<symbol>' + symbol + '</symbol> ' +
		     '</GetQuote> ' +
		   '</soap:Body> ' +
		 '</soap:Envelope>';
		xmlhttp.send(xml);		
	};
}