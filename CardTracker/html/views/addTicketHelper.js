var combo = new comboAccounts();
var comboPagos = new comboPagos();
var comboUsers = new comboUsers();
var comboCurrency = new comboCurrency();
var gridPurchases = new gridPurchases();

var sendingData = false;
var loadingMode = "DEFAULT";

var hash = "nada";
var username = "LOUCIMJ";
var limit = "5";
var dateTouchMode = true;



/** Cuando la pagina se haya creado ---------------------------------------------   **/
function initAddTicketHTML () {
	comboUsers.username= username;
	combo.holder = username;
	//ConnectionString esta definido en GlobalVariables.js
	combo.connectionString = ConnectionString;
	combo.destinationDiv = "#comboBox"
	comboPagos.destinationDiv = "#comboPagos";
	comboCurrency.destinationDiv = "#comboCurrency";
	comboUsers.connectionString = ConnectionString;
	comboUsers.destinationDiv = "#comboUsers"
		
	gridPurchases.destinationDiv = "#grid";
	gridPurchases.connectionString = ConnectionString;
	
	//alert (username);
	if (BrowserDetect.OS == "iPhone/iPod" || BrowserDetect.OS == "iPad") {
		//Usar el datepicker solamente en dispositivos moviles
		$('#datepicker').scroller({
	        preset: 'date',
	        theme: 'android-ics',
	        headerText: 'false',
	        height: 40,
	        showLabel: false,
	        dateFormat: 'yy/mm/dd',
	        dayNamesShort: ['Domingo','Lunes','Martes','Miercoles','Jueves','Viernes','Sabado'],
	        dayNamesShort: ['Dom','Lu','Ma','Mie','Jue','Vie','Sab'],
	        monthNamesShort: ['Ene','Feb','Mar','Abr','May','Jun','Jul','Ago','Sep','Oct','Nov','Dic'],
	        display: 'inline',
	        mode: 'scroller',
	        dateOrder: 'D ddMyyyy'
	    });    
	} else{
		var circle = document.getElementById("datepicker2");
		circle.style.display = "block";
		dateTouchMode = false;
		
	}
		    		
    setTimeout(function() {

		comboUsers.createCombo();
		var dropdownlist = $("#comboUsers").data("kendoDropDownList");
		dropdownlist.bind("change",onComboUsersChangeValue);

    	
    	//* inicializar combo de cuentas *//
        combo.createCombo();
		dropdownlist = $("#comboBox").data("kendoDropDownList");
		dropdownlist.bind("change",onComboAccountsChangeValue);
		
		comboCurrency.createCombo();
		
		gridPurchases.hash = "nada";
		gridPurchases.purchased_by = this.username;
		gridPurchases.limit = this.limit;
		gridPurchases.orderBy = "TIMESTAMP";
		gridPurchases.createGrid();
        
    }, 400);
        		    	
}



/** FUNCIONES addTicket ---------------------------------------------   **/

function onComboUsersChangeValue(event) {
	
	var dropdownlist = $("#comboUsers").data("kendoDropDownList");
	var dataItem = dropdownlist.dataItem();

	//dropdownlist.text(dataItem.username);
	combo.holder = dataItem.username;
	combo.createCombo();
}

function onComboAccountsChangeValue(event) {
	
	var dropdownlist = $("#comboBox").data("kendoDropDownList");
	var dataItem = dropdownlist.dataItem();

	dropdownlist.text(dataItem.card_type);
	$("#resultadoBanco").html ("<p>" + dataItem.bank + "</p>" ); 
	$("#resultadoValidate").html ( "");
//
//	var circle = document.getElementById("comboPeriodos");
//	circle.style.display = "block";
	
}


/** FUNCIONES comunes ---------------------------------------------   **/

function onComboPagosChange(event) {

	if ($("#comboPagos").val()  > 1 && $("#valor").val() > 0 ) {
		var cuota = Math.round($("#valor").val() / $("#comboPagos").val() );
		
		if (cuota == 0) {
			$("#resultadoCuotas").html ("<p>" + $("#comboPagos").val() + " pagos de casi nada, no llega a $1!!</p>" ); 
		} else {
			$("#resultadoCuotas").html ("<p>" + $("#comboPagos").val() + " pagos de $"+(Math.round($("#valor").val() / $("#comboPagos").val() )) + "</p>" ); 
		}
	} else {
		$("#resultadoCuotas").html ("");
	}
	$("#resultadoValidate").html ( "");
	
}

function onComboPagosChange2(event) {
	var y = $("#comboPagos").val();

	if (this.loadingMode == "MONTHLY_PAYMENT") {
		$("#resultadoCuotas").html ( "el valor total fue $" + Math.round(y*$("#valor").val()));
		$("#resultadoValidate").html ( "");
	}
	
}

function validateData() {
	var tarjeta = $("#comboBox").data("kendoDropDownList");
	var tarjetaData = tarjeta.dataItem();
	var moneda = $("#comboCurrency").data("kendoDropDownList");
	var pagos = $("#comboPagos").val();
	var valor = $("#valor").val();
	
	
	var day = $("#day").val();
	var month = $("#month").val();
	var year = $("#year").val();

	var stringFecha = jQuery.scroller.formatDate('yyyy-mm-dd',fecha);
	
	
//				alert (stringFecha);
	
	var x = tarjeta.text();
	if (x == "Ê") {
		$("#resultadoValidate").html ( "Tienes que seleccionar una tarjeta!");
		return;
	}
	//alert (tarjetaData.data.acc_id);

	//alert (valor);
	
	if (dateTouchMode == false) {
		if (day == 0) {
			$("#resultadoValidate").html ( "Tienes que completar el dia.");
			return;
		}
		if (month == 0) {
			$("#resultadoValidate").html ( "Tienes que completar el mes!");
			return;
		}
		if (year == 0) {
			$("#resultadoValidate").html ( "Tienes que completar el a–o.");
			return;
		}
	} else {
		var fecha = $("#datepicker").scroller('getDate');					
	}
	
	if (valor == 0) {
		$("#resultadoValidate").html ( "No se compra nada gratis con tarjeta!! completa el valor.");
		return;
	}
	if (valor < 0) {
		$("#resultadoValidate").html ( "Te devolvieron plata en la tarjeta!?? completa el valor.");
		return;
	}
	
	
	if (pagos == 0) {
		$("#resultadoValidate").html ( "No se inventaron los pagos en cero!!");
		return;
	}
	if (pagos < 0) {
		$("#resultadoValidate").html ( "Pagos negativos??! Que maldad! querer romper el sistema as’!");
		return;
	}
	$("#resultadoValidate").html ( "");
	//$("#circle").style ("display:true");
	
	sendData();

}

function sendData(force) {
	
	if (this.dateTouchMode) {
		var fecha = $("#datepicker").scroller('getDate');
		var stringFecha = jQuery.scroller.formatDate('yyyy-mm-dd',fecha);
	}else {
		var day = $("#day").val();
		var month = $("#month").val();
		var year = $("#year").val();
		var stringFecha = year+"-"+pad(month,2,"0",STR_PAD_LEFT)+"-"+pad(day,2,"0",STR_PAD_LEFT);
	}
	
	var tarjeta = $("#comboBox").data("kendoDropDownList");
	var tarjetaData = tarjeta.dataItem();
	
	sendingData = true;
	
	//deshabilitar los divs
	var circle = document.getElementById("circle");
	circle.style.display = "block";
	var temp = document.getElementById("divBanco");
	temp.style.opacity = "0.3";
	var temp = document.getElementById("divFecha");
	temp.style.opacity = "0.3";
	$("#datepicker").scroller.readOnly= true;
	var temp = document.getElementById("divValor");
	temp.style.opacity = "0.3";
	
	var pagos = $("#comboPagos").val();
	var valor_total = $("#valor").val();


	if (this.loadingMode == "MONTHLY_PAYMENT") {
		//total_pagos = pagos*$("#valor").val();
	}

	var bypass_check = "0";
	if (force != null) {
		var bypass_check = "1";
	}
	
	var dataSource = new kendo.data.DataSource({
	    transport: {
	        read: {
				url: ConnectionString+"/business/load_purchases.php",
				data: {
					cHash: this.hash,
					cAction: "ADD",
					value_type: this.loadingMode,
					date: stringFecha,
					purchased_by: this.username,
					credit_card: tarjetaData.acc_id,
					description: $("#description").val(),
					value: $("#valor").val(),
//	    						value: valor_total,
					payments: pagos,
					bypass_check: bypass_check
				}
	        }
	    },
		schema: {
			type: "xml",
			data: "/action",
			model: {
				fields: {
					code: "code/text()",
					error: "error/text()",
					response: "response/text()"
				}
			}
		},
	    change: function(e) {
	        // handle event
			var circle = document.getElementById("circle");
			circle.style.display = "none";
			var temp = document.getElementById("divBanco");
			temp.style.opacity = "1";
			temp = document.getElementById("divFecha");
			temp.style.opacity = "1";
			temp = document.getElementById("divValor");
			temp.style.opacity = "1";

	        var data = this.data();
	        
	        //alert (data[0].data.code);
			if (data[0].code == "3") {
	        	$("#resultadoValidate").html ( data[0].error+" <h6><a onclick='sendData(1);'>cargar igualmente</a></h6>");
	        } else {
	        	$("#resultadoValidate").html ( data[0].response);
// 							if (this.loadingMode == "MONTHLY_PAYMENT") {
// 					        	toggleResumen();
// 							} else {
// 								toggleTicket();
// 							}
	        	gridPurchases.createGrid();
	        }
			
	    }
	});	
	
	dataSource.read();
					
}

function toggleTicket(){
/*
				var x = document.getElementById("divPagosTicket");
				x.style.display = "block";
				x = document.getElementById("divPagosResumen");
				x.style.display = "none";
				*/
	$("#valor").attr("placeholder", "valor");
	this.loadingMode = "DEFAULT";
	onComboPagosChange();
	
}

function toggleResumen(){
	/*
	var x = document.getElementById("divPagosResumen");
	x.style.display = "block";
	x = document.getElementById("divPagosTicket");
	x.style.display = "none";
	*/
	$("#valor").attr("placeholder", "valor cuota");
	this.loadingMode = "MONTHLY_PAYMENT";
	onComboPagosChange2(null);
}
