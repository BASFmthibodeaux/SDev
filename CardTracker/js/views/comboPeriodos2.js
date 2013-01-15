/**
MoneyTrack objects


Created 07May12 JL

IMPORTANT:
on each HTML that this combo is created you need to create the following functions (events of the component):

onComboAccountsChangeValue

*/
function comboPeriodos2() {
	// PROPERTIES ----------------------------------------------------------------
	this.connectionString = "";
	this.holder = "";
	this.destinationDiv = "";
	this.hash = "Nada";
	this.credit_card = "";
	
	this.isInitialized = false;
	
	// ---------------------------------------------------------------------------
	this.createCombo = 
			function () {
		    	var ds = new kendo.data.DataSource({ 
		    			transport: {
		    				read: {
		    					url: ConnectionString+"/views/list_periods.php",
		    					data: {
		    						cHash: this.hash,
		    						holder: this.holder
		    					}
		    				},
		    			},
		    			autoBind: true,
	    				schema: {
	    					type: "xml",
	    					data: "/periods/period",
	    					model: {
	    						fields: {
	    							period: "period/text()"
	    						}
	    					}
	    				}
		    		}
		    	);

		    	if (this.destinationDiv == "" || this.destinationDiv == undefined) {
		    		alert ("WARNING: comboPeriodos2.js - destinationDiv is not defined.");
		    	}
				
		    	if ($(this.destinationDiv) == undefined) {
		    		alert ("WARNING: comboPeriodos2.js -can't find "+this.destinationDiv+" div tag in HTML file.");
		    	}
		    	
 		    	if (this.isInitialized) { 
 		    		var temp = $(this.destinationDiv).data("kendoDropDownList");
 		    		temp.setDataSource(ds);
 		    		temp.refresh();

 		    	} else {
 	                $(this.destinationDiv).kendoDropDownList({
 		            	dataSource: ds,
 				        dataTextField: "period",
 	        			dataValueField: "period",
 	        			suggest: true,		    	        
 	        			animation: {
 		    	             open: {
 		    	                 effects: "fadeIn",
 		    	                 duration: 300,
 		    	                 show: true
 		    	             },
 		    	             close: {
 		    	                 effects: "fadeOut",
 		    	                 duration: 300,
 		    	                 show: true
 		    	             }
 		    	        },
 	        			template: '<div width="250">${ data.period } </div>'
 		            });
 		    		this.isInitialized= true;
 		    		
 		    	}
            };
            
}
	
