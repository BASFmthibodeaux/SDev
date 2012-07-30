/**
MoneyTrack objects


Created 07May12 JL

IMPORTANT:
on each HTML that this combo is created you need to create the following functions (events of the component):

onComboAccountsChangeValue

*/
function comboAccounts() {
	// PROPERTIES ----------------------------------------------------------------
	this.connectionString = "";
	this.account = "";
	this.destinationDiv = "";
	this.hash = "Nada";
	
	// ---------------------------------------------------------------------------
	this.createCombo = 
			function () {
		    	var ds = new kendo.data.DataSource({ 
		    			transport: {
		    				read: {
		    					url: ConnectionString+"/views/list_accounts.php",
		    					data: {
		    						cHash: this.hash,
		    						account: this.account
		    					}
		    				},
		    			},

	    				schema: {
	    					type: "xml",
	    					data: "/accounts/account",
	    					model: {
	    						fields: {
	    							acc_id: "acc_id/text()",
	    							bank: "bank/text()",
	    							card_type: "card_type/text()"
	    						}
	    					}
	    				}
		    		}
		    	);

		    	if (this.destinationDiv == "" || this.destinationDiv == undefined) {
		    		alert ("WARNING: comboAccounts.js - destinationDiv is not defined.");
		    	}
				
		    	if ($(this.destinationDiv) == undefined) {
		    		alert ("WARNING: comboAccounts.js -can't find "+this.destinationDiv+" div tag in HTML file.");
		    	}
		    	
                $(this.destinationDiv).kendoDropDownList({
	            	dataSource: ds,
			        dataTextField: "card_type",
        			dataValueField: "acc_id",
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
        			template: '<div width="250"><b>${ data.card_type }</b> - ${ data.bank } </div>'
	            });
            };
}

