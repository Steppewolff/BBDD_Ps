DELIMITER |
CREATE TRIGGER `concat_project_isolate` BEFORE INSERT ON `metadata_general`
FOR EACH ROW 
BEGIN
  SET NEW.isolate_project_id = CONCAT(NEW.project_name, '_', NEW.isolate_name);
END |
DELIMITER ;

DELIMITER |
CREATE TRIGGER `update_concat_project_isolate` BEFORE UPDATE ON `metadata_general`
FOR EACH ROW 
BEGIN
  SET NEW.isolate_project_id = CONCAT(NEW.project_name, '_', NEW.isolate_name);
END |
DELIMITER ;