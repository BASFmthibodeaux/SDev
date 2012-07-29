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
	// ---------------------------------------------------------------------------
	this.createCombo = 
			function () {
		    	var ds = new kendo.data.DataSource({ 
		    			transport: {
		    				read: {
		    					url: ConnectionString+"/views/list_accounts.php",
		    					data: {
		    						cHash: "nada1",
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
		    	
		    	if (onComboAccountsChangeValue == undefined) {
		    		alert ("WARNING: comboAccounts.js -onComboAccountsChangeValue function in HTML file is missing.");
		    	}
		    	
                $(this.destinationDiv).kendoDropDownList({
	            	dataSource: ds,
			        dataTextField: "bank",
        			dataValueField: "acc_id",
        			suggest: true,
        			template: '<div width="300">${ data.bank } / <b>${ data.card_type }</b></div>', 
        			change: onComboAccountsChangeValue
	            });
            };
}

