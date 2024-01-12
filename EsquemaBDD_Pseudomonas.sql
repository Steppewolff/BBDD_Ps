DROP DATABASE IF EXISTS psdb;
create database psdb;

use psdb;

DROP TABLE IF EXISTS summary;
create table summary(
	summary_id INT NOT NULL AUTO_INCREMENT,
	strain_id INT NOT NULL,
    strain_name varchar(255) NOT NULL,
    clone_name varchar(255),
    PRIMARY KEY(summary_id)
);

DROP TABLE IF EXISTS phenotypes;
create table phenotypes(
	phenotypes_id INT NOT NULL AUTO_INCREMENT,
	strain_id INT NOT NULL,
    pdc INT,
    mic_cft INT,
    mic_2 INT,
    mic_3 INT,
    PRIMARY KEY(phenotypes_id)
);

ALTER TABLE phenotypes
ADD FOREIGN KEY (strain_id) REFERENCES summary(strain_id);

DROP TABLE IF EXISTS genotypes;
create table genotypes(
	genotypes_id INT NOT NULL AUTO_INCREMENT,
	strain_id INT NOT NULL,
    pdc INT,
    mic_cft INT,
    mic_cmax INT,
    mic_3 INT,
    PRIMARY KEY(genotypes_id),
    FOREIGN KEY (strain_id) REFERENCES summary(strain_id)	
);