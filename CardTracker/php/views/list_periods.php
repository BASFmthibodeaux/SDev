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
 * 14/12/12 JL V000
 * 	 -Creacion del archivo
 * -----------------------------------------------------
 *  
*/

/* PARAMETROS

cHash			hash de seguridad

-- campos:
credit_card


*/
require_once '../global/global_variables.php';
require_once $functions_path . '/connect.php';

	header('Content-type: text/xml');
	header('Pragma: public');
	header('Cache-control: private');
	header('Expires: -1');

    import_request_variables("gP","rvar_");


	$NL = chr(13);
	$link=connect_database($main_database);
	
	print '<?xml version="1.0" encoding="iso-8859-1"?>'. $NL;
	print ('<periods>'.$NL);
	
	if ($rvar_cHash !="") {
		
		//TODO: revisar HASH primero!
		
		$query="select distinct fp_due_period from future_payments ";
		$where = " "  ;
		if ($rvar_credit_card !="") {
			$where = $where . " where fp_cc_id= ".$rvar_credit_card;
		}
		$query .= $where;
		$query .= " order by 1 ";
		
		$result = mysql_query($query) or die("list_periods.php: Query failed (" . $query .") ". mysql_error());
		$item_index = 0;

		while ($row = mysql_fetch_array($result, MYSQL_ASSOC)) {

			print('<period>'.$row["fp_due_period"].'</period>'.$NL);

			$item_index ++;
	    }
// 		print('<query>'.$query.'</query>'.$NL);
// 		print('<query>'.$rvar_order_by.'</query>'.$NL);
// 		print('<where_clause>'.$where.'</where_clause>'.$NL);
   	} else {
   		$texto_error = "";
   		if ($rvar_cHash == "") {
   			$texto_error.= "Invalid HASH.";
   		} 
		print ('<error>'.$texto_error.'</error>'.$NL);;
	}	

	print ('</periods>'. $NL);
?>