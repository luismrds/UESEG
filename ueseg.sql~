
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
