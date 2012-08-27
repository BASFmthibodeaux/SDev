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


/* PARAMETROS

	cHash			hash de seguridad
	type			PAYMENTS or blank / 
	credit_card		
	account
	period_from
	
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
	print ('<graph>'.$NL);
	
	if ($rvar_cHash !="") {
		
		//TODO: revisar HASH primero!
		
		if ($rvar_type == "PAYMENTS" || $rvar_type == "") {

			
			// Buscar en funcion de los pagos
			$query="select fp_due_period, sum(if (pur_payments=null or pur_payments = 1 ,fp_value,0)) one_payment, sum(if (pur_payments > 1 ,fp_value,0)) more_payments from future_payments, purchases, credit_cards";
			$where = " where fp_pur_id = pur_id and pur_cc_id = cc_id "  ;
			if ($rvar_credit_card !="") {
				$where = $where . " and pur_cc_id= ".$rvar_credit_card;
			}
			if ($rvar_account !="") {
				$where = $where . " and cc_acc_id= ".$rvar_account;
			}
			//determinar el periodo 
			
			if ($rvar_period_from == "TODAY" || $rvar_period_from =="") {
				$from_date = date("Y-m-d",mktime(0, 0, 0, date("m")-3, "01",   date("Y")));
				$to_date = date("Y-m-d", mktime(0, 0, 0, date("m")+9,"01",   date("Y")));
			} 
			if ($rvar_period_from == "-6") {
				$from_date = date("Y-m-d",mktime(0, 0, 0, date("m")-6, "01",   date("Y")));
				$to_date = date("Y-m-d", mktime(0, 0, 0, date("m")+6,"01",   date("Y")));
			}
			if ($rvar_period_from == "-9") {
				$from_date = date("Y-m-d",mktime(0, 0, 0, date("m")-9, "01",   date("Y")));
				$to_date = date("Y-m-d", mktime(0, 0, 0, date("m")+3,"01",   date("Y")));
			}
			if ($rvar_period_from == "-12") {
				$from_date = date("Y-m-d",mktime(0, 0, 0, date("m")-12, "01",   date("Y")));
				$to_date = date("Y-m-d", mktime(0, 0, 0, date("m"),"01",   date("Y")));
			}
				
			$where .= " and fp_due_date >= '".$from_date."' and fp_due_date <'".$to_date."' ";
			
			$order_by = " group by fp_due_period order by fp_due_period";
			$query .= $where;
			$query .= $order_by;
			$result = mysql_query($query) or die("graph.php: Query failed (" . $query .") ". mysql_error());
			$item_index = 0;
	
			while ($row = mysql_fetch_array($result, MYSQL_ASSOC)) {
				print('<period>'.$NL);
	
				print('<month>'.date("M y",strtotime($row["fp_due_period"]."-01 00:00:00")).'</month>'.$NL);
				print('<one_payment>'.round($row["one_payment"]).'</one_payment>'.$NL);
				print('<more_payments>'.round($row["more_payments"]).'</more_payments>'.$NL);

				print('</period>'.$NL);
				$item_index ++;
		    } 
			print('<query><![CDATA['.$query.']]></query>'.$NL);
			print('<where_clause><![CDATA['.$where.']]></where_clause>'.$NL);
		}
		
	}	

	print ('</graph>'. $NL);
?>