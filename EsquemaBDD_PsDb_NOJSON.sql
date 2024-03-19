DROP DATABASE IF EXISTS psdb;
create database psdb;

use psdb;

DROP TABLE IF EXISTS hospital;
create table hospital(
	hospital_id INT NOT NULL AUTO_INCREMENT,
	hospital_nombre VARCHAR(255),
    pais VARCHAR(255),
    region VARCHAR(255),
    localidad VARCHAR(255),
	/* Table restrictions */    
    PRIMARY KEY(hospital_id)
);

DROP TABLE IF EXISTS resistoma;
create table resistoma(
	resistoma_id INT NOT NULL AUTO_INCREMENT,
	resistoma_fecha date,
    #Se pueden cambiar las adquiridas a formato JSON también, ¿son siempre los mismos tipos (betalactamasas y aminog) o puede haber más?
    betalac_adquiridas VARCHAR(255),
    aminog_adquiridas VARCHAR(255),
	otras_adquiridas VARCHAR(255),
    resistoma_observaciones VARCHAR(255),
	/* Table restrictions */
    PRIMARY KEY(resistoma_id)
);

DROP TABLE IF EXISTS nombrelocus;
create table nombrelocus(
	nombrelocus_id INT NOT NULL AUTO_INCREMENT,
    nombre_locus VARCHAR(10),
    tipo_funcion VARCHAR(10),
    tipo_pbp VARCHAR(10),
    PRIMARY KEY(nombreLocus_id)
);

DROP TABLE IF EXISTS locus;
create table locus(
	locus_id INT NOT NULL AUTO_INCREMENT,
    PRIMARY KEY(locus_id)
);

DROP TABLE IF EXISTS mutacion;
create table mutacion(
	mutacion_id INT NOT NULL AUTO_INCREMENT,
    PRIMARY KEY(mutacion_id)
);

DROP TABLE IF EXISTS invitro;
create table invitro(
	invitro_id INT NOT NULL AUTO_INCREMENT,
	serotipo VARCHAR(255),
	serotipo_insilico VARCHAR(5),
	maldi VARCHAR(50),
	maldi_observaciones VARCHAR(255),
	pulsado VARCHAR(20),
	pulsado_observaciones VARCHAR(255),
	cloxa_paer VARCHAR(3),
	cloxa_paer_observaciones VARCHAR(255),
	mbl_test VARCHAR(5),
	blee_test VARCHAR(5),
	pcr_multi VARCHAR(255),
	pcr_vim1 VARCHAR(5),
	pcr_vim2 VARCHAR(5),
	pcr_oxa VARCHAR(5),    
	pcr_blee VARCHAR(5),    
	pcr_infer VARCHAR(5),
	pcr_otras VARCHAR(255),
	/* Table restrictions */
    PRIMARY KEY(invitro_id)
);

DROP TABLE IF EXISTS insilico;
create table insilico(
	insilico_id INT NOT NULL AUTO_INCREMENT,
	wgs_fecha DATE,
	wgs_tech VARCHAR(255),
	mlst_insilico VARCHAR(7),
	mlst_inferido VARCHAR(7),
    #¿Qué codifica esta variable EMA?
	ema VARCHAR(255),
    betalactamasa_otras VARCHAR(255),
    carbapenemasa_otras VARCHAR(255),
    ab_otros VARCHAR(255),
	/* Table restrictions */
    PRIMARY KEY(insilico_id)
);

DROP TABLE IF EXISTS archivos;
create table archivos(
	archivos_id INT NOT NULL AUTO_INCREMENT,
    fastq VARCHAR(255),
    variant_calling VARCHAR(255),
    snps VARCHAR(255),
    pileup VARCHAR(255),
	/* Table restrictions */
    PRIMARY KEY(archivos_id)
);

DROP TABLE IF EXISTS summary;
create table summary(
	aislado_id INT NOT NULL AUTO_INCREMENT,
    aislado_nombre CHAR(50),
    #Nº de cepa, ej.: 15, 41, 90, 102, ... --> RESULTADOS UNIFICADOS GEMARA_última vEBT11 febrero2019.xls
	cepa_id INT,
    #ST
    clon_id CHAR(7),
    hospital_id INT,
    servicio_obtencion CHAR(255),
    tipo_muestra CHAR(255),
    resistoma_id INT,
    invitro_id INT,
    insilico_id INT,
	archivos_id INT,
	/* Table restrictions */    
    PRIMARY KEY(aislado_id),
	FOREIGN KEY(hospital_id) REFERENCES hospital(hospital_id),
 	FOREIGN KEY(resistoma_id) REFERENCES resistoma(resistoma_id),
	FOREIGN KEY(invitro_id) REFERENCES invitro(invitro_id),
	FOREIGN KEY(insilico_id) REFERENCES insilico(insilico_id),
   	FOREIGN KEY(archivos_id) REFERENCES archivos(archivos_id)
);

DROP TABLE IF EXISTS mic;
create table mic(
	mic_id INT NOT NULL AUTO_INCREMENT,
	aislado_id INT,
	mic_tipo VARCHAR(255),
	mic_fecha DATE,
	tic VARCHAR(10),
    ptz VARCHAR(10),
    azt VARCHAR(10),
    taz VARCHAR(10),
    ct VARCHAR(10),
    cza VARCHAR(10),
    fep VARCHAR(10),
    cip VARCHAR(10),
    ami VARCHAR(10),
    tob VARCHAR(10),
    imi VARCHAR(10),
    mer VARCHAR(10),
    col VARCHAR(10),
    pip VARCHAR(10),
    caz VARCHAR(10),
    tol VARCHAR(10),
    atm VARCHAR(10),
    caz_cloxa VARCHAR(3),
    imi_cloxa VARCHAR(3),
    mic_observaciones VARCHAR(255),
	/* Table restrictions */
    PRIMARY KEY(mic_id),
	FOREIGN KEY(aislado_id) REFERENCES summary(aislado_id)
);
