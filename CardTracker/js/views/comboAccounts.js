/*
MoneyTrack objects


Created 07May12 JL
(function($, undefined) {



})(jQuery);


*/
			function createChart() {
		    	var ds = new kendo.data.DataSource({ 
		    			transport: {
		    				read: {
		    					url:"http://localhost:8080/php/view/graph.php",
		    					data: {
		    						cHash: "nada1"
		    					}
		    				},
		    			},
	    				schema: {
	    					type: "xml",
	    					data: "/graph/period",
	    					model: {
	    						fields: {
	    							month: "month/text()",
	    							one_payment: "one_payment/text()",
	    							more_payments: "more_payments/text()"
	    						}
	    					}
	    				}
		    		}
		    	);

				
                $("#graph").kendoChart({
                	dataSource: ds,
                    theme: $(document).data("kendoSkin") || "default",
                    title: {
                        text: "Pagos a realizar"
                    },
                    legend: {
                        visible: false
                    },
                    seriesDefaults: {
                        type: "column"
                    },
                    categoryAxis: { 
                    	field: "month" 
                    },
                    series: [{
                    	field: "one_payment",
                        name: "Un Pago",
                    }, {
                    	field: "more_payments",
                        name: "En cuotas",
                    }],
                    seriesColors: ["#cd1533", "#d43851", "#dc5c71", "#e47f8f", "#eba1ad",
                                   "#009bd7", "#26aadd", "#4db9e3", "#73c8e9", "#99d7ef"]
                    
                });
            }



