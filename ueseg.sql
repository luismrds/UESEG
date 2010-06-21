
DROP TABLE oferta_de_trabajo;
DROP TYPE oferta_de_trabajo_t;

DROP TABLE organizacion;
DROP TYPE organizacion_t;

DROP TYPE telefono_t;
DROP TYPE email_t;
DROP TYPE pagina_web_t;

DROP TYPE direccion_table_t;

DROP TYPE direccion_t;



CREATE  TYPE direccion_t AS OBJECT(
	zona VARCHAR2(20),
	calle VARCHAR2(20),
	edificio VARCHAR2(20),
	oficina VARCHAR2(20)
);
/

CREATE TYPE direccion_table_t AS TABLE OF direccion_t;
/

CREATE TYPE telefono_t AS VARRAY(10) OF VARCHAR2(15);
/

CREATE TYPE email_t AS VARRAY(10) OF VARCHAR(15);
/

CREATE TYPE pagina_web_t AS VARRAY(10) OF VARCHAR(15);
/

CREATE TYPE organizacion_t AS OBJECT(
	nombre VARCHAR2(20),
	fecha_creacion DATE,
	cantidad_empleados NUMBER,
	direccion direccion_table_t,
	telefono telefono_t,
	email email_t,
	pagina_web pagina_web_t,
	tipo VARCHAR2(20)
);
/

CREATE TYPE oferta_de_trabajo_t AS OBJECT(
	cargo VARCHAR2(20),
	salario NUMBER,
	duracion NUMBER,
	tipo VARCHAR2(20),
	contenido VARCHAR2(200),
	pertenece_a REF organizacion_t
);
/

CREATE TYPE ciudad_t AS OBJECT(
	ciudad VARCHAR2(32),
	estado VARCHAR2(32),
	pais VARCHAR2(32)
);
/

REM
REM Tipo creado por ahora solo para modelar las ocupaciones de padres y madres. Luego para los empleos de los egresados. 
REM

CREATE TYPE empleo_t AS OBJECT(
	cargo VARCHAR2(32),
	fecha_inicio DATE,
	fecha_fin DATE,
	area VARCHAR2(32)

);

CREATE TYPE egresado_t AS OBJECT(
	nombres VARCHAR2(64),
	apellidos VARCHAR2(64),
	nacimiento DATE,
	estado_civil VARCHAR2(32),
	procedencia_padre REF ciudad_t;
	procedencia_madre REF ciudad_t;
	ocupacion_padre REF empelo_t; 
	ocupacion_madre REF empleo_t;
	rem no se si hay que hacer ademas de esto varrays o algo asi porq creo q las ocupaciones son multivaluados. 
	telefono REF telefono_t;
	email REF email_t;
	
);

CREATE TYPE sede_t AS OBJECT(
	nombre VARCHAR2(32),
	ubicacion REF direccion_t,
	numero_estudiantes NUMBER,
	fecha_fundacion DATE
);

CREATE TYPE carrera_t AS OBJECT(
	nombre VARCHAR2(32),
	numero_estudiantes NUMBER
);

REM
REM Tabla que implementa la relacion "estudia". Son referencias a cada uno de los objetos que menciona. 
REM

CREATE TABLE ESTUDIA(
	egresado REF egresado_t,
	sede REF sede_t,
	carrera REF carrera_t
);

REM
REM CREACION DE TABLAS
REM

CREATE TABLE organizacion OF organizacion_t NESTED TABLE direccion STORE AS direccion_org
/

CREATE TABLE oferta_de_trabajo OF oferta_de_trabajo_t(
	CONSTRAINT fk_pertenece_a_oferta_org
	FOREIGN KEY (pertenece_a)
	REFERENCES organizacion
)
/
