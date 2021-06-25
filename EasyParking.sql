CREATE TABLE athority (
	name varchar(50) NOT NULL,
	PRIMARY KEY (name)
);

CREATE TABLE user_authority (
	name_rol varchar(50) NOT NULL,
	id_system_user int4 NOT NULL,
	PRIMARY KEY (name_rol, id_system_user)
);

CREATE TABLE "system_user" (
	id SERIAL NOT NULL,
	login varchar(50) NOT NULL UNIQUE,
	password varchar(60) NOT NULL,
	email varchar(254) NOT NULL UNIQUE, 
	activated int4, 
	lang_key varchar(6) NOT NULL,
	image_url varchar(256),
	activation_key varchar(20),
	reset_ket varchar(20), 
	reset_date timestamp,
	PRIMARY KEY (id), 
	CONSTRAINT uk_system_user UNIQUE (login, email)
);

CREATE TABLE empleado (
	id SERIAL NOT NULL, 
	id_system_user int4 NOT NULL UNIQUE,
	id_tipo_documento int4 NOT NULL UNIQUE,
	numero_documento varchar(50) NOT NULL UNIQUE,
	primer_nombre varchar(50) NOT NULL,
	segundo_nombre varchar(50),
	primer_apellido varchar(50) NOT NULL, 
	segundo_apellido varchar(50),
	telefono int4 NOT NULL,
	rh varchar(10), 
	cargo varchar(50) NOT NULL,
	PRIMARY KEY (id),
	CONSTRAINT uk_empleado UNIQUE (id_system_user, id_tipo_documento, numero_documento)
);

CREATE TABLE tipo_documento (
	id SERIAL NOT NULL, 
	sigla varchar(50) NOT NULL UNIQUE,
	nombre_documento varchar(50) NOT NULL,
	estado varchar(50) NOT NULL,
	PRIMARY KEY (id), 
	CONSTRAINT uk_tipo_documento UNIQUE (sigla)
);

CREATE TABLE vehiculo (
	id SERIAL NOT NULL,
	numero_placa int4 NOT NULL,
	color varchar(50) NOT NULL,
	marca varchar(50) NOT NULL,
	id_empleado int4 NOT NULL UNIQUE,
	id_ticket int4 NOT NULL, 
	PRIMARY KEY (id), 
	CONSTRAINT uk_vehiculo UNIQUE (id_empleado)
);

CREATE TABLE tarifa (
	id SERIAL NOT NULL,
	tipo_vehiculo varchar(50) NOT NULL UNIQUE,
	tarifa_tipo_vehiculo int4 NOT NULL,
	PRIMARY KEY (id),
	CONSTRAINT uk_tarifa UNIQUE (tipo_vehiculo)
);

CREATE TABLE reporte (
	id SERIAL NOT NULL,
	numero_reporte varchar(50) NOT NULL UNIQUE,
	fecha timestamp NOT NULL,
	id_empleado int4 NOT NULL UNIQUE,
	id_vehiculo int4 NOT NULL UNIQUE,
	PRIMARY KEY (id), 
	CONSTRAINT uk_reporte UNIQUE (numero_reporte, id_empleado, id_vehiculo)
);

CREATE TABLE ticket (
	id SERIAL NOT NULL,
	numero_ticket int4 NOT NULL UNIQUE,
	fecha timestamp NOT NULL, 
	hora_ingreso time(10) NOT NULL, 
	hora_salida time(10) NOT NULL, 
	valor_final int4 NOT NULL, 
	id_tarifa int4 NOT NULL, 
	PRIMARY KEY (id), 
	CONSTRAINT uk_ticket UNIQUE (numero_ticket)
);

ALTER TABLE user_authority ADD CONSTRAINT fk_auth_usau FOREIGN KEY (name_rol) REFERENCES athority (name);
ALTER TABLE user_authority ADD CONSTRAINT fk_syus_usau FOREIGN KEY (id_system_user) REFERENCES "system_user" (id);
ALTER TABLE empleado ADD CONSTRAINT fk_syus_empl FOREIGN KEY (id_system_user) REFERENCES "system_user" (id);
ALTER TABLE empleado ADD CONSTRAINT fk_tido_empl FOREIGN KEY (id_tipo_documento) REFERENCES tipo_documento (id);
ALTER TABLE vehiculo ADD CONSTRAINT fk_empl_vehi FOREIGN KEY (id_empleado) REFERENCES empleado (id);
ALTER TABLE reporte ADD CONSTRAINT fk_empl_repo FOREIGN KEY (id_empleado) REFERENCES empleado (id);
ALTER TABLE reporte ADD CONSTRAINT fk_vehi_repo FOREIGN KEY (id_vehiculo) REFERENCES vehiculo (id);
ALTER TABLE ticket ADD CONSTRAINT fk_tari_tick FOREIGN KEY (id_tarifa) REFERENCES tarifa (id);
ALTER TABLE vehiculo ADD CONSTRAINT fk_tick_vehi FOREIGN KEY (id_ticket) REFERENCES ticket (id);
