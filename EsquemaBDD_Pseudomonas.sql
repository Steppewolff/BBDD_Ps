DROP DATABASE IF EXISTS psdb;
create database psdb;

use psdb;

DROP TABLE IF EXISTS summary;
create table summary(
	summary_id INT NOT NULL AUTO_INCREMENT,
    isolated_id varchar(255),
	strain_id INT,
    strain_name varchar(255),
    clone_name varchar(255),
    sequence_path varchar(255),
    PRIMARY KEY(summary_id)
);

DROP TABLE IF EXISTS phenotypes;
create table phenotypes(
	phenotypes_id INT NOT NULL AUTO_INCREMENT,
	isolated_id INT,
    serotype VARCHAR(100),
    serotype_insil VARCHAR(5),
    mic_3 INT,
    PRIMARY KEY(phenotypes_id),
	FOREIGN KEY(isolated_id) REFERENCES summary(summary_id)
);

DROP TABLE IF EXISTS genotypes;
create table genotypes(
	genotypes_id INT NOT NULL AUTO_INCREMENT,
	isolate_id INT,
    pdc INT,
    mic_cft INT,
    mic_cmax INT,
    mic_3 INT,
    PRIMARY KEY(genotypes_id),
	FOREIGN KEY(isolate_id) REFERENCES summary(summary_id)
);

DROP TABLE IF EXISTS ab_resistance;
create table ab_resistance(
	ab_resistance_id INT NOT NULL AUTO_INCREMENT,
	isolated_id INT,
    tic INT,
    tic_mod VARCHAR(2),
    pip INT,
    pip_mod VARCHAR(2),
    caz INT,
	caz_mod VARCHAR(2),
    fep INT,
    fep_mod VARCHAR(2),    
    tol INT,
    tol_mod VARCHAR(2),    
    cza INT,
    cza_mod VARCHAR(2),    
    atm INT,
    atm_mod VARCHAR(2),    
    imi INT,
    imi_mod VARCHAR(2),    
    mer INT,
    mer_mod VARCHAR(2),    
    cip INT,
    cip_mod VARCHAR(2),    
    tob INT,
    tob_mod VARCHAR(2),    
    ami INT,
    ami_mod VARCHAR(2),    
    col INT,
    col_mod VARCHAR(2), 
    /*CAZ cloxa-test*/    
    caz_cloxa INT,
    caz_cloxa_mod VARCHAR(2),   
    /*IMI cloxa-test*/        
    imi_cloxa INT,
    imi_cloxa_mod VARCHAR(2),
    /*Acquired beta-lactamases*/
    acq_betalact VARCHAR(255),
    /*Acquired Aminog. Mod. Enzymes*/    
    imi_aminog VARCHAR(255),
    /*Acquired Other Enzimes*/
    imi_other VARCHAR(255),
    PA0004_gyrB VARCHAR(255),
	PA0424_mexR VARCHAR(255),
	PA0425_mexA VARCHAR(255),
	PA0426_mexB VARCHAR(255),
	PA0427_oprM VARCHAR(255),
	PA0807_ampDh3 VARCHAR(255),
	PA0869_pbpG VARCHAR(255),
	PA0958_oprD VARCHAR(255),
    /* oprD Reference Strain */
	oprD_ref_st VARCHAR(255),
	PA1179_phoP VARCHAR(255),
	PA1180_phoQ VARCHAR(255),
	PA1777_oprF VARCHAR(255),
	PA1798_parS VARCHAR(255),
	PA1799_parR VARCHAR(255),
	PA2018_mexY VARCHAR(255),
	PA2019_mexX VARCHAR(255),
	PA2020_mexZ VARCHAR(255),
	PA2272_pbpC VARCHAR(255),
	PA2491_mexS VARCHAR(255),
	PA2492_mexT VARCHAR(255),
	PA3047_dacB VARCHAR(255),
	PA3168_gyrA VARCHAR(255),
	PA3574_nalD VARCHAR(255),
	PA3721_nalC VARCHAR(255),
	PA3999_dacC VARCHAR(255),
	PA4003_pbpA VARCHAR(255),
	PA4020_mpl VARCHAR(255),
	PA4109_ampR VARCHAR(255),
	PA4110_ampC VARCHAR(255),
	PA4266_fusA1 VARCHAR(255),
	PA4418_ftsI VARCHAR(255),
	PA4522_ampD VARCHAR(255),
	PA4600_nfxB VARCHAR(255),
	PA4700_mrcB VARCHAR(255),
	PA4776_pmrA VARCHAR(255),
	PA4777_pmrB VARCHAR(255),
	PA4964_parC VARCHAR(255),
	PA4967_parE VARCHAR(255),    
	PA5045_ponA_mrcA VARCHAR(255),
	PA5235_glpT VARCHAR(255),
	PA5471_armZ VARCHAR(255),
	PA5485_ampDh2 VARCHAR(255),
	/* Table restrictions */
    PRIMARY KEY(ab_resistance_id),
	FOREIGN KEY(isolated_id) REFERENCES summary(summary_id)
);