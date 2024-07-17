-- DROP DATABASE IF EXISTS psdb_json;
-- create database psdb_json;

use psdb_json;

DROP TABLE IF EXISTS metadata_general;
create table metadata_general(
	isolate_id INT NOT NULL AUTO_INCREMENT,
	isolate_name VARCHAR(50) UNIQUE,
    isolate_project_id VARCHAR(50) UNIQUE,
    species VARCHAR(255),
    project_name VARCHAR(255),
	isolation_day int,
	isolation_month int,
	isolation_year  int,
	isolation_date  date,
    isolate_source VARCHAR(255),
    isolate_comments VARCHAR(255),
	# parental_id INT,
    
	/* Table restrictions */    
    PRIMARY KEY(isolate_id)
);

-- ALTER TABLE metadata_general
-- MODIFY COLUMN isolate_name VARCHAR(50) UNIQUE;

-- ALTER TABLE metadata_general
-- RENAME COLUMN isolate_project_idauth_user TO isolate_project_id;

# Comprobar que esto se hace aqui y no en INSERT INTO, ¿hace falta crear la variable antes y luego update o se hace update directo?
# UPDATE metadata_general SET isolate_project_id = CONCAT(isolate_name, '-', project_name);

DROP TABLE IF EXISTS hospital;
create table hospital(
	hospital_id INT NOT NULL AUTO_INCREMENT,
	hospital_name VARCHAR(255),
	hospital_code VARCHAR(255), # ¿Es mejor cambiar el tipo de dato a INT o CHAR, dependiendo del formato del código?
	hospital_comments VARCHAR(255),    
    country VARCHAR(255),
    region VARCHAR(255),
    town VARCHAR(255),

	/* Table restrictions */    
    PRIMARY KEY(hospital_id)
);

DROP TABLE IF EXISTS sample_type;
create table sample_type(
	sample_type_id INT NOT NULL AUTO_INCREMENT,
	sample VARCHAR(255),
    
	/* Table restrictions */    
    PRIMARY KEY(sample_type_id)
);

DROP TABLE IF EXISTS metadata_clinic;
create table metadata_clinic(
	clinic_id INT NOT NULL AUTO_INCREMENT,
	isolate_id INT UNIQUE,
	patient_id VARCHAR(255),
    sample_type VARCHAR(255),
    hospital INT,
    collection_ward VARCHAR(255),
    
	/* Table restrictions */
    PRIMARY KEY(clinic_id),
    FOREIGN KEY(isolate_id) REFERENCES metadata_general(isolate_id),
    FOREIGN KEY(hospital) REFERENCES hospital(hospital_id)    
);

-- ALTER TABLE metadata_clinico
-- ADD COLUMN aislado_id INT UNIQUE;

-- ALTER TABLE metadata_clinico
-- MODIFY COLUMN hospital INT;

DROP TABLE IF EXISTS sequence_analysis;
create table sequence_analysis(
	sequence_analysis_id INT NOT NULL AUTO_INCREMENT,
    isolate_id INT UNIQUE,
	mlst_allelic_profile JSON,
    sequence_type VARCHAR(10),
    #Se pueden cambiar las adquiridas a formato JSON también, ¿son siempre los mismos tipos (betalactamasas y aminog) o puede haber más?
    clonal_complex VARCHAR(10),
    mutational_resistome JSON,
	acquired_resistome JSON,
    virulence_genes JSON,
    hypermutation_genes JSON,
    insilico_serotype VARCHAR(3),
    betalactamase_pcr JSON,
    ame_loci VARCHAR(500),
    beta_lactamase_loci varchar(500),
    carbapenemase_loci varchar(500),
    other_acq_ab_loci varchar(500),
    
	/* Table restrictions */
    PRIMARY KEY(sequence_analysis_id),
    FOREIGN KEY(isolate_id) REFERENCES metadata_general(isolate_id)
);

DROP TABLE IF EXISTS sequencing_platform;
create table sequencing_platform(
	sequencing_platform_id INT NOT NULL AUTO_INCREMENT,
	sequencing_platform_name VARCHAR(255),
	sequencing_platform_supplier VARCHAR(255),
    
 	/* Table restrictions */
    PRIMARY KEY(sequencing_platform_id)
);

DROP TABLE IF EXISTS sequencing_technology;
create table sequencing_technology(
	sequencing_technology_id INT NOT NULL AUTO_INCREMENT,
	sequencing_technology_name VARCHAR(255),
    reads_type VARCHAR(255),
    
 	/* Table restrictions */
    PRIMARY KEY(sequencing_technology_id)
);

DROP TABLE IF EXISTS sequencing_library;
create table sequencing_library(
	sequencing_library_id INT NOT NULL AUTO_INCREMENT,
	sequencing_library_method VARCHAR(255),

 	/* Table restrictions */
    PRIMARY KEY(sequencing_library_id)
);

DROP TABLE IF EXISTS flowcell_kit;
create table flowcell_kit(
	flowcell_kit_id INT NOT NULL AUTO_INCREMENT,
	flowcell_kit_name VARCHAR(255),

 	/* Table restrictions */
    PRIMARY KEY(flowcell_kit_id)
);

/*ALTER TABLE locus_hipermutacion
MODIFY locus VARCHAR(20);*/

DROP TABLE IF EXISTS mutational_resistome;
create table mutational_resistome(
	mutational_resistome_id INT NOT NULL AUTO_INCREMENT,
	locus VARCHAR(20) UNIQUE,
    official_name VARCHAR(6),
    synonym_name VARCHAR(255),
    pbp_name VARCHAR(6),
    species VARCHAR(100),
    
 	/* Table restrictions */
    PRIMARY KEY(mutational_resistome_id)
);

DROP TABLE IF EXISTS acquired_resistome;
create table acquired_resistome(
	acquired_resistome_id INT NOT NULL AUTO_INCREMENT,
	acquired_gene_name VARCHAR(20),
    gene_type VARCHAR(100),
    
 	/* Table restrictions */
    PRIMARY KEY(acquired_resistome_id)
);

DROP TABLE IF EXISTS locus_mlst;
create table locus_mlst(
	mlst_id INT NOT NULL AUTO_INCREMENT,
	locus VARCHAR(20) UNIQUE,
    official_name VARCHAR(6),
    synonym_name VARCHAR(255),
    species VARCHAR(100),
    
 	/* Table restrictions */
    PRIMARY KEY(mlst_id)
);

DROP TABLE IF EXISTS virulence_gene;
create table virulence_gene(
	virulence_gene_id INT NOT NULL AUTO_INCREMENT,
	locus VARCHAR(20) UNIQUE,
    official_name VARCHAR(6),
    synonym_name VARCHAR(255),
    species VARCHAR(100),
    
 	/* Table restrictions */
    PRIMARY KEY(virulence_gene_id)
);

DROP TABLE IF EXISTS hypermutation_gene;
create table hypermutation_gene(
	hypermutation_gene_id INT NOT NULL AUTO_INCREMENT,
	locus VARCHAR(20) UNIQUE,
    official_name VARCHAR(6),
    synonym_name VARCHAR(255),
    species VARCHAR(100),
    
 	/* Table restrictions */
    PRIMARY KEY(hypermutation_gene_id)
);

DROP TABLE IF EXISTS sequencing_info;
create table sequencing_info(
	sequencing_id INT NOT NULL AUTO_INCREMENT,
	isolate_id INT UNIQUE,
	sequencing_technology INT,
	sequencing_platform INT,
    flowcell_kit INT,
	sequencing_goal VARCHAR(100),
	sequencing_source VARCHAR(100),
	library_method INT,
    
 	/* Table restrictions */
    PRIMARY KEY(sequencing_id),
    FOREIGN KEY(isolate_id) REFERENCES metadata_general(isolate_id),
    FOREIGN KEY(sequencing_technology) REFERENCES sequencing_technology(sequencing_technology_id),
    FOREIGN KEY(sequencing_platform) REFERENCES sequencing_platform(sequencing_platform_id),
    FOREIGN KEY(library_method) REFERENCES sequencing_library(sequencing_library_id),
	FOREIGN KEY(flowcell_kit) REFERENCES flowcell_kit(flowcell_kit_id)
);

DROP TABLE IF EXISTS assembler;
create table assembler(
	assembler_id INT NOT NULL AUTO_INCREMENT,
	assembler_name VARCHAR(100),
    
 	/* Table restrictions */
    PRIMARY KEY(assembler_id)
);

DROP TABLE IF EXISTS file_path;
create table file_path(
	file_path_id INT NOT NULL AUTO_INCREMENT,
	isolate_id INT UNIQUE,
	fastq_path VARCHAR(255),
	denovo_assembly_path VARCHAR(255),
	assembler INT,
    
 	/* Table restrictions */
    PRIMARY KEY(file_path_id),
    FOREIGN KEY(isolate_id) REFERENCES metadata_general(isolate_id),
	FOREIGN KEY(assembler) REFERENCES assembler(assembler_id)
);

DROP TABLE IF EXISTS invitro_serotype;
create table invitro_serotype(
	invitro_serotype_id INT NOT NULL AUTO_INCREMENT,
    invitro_value VARCHAR(20),
    
 	/* Table restrictions */
    PRIMARY KEY(invitro_serotype_id)
);

DROP TABLE IF EXISTS mic;
create table mic(
	mic_id INT NOT NULL AUTO_INCREMENT,
	isolate_id INT UNIQUE,
# mic_fecha DATE, ¿Esta variable al final va a hacer falta?
    pip VARCHAR(10),
    pip_clinical_category VARCHAR(2),
    pip_tz VARCHAR(10),
	pip_tz_clinical_category VARCHAR(2),
    fep VARCHAR(10),
	fep_clinical_category VARCHAR(2),
    cfdc VARCHAR(10),
    cfdc_clinical_category VARCHAR(2),
    caz VARCHAR(10),
    caz_clinical_category VARCHAR(2),
    caz_avi VARCHAR(10),
    caz_avi_clinical_category VARCHAR(2),
    ct VARCHAR(10),
    ct_clinical_category VARCHAR(2),
    imi VARCHAR(10),
    imi_clinical_category VARCHAR(2),
    imi_rel VARCHAR(10),
    imi_rel_clinical_category VARCHAR(2),
    mer VARCHAR(10),
    mer_clinical_category VARCHAR(2),
    mer_vab VARCHAR(10),
    mer_vab_clinical_category VARCHAR(2),
    azt VARCHAR(10),
    azt_clinical_category VARCHAR(2),
    azt_avi VARCHAR(10),
    azt_avi_clinical_category VARCHAR(2),
    cip VARCHAR(10),
    cip_clinical_category VARCHAR(2),
    dlx VARCHAR(10),
    dlx_clinical_category VARCHAR(2),
    lvx VARCHAR(10),
    lvx_clinical_category VARCHAR(2),
    mxl VARCHAR(10),
    mxl_clinical_category VARCHAR(2),
    ami VARCHAR(10),
    ami_clinical_category VARCHAR(2),
    gen VARCHAR(10),
    gen_clinical_category VARCHAR(2),
    net VARCHAR(10),
    net_clinical_category VARCHAR(2),
    tob VARCHAR(10),
    tob_clinical_category VARCHAR(2),
    col VARCHAR(10),
    col_clinical_category VARCHAR(2),
    fo VARCHAR(10),
    fo_clinical_category VARCHAR(2),
	tic VARCHAR(10),
    tic_clinical_category VARCHAR(2),
    ptz VARCHAR(10),
    ptz_clinical_category VARCHAR(2),
    taz VARCHAR(10),
    taz_clinical_category VARCHAR(2),
    cza VARCHAR(10),
    cza_clinical_category VARCHAR(2),
    tol VARCHAR(10),
    tol_clinical_category VARCHAR(2),
    atm VARCHAR(10),
    atm_clinical_category VARCHAR(2),
--     fep_zid VARCHAR(10), Cefepime/Zidebactam???
--     fep_??? VARCHAR(10), Cefepime/Tamibactam???
--     azt_avi VARCHAR(10), Aztreonam/Avibactam???
    caz_cloxa VARCHAR(3),
    imi_cloxa VARCHAR(3),
    mic_comments VARCHAR(255),
    
	/* Table restrictions */
    PRIMARY KEY(mic_id),
	FOREIGN KEY(isolate_id) REFERENCES metadata_general(isolate_id)
);

DROP TABLE IF EXISTS phenotypic_data;
create table phenotypic_data(
	phenotypic_data_id INT NOT NULL AUTO_INCREMENT,
	isolate_id INT UNIQUE,
	ab_susceptibility_method VARCHAR(100),
    mic_id INT,
    ecdc_resistance_profile VARCHAR(3),
    idsa_resistance_profile VARCHAR(3),
    cloxa_test VARCHAR(3),
    mbl_test VARCHAR(3),
    esbl_test VARCHAR(3),
    class_a_carbapenemase_test VARCHAR(3),
    invitro_serotype_id INT,
    hypermutator_phenotype VARCHAR(15),
# cat_clinica VARCHAR(3),
# cevs INT,
# virulencia_galleria INT,
    
	/* Table restrictions */
    PRIMARY KEY(phenotypic_data_id),
	FOREIGN KEY(isolate_id) REFERENCES metadata_general(isolate_id),
	FOREIGN KEY(mic_id) REFERENCES mic(mic_id),
	FOREIGN KEY(invitro_serotype_id) REFERENCES invitro_serotype(invitro_serotype_id)    
);

-- ALTER TABLE fenotipo
-- MODIFY serotipo_invitro VARCHAR(60);