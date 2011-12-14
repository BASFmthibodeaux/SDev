<?php
/*
 * -----------------------------------------------------
 * Administracion de entidad Evento
 * -----------------------------------------------------
 * Este PHP se utiliza para crear, editar y borrar Eventos,
 * genera como respuesta un archivo XML con el resultado de la operacion:
 * 
 * 1: OK (ver propiedad id para ver el nuevo objeto)
 * 0: Error (ver propiedad mensaje_error)
 * 
 * TODO: Agregar hash de seguridad para que el PHP sea llamado desde una conexion valida
 * 
 * Log de modificaciones
 * 
 * 12Dec11 JL 	 -Creacion del archivo
 * -----------------------------------------------------
 *  
*/
require_once '../global/global_variables.php';
require_once $functions_path . '/connect.php';
require_once $functions_path . '/database_functions.php';



	header('Content-type: text/xml');
	header('Pragma: public');
	header('Cache-control: private');
	header('Expires: -1');

    import_request_variables("gP","rvar_");


	$NL = chr(13);
	$link=connect_database($main_database);
	
	print '<?xml version="1.0" encoding="iso-8859-1"?>'. $NL;
	
	print ('<action>'.$NL);
	
	//TODO:Hacer que valide la conexion en el hash
	if ($rvar_cHash !="") {
		print ('<object>purchases</object>'.$NL);
		print ('<action_type>'.$rvar_cAction.'</action_type>'.$NL);

		switch ($rvar_cAction) {
			case "ADD":
				$query="insert into purchases (" 
								." pur_date "
								.", pur_purchased_by "
								.", pur_cc_id "
								.", pur_description "
								.", pur_value "
								.", pur_payments "
								." ) values (" 
								." '".$rvar_date."'" 
								.", '".$rvar_purchased_by."'" 
								.", ".$rvar_credit_card 
								.", '".$rvar_description."'" 
								.", ".$rvar_value 
								.", ".$rvar_payments
								.")";
				if (mysql_query ($query)) {
					$rvar_nId=mysql_insert_id($link);
					print('<response codigo="1">Se cargo el Evento con el id '.$rvar_nId.' id='.$rvar_nId.'</response>'. $NL);
				} else {
					print ('<error>MySQL error: '.mysql_error().'</error>'.$NL);;
				}	
				//tomar el dia de cierre para ver si entra en el cierre de la compra o en el siguiente
				
				$dia = execute_sql ('select cc_closing_date from credit_cards where cc_id = '.$rvar_credit_card);
				$dia_operacion = substr($rvar_date,8,2);
				$mes_operacion = substr($rvar_date,5,2);
				$anio_operacion = substr($rvar_date,0,4);

				if ($dia_operacion > $dia) {
					$due_date = add_month ($rvar_date);
					$due_date = substr($due_date,0,7)."-".str_pad($dia,2,"0",STR_PAD_LEFT);
				} else {
					$due_date = substr($rvar_date,0,7)."-".str_pad($dia,2,"0",STR_PAD_LEFT);
				}
				
				if ($rvar_payments > 1) {
					for ($x=1;$x<=$rvar_payments;$x++) {

					$query2 = "insert into future_payments ("
								."fp_cc_id,"
								."fp_due_date,"
								."fp_due_period,"
								."fp_value,"
								."fp_created_by,"
								."fp_pur_id"
								.") values ("
								." ".$rvar_credit_card 
								.",'". $due_date. "'" 
								.",'".substr($due_date,0,7)."'" 
								.", ".$rvar_value/$rvar_payments 
								.", '".$rvar_purchased_by."'" 
								.", ".$rvar_nId
								.")";

//					print ($query2);
					mysql_query ($query2) or die("EXECUTE_SQL:Query failed '".$query2."'" . "<br>" .mysql_error());;								

					$due_date = add_month ($due_date);
					$due_date = substr($due_date,0,7)."-".str_pad($dia,2,"0",STR_PAD_LEFT);

					}
				} else {
					$query2 = "insert into future_payments ("
								."fp_cc_id,"
								."fp_due_date,"
								."fp_due_period,"
								."fp_value,"
								."fp_created_by,"
								."fp_pur_id"
								.") values ("
								." ".$rvar_credit_card 
								.",'". $due_date. "'" 
								.",'".substr($due_date,0,7)."'" 
								.", ".$rvar_value 
								.", '".$rvar_purchased_by."'" 
								.", ".$rvar_nId
								.")";

//					print ($query2);
					mysql_query ($query2) or die("EXECUTE_SQL:Query failed '".$query2."'" . "<br>" .mysql_error());;								
				}
				
				break;
			case "EDIT":
				$query="update eventos set "
								."  event_id = ".$rvar_nId.""
								." , event_flex_name = '".$rvar_cFlexName."'"
								." , event_ent_id = '".$rvar_nIdEntidad."'"
								." , event_php_name = '".$rvar_cPHPName."'"
								." , event_apl_id = ".$rvar_nIdAplicacion.""
								." , event_ent_schema = '".$rvar_cSchema."'"
								." where "
								."  event_id = ".$rvar_nId.""
								."  and  event_ent_id = '".$rvar_nIdEntidad."'"
								."  and  event_apl_id = ".$rvar_nIdAplicacion.""
								."  and  event_ent_schema = '".$rvar_cSchema."'"
				;
				$result_update= mysql_query ($query);
				$affected_rows = mysql_affected_rows();
			    mysql_free_result($result_update);
				if (!$result_update || $rvar_nId=="" || $affected_rows < 1) {
					print ('<respuesta><error texto="Hubo un problema al actualizar LA ENTIDAD ('.$rvar_nId.') '.mysql_error().'" '.
									' affected_rows="'.$affected_rows.'" '.
									'/></respuesta>'.$NL);
					print ('<query>'.$query.'</query>'.$NL);
				} else {
					print('<respuesta codigo="1" mensaje="Se actualizaron los datos de LA ENTIDAD '.$rvar_nIdCampo.'"/>'. $NL);
				}					
				break;
			case "DELETE":
				$query="delete from eventos  " 
								." where "
								."  event_id = ".$rvar_nId.""
								."  and  event_ent_id = '".$rvar_nIdEntidad."'"
								."  and  event_apl_id = ".$rvar_nIdAplicacion.""
								."  and  event_ent_schema = '".$rvar_cSchema."'"
				;
				if (!mysql_query ($query) || $rvar_nId="" || mysql_affected_rows() < 1) {
					print ('<respuesta><error texto="Hubo un problema al borrar. '.mysql_error().'"/></respuesta>'.$NL);;
				} else {
					print('<respuesta codigo="1" mensaje="Se borraron los datos '.$rvar_nId.'"/>'. $NL);
				}	
				break;
			default:
				print('<respuesta><error texto="La acción '.$rvar_cAction.' no es reconocida"/></respuesta>'. $NL);
				break;
		} 
	} else {
   		if ($rvar_cHash == "") {
   			$texto_error.= "Invalid HASH.";
   		} 
		print ('<error>'.$texto_error.'</error>'.$NL);;
	}
	print ('</action>'. $NL);
?>