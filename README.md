# TastyBite Restaurant Management System

**Proyecto Final de Evaluación Cátedra de Programación II**
**Carrera:** Perito en Informática
**Sección:** IN4CM  
**Centro Educativo Técnico Laboral Kinal** ---

## 1. Información del Estudiante y Entrega

| Dato | Detalle |
| :--- | :--- |
| **Estudiante** | Andrés Edoardo Aquino López |
| **Código Académico / Carné** | 2023534 |
| **Enunciado Asignado** | #8 - Pedidos Restaurante TastyBite |
| **Versión de Release** | `v1.0.0` |
| **Arquitectura Principal** | MVC + DAO + SessionContext Singleton |
| **Base de Datos** | MySQL 8.0 (Engine InnoDB) |

---

## 2. Descripción General del Sistema

**TastyBite** es un sistema integral de gestión transaccional y control de comandas en tiempo 
real diseñado para optimizar el flujo operativo en restaurantes de alta demanda. El sistema 
resuelve la desacople entre la toma de orden en mesa, la preparación en cocina y la facturación 
en caja, ofreciendo trazabilidad completa por rol y un cálculo automatizado de impuestos y propinas 
sugeridas.

---

## 3. Arquitectura del Sistema y Patrones de Diseño

El desarrollo del software fue construido siguiendo una arquitectura multicapa altamente desacoplada 
y basada en estándares de la industria Java Enterprise:

```text
                  +--------------------------------+
                  |   Capa Vista (JavaFX / FXML)   |
                  +---------------+----------------+
                                  |
                                  v
                  +--------------------------------+
                  |  Capa Controladores (Events)  |
                  +---------------+----------------+
                                  |
                                  v
                  +--------------------------------+
                  |    Capa DAO (Interfaces)       |
                  +---------------+----------------+
                                  |
                                  v
                  +--------------------------------+
                  |  Base de Datos (MySQL SPs)     |
                  +--------------------------------+

 Patrones Implementados:Model-View-Controller (MVC): Separa la interfaz gráfica (.fxml) de la lógica 
de negocio.Data Access Object (DAO): Aísla la persistencia de datos mediante interfaces e implementaciones 
con CallableStatement.Singleton Pattern:Conexion.java: Garantiza una única instancia del pool de conexión a 
MySQL.SessionContext.java: Administra la sesión activa del usuario y permisos por rol.Stored Procedures 
Pattern: Encapsulamiento total de operaciones en la base de datos sin SQL directo en Java.

## 4. Módulos y Roles de Usuario

El sistema cuenta con control de acceso basado en roles (RBAC):
Mesero: Apertura de mesas, selección de menú, adición de observaciones por platillo e inserción de comandas a cocina.

Cocinero: Monitor de pedidos en tiempo real ordenados por antigüedad (FIFO) y cambio de estados (PENDIENTE -> EN_PREPARACION -> LISTO).

Cajero: Consulta de comandas listadas, cierre de mesa, cálculo automático de subtotal, IVA (12%) y propina sugerida (10%), registrando la factura final.

 Administrador: Gestión global del sistema y usuarios.


## 5. Modelo Entidad-Relación (Base de Datos)La base de datos tastybite_db se encuentra normalizada en Tercera Forma Normal (3FN):Plaintext[ROL] 1---N 
[USUARIO] 1---N [PEDIDO] 1---N [DETALLE_PEDIDO] N---1 [PLATILLO] N---1 [CATEGORIA]
                               |
                               +---1 [MESA]
                               |
                               +---1 [FACTURA]
Tablas Principales:rol / usuariomesa / categoria / platillopedido / detalle_pedidofactura

 ## 6. Tecnologías y HerramientasLenguaje: 
Java 17 / OpenJFX 21
Motor de BD: MySQL Community Server 8.0
Conector: mysql-connector-j-8.x
IDE: Apache NetBeans 19+
Control de Versiones: Git / GitHub (GitFlow)

 ## 7. Guía de Instalación y Despliegue Local
Requisitos Previos:
MySQL Server 8.0 y MySQL Workbench instalados.
JDK 17 o superior configurado.
Apache NetBeans IDE.
     
      Paso 1: Clonar el RepositorioBashgit clone [https://github.com/aqinon-15/TastyBite_AndresAquino.git](https://github.com/aqinon-15/TastyBite_AndresAquino.git)
cd TastyBite_AndresAquino
      Paso 2: Restaurar la Base de DatosEjecuta en MySQL Workbench los scripts ubicados dentro de la carpeta /sql en el siguiente orden:
         sql/01_ddl_tables.sql
         sql/02_stored_procedures.
         sqlsql/03_seeders.sql

      Paso 3: Configurar Credenciales de BDVerifica que las credenciales en org.ae.util.Conexion.java coincidan con tu servidor MySQL:
         private static final String URL = "jdbc:mysql://localhost:3306/tastybite_db?useSSL=false&serverTimezone=UTC";
         private static final String USER = "root";
         private static final String PASSWORD = "tu_password";

      Paso 4: Compilar y EjecutarEn NetBeans, presiona Clean and Build (Shift + F11) y ejecuta la clase system.Main.

## 8. Credenciales de Prueba (Seeders)
Rol            Usuario         Contraseña     nombre del empleado    Permisos
Mesero         mesero1            12345           Carlos Gomez        Apertura de mesas, selección de menú y envío de comandas a cocina. 
Mesero         mesero2            12345          Luis Fernandez       Apertura de mesas, selección de menú y envío de comandas a cocina.
Cocinero       cocina1            12345          Ana Martinez         Monitor de comandas en tiempo real (FIFO) y cambio de estados. 
Cajero         cajero1            12345          Mario Lopez          Cierre de mesa, cálculo de IVA/propina y emisión de factura.
Administrador  admin            admin123        Andres Aquino         Acceso global y administración del sistema. 


## 9. Licencia y Derechos de AutorDesarrollado para la evaluación académica del curso de Taller I (IN4CM) en Fundación Kinal. Todos los derechos reservados para fines educativos.

## 10. enlace de video del proyecto final
https://youtu.be/Pu50tm4R_fk