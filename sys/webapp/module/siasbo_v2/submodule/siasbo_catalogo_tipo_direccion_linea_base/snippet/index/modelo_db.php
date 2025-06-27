<?php

class ModeloBD {

	private function abrirConexion($gestorBD='mysql') {
		try {
			switch ($gestorBD) {
				default:
					return new PDO('mysql:host=localhost;dbname=vrhr_siasbo_v2', 'root', '');
					break;

				/*case 'pgsql':
					return new PDO('pgsql:host=localhost;port=5432;dbname=vrhr_siasbo_v2', 'posgres', '');
					break;*/
			}
		} catch (PDOException $e) {
			return json_encode(array('res' => 0, 'id' => 0, 'accion' => '', 'message' => $e->getMessage()));
		}
	}

	private function cerrarConexion($conexion) {
		$conexion = null;
	}

	public function listarRegistros() {
		try {
			$conexion = $this->abrirConexion();
            $resultado = $conexion->query('SELECT itemId, nombre, estado from tipo_direccion_linea_base');
            $cantidadRegistros = $resultado->rowCount();
            $almacenDatos = array();
            foreach ($resultado as $dato) {
                $almacenDatos[] = array('Actions' => $dato['itemId'], 'itemId' => $dato['itemId'], 'nombre' => $dato['nombre'], 'estado' => $dato['estado']);
            }
            $resultado = null;
            $this->cerrarConexion($conexion);
            return array('draw' => 0, 'recordsTotal' => $cantidadRegistros, 'recordsFiltered' => $cantidadRegistros, 'data' => $almacenDatos);
        } catch (PDOException $e) {
            return array('res' => 2, 'id' => 0, 'accion' => '', 'message' => $e->getMessage());
        }
	}

	public function crearRegistro($datos, $accion) {
		try {
			$conexion = $this->abrirConexion();
			$conexion->beginTransaction();
			$transaccion = $conexion->prepare("INSERT INTO tipo_direccion_linea_base (nombre, estado) VALUES (:nombre, :estado)");
			$transaccion->bindParam(':nombre', $datos['nombre']);
			$transaccion->bindParam(':estado', $datos['estado']);
			$transaccion->execute();
			$ultimoId = $conexion->lastInsertId();
			$conexion->commit();
            $cantidadRegistros = $transaccion->rowCount();
            $this->cerrarConexion($conexion);
            return array('res' => 1, 'id' => $ultimoId, 'accion' => $accion);
        } catch (PDOException $e) {
        	$conexion->rollback(); 
            return array('res' => 2, 'id' => 0, 'accion' => $accion, 'message' => $e->getMessage());
        }
	}

	public function actualizarRegistro($datos, $accion, $id) {
		try {
			$conexion = $this->abrirConexion();
			$conexion->beginTransaction();
			$transaccion = $conexion->prepare("UPDATE tipo_direccion_linea_base SET nombre=:nombre, estado=:estado WHERE itemId=:itemId LIMIT 1");
			$transaccion->bindParam(':nombre', $datos['nombre']);
			$transaccion->bindParam(':estado', $datos['estado']);
			$transaccion->bindParam(':itemId', $id);
			$transaccion->execute();
			$conexion->commit();
            $cantidadRegistros = $transaccion->rowCount();
            $this->cerrarConexion($conexion);
            return array('res' => 1, 'id' => $id, 'accion' => $accion);
        } catch (PDOException $e) {
        	$conexion->rollback(); 
            return array('res' => 2, 'id' => 0, 'accion' => $accion, 'message' => $e->getMessage());
        }
	}

	public function eliminarRegistro($accion, $id) {
		try {
			$conexion = $this->abrirConexion();
			$conexion->beginTransaction();
			$transaccion = $conexion->prepare("DELETE FROM tipo_direccion_linea_base WHERE itemId=:itemId LIMIT 1");
			$transaccion->bindParam(':itemId', $id);
			$transaccion->execute();
			$conexion->commit();
            $cantidadRegistros = $transaccion->rowCount();
            $this->cerrarConexion($conexion);
            return array('res' => 1, 'id' => $id, 'accion' => $accion);
        } catch (PDOException $e) {
        	$conexion->rollback(); 
            return array('res' => 2, 'id' => 0, 'accion' => $accion, 'message' => $e->getMessage());
        }
	}

	public function desactivarRegistro($accion, $id) {
		try {
			$conexion = $this->abrirConexion();
			$conexion->beginTransaction();
			$transaccion = $conexion->prepare("UPDATE tipo_direccion_linea_base SET estado='INACTIVO' WHERE itemId=:itemId LIMIT 1");
			$transaccion->bindParam(':itemId', $id);
			$transaccion->execute();
			$conexion->commit();
            $cantidadRegistros = $transaccion->rowCount();
            $this->cerrarConexion($conexion);
            return array('res' => 1, 'id' => $id, 'accion' => $accion);
        } catch (PDOException $e) {
        	$conexion->rollback(); 
            return array('res' => 2, 'id' => 0, 'accion' => $accion, 'message' => $e->getMessage());
        }
	}

}