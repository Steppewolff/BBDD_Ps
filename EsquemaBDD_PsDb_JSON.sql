DROP DATABASE IF EXISTS psdb_json;
create database psdb_json;

use psdb_json;

DROP TABLE IF EXISTS metadata_general;
create table metadata_general(
	aislado_id INT NOT NULL AUTO_INCREMENT,
	aislado_nombre VARCHAR(50),
    aislado_exportar_id VARCHAR(50) UNIQUE,
    #Nº de cepa, ej.: 15, 41, 90, 102, ... --> RESULTADOS UNIFICADOS GEMARA_última vEBT11 febrero2019.xls
	#cepa_id INT,
    #ST
    especie VARCHAR(255),
    nombre_proyecto VARCHAR(255),
	aislamiento_dia int,
	aislamiento_mes int,
	aislamiento_year int,
	aislamiento_fecha date,
    origen VARCHAR(255),
    observaciones VARCHAR(255),
    parental_id INT,
	/* Table restrictions */    
    PRIMARY KEY(aislado_id)
);

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

DROP TABLE IF EXISTS tipo_muestra;
create table tipo_muestra(
	tipo_muestra_id INT NOT NULL AUTO_INCREMENT,
	tipo VARCHAR(255),
	/* Table restrictions */    
    PRIMARY KEY(tipo_muestra_id)
);

DROP TABLE IF EXISTS metadata_clinico;
create table metadata_clinico(
	clinico_id INT NOT NULL AUTO_INCREMENT,
	paciente_id VARCHAR(255),
    tipo_muestra VARCHAR(255),
    hospital INT UNIQUE,
    servicio_obtencion VARCHAR(255),
	/* Table restrictions */
    PRIMARY KEY(clinico_id),
    FOREIGN KEY(hospital) REFERENCES hospital(hospital_id)
);

DROP TABLE IF EXISTS secuencia;
create table secuencia(
	secuencia_id INT NOT NULL AUTO_INCREMENT,
    aislado_id INT UNIQUE,
	perfil_mlst JSON,
    clon VARCHAR(10),
    #Se pueden cambiar las adquiridas a formato JSON también, ¿son siempre los mismos tipos (betalactamasas y aminog) o puede haber más?
    complejo_clonal VARCHAR(10),
    resistoma_mutante JSON,
	resistoma_adquirido JSON,
    genes_virulencia JSON,
    genes_hipermutacion JSON,
    serotipo_insilico VARCHAR(3),
    betalactamasas_adquiridas JSON,
	/* Table restrictions */
    PRIMARY KEY(secuencia_id),
    FOREIGN KEY(aislado_id) REFERENCES metadata_general(aislado_id)
);

DROP TABLE IF EXISTS tecnica;
create table tecnica(
	tecnica_id INT NOT NULL AUTO_INCREMENT,
	nombre VARCHAR(255),
	version VARCHAR(50),
 	/* Table restrictions */
    PRIMARY KEY(tecnica_id)
);

DROP TABLE IF EXISTS plataforma;
create table plataforma(
	plataforma_id INT NOT NULL AUTO_INCREMENT,
	nombre VARCHAR(255),
	proveedor VARCHAR(255),
 	/* Table restrictions */
    PRIMARY KEY(plataforma_id)
);

DROP TABLE IF EXISTS libreria;
create table libreria(
	libreria_id INT NOT NULL AUTO_INCREMENT,
	nombre VARCHAR(255),
 	/* Table restrictions */
    PRIMARY KEY(libreria_id)
);

DROP TABLE IF EXISTS resistoma_mutante;
create table resistoma_mut(
	resistoma_mut_id INT NOT NULL AUTO_INCREMENT,
	locus VARCHAR(6),
    tipo_funcion VARCHAR(6),
    tipo_pbp VARCHAR(6),
    especie JSON,
 	/* Table restrictions */
    PRIMARY KEY(resistoma_mut_id)
);

DROP TABLE IF EXISTS resistoma_adquirido;
create table resistoma_adq(
	resistoma_adq_id INT NOT NULL AUTO_INCREMENT,
	locus VARCHAR(6),
    tipo_funcion VARCHAR(6),
 	/* Table restrictions */
    PRIMARY KEY(resistoma_adq_id)
);

DROP TABLE IF EXISTS locus_mlst;
create table loci_mlst(
	mlst_id INT NOT NULL AUTO_INCREMENT,
	locus VARCHAR(6),
    especie JSON,
 	/* Table restrictions */
    PRIMARY KEY(mlst_id)
);

DROP TABLE IF EXISTS locus_virulencia;
create table loci_virulencia(
	virulencia_id INT NOT NULL AUTO_INCREMENT,
	locus VARCHAR(6),
    especie JSON,
 	/* Table restrictions */
    PRIMARY KEY(virulencia_id)
);

DROP TABLE IF EXISTS locus_hipermutacion;
create table loci_hipermutacion(
	hipermut_id INT NOT NULL AUTO_INCREMENT,
	locus VARCHAR(6),
    especie JSON,
 	/* Table restrictions */
    PRIMARY KEY(hipermut_id)
);

DROP TABLE IF EXISTS secuenciacion;
create table secuenciacion(
	secuenciacion_id INT NOT NULL AUTO_INCREMENT,
	aislado_id INT UNIQUE,
	tecnica_sec INT,
	plataforma_sec INT,
	motivo_sec VARCHAR(100),
	origen_sec VARCHAR(100),
	preparacion_librerias INT,
 	/* Table restrictions */
    PRIMARY KEY(secuenciacion_id),
    FOREIGN KEY(aislado_id) REFERENCES metadata_general(aislado_id),
    FOREIGN KEY(tecnica_sec) REFERENCES tecnica(tecnica_id),
    FOREIGN KEY(plataforma_sec) REFERENCES plataforma(plataforma_id),
    FOREIGN KEY(preparacion_librerias) REFERENCES libreria(libreria_id)    
);

DROP TABLE IF EXISTS archivo;
create table archivo(
	archivo_id INT NOT NULL AUTO_INCREMENT,
	aislado_id INT UNIQUE,
	fastq VARCHAR(255),
	ensamblado VARCHAR(255),
 	/* Table restrictions */
    PRIMARY KEY(archivo_id),
    FOREIGN KEY(aislado_id) REFERENCES metadata_general(aislado_id)
);

DROP TABLE IF EXISTS fenotipo;
create table fenotipo(
	fenotipo_id INT NOT NULL AUTO_INCREMENT,
	aislado_id INT UNIQUE,
	metodo_suscept VARCHAR(100),
    cmi_id VARCHAR(10),
    cat_clinica VARCHAR(3),
    perfil_ecdc VARCHAR(3),
    perfil_idsa VARCHAR(3),
    test_cloxa VARCHAR(3),
    test_mbl VARCHAR(3),
    test_blee VARCHAR(3),
    test_carba_A VARCHAR(3),
    serotipo_invitro VARCHAR(3),
    cevs INT,
    virulencia_galleria INT,
    fenot_hipermutador VARCHAR(15),
	/* Table restrictions */
    PRIMARY KEY(fenotipo_id),
	FOREIGN KEY(aislado_id) REFERENCES metadata_general(aislado_id)
);

DROP TABLE IF EXISTS mic;
create table mic(
	mic_id INT NOT NULL AUTO_INCREMENT,
	aislado_id INT UNIQUE,
	mic_fecha DATE,
    pip VARCHAR(10),
    pip_tz VARCHAR(10),
    fep VARCHAR(10),
    cfdc VARCHAR(10),
    caz VARCHAR(10),
    caz_avi VARCHAR(10),
    ct VARCHAR(10),
    imi VARCHAR(10),
    imi_rel VARCHAR(10),
    mer VARCHAR(10),
    mer_vab VARCHAR(10),
    azt VARCHAR(10),
    azt_avi VARCHAR(10),
    cip VARCHAR(10),
    dlx VARCHAR(10),
    lvx VARCHAR(10),
    mxl VARCHAR(10),
    ami VARCHAR(10),
    gen VARCHAR(10),
    net VARCHAR(10),
    tob VARCHAR(10),
    col VARCHAR(10),
    fo VARCHAR(10),
	tic VARCHAR(10),
    ptz VARCHAR(10),
    taz VARCHAR(10),
    cza VARCHAR(10),
    tol VARCHAR(10),
    atm VARCHAR(10),
    caz_cloxa VARCHAR(3),
    imi_cloxa VARCHAR(3),
    mic_observaciones VARCHAR(255),
	/* Table restrictions */
    PRIMARY KEY(mic_id),
	FOREIGN KEY(aislado_id) REFERENCES metadata_general(aislado_id)
);