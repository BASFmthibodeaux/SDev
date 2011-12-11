<?php
/*
 * -----------------------------------------------------
 * Lista de aplicaciones
 * -----------------------------------------------------
 * Este PHP se utiliza para mostrar la lista de aplicaciones
 * 
 * PARAMETROS:
 * 
 * 
 * TODO: Agregar hash de seguridad para que el PHP sea llamado desde una conexion valida
 * 
 * Log de modificaciones
 * 
 * 11/12/11 JL V000
 * 	 -Creacion del archivo
 * -----------------------------------------------------
 *  
*/
require_once '../global/global_variables.php';
require_once $functions_path . '/connect.php';
	$NL = "
";
	$link=connect_database($main_database);
    import_request_variables("gP","rvar_");
	header ('Content-Type: application/xml; charset=iso-8859-1');
	print '<?xml version="1.0" encoding="iso-8859-1"?>'. $NL;
	print ('<credit_cards'
				.'>'. $NL);
	if ($rvar_cHash !="") {
		$query="select * from credit_cards,banks,accounts ";
		$where = "where bank_id = acc_bank_id and cc_acc_id = acc_id ";
		if ($rvar_username !="") {
			$where = $where . " and cc_holder = '".$rvar_username. "' ";
		}
		$and_operator = "";
		$order_by = " order by bank_description,cc_holder,acc_card_type";
		$query .= $where;
		$result = mysql_query($query) or die("list_cards.php: Query failed (" . $query .") ". mysql_error());
		$item_index = 0;

		while ($row = mysql_fetch_array($result, MYSQL_ASSOC)) {
			print('<credit_card>'.$NL);
			print('<credit_card>'.$NL);
			print('</credit_card>'.$NL);
	        					.' base_datos="'.$row["apl_database"].'" '
	        					.' descripcion="'.$row["apl_descripcion"].'" '
	        					.' id_aplicacion="'.$row["apl_id"].'" '
	        					.' namespace="'.$row["apl_namespace"].'" '
								."/>" .$NL);
			$item_index ++;
	    }
		print('<where string="'.$where.'" />');
   	} else {
   		$texto_error = "";
   		if ($rvar_cHash == "") {
   			$texto_error.= " HASH invalid.";
   		}
		print ('<error texto="'.$texto_error.'"/>'.$NL);;
	}	
	print ('</credit_cards>'. $NL);
?>