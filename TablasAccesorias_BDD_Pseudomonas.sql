INSERT INTO hospital (hospital_nombre, pais, region, localidad) VALUES
('C.H. Ciudad de Jaén','España', 'Andalucía', 'Jaén'),
('Corporació Sanitària Parc Taulí','España', 'Cataluña', 'Sabadell'),
('Hospital 12 Octubre','España', 'Madrid', 'Madrid'),
('Hospital A Coruña','España', 'Galicia', 'A Coruña'),
('Hospital Álava','España', 'País Vasco', 'Vitoria'),
('Hospital Bellvitge','España', 'Cataluña', 'Barcelona'),
('Hospital Cabueñes','España', 'Asturias', 'Gijón'),
('Hospital Clínico Lozano Blesa','España', 'Aragón', 'Zaragoza'),
('Hospital Clinic','España', 'Cataluña', 'Barcelona'),
('Hospital de Burgos','España', 'Castilla y León', 'Burgos'),
('Hospital de Castellón','España', 'Comunidad Valenciana', 'Castellón'),
('Hospital de Guadalajara','España', 'Castilla La Mancha', 'Guadalajara'),
('Hospital de Jerez','España','Andalucía', 'Jerez'),
('Hospital de La Fé','España','Comunidad Valenciana','Valencia'),
('Hospital de Pontevedra','España','Galicia','Pontevedra'),
('Hospital de Salamanca','España','Castilla y León', 'Salamanca'),
('Hospital de Jerez','España','Andalucía', 'Jerez'),
('Hospital Doctor Negrín','España','Canarias', 'Las Palmas de Gran Canaria'),
('Hospital General de Valencia','España','Comunidad Valenciana', 'Valencia'),
('Hospital Germans Trias i Pujol','España','Cataluña', 'Barcelona'),
('Hospital Getafe','España','Madrid', 'Getafe'),
('Hospital La Princesa','España','Madrid', 'Madrid'),
('Hospital Manacor','España','Baleares', 'Manacor'),
('Hospital Marqués de Valdecilla','España','Cantabria', 'Santander'),
('Hospital Miguel Servet','España','Aragón', 'Zaragoza'),
('Hospital Mutua de Terrasa','España','Cataluña', 'Terrasa'),
('Hospital Puerta del Mar','España','Andalucía', 'Cádiz'),
('Hospital Ramón y Cajal','España','Madrid', 'Madrid'),
('Hospital Reina Sofía','España','Madrid', 'Madrid'),
('Hospital Royo Villanova','España','Aragón', 'Zaragoza'),
('Hospital Santa Creu i Sant Pau','España','Cataluña', 'Barcelona'),
('Hospital Santiago de Compostela','España','Galicia', 'Santiago de Compostela'),
('Hospital Son Llàtzer','España','Baleares', 'Palma'),
('Hospital Vall d´Hebron','España','Cataluña', 'Barcelona'),
('Hospital Virgen Arrixaca','España','Murcia', 'Murcia'),
('Hospital Virgen de la Macarena','España','Andalucía', 'Sevilla');

INSERT INTO tipo_muestra (tipo) VALUES
('Esputo'),
('Esputo(FQ)'),
('Líquido pleural'),
('Líquido peritoneal'),
('Orina'),
('Sangre'),
('Broncoaspirado'),
('Absceso'),
('Exudado cutáneo'),
('Exudado ótico'),
('Exudado quemadura'),
('Exudado herida'),
('Exudado herida'),
('Exudado conjuntival'),
('Exudado herida quirúrgica'),
('Exudado otros'),
('Biopsia cutánea'),
('Prótesis'),
('Raspado córneal'),
('Aspirado traqueal'),
('Biopsia ósea'),
('Úlcera'),
('Líquido articular'),
('Catéter'),
('Lavado broncoalveolar'),
('Aspirado nasofaringeo'),
('Lavado Broncoalveolar'),
('Cepillado bronquial'),
('Biopsia otros'),
('Líquido estéril otros'),
('Otros');

INSERT INTO plataforma (nombre, proveedor) VALUES 
('Illumina HiSeq', 'Illumina'),
('Illumina MiSeq', 'Illumina'),
('Illumina NovaSeq', 'Illumina'),
('PacBio Sequel', 'Pacific Biosciences'),
('Ion Torrent', 'Thermo Fisher Scientific'),
('Oxford Nanopore MinION', 'Oxford Nanopore Technologies'),
('Oxford Nanopore GridION', 'Oxford Nanopore Technologies'),
('10X Genomics Chromium', '10X Genomics'),
('BioNano Genomics Saphyr', 'BioNano Genomics'),
('Dovetail Genomics Hi-C', 'Dovetail Genomics'),
('ABI SOLiD', 'Thermo Fisher Scientific'),
('Complete Genomics', 'BGI'),
('Roche 454', 'Roche Diagnostics'),
('BGISEQ', 'BGI'),
('PacBio RS II', 'Pacific Biosciences'),
('Thermo Fisher Ion Proton', 'Thermo Fisher Scientific'),
('MGI DNBSEQ-T7', 'MGI Tech'),
('Nebula Genomics Sequencing', 'Nebula Genomics'),
('Oxford Nanopore PromethION', 'Oxford Nanopore Technologies'),
('PacBio Sequel II', 'Pacific Biosciences');

INSERT INTO tecnica (nombre, lecturas, metodo) VALUES 
('Illumina Sequencing', 'Short Read', 'Sequenciación por síntesis'),
('Illumina NovaSeq', 'Short Read', 'Sequenciación por síntesis'),
('Illumina MiSeq', 'Short Read', 'Sequenciación por síntesis'),
('Illumina HiSeq', 'Short Read', 'Sequenciación por síntesis'),
('PacBio Sequencing', 'Long Read', 'Secuenciación de molécula única (SMRT)'),
('PacBio Sequel', 'Long Read', 'Secuenciación de molécula única (SMRT)'),
('PacBio Sequel II', 'Long Read', 'Secuenciación de molécula única (SMRT)'),
('Oxford Nanopore Sequencing', 'Long Read', 'Secuenciación por nanoporos'),
('Oxford Nanopore MinION', 'Long Read', 'Secuenciación por nanoporos'),
('Oxford Nanopore GridION', 'Long Read', 'Secuenciación por nanoporos'),
('10X Genomics Chromium', 'Short Read', 'Sequenciación por síntesis'),
('Ion Torrent Sequencing', 'Short Read', 'Secuenciación por semiconductor'),
('BioNano Genomics Sequencing', 'Long Read', 'Mapa óptico'),
('Hi-C Sequencing', 'Short Read', 'Secuenciación por síntesis'),
('Tagmentation-Based Sequencing', 'Short Read', 'Sequenciación por síntesis'),
('Linked-Read Sequencing', 'Short Read', 'Sequenciación por síntesis'),
('Whole Genome Sequencing (WGS)', 'Short Read', 'Sequenciación por síntesis'),
('Exome Sequencing', 'Short Read', 'Sequenciación por síntesis'),
('RNA Sequencing (RNA-seq)', 'Short Read', 'Sequenciación por síntesis'),
('ChIP Sequencing (ChIP-seq)', 'Short Read', 'Sequenciación por síntesis'),
('Methyl Sequencing (Methyl-seq)', 'Short Read', 'Sequenciación por síntesis'),
('Amplicon Sequencing', 'Short Read', 'Sequenciación por síntesis'),
('Metagenomic Sequencing', 'Short Read', 'Sequenciación por síntesis'),
('Targeted Sequencing', 'Short Read', 'Sequenciación por síntesis'),
('Whole Transcriptome Sequencing', 'Short Read', 'Sequenciación por síntesis'),
('cDNA Sequencing', 'Short Read', 'Sequenciación por síntesis'),
('Shotgun Sequencing', 'Short Read', 'Sequenciación por síntesis'),
('RAD Sequencing', 'Short Read', 'Sequenciación por síntesis'),
('Paired-End Sequencing', 'Short Read', 'Sequenciación por síntesis'),
('Single-Cell Sequencing', 'Short Read', 'Sequenciación por síntesis'),
('Single-Molecule Sequencing', 'Long Read', 'Sequenciación por síntesis');

INSERT INTO libreria (nombre, metodo) VALUES 
('WGS Library', 'tagmentation-based'),
('Exome Library', 'tagmentation-based'),
('RNA Library', 'tagmentation-based'),
('ChIP Library', 'tagmentation-based'),
('Methyl-seq Library', 'tagmentation-based'),
('Amplicon Library', 'ligation-based'),
('Metagenomic Library', 'tagmentation-based'),
('Targeted Library', 'ligation-based'),
('Whole Transcriptome Library', 'tagmentation-based'),
('cDNA Library', 'tagmentation-based'),
('Shotgun Library', 'tagmentation-based'),
('RAD Library', 'ligation-based'),
('Paired-End Library', 'ligation-based'),
('Single-Cell Library', 'tagmentation-based'),
('Long-Read Library', 'ligation-based'),
('Short-Read Library', 'ligation-based'),
('PCR-free Library', 'ligation-based'),
('Mate-Pair Library', 'ligation-based'),
('3\' Tag Library', 'ligation-based'),
('5\' Tag Library', 'ligation-based'),
('Full-length Library', 'ligation-based'),
('Strand-specific Library', 'ligation-based'),
('Synthetic Long-Read Library', 'ligation-based'),
('Circularized Library', 'ligation-based'),
('Size-Selected Library', 'ligation-based'),
('Normalized Library', 'ligation-based'),
('Low-Input Library', 'ligation-based'),
('Direct-capture Library', 'ligation-based'),
('Tethered-capture Library', 'ligation-based'),
('Capture-Hi-C Library', 'ligation-based');

INSERT INTO resistoma_mutante (locus, nombre_oficial, nombre_sinonimo, nombre_pbp, especie) VALUES 
('PA0004', 'gyrB', '', '', 'Pseudomonas aeruginosa'),
('PA0005', 'lptA', '', '', 'Pseudomonas aeruginosa'),
('PA0018', 'fmt', '', '', 'Pseudomonas aeruginosa'),
('PA0058', 'dsbM', '', '', 'Pseudomonas aeruginosa'),
('PA0301', 'spuE', '', '', 'Pseudomonas aeruginosa'),
('PA0302', 'spuF', '', '', 'Pseudomonas aeruginosa'),
('PA0392', 'yggT', '', '', 'Pseudomonas aeruginosa'),
('PA0402', 'pyrB', '', '', 'Pseudomonas aeruginosa'),
('PA0424', 'mexR', '', '', 'Pseudomonas aeruginosa'),
('PA0425', 'mexA', '', '', 'Pseudomonas aeruginosa'),
('PA0426', 'mexB', '', '', 'Pseudomonas aeruginosa'),
('PA0427', 'oprM', '', '', 'Pseudomonas aeruginosa'),
('PA0463', 'creB', '', '', 'Pseudomonas aeruginosa'),
('PA0464', 'creC', '', '', 'Pseudomonas aeruginosa'),
('PA0465', 'creD', '', '', 'Pseudomonas aeruginosa'),
('PA0486', 'yihE', '', '', 'Pseudomonas aeruginosa'),
('PA0487', 'modR', '', '', 'Pseudomonas aeruginosa'),
('PA0610', 'prtN', '', '', 'Pseudomonas aeruginosa'),
('PA0611', 'prtR', '', '', 'Pseudomonas aeruginosa'),
('PA0612', 'ptrB', '', '', 'Pseudomonas aeruginosa'),
('PA0779', 'asrA', '', '', 'Pseudomonas aeruginosa'),
('PA0807', 'ampDh3', '', '', 'Pseudomonas aeruginosa'),
('PA0869', '', '', 'PBP7', 'Pseudomonas aeruginosa'),
('PA0893', 'argR', '', '', 'Pseudomonas aeruginosa'),
('PA0958', 'oprD', '', '', 'Pseudomonas aeruginosa'),
('PA1178', 'oprH', '', '', 'Pseudomonas aeruginosa'),
('PA1179', 'phoP', '', '', 'Pseudomonas aeruginosa'),
('PA1180', 'phoQ', '', '', 'Pseudomonas aeruginosa'),
('PA1343', 'pagP', '', '', 'Pseudomonas aeruginosa'),
('PA1345', 'gshB', '', '', 'Pseudomonas aeruginosa'),
('PA1375', 'pdxB', '', '', 'Pseudomonas aeruginosa'),
('PA1409', 'aphA', '', '', 'Pseudomonas aeruginosa'),
('PA1430', 'lasR', '', '', 'Pseudomonas aeruginosa'),
('PA1588', 'sucC', '', '', 'Pseudomonas aeruginosa'),
('PA1589', 'sucD', '', '', 'Pseudomonas aeruginosa'),
('PA1777', 'oprF', '', '', 'Pseudomonas aeruginosa'),
('PA1796', 'folD', '', '', 'Pseudomonas aeruginosa'),
('PA1797', '', '', '-', 'Pseudomonas aeruginosa'),
('PA1798', 'parS', '', '', 'Pseudomonas aeruginosa'),
('PA1799', 'parR', '', '', 'Pseudomonas aeruginosa'),
('PA1801', 'clpP', '', '', 'Pseudomonas aeruginosa'),
('PA1803', 'lon', '', '', 'Pseudomonas aeruginosa'),
('PA1812', 'mltD', '', '', 'Pseudomonas aeruginosa'),
('PA1886', 'polB', '', '', 'Pseudomonas aeruginosa'),
('PA2006', '', '', '-', 'Pseudomonas aeruginosa'),
('PA2018', 'mexY', '', '', 'Pseudomonas aeruginosa'),
('PA2019', 'mexX', '', '', 'Pseudomonas aeruginosa'),
('PA2020', 'mexZ', '', '', 'Pseudomonas aeruginosa'),
('PA2023', 'galU', '', '', 'Pseudomonas aeruginosa'),
('PA2050', '', '', '-', 'Pseudomonas aeruginosa'),
('PA2071', 'fusA2', '', '', 'Pseudomonas aeruginosa'),
('PA2227', 'vqsM', '', '', 'Pseudomonas aeruginosa'),
('PA2272', '', '', 'PBP3a', 'Pseudomonas aeruginosa'),
('PA2273', 'soxR', '', '', 'Pseudomonas aeruginosa'),
('PA2489', '', '', '-', 'Pseudomonas aeruginosa'),
('PA2490', 'ydbB', '', '', 'Pseudomonas aeruginosa'),
('PA2491', 'mexS', '', '', 'Pseudomonas aeruginosa'),
('PA2492', 'mexT', '', '', 'Pseudomonas aeruginosa'),
('PA2493', 'mexE', '', '', 'Pseudomonas aeruginosa'),
('PA2494', 'mexF', '', '', 'Pseudomonas aeruginosa'),
('PA2495', 'oprN', '', '', 'Pseudomonas aeruginosa'),
('PA2522', 'czcC', '', '', 'Pseudomonas aeruginosa'),
('PA2523', 'czcR', '', '', 'Pseudomonas aeruginosa'),
('PA2524', 'czcS', '', '', 'Pseudomonas aeruginosa'),
('PA2525', 'opmB', '', '', 'Pseudomonas aeruginosa'),
('PA2526', 'muxC', '', '', 'Pseudomonas aeruginosa'),
('PA2527', 'muxB', '', '', 'Pseudomonas aeruginosa'),
('PA2528', 'muxA', '', '', 'Pseudomonas aeruginosa'),
('PA2615', 'ftsK', '', '', 'Pseudomonas aeruginosa'),
('PA2621', 'clpS', '', '', 'Pseudomonas aeruginosa'),
('PA2642', 'nuoG', '', '', 'Pseudomonas aeruginosa'),
('PA2649', 'nuoN', '', '', 'Pseudomonas aeruginosa'),
('PA2797', '', '', '-', 'Pseudomonas aeruginosa'),
('PA2798', '', '', '-', 'Pseudomonas aeruginosa'),
('PA2809', 'copR', '', '', 'Pseudomonas aeruginosa'),
('PA2810', 'copS', '', '', 'Pseudomonas aeruginosa'),
('PA2830', 'htpX', '', '', 'Pseudomonas aeruginosa'),
('PA3005', 'nagZ', '', '', 'Pseudomonas aeruginosa'),
('PA3013', 'foaB', '', '', 'Pseudomonas aeruginosa'),
('PA3014', 'faoA', '', '', 'Pseudomonas aeruginosa'),
('PA3047', '', '', 'PBP4', 'Pseudomonas aeruginosa'),
('PA3050', 'pyrD', '', '', 'Pseudomonas aeruginosa'),
('PA3077', 'cprR', '', '', 'Pseudomonas aeruginosa'),
('PA3078', 'cprS', '', '', 'Pseudomonas aeruginosa'),
('PA3141', 'capD', '', '', 'Pseudomonas aeruginosa'),
('PA3168', 'gyrA', '', '', 'Pseudomonas aeruginosa'),
('PA3521', 'opmE', '', '', 'Pseudomonas aeruginosa'),
('PA3522', 'mexQ', '', '', 'Pseudomonas aeruginosa'),
('PA3523', 'mexP', '', '', 'Pseudomonas aeruginosa'),
('PA3533', 'grxD', '', '', 'Pseudomonas aeruginosa'),
('PA3574', 'nalD', '', '', 'Pseudomonas aeruginosa'),
('PA3602', 'yerD', '', '', 'Pseudomonas aeruginosa'),
('PA3676', 'mexK', '', '', 'Pseudomonas aeruginosa'),
('PA3677', 'mexJ', '', '', 'Pseudomonas aeruginosa'),
('PA3678', 'mexL', '', '', 'Pseudomonas aeruginosa'),
('PA3719', 'armR', '', '', 'Pseudomonas aeruginosa'),
('PA3721', 'nalC', '', '', 'Pseudomonas aeruginosa'),
('PA3999', '', '', 'PBP5/6', 'Pseudomonas aeruginosa'),
('PA4001', 'sltB1', '', '', 'Pseudomonas aeruginosa'),
('PA4003', '', '', 'PBP2', 'Pseudomonas aeruginosa'),
('PA4020', 'mpl', '', '', 'Pseudomonas aeruginosa'),
('PA4069', '', '', '-', 'Pseudomonas aeruginosa'),
('PA4109', 'ampR', '', '', 'Pseudomonas aeruginosa'),
('PA4110', 'ampC', '', '', 'Pseudomonas aeruginosa'),
('PA4119', 'aph', '', '', 'Pseudomonas aeruginosa'),
('PA4205', 'mexG', '', '', 'Pseudomonas aeruginosa'),
('PA4206', 'mexH', '', '', 'Pseudomonas aeruginosa'),
('PA4207', 'mexI', '', '', 'Pseudomonas aeruginosa'),
('PA4208', 'opmD', '', '', 'Pseudomonas aeruginosa'),
('PA4218', 'ampP', '', '', 'Pseudomonas aeruginosa'),
('PA4238', 'rpoA', '', '', 'Pseudomonas aeruginosa'),
('PA4260', 'rplB', '', '', 'Pseudomonas aeruginosa'),
('PA4266', 'fusA1', '', '', 'Pseudomonas aeruginosa'),
('PA4269', 'rpoC', '', '', 'Pseudomonas aeruginosa'),
('PA4270', 'rpoB', '', '', 'Pseudomonas aeruginosa'),
('PA4273', 'rplA', '', '', 'Pseudomonas aeruginosa'),
('PA4315', 'mvaT', '', '', 'Pseudomonas aeruginosa'),
('PA4374', 'mexV', '', '', 'Pseudomonas aeruginosa'),
('PA4375', 'mexW', '', '', 'Pseudomonas aeruginosa'),
('PA4380', 'colS', '', '', 'Pseudomonas aeruginosa'),
('PA4381', 'colR', '', '', 'Pseudomonas aeruginosa'),
('PA4393', 'ampG', '', '', 'Pseudomonas aeruginosa'),
('PA4406', 'lpxC', '', '', 'Pseudomonas aeruginosa'),
('PA4418', '', '', 'PBP3', 'Pseudomonas aeruginosa'),
('PA4444', 'mltB1', '', '', 'Pseudomonas aeruginosa'),
('PA4462', 'rpoN', '', '', 'Pseudomonas aeruginosa'),
('PA4521', 'ampE', '', '', 'Pseudomonas aeruginosa'),
('PA4522', 'ampD', '', '', 'Pseudomonas aeruginosa'),
('PA4567', 'rpmA', '', '', 'Pseudomonas aeruginosa'),
('PA4568', 'rplU', '', '', 'Pseudomonas aeruginosa'),
('PA4597', 'oprJ', '', '', 'Pseudomonas aeruginosa'),
('PA4598', 'mexD', '', '', 'Pseudomonas aeruginosa'),
('PA4599', 'mexC', '', '', 'Pseudomonas aeruginosa'),
('PA4600', 'nfxB', '', '', 'Pseudomonas aeruginosa'),
('PA4661', 'pagL', '', '', 'Pseudomonas aeruginosa'),
('PA4671', 'rplY', '', '', 'Pseudomonas aeruginosa'),
('PA4700', '', '', 'PBP1b', 'Pseudomonas aeruginosa'),
('PA4748', 'tpiA', '', '', 'Pseudomonas aeruginosa'),
('PA4751', 'ftsH', '', '', 'Pseudomonas aeruginosa'),
('PA4773', 'speD2', '', '', 'Pseudomonas aeruginosa'),
('PA4774', 'speE2', '', '', 'Pseudomonas aeruginosa'),
('PA4775', '', '', '-', 'Pseudomonas aeruginosa'),
('PA4776', 'pmrA', '', '', 'Pseudomonas aeruginosa'),
('PA4777', 'pmrB', '', '', 'Pseudomonas aeruginosa'),
('PA4878', 'brlR', '', '', 'Pseudomonas aeruginosa'),
('PA4944', 'hfq', '', '', 'Pseudomonas aeruginosa'),
('PA4964', 'parC', '', '', 'Pseudomonas aeruginosa'),
('PA4967', 'parE', '', '', 'Pseudomonas aeruginosa'),
('PA5000', 'wapR', '', '', 'Pseudomonas aeruginosa'),
('PA5038', 'aroB', '', '', 'Pseudomonas aeruginosa'),
('PA5045', '', '', 'PBP1a', 'Pseudomonas aeruginosa'),
('PA5117', 'typA', '', '', 'Pseudomonas aeruginosa'),
('PA5199', 'amgS', '', '', 'Pseudomonas aeruginosa'),
('PA5200', 'amgR', '', '', 'Pseudomonas aeruginosa'),
('PA5235', 'glpT', '', '', 'Pseudomonas aeruginosa'),
('PA5332', 'crc', '', '', 'Pseudomonas aeruginosa'),
('PA5366', 'pstB', '', '', 'Pseudomonas aeruginosa'),
('PA5471', 'armZ', '', '', 'Pseudomonas aeruginosa'),
('PA5471.1', '', '', '-', 'Pseudomonas aeruginosa'),
('PA5485', 'ampDh2', '', '', 'Pseudomonas aeruginosa'),
('PA5513', 'poxA', '', '', 'Pseudomonas aeruginosa'),
('PA5514', '', '', '-', 'Pseudomonas aeruginosa'),
('PA5528', '', '', '-', 'Pseudomonas aeruginosa'),
('PA5542', 'PIB-1', '', '', 'Pseudomonas aeruginosa'),
('PA0355', 'pfpI', '', '', 'Pseudomonas aeruginosa'),
('PA0357', 'mutM', '', '', 'Pseudomonas aeruginosa'),
('PA0750', 'ung', '', '', 'Pseudomonas aeruginosa'),
('PA1816', 'dnaQ', '', '', 'Pseudomonas aeruginosa'),
('PA3002', 'mfd', '', '', 'Pseudomonas aeruginosa'),
('PA3620', 'mutS', '', '', 'Pseudomonas aeruginosa'),
('PA4366', 'sodB', '', '', 'Pseudomonas aeruginosa'),
('PA4400', 'mutT', '', '', 'Pseudomonas aeruginosa'),
('PA4468', 'sodM', '', '', 'Pseudomonas aeruginosa'),
('PA4609', 'radA', '', '', 'Pseudomonas aeruginosa'),
('PA4946', 'mutL', '', '', 'Pseudomonas aeruginosa'),
('PA5147', 'mutY', '', '', 'Pseudomonas aeruginosa'),
('PA5344', 'oxyR', '', '', 'Pseudomonas aeruginosa'),
('PA5443', 'uvrD', '', '', 'Pseudomonas aeruginosa'),
('PA5493', 'polA', '', '', 'Pseudomonas aeruginosa');



INSERT INTO resistoma_adquirido (locus, nombre_oficial, nombre_sinonimo) VALUES
('1','175','175'),
('1','175','175');



INSERT INTO locus_mlst (locus, nombre_oficial, nombre_sinonimo, especie) VALUES
('PA0887','acsA','','Pseudomonas aeruginosa'),
('PA0025','aroE','','Pseudomonas aeruginosa'),
('PA3769','guaA','','Pseudomonas aeruginosa'),
('PA4946','mutL','','Pseudomonas aeruginosa'),
('PA2639','nuoD','','Pseudomonas aeruginosa'),
('PA1770','ppsA','','Pseudomonas aeruginosa'),
('PA0609','trpE','','Pseudomonas aeruginosa');

INSERT INTO locus_virulencia (locus, nombre_oficial, nombre_sinonimo, especie) VALUES
('PA2191','exoY','','Pseudomonas aeruginosa'),
('PA3841','exoS','','Pseudomonas aeruginosa'),
('PA14_51530','exoU','','Pseudomonas aeruginosa'),
('PA0044','exoT','','Pseudomonas aeruginosa');

INSERT INTO locus_hipermutacion (locus, nombre_oficial, nombre_sinonimo, especie) VALUES
('1','175'),
('1','175');

INSERT INTO metadata_general (aislado_nombre, especie) VALUES 
('AND01-001', 'Pseudomonas aeruginosa');

-- INSERT INTO books
--     (id, title, author, year_published)
-- VALUES
--     (@id, @title, @author, @year_published)
-- ON DUPLICATE KEY UPDATE
--     title = @title,
--     author = @author,
--     year_published = @year_published;