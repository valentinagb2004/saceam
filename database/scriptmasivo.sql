
-- Schema saceam
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `saceam` DEFAULT CHARACTER SET utf8 ;
USE `saceam` ;

-- -----------------------------------------------------
-- Table `saceam`.`pais`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `saceam`.`pais` (
  `id_pais` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_pais`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `saceam`.`departamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `saceam`.`departamento` (
  `id_departamento` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `id_pais` INT NOT NULL,
  PRIMARY KEY (`id_departamento`, `id_pais`),
  INDEX `fk_departamento_pais_idx` (`id_pais` ASC) ,
  CONSTRAINT `fk_departamento_pais`
    FOREIGN KEY (`id_pais`)
    REFERENCES `saceam`.`pais` (`id_pais`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `saceam`.`ciudad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `saceam`.`ciudad` (
  `id_ciudad` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `id_departamento` INT NOT NULL,
  PRIMARY KEY (`id_ciudad`, `id_departamento`),
  INDEX `fk_ciudad_departamento1_idx` (`id_departamento` ASC) ,
  CONSTRAINT `fk_ciudad_departamento1`
    FOREIGN KEY (`id_departamento`)
    REFERENCES `saceam`.`departamento` (`id_departamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `saceam`.`persona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `saceam`.`persona` (
  `id_persona` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(250) NOT NULL,
  `apellido` VARCHAR(250) NOT NULL,
  `fecha_nacimiento` DATE NOT NULL,
  `ciudad_id_nacimiento` INT NOT NULL,
  `ciudad_id_residencia` INT NOT NULL,
  `estrato` INT NOT NULL,
  `sisben` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id_persona`),
  INDEX `fk_persona_ciudad1_naci_idx` (`ciudad_id_nacimiento` ASC) ,
  INDEX `fk_persona_ciudad1_residencia_dx` (`ciudad_id_residencia` ASC) ,
  CONSTRAINT `fk_persona_ciudad1_naci`
    FOREIGN KEY (`ciudad_id_nacimiento`)
    REFERENCES `saceam`.`ciudad` (`id_ciudad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_persona_ciudad1_residencia`
    FOREIGN KEY (`ciudad_id_residencia`)
    REFERENCES `saceam`.`ciudad` (`id_ciudad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `saceam`.`telefono`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `saceam`.`telefono` (
  `id_tele` INT NOT NULL AUTO_INCREMENT,
  `telefono` VARCHAR(30) NOT NULL,
  `id_persona` INT NOT NULL,
  PRIMARY KEY (`id_tele`),
  INDEX `fk_telefono_persona1_idx` (`id_persona` ASC) ,
  CONSTRAINT `fk_telefono_persona1`
    FOREIGN KEY (`id_persona`)
    REFERENCES `saceam`.`persona` (`id_persona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `funcionario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `funcionario` ;

CREATE TABLE IF NOT EXISTS `funcionario` (
  `id_funcionario` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `puesto` VARCHAR(45) NOT NULL,
  `id_persona` INT NOT NULL,
  PRIMARY KEY (`id_funcionario`, `id_persona`),
  CONSTRAINT `fk_funcionario_persona1`
    FOREIGN KEY (`id_persona`)
    REFERENCES `persona` (`id_persona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_spanish2_ci;

CREATE INDEX `fk_funcionario_persona1_idx` ON `funcionario` (`id_persona` ASC) ;



-- -----------------------------------------------------
-- Table `saceam`.`estudiante`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `saceam`.`estudiante` (
  `id_persona` INT NOT NULL,
  `es_articulacion` TINYINT NULL COMMENT 'indica si un estadudiante  viene de articulacion si viene 1 si no viene 0',
  `fecha_ingreso` DATE NOT NULL,
  `estado` ENUM('activo', 'inactivo', 'graduado') NOT NULL,
  PRIMARY KEY (`id_persona`),
  CONSTRAINT `fk_estudiante_persona1`
    FOREIGN KEY (`id_persona`)
    REFERENCES `saceam`.`persona` (`id_persona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `saceam`.`estado_academico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `saceam`.`estado_academico` (
  `id_estac` INT NOT NULL,
  `nombre` VARCHAR(100) NOT NULL,
  `descripcion` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id_estac`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `saceam`.`programa_academico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `saceam`.`programa_academico` (
  `id_prog` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(250) NOT NULL,
  `codigo` VARCHAR(45) NOT NULL,
  `duracion_semestre` INT NOT NULL,
  PRIMARY KEY (`id_prog`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `saceam`.`estudiante_programa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `saceam`.`estudiante_programa` (
  `id_persona` INT NOT NULL,
  `id_prog` INT NOT NULL,
  `id_estac` INT NOT NULL,
  `fecha_inicion` DATE NOT NULL,
  `fecha_fin` DATE NOT NULL,
  INDEX `fk_estudiante_carrera_estudiante1_idx` (`id_persona` ASC) ,
  INDEX `fk_estudiante_carrera_programa_academico1_idx` (`id_prog` ASC) ,
  INDEX `fk_estudiante_programa_estado_academico1_idx` (`id_estac` ASC) ,
  PRIMARY KEY (`id_persona`, `id_prog`),
  CONSTRAINT `fk_estudiante_carrera_estudiante1`
    FOREIGN KEY (`id_persona`)
    REFERENCES `saceam`.`estudiante` (`id_persona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_estudiante_carrera_programa_academico1`
    FOREIGN KEY (`id_prog`)
    REFERENCES `saceam`.`programa_academico` (`id_prog`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_estudiante_programa_estado_academico1`
    FOREIGN KEY (`id_estac`)
    REFERENCES `saceam`.`estado_academico` (`id_estac`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `saceam`.`Nota`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `saceam`.`Nota` (
  `id_nota` INT NOT NULL AUTO_INCREMENT,
  `materia` VARCHAR(45) NOT NULL,
  `semestre` VARCHAR(45) NOT NULL,
  `id_prog` INT NOT NULL,
  `estudiante_id_persona` INT NOT NULL,
  `calificacion` DECIMAL NOT NULL,
  `fecha_registro` DATE NOT NULL,
  PRIMARY KEY (`id_nota`, `id_prog`, `estudiante_id_persona`),
  INDEX `fk_Nota_estudiante_programa1_idx` (`id_prog` ASC) ,
  INDEX `fk_Nota_estudiante1_idx` (`estudiante_id_persona` ASC) ,
  CONSTRAINT `fk_Nota_estudiante_programa1`
    FOREIGN KEY (`id_prog`)
    REFERENCES `saceam`.`estudiante_programa` (`id_prog`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Nota_estudiante1`
    FOREIGN KEY (`estudiante_id_persona`)
    REFERENCES `saceam`.`estudiante` (`id_persona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `saceam`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `saceam`.`usuario` (
  `id_usuario` INT NOT NULL AUTO_INCREMENT,
  `nombre_usuario` VARCHAR(45) NOT NULL,
  `correro` VARCHAR(45) NOT NULL,
  `contraseña` VARCHAR(45) NOT NULL,
  `id_persona` INT NOT NULL,
  PRIMARY KEY (`id_usuario`, `id_persona`),
  INDEX `fk_usuario_persona1_idx` (`id_persona` ASC) ,
  CONSTRAINT `fk_usuario_persona1`
    FOREIGN KEY (`id_persona`)
    REFERENCES `saceam`.`persona` (`id_persona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `saceam`.`docente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `saceam`.`docente` (
  `persona_id_persona` INT NOT NULL,
  `sueldo` DOUBLE NULL,
  PRIMARY KEY (`persona_id_persona`),
  CONSTRAINT `fk_docente_persona1`
    FOREIGN KEY (`persona_id_persona`)
    REFERENCES `saceam`.`persona` (`id_persona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;





USE `saceam` ;



-- Insert countries (paises)
INSERT INTO `saceam`.`pais` (`nombre`) VALUES ('Colombia');
INSERT INTO `saceam`.`pais` (`nombre`) VALUES ('México');
INSERT INTO `saceam`.`pais` (`nombre`) VALUES ('Argentina');
INSERT INTO `saceam`.`pais` (`nombre`) VALUES ('Chile');
INSERT INTO `saceam`.`pais` (`nombre`) VALUES ('Perú');
INSERT INTO `saceam`.`pais` (`nombre`) VALUES ('Ecuador');
INSERT INTO `saceam`.`pais` (`nombre`) VALUES ('Brasil');
INSERT INTO `saceam`.`pais` (`nombre`) VALUES ('Venezuela');
INSERT INTO `saceam`.`pais` (`nombre`) VALUES ('Uruguay');
INSERT INTO `saceam`.`pais` (`nombre`) VALUES ('Paraguay');

-- Insert departments (departamentos)
INSERT INTO `saceam`.`departamento` (`nombre`, `id_pais`) VALUES ('Cundinamarca', 1);
INSERT INTO `saceam`.`departamento` (`nombre`, `id_pais`) VALUES ('Antioquia', 1);
INSERT INTO `saceam`.`departamento` (`nombre`, `id_pais`) VALUES ('Jalisco', 2);
INSERT INTO `saceam`.`departamento` (`nombre`, `id_pais`) VALUES ('Buenos Aires', 3);
INSERT INTO `saceam`.`departamento` (`nombre`, `id_pais`) VALUES ('Santiago', 4);
INSERT INTO `saceam`.`departamento` (`nombre`, `id_pais`) VALUES ('Lima', 5);
INSERT INTO `saceam`.`departamento` (`nombre`, `id_pais`) VALUES ('Pichincha', 6);
INSERT INTO `saceam`.`departamento` (`nombre`, `id_pais`) VALUES ('São Paulo', 7);
INSERT INTO `saceam`.`departamento` (`nombre`, `id_pais`) VALUES ('Caracas', 8);
INSERT INTO `saceam`.`departamento` (`nombre`, `id_pais`) VALUES ('Montevideo', 9);

-- Insert cities (ciudades)
INSERT INTO `saceam`.`ciudad` (`nombre`, `id_departamento`) VALUES ('Bogotá', 1);
INSERT INTO `saceam`.`ciudad` (`nombre`, `id_departamento`) VALUES ('Medellín', 2);
INSERT INTO `saceam`.`ciudad` (`nombre`, `id_departamento`) VALUES ('Guadalajara', 3);
INSERT INTO `saceam`.`ciudad` (`nombre`, `id_departamento`) VALUES ('Buenos Aires', 4);
INSERT INTO `saceam`.`ciudad` (`nombre`, `id_departamento`) VALUES ('Santiago', 5);
INSERT INTO `saceam`.`ciudad` (`nombre`, `id_departamento`) VALUES ('Lima', 6);
INSERT INTO `saceam`.`ciudad` (`nombre`, `id_departamento`) VALUES ('Quito', 7);
INSERT INTO `saceam`.`ciudad` (`nombre`, `id_departamento`) VALUES ('São Paulo', 8);
INSERT INTO `saceam`.`ciudad` (`nombre`, `id_departamento`) VALUES ('Caracas', 9);
INSERT INTO `saceam`.`ciudad` (`nombre`, `id_departamento`) VALUES ('Montevideo', 10);

-- Insert estado_academico
INSERT INTO `saceam`.`estado_academico` (`id_estac`, `nombre`, `descripcion`) VALUES (1, 'Matriculado', 'Estudiante actualmente matriculado en el programa');
INSERT INTO `saceam`.`estado_academico` (`id_estac`, `nombre`, `descripcion`) VALUES (2, 'Suspendido', 'Estudiante con matrícula suspendida');
INSERT INTO `saceam`.`estado_academico` (`id_estac`, `nombre`, `descripcion`) VALUES (3, 'Graduado', 'Estudiante que ha completado el programa académico');

-- Insert programa_academico
INSERT INTO `saceam`.`programa_academico` (`nombre`, `codigo`, `duracion_semestre`) VALUES ('Ingeniería de Sistemas', 'ING-SIS', 10);
INSERT INTO `saceam`.`programa_academico` (`nombre`, `codigo`, `duracion_semestre`) VALUES ('Derecho', 'DER', 10);
INSERT INTO `saceam`.`programa_academico` (`nombre`, `codigo`, `duracion_semestre`) VALUES ('Medicina', 'MED', 12);
INSERT INTO `saceam`.`programa_academico` (`nombre`, `codigo`, `duracion_semestre`) VALUES ('Administración de Empresas', 'ADM', 8);
INSERT INTO `saceam`.`programa_academico` (`nombre`, `codigo`, `duracion_semestre`) VALUES ('Psicología', 'PSI', 10);

-- Insert personas (100 personas)
-- First, inserting all 100 personas
-- Using a combination of different birth cities and residence cities

-- Generando 100 personas
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Juan', 'Pérez', '1990-01-15', 1, 1, 3, 'A1');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('María', 'González', '1992-03-20', 2, 1, 2, 'B2');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Carlos', 'Rodríguez', '1985-07-10', 3, 3, 4, 'C3');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Ana', 'Martínez', '1993-11-05', 4, 4, 3, 'B1');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Pedro', 'López', '1988-05-25', 5, 5, 2, 'A2');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Laura', 'Hernández', '1991-09-12', 6, 6, 3, 'B3');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Miguel', 'Díaz', '1987-04-30', 7, 7, 4, 'C1');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Isabel', 'Torres', '1994-08-22', 8, 8, 3, 'B2');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Javier', 'Ramírez', '1990-02-18', 9, 9, 2, 'A3');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Patricia', 'Flores', '1989-06-15', 10, 10, 3, 'B1');

-- Personas 11-20
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Roberto', 'García', '1992-12-01', 1, 2, 4, 'C2');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Sofía', 'Vargas', '1986-10-08', 2, 3, 3, 'B3');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Fernando', 'Castro', '1995-03-27', 3, 4, 2, 'A1');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Claudia', 'Ríos', '1991-07-14', 4, 5, 3, 'B2');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Andrés', 'Morales', '1987-01-05', 5, 6, 4, 'C3');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Natalia', 'Silva', '1993-05-19', 6, 7, 3, 'B1');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Ricardo', 'Ortiz', '1989-09-03', 7, 8, 2, 'A2');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Carolina', 'Núñez', '1994-12-28', 8, 9, 3, 'B3');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Gabriel', 'Vega', '1990-04-11', 9, 10, 4, 'C1');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Valentina', 'Rojas', '1988-08-07', 10, 1, 3, 'B2');

-- Personas 21-30
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Jorge', 'Mendoza', '1993-02-23', 1, 3, 2, 'A3');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Diana', 'Gómez', '1987-06-17', 2, 4, 3, 'B1');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Sergio', 'Herrera', '1995-10-09', 3, 5, 4, 'C2');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Mónica', 'Santos', '1991-04-04', 4, 6, 3, 'B3');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Daniel', 'Molina', '1986-08-31', 5, 7, 2, 'A1');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Lorena', 'Paz', '1994-12-26', 6, 8, 3, 'B2');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Eduardo', 'Rosales', '1989-04-20', 7, 9, 4, 'C3');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Paola', 'Luna', '1992-08-13', 8, 10, 3, 'B1');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Alberto', 'Aguilar', '1990-02-07', 9, 1, 2, 'A2');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Marcela', 'Soto', '1988-06-01', 10, 2, 3, 'B3');

-- Personas 31-40
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Oscar', 'Navarro', '1993-09-24', 1, 4, 4, 'C1');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Camila', 'Acosta', '1987-01-18', 2, 5, 3, 'B2');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Hugo', 'Ramos', '1995-05-12', 3, 6, 2, 'A3');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Mariana', 'Ochoa', '1990-09-05', 4, 7, 3, 'B1');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Felipe', 'Duarte', '1986-01-29', 5, 8, 4, 'C2');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Verónica', 'Paredes', '1994-05-22', 6, 9, 3, 'B3');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Raúl', 'Ponce', '1989-09-16', 7, 10, 2, 'A1');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Julia', 'Miranda', '1992-01-10', 8, 1, 3, 'B2');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Manuel', 'Cordero', '1990-05-03', 9, 2, 4, 'C3');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Lucía', 'Campos', '1987-09-27', 10, 3, 3, 'B1');

-- Personas 41-50
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Federico', 'Barrios', '1993-01-21', 1, 5, 2, 'A2');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Cecilia', 'Fuentes', '1988-05-14', 2, 6, 3, 'B3');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Arturo', 'Medina', '1994-09-08', 3, 7, 4, 'C1');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Sandra', 'Gutiérrez', '1990-01-02', 4, 8, 3, 'B2');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Martín', 'Ayala', '1986-05-26', 5, 9, 2, 'A3');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Elena', 'Pinto', '1994-09-19', 6, 10, 3, 'B1');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Gustavo', 'Mora', '1989-01-13', 7, 1, 4, 'C2');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Margarita', 'Vera', '1992-05-07', 8, 2, 3, 'B3');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Leonardo', 'Salazar', '1990-08-31', 9, 3, 2, 'A1');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Cristina', 'Reyes', '1987-12-25', 10, 4, 3, 'B2');

-- Personas 51-60
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Alejandro', 'Cárdenas', '1993-04-18', 1, 6, 4, 'C3');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Regina', 'Delgado', '1988-08-12', 2, 7, 3, 'B1');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Pablo', 'Espinosa', '1994-12-05', 3, 8, 2, 'A2');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Adriana', 'Mejía', '1990-04-01', 4, 9, 3, 'B3');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Héctor', 'Varela', '1986-07-25', 5, 10, 4, 'C1');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Valeria', 'Cortés', '1994-11-18', 6, 1, 3, 'B2');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('César', 'Orozco', '1989-03-12', 7, 2, 2, 'A3');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Gloria', 'Quintero', '1992-07-06', 8, 3, 3, 'B1');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Antonio', 'Zamora', '1990-10-30', 9, 4, 4, 'C2');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Silvia', 'Montes', '1987-02-22', 10, 5, 3, 'B3');

-- Personas 61-70
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Joaquín', 'Nieto', '1993-06-17', 1, 7, 2, 'A1');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Tatiana', 'Castillo', '1988-10-10', 2, 8, 3, 'B2');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Emilio', 'Cruz', '1994-02-03', 3, 9, 4, 'C3');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Rosa', 'Aragón', '1989-06-28', 4, 10, 3, 'B1');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Alfredo', 'Franco', '1986-10-20', 5, 1, 2, 'A2');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Daniela', 'Pacheco', '1994-02-14', 6, 2, 3, 'B3');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Victor', 'Romero', '1989-06-07', 7, 3, 4, 'C1');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Ángela', 'Valencia', '1992-10-01', 8, 4, 3, 'B2');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Luis', 'Carrillo', '1990-01-25', 9, 5, 2, 'A3');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Teresa', 'Beltrán', '1987-05-19', 10, 6, 3, 'B1');

-- Personas 71-80
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Mateo', 'Suárez', '1993-09-12', 1, 8, 4, 'C2');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Clara', 'Figueroa', '1988-01-06', 2, 9, 3, 'B3');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Samuel', 'Galindo', '1994-04-30', 3, 10, 2, 'A1');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Beatriz', 'Arias', '1990-08-24', 4, 1, 3, 'B2');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Julián', 'Contreras', '1986-12-17', 5, 2, 4, 'C3');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Gabriela', 'Pineda', '1994-04-11', 6, 3, 3, 'B1');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Ignacio', 'Palacios', '1989-08-05', 7, 4, 2, 'A2');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Eva', 'Vásquez', '1992-11-29', 8, 5, 3, 'B3');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Diego', 'Gil', '1990-03-23', 9, 6, 4, 'C1');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Luz', 'Cano', '1987-07-17', 10, 7, 3, 'B2');

-- Personas 81-90
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Esteban', 'Bravo', '1993-11-10', 1, 9, 2, 'A3');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Marina', 'León', '1988-03-04', 2, 10, 3, 'B1');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Francisco', 'Guerra', '1994-06-28', 3, 1, 4, 'C2');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Carmen', 'Cervantes', '1990-10-22', 4, 2, 3, 'B3');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Simón', 'Lara', '1986-02-15', 5, 3, 2, 'A1');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Irene', 'Cabrera', '1994-06-09', 6, 4, 3, 'B2');
-- Personas 87-90 (continuación)
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Armando', 'Solano', '1989-10-03', 7, 5, 4, 'C3');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Rebeca', 'Carmona', '1992-01-27', 8, 6, 3, 'B1');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Mauricio', 'Paredes', '1990-05-21', 9, 7, 2, 'A2');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Susana', 'Montoya', '1987-09-14', 10, 8, 3, 'B3');

-- Personas 91-100
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Rafael', 'Andrade', '1993-01-08', 1, 10, 4, 'C1');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Liliana', 'Sánchez', '1988-05-02', 2, 1, 3, 'B2');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Marcos', 'Navarrete', '1994-08-26', 3, 2, 2, 'A3');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Angélica', 'Roldán', '1990-12-20', 4, 3, 3, 'B1');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Darío', 'Coronado', '1986-04-14', 5, 4, 4, 'C2');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Esperanza', 'Araya', '1994-08-07', 6, 5, 3, 'B3');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Gonzalo', 'Meza', '1989-12-01', 7, 6, 2, 'A1');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Alicia', 'Toro', '1992-03-25', 8, 7, 3, 'B2');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Jaime', 'Briones', '1990-07-19', 9, 8, 4, 'C3');
INSERT INTO `saceam`.`persona` (`nombre`, `apellido`, `fecha_nacimiento`, `ciudad_id_nacimiento`, `ciudad_id_residencia`, `estrato`, `sisben`) VALUES ('Nina', 'Parra', '1987-11-12', 10, 9, 3, 'B1');

-- Teléfonos para las personas (un teléfono por persona)
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3001234567', 1);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3002345678', 2);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3003456789', 3);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3004567890', 4);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3005678901', 5);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3006789012', 6);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3007890123', 7);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3008901234', 8);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3009012345', 9);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3010123456', 10);

-- Resto de teléfonos (del 11 al 100 - solo algunos ejemplos)
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3011234567', 11);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3012345678', 12);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3013456789', 13);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3014567890', 14);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3015678901', 15);
-- Teléfonos para personas del 16 al 100
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3016789012', 16);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3017890123', 17);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3018901234', 18);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3019012345', 19);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3020123456', 20);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3021234567', 21);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3022345678', 22);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3023456789', 23);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3024567890', 24);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3025678901', 25);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3026789012', 26);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3027890123', 27);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3028901234', 28);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3029012345', 29);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3030123456', 30);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3031234567', 31);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3032345678', 32);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3033456789', 33);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3034567890', 34);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3035678901', 35);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3036789012', 36);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3037890123', 37);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3038901234', 38);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3039012345', 39);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3040123456', 40);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3041234567', 41);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3042345678', 42);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3043456789', 43);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3044567890', 44);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3045678901', 45);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3046789012', 46);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3047890123', 47);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3048901234', 48);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3049012345', 49);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3050123456', 50);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3051234567', 51);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3052345678', 52);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3053456789', 53);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3054567890', 54);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3055678901', 55);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3056789012', 56);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3057890123', 57);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3058901234', 58);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3059012345', 59);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3060123456', 60);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3061234567', 61);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3062345678', 62);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3063456789', 63);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3064567890', 64);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3065678901', 65);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3066789012', 66);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3067890123', 67);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3068901234', 68);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3069012345', 69);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3070123456', 70);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3071234567', 71);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3072345678', 72);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3073456789', 73);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3074567890', 74);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3075678901', 75);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3076789012', 76);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3077890123', 77);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3078901234', 78);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3079012345', 79);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3080123456', 80);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3081234567', 81);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3082345678', 82);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3083456789', 83);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3084567890', 84);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3085678901', 85);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3086789012', 86);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3087890123', 87);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3088901234', 88);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3089012345', 89);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3090123456', 90);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3091234567', 91);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3092345678', 92);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3093456789', 93);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3094567890', 94);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3095678901', 95);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3096789012', 96);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3097890123', 97);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3098901234', 98);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3099012345', 99);
INSERT INTO `saceam`.`telefono` (`telefono`, `id_persona`) VALUES ('3100123456', 100);

-- Insertar 80 usuarios (del id_persona 1 al 80)
-- Usuarios 1-10
INSERT INTO `saceam`.`usuario` (`nombre_usuario`, `correro`, `contraseña`, `id_persona`) VALUES ('juan_perez', 'juan.perez@email.com', 'pass123', 1);
INSERT INTO `saceam`.`usuario` (`nombre_usuario`, `correro`, `contraseña`, `id_persona`) VALUES ('maria_g', 'maria.g@email.com', 'pass456', 2);
INSERT INTO `saceam`.`usuario` (`nombre_usuario`, `correro`, `contraseña`, `id_persona`) VALUES ('carlos_r', 'carlos.r@email.com', 'pass789', 3);
INSERT INTO `saceam`.`usuario` (`nombre_usuario`, `correro`, `contraseña`, `id_persona`) VALUES ('ana_m', 'ana.m@email.com', 'pass101', 4);
INSERT INTO `saceam`.`usuario` (`nombre_usuario`, `correro`, `contraseña`, `id_persona`) VALUES ('pedro_l', 'pedro.l@email.com', 'pass112', 5);
INSERT INTO `saceam`.`usuario` (`nombre_usuario`, `correro`, `contraseña`, `id_persona`) VALUES ('laura_h', 'laura.h@email.com', 'pass131', 6);
INSERT INTO `saceam`.`usuario` (`nombre_usuario`, `correro`, `contraseña`, `id_persona`) VALUES ('miguel_d', 'miguel.d@email.com', 'pass415', 7);
INSERT INTO `saceam`.`usuario` (`nombre_usuario`, `correro`, `contraseña`, `id_persona`) VALUES ('isabel_t', 'isabel.t@email.com', 'pass161', 8);
INSERT INTO `saceam`.`usuario` (`nombre_usuario`, `correro`, `contraseña`, `id_persona`) VALUES ('javier_r', 'javier.r@email.com', 'pass718', 9);
INSERT INTO `saceam`.`usuario` (`nombre_usuario`, `correro`, `contraseña`, `id_persona`) VALUES ('patricia_f', 'patricia.f@email.com', 'pass919', 10);

-- Usuarios 11-20
INSERT INTO `saceam`.`usuario` (`nombre_usuario`, `correro`, `contraseña`, `id_persona`) VALUES ('roberto_g', 'roberto.g@email.com', 'pass210', 11);
INSERT INTO `saceam`.`usuario` (`nombre_usuario`, `correro`, `contraseña`, `id_persona`) VALUES ('sofia_v', 'sofia.v@email.com', 'pass221', 12);
INSERT INTO `saceam`.`usuario` (`nombre_usuario`, `correro`, `contraseña`, `id_persona`) VALUES ('fernando_c', 'fernando.c@email.com', 'pass232', 13);
INSERT INTO `saceam`.`usuario` (`nombre_usuario`, `correro`, `contraseña`, `id_persona`) VALUES ('claudia_r', 'claudia.r@email.com', 'pass243', 14);
INSERT INTO `saceam`.`usuario` (`nombre_usuario`, `correro`, `contraseña`, `id_persona`) VALUES ('andres_m', 'andres.m@email.com', 'pass254', 15);
INSERT INTO `saceam`.`usuario` (`nombre_usuario`, `correro`, `contraseña`, `id_persona`) VALUES ('natalia_s', 'natalia.s@email.com', 'pass265', 16);
INSERT INTO `saceam`.`usuario` (`nombre_usuario`, `correro`, `contraseña`, `id_persona`) VALUES ('ricardo_o', 'ricardo.o@email.com', 'pass276', 17);
INSERT INTO `saceam`.`usuario` (`nombre_usuario`, `correro`, `contraseña`, `id_persona`) VALUES ('carolina_n', 'carolina.n@email.com', 'pass287', 18);
INSERT INTO `saceam`.`usuario` (`nombre_usuario`, `correro`, `contraseña`, `id_persona`) VALUES ('gabriel_v', 'gabriel.v@email.com', 'pass298', 19);
INSERT INTO `saceam`.`usuario` (`nombre_usuario`, `correro`, `contraseña`, `id_persona`) VALUES ('valentina_r', 'valentina.r@email.com', 'pass309', 20);

-- Usuarios 21-30
INSERT INTO `saceam`.`usuario` (`nombre_usuario`, `correro`, `contraseña`, `id_persona`) VALUES ('jorge_m', 'jorge.m@email.com', 'pass310', 21);
INSERT INTO `saceam`.`usuario` (`nombre_usuario`, `correro`, `contraseña`, `id_persona`) VALUES ('diana_g', 'diana.g@email.com', 'pass321', 22);
INSERT INTO `saceam`.`usuario` (`nombre_usuario`, `correro`, `contraseña`, `id_persona`) VALUES ('sergio_h', 'sergio.h@email.com', 'pass332', 23);
INSERT INTO `saceam`.`usuario` (`nombre_usuario`, `correro`, `contraseña`, `id_persona`) VALUES ('monica_s', 'monica.s@email.com', 'pass343', 24);
INSERT INTO `saceam`.`usuario` (`nombre_usuario`, `correro`, `contraseña`, `id_persona`) VALUES ('daniel_m', 'daniel.m@email.com', 'pass354', 25);
INSERT INTO `saceam`.`usuario` (`nombre_usuario`, `correro`, `contraseña`, `id_persona`) VALUES ('lorena_p', 'lorena.p@email.com', 'pass365', 26);
INSERT INTO `saceam`.`usuario` (`nombre_usuario`, `correro`, `contraseña`, `id_persona`) VALUES ('eduardo_r', 'eduardo.r@email.com', 'pass376', 27);
INSERT INTO `saceam`.`usuario` (`nombre_usuario`, `correro`, `contraseña`, `id_persona`) VALUES ('paola_l', 'paola.l@email.com', 'pass387', 28);
INSERT INTO `saceam`.`usuario` (`nombre_usuario`, `correro`, `contraseña`, `id_persona`) VALUES ('alberto_a', 'alberto.a@email.com', 'pass398', 29);
INSERT INTO `saceam`.`usuario` (`nombre_usuario`, `correro`, `contraseña`, `id_persona`) VALUES ('marcela_s', 'marcela.s@email.com', 'pass409', 30);

-- Usuarios del 31 al 80 (abreviados para no hacer el script muy largo)
INSERT INTO `saceam`.`usuario` (`nombre_usuario`, `correro`, `contraseña`, `id_persona`) VALUES ('user31', 'user31@email.com', 'pass31', 31);
INSERT INTO `saceam`.`usuario` (`nombre_usuario`, `correro`, `contraseña`, `id_persona`) VALUES ('user32', 'user32@email.com', 'pass32', 32);
INSERT INTO `saceam`.`usuario` (`nombre_usuario`, `correro`, `contraseña`, `id_persona`) VALUES ('user33', 'user33@email.com', 'pass33', 33);
INSERT INTO `saceam`.`usuario` (`nombre_usuario`, `correro`, `contraseña`, `id_persona`) VALUES ('user34', 'user34@email.com', 'pass34', 34);
INSERT INTO `saceam`.`usuario` (`nombre_usuario`, `correro`, `contraseña`, `id_persona`) VALUES ('user35', 'user35@email.com', 'pass35', 35);
INSERT INTO `saceam`.`usuario` (`nombre_usuario`, `correro`, `contraseña`, `id_persona`) VALUES ('user36', 'user36@email.com', 'pass36', 36);
INSERT INTO `saceam`.`usuario` (`nombre_usuario`, `correro`, `contraseña`, `id_persona`) VALUES ('user37', 'user37@email.com', 'pass37', 37);
INSERT INTO `saceam`.`usuario` (`nombre_usuario`, `correro`, `contraseña`, `id_persona`) VALUES ('user38', 'user38@email.com', 'pass38', 38);
INSERT INTO `saceam`.`usuario` (`nombre_usuario`, `correro`, `contraseña`, `id_persona`) VALUES ('user39', 'user39@email.com', 'pass39', 39);
INSERT INTO `saceam`.`usuario` (`nombre_usuario`, `correro`, `contraseña`, `id_persona`) VALUES ('user40', 'user40@email.com', 'pass40', 40);
INSERT INTO `saceam`.`usuario` (`nombre_usuario`, `correro`, `contraseña`, `id_persona`) VALUES ('user41', 'user41@email.com', 'pass41', 41);
INSERT INTO `saceam`.`usuario` (`nombre_usuario`, `correro`, `contraseña`, `id_persona`) VALUES ('user42', 'user42@email.com', 'pass42', 42);
INSERT INTO `saceam`.`usuario` (`nombre_usuario`, `correro`, `contraseña`, `id_persona`) VALUES ('user43', 'user43@email.com', 'pass43', 43);
INSERT INTO `saceam`.`usuario` (`nombre_usuario`, `correro`, `contraseña`, `id_persona`) VALUES ('user44', 'user44@email.com', 'pass44', 44);
INSERT INTO `saceam`.`usuario` (`nombre_usuario`, `correro`, `contraseña`, `id_persona`) VALUES ('user45', 'user45@email.com', 'pass45', 45);
INSERT INTO `saceam`.`usuario` (`nombre_usuario`, `correro`, `contraseña`, `id_persona`) VALUES ('user46', 'user46@email.com', 'pass46', 46);
INSERT INTO `saceam`.`usuario` (`nombre_usuario`, `correro`, `contraseña`, `id_persona`) VALUES ('user47', 'user47@email.com', 'pass47', 47);
INSERT INTO `saceam`.`usuario` (`nombre_usuario`, `correro`, `contraseña`, `id_persona`) VALUES ('user48', 'user48@email.com', 'pass48', 48);
INSERT INTO `saceam`.`usuario` (`nombre_usuario`, `correro`, `contraseña`, `id_persona`) VALUES ('user49', 'user49@email.com', 'pass49', 49);
INSERT INTO `saceam`.`usuario` (`nombre_usuario`, `correro`, `contraseña`, `id_persona`) VALUES ('user50', 'user50@email.com', 'pass50', 50);
INSERT INTO `saceam`.`usuario` (`nombre_usuario`, `correro`, `contraseña`, `id_persona`) VALUES ('user51', 'user51@email.com', 'pass51', 51);
INSERT INTO `saceam`.`usuario` (`nombre_usuario`, `correro`, `contraseña`, `id_persona`) VALUES ('user52', 'user52@email.com', 'pass52', 52);
INSERT INTO `saceam`.`usuario` (`nombre_usuario`, `correro`, `contraseña`, `id_persona`) VALUES ('user53', 'user53@email.com', 'pass53', 53);
INSERT INTO `saceam`.`usuario` (`nombre_usuario`, `correro`, `contraseña`, `id_persona`) VALUES ('user54', 'user54@email.com', 'pass54', 54);
INSERT INTO `saceam`.`usuario` (`nombre_usuario`, `correro`, `contraseña`, `id_persona`) VALUES ('user55', 'user55@email.com', 'pass55', 55);
INSERT INTO `saceam`.`usuario` (`nombre_usuario`, `correro`, `contraseña`, `id_persona`) VALUES ('user56', 'user56@email.com', 'pass56', 56);
INSERT INTO `saceam`.`usuario` (`nombre_usuario`, `correro`, `contraseña`, `id_persona`) VALUES ('user57', 'user57@email.com', 'pass57', 57);
INSERT INTO `saceam`.`usuario` (`nombre_usuario`, `correro`, `contraseña`, `id_persona`) VALUES ('user58', 'user58@email.com', 'pass58', 58);
INSERT INTO `saceam`.`usuario` (`nombre_usuario`, `correro`, `contraseña`, `id_persona`) VALUES ('user59', 'user59@email.com', 'pass59', 59);
INSERT INTO `saceam`.`usuario` (`nombre_usuario`, `correro`, `contraseña`, `id_persona`) VALUES ('user60', 'user60@email.com', 'pass60', 60);
INSERT INTO `saceam`.`usuario` (`nombre_usuario`, `correro`, `contraseña`, `id_persona`) VALUES ('user61', 'user61@email.com', 'pass61', 61);
INSERT INTO `saceam`.`usuario` (`nombre_usuario`, `correro`, `contraseña`, `id_persona`) VALUES ('user62', 'user62@email.com', 'pass62', 62);
INSERT INTO `saceam`.`usuario` (`nombre_usuario`, `correro`, `contraseña`, `id_persona`) VALUES ('user63', 'user63@email.com', 'pass63', 63);
INSERT INTO `saceam`.`usuario` (`nombre_usuario`, `correro`, `contraseña`, `id_persona`) VALUES ('user64', 'user64@email.com', 'pass64', 64);
INSERT INTO `saceam`.`usuario` (`nombre_usuario`, `correro`, `contraseña`, `id_persona`) VALUES ('user65', 'user65@email.com', 'pass65', 65);
INSERT INTO `saceam`.`usuario` (`nombre_usuario`, `correro`, `contraseña`, `id_persona`) VALUES ('user66', 'user66@email.com', 'pass66', 66);
INSERT INTO `saceam`.`usuario` (`nombre_usuario`, `correro`, `contraseña`, `id_persona`) VALUES ('user67', 'user67@email.com', 'pass67', 67);
INSERT INTO `saceam`.`usuario` (`nombre_usuario`, `correro`, `contraseña`, `id_persona`) VALUES ('user68', 'user68@email.com', 'pass68', 68);
INSERT INTO `saceam`.`usuario` (`nombre_usuario`, `correro`, `contraseña`, `id_persona`) VALUES ('user69', 'user69@email.com', 'pass69', 69);
INSERT INTO `saceam`.`usuario` (`nombre_usuario`, `correro`, `contraseña`, `id_persona`) VALUES ('user70', 'user70@email.com', 'pass70', 70);
INSERT INTO `saceam`.`usuario` (`nombre_usuario`, `correro`, `contraseña`, `id_persona`) VALUES ('user71', 'user71@email.com', 'pass71', 71);
INSERT INTO `saceam`.`usuario` (`nombre_usuario`, `correro`, `contraseña`, `id_persona`) VALUES ('user72', 'user72@email.com', 'pass72', 72);
INSERT INTO `saceam`.`usuario` (`nombre_usuario`, `correro`, `contraseña`, `id_persona`) VALUES ('user73', 'user73@email.com', 'pass73', 73);
INSERT INTO `saceam`.`usuario` (`nombre_usuario`, `correro`, `contraseña`, `id_persona`) VALUES ('user74', 'user74@email.com', 'pass74', 74);
INSERT INTO `saceam`.`usuario` (`nombre_usuario`, `correro`, `contraseña`, `id_persona`) VALUES ('user75', 'user75@email.com', 'pass75', 75);
INSERT INTO `saceam`.`usuario` (`nombre_usuario`, `correro`, `contraseña`, `id_persona`) VALUES ('user76', 'user76@email.com', 'pass76', 76);
INSERT INTO `saceam`.`usuario` (`nombre_usuario`, `correro`, `contraseña`, `id_persona`) VALUES ('user77', 'user77@email.com', 'pass77', 77);
INSERT INTO `saceam`.`usuario` (`nombre_usuario`, `correro`, `contraseña`, `id_persona`) VALUES ('user78', 'user78@email.com', 'pass78', 78);
INSERT INTO `saceam`.`usuario` (`nombre_usuario`, `correro`, `contraseña`, `id_persona`) VALUES ('user79', 'user79@email.com', 'pass79', 79);
INSERT INTO `saceam`.`usuario` (`nombre_usuario`, `correro`, `contraseña`, `id_persona`) VALUES ('user80', 'user80@email.com', 'pass80', 80);

-- Insertar 30 docentes (del id_persona 1 al 30)
INSERT INTO `saceam`.`docente` (`persona_id_persona`, `sueldo`) VALUES (1, 3500000);
INSERT INTO `saceam`.`docente` (`persona_id_persona`, `sueldo`) VALUES (2, 3600000);
INSERT INTO `saceam`.`docente` (`persona_id_persona`, `sueldo`) VALUES (3, 3700000);
INSERT INTO `saceam`.`docente` (`persona_id_persona`, `sueldo`) VALUES (4, 3800000);
INSERT INTO `saceam`.`docente` (`persona_id_persona`, `sueldo`) VALUES (5, 3900000);
INSERT INTO `saceam`.`docente` (`persona_id_persona`, `sueldo`) VALUES (6, 4000000);
INSERT INTO `saceam`.`docente` (`persona_id_persona`, `sueldo`) VALUES (7, 4100000);
INSERT INTO `saceam`.`docente` (`persona_id_persona`, `sueldo`) VALUES (8, 4200000);
INSERT INTO `saceam`.`docente` (`persona_id_persona`, `sueldo`) VALUES (9, 4300000);
INSERT INTO `saceam`.`docente` (`persona_id_persona`, `sueldo`) VALUES (10, 4400000);
INSERT INTO `saceam`.`docente` (`persona_id_persona`, `sueldo`) VALUES (11, 3550000);
INSERT INTO `saceam`.`docente` (`persona_id_persona`, `sueldo`) VALUES (12, 3650000);
INSERT INTO `saceam`.`docente` (`persona_id_persona`, `sueldo`) VALUES (13, 3750000);
INSERT INTO `saceam`.`docente` (`persona_id_persona`, `sueldo`) VALUES (14, 3850000);
INSERT INTO `saceam`.`docente` (`persona_id_persona`, `sueldo`) VALUES (15, 3950000);
INSERT INTO `saceam`.`docente` (`persona_id_persona`, `sueldo`) VALUES (16, 4050000);
INSERT INTO `saceam`.`docente` (`persona_id_persona`, `sueldo`) VALUES (17, 4150000);
INSERT INTO `saceam`.`docente` (`persona_id_persona`, `sueldo`) VALUES (18, 4250000);
INSERT INTO `saceam`.`docente` (`persona_id_persona`, `sueldo`) VALUES (19, 4350000);
INSERT INTO `saceam`.`docente` (`persona_id_persona`, `sueldo`) VALUES (20, 4450000);
INSERT INTO `saceam`.`docente` (`persona_id_persona`, `sueldo`) VALUES (21, 3525000);
INSERT INTO `saceam`.`docente` (`persona_id_persona`, `sueldo`) VALUES (22, 3625000);
INSERT INTO `saceam`.`docente` (`persona_id_persona`, `sueldo`) VALUES (23, 3725000);
INSERT INTO `saceam`.`docente` (`persona_id_persona`, `sueldo`) VALUES (24, 3825000);
INSERT INTO `saceam`.`docente` (`persona_id_persona`, `sueldo`) VALUES (25, 3925000);
INSERT INTO `saceam`.`docente` (`persona_id_persona`, `sueldo`) VALUES (26, 4025000);
INSERT INTO `saceam`.`docente` (`persona_id_persona`, `sueldo`) VALUES (27, 4125000);
INSERT INTO `saceam`.`docente` (`persona_id_persona`, `sueldo`) VALUES (28, 4225000);
INSERT INTO `saceam`.`docente` (`persona_id_persona`, `sueldo`) VALUES (29, 4325000);
INSERT INTO `saceam`.`docente` (`persona_id_persona`, `sueldo`) VALUES (30, 4425000);

-- Insertar 50 estudiantes (del id_persona 31 al 80)
INSERT INTO `saceam`.`estudiante` (`id_persona`, `es_articulacion`, `fecha_ingreso`, `estado`) VALUES (31, 1, '2020-01-15', 'activo');
INSERT INTO `saceam`.`estudiante` (`id_persona`, `es_articulacion`, `fecha_ingreso`, `estado`) VALUES (32, 0, '2020-01-15', 'activo');
INSERT INTO `saceam`.`estudiante` (`id_persona`, `es_articulacion`, `fecha_ingreso`, `estado`) VALUES (33, 1, '2020-01-15', 'activo');
INSERT INTO `saceam`.`estudiante` (`id_persona`, `es_articulacion`, `fecha_ingreso`, `estado`) VALUES (34, 0, '2020-01-15', 'activo');
INSERT INTO `saceam`.`estudiante` (`id_persona`, `es_articulacion`, `fecha_ingreso`, `estado`) VALUES (35, 1, '2020-01-15', 'activo');
INSERT INTO `saceam`.`estudiante` (`id_persona`, `es_articulacion`, `fecha_ingreso`, `estado`) VALUES (36, 0, '2020-01-15', 'activo');
INSERT INTO `saceam`.`estudiante` (`id_persona`, `es_articulacion`, `fecha_ingreso`, `estado`) VALUES (37, 1, '2020-01-15', 'activo');
INSERT INTO `saceam`.`estudiante` (`id_persona`, `es_articulacion`, `fecha_ingreso`, `estado`) VALUES (38, 0, '2020-01-15', 'activo');
INSERT INTO `saceam`.`estudiante` (`id_persona`, `es_articulacion`, `fecha_ingreso`, `estado`) VALUES (39, 1, '2020-01-15', 'activo');
INSERT INTO `saceam`.`estudiante` (`id_persona`, `es_articulacion`, `fecha_ingreso`, `estado`) VALUES (40, 0, '2020-01-15', 'activo');
INSERT INTO `saceam`.`estudiante` (`id_persona`, `es_articulacion`, `fecha_ingreso`, `estado`) VALUES (41, 1, '2021-01-15', 'activo');
INSERT INTO `saceam`.`estudiante` (`id_persona`, `es_articulacion`, `fecha_ingreso`, `estado`) VALUES (42, 0, '2021-01-15', 'activo');
INSERT INTO `saceam`.`estudiante` (`id_persona`, `es_articulacion`, `fecha_ingreso`, `estado`) VALUES (43, 1, '2021-01-15', 'activo');
INSERT INTO `saceam`.`estudiante` (`id_persona`, `es_articulacion`, `fecha_ingreso`, `estado`) VALUES (44, 0, '2021-01-15', 'activo');
INSERT INTO `saceam`.`estudiante` (`id_persona`, `es_articulacion`, `fecha_ingreso`, `estado`) VALUES (45, 1, '2021-01-15', 'activo');
INSERT INTO `saceam`.`estudiante` (`id_persona`, `es_articulacion`, `fecha_ingreso`, `estado`) VALUES (46, 0, '2021-01-15', 'activo');
INSERT INTO `saceam`.`estudiante` (`id_persona`, `es_articulacion`, `fecha_ingreso`, `estado`) VALUES (47, 1, '2021-01-15', 'activo');
INSERT INTO `saceam`.`estudiante` (`id_persona`, `es_articulacion`, `fecha_ingreso`, `estado`) VALUES (48, 0, '2021-01-15', 'activo');
INSERT INTO `saceam`.`estudiante` (`id_persona`, `es_articulacion`, `fecha_ingreso`, `estado`) VALUES (49, 1, '2021-01-15', 'activo');
INSERT INTO `saceam`.`estudiante` (`id_persona`, `es_articulacion`, `fecha_ingreso`, `estado`) VALUES (50, 0, '2021-01-15', 'activo');
INSERT INTO `saceam`.`estudiante` (`id_persona`, `es_articulacion`, `fecha_ingreso`, `estado`) VALUES (51, 1, '2022-01-15', 'activo');
INSERT INTO `saceam`.`estudiante` (`id_persona`, `es_articulacion`, `fecha_ingreso`, `estado`) VALUES (52, 0, '2022-01-15', 'activo');
INSERT INTO `saceam`.`estudiante` (`id_persona`, `es_articulacion`, `fecha_ingreso`, `estado`) VALUES (53, 1, '2022-01-15', 'activo');
INSERT INTO `saceam`.`estudiante` (`id_persona`, `es_articulacion`, `fecha_ingreso`, `estado`) VALUES (54, 0, '2022-01-15', 'activo');
INSERT INTO `saceam`.`estudiante` (`id_persona`, `es_articulacion`, `fecha_ingreso`, `estado`) VALUES (55, 1, '2022-01-15', 'activo');
INSERT INTO `saceam`.`estudiante` (`id_persona`, `es_articulacion`, `fecha_ingreso`, `estado`) VALUES (56, 0, '2022-01-15', 'activo');
INSERT INTO `saceam`.`estudiante` (`id_persona`, `es_articulacion`, `fecha_ingreso`, `estado`) VALUES (57, 1, '2022-01-15', 'activo');
INSERT INTO `saceam`.`estudiante` (`id_persona`, `es_articulacion`, `fecha_ingreso`, `estado`) VALUES (58, 0, '2022-01-15', 'activo');
INSERT INTO `saceam`.`estudiante` (`id_persona`, `es_articulacion`, `fecha_ingreso`, `estado`) VALUES (59, 1, '2022-01-15', 'activo');
INSERT INTO `saceam`.`estudiante` (`id_persona`, `es_articulacion`, `fecha_ingreso`, `estado`) VALUES (60, 0, '2022-01-15', 'activo');
INSERT INTO `saceam`.`estudiante` (`id_persona`, `es_articulacion`, `fecha_ingreso`, `estado`) VALUES (61, 1, '2023-01-15', 'activo');
INSERT INTO `saceam`.`estudiante` (`id_persona`, `es_articulacion`, `fecha_ingreso`, `estado`) VALUES (62, 0, '2023-01-15', 'activo');
INSERT INTO `saceam`.`estudiante` (`id_persona`, `es_articulacion`, `fecha_ingreso`, `estado`) VALUES (63, 1, '2023-01-15', 'activo');
INSERT INTO `saceam`.`estudiante` (`id_persona`, `es_articulacion`, `fecha_ingreso`, `estado`) VALUES (64, 0, '2023-01-15', 'activo');
INSERT INTO `saceam`.`estudiante` (`id_persona`, `es_articulacion`, `fecha_ingreso`, `estado`) VALUES (65, 1, '2023-01-15', 'activo');
INSERT INTO `saceam`.`estudiante` (`id_persona`, `es_articulacion`, `fecha_ingreso`, `estado`) VALUES (66, 0, '2023-01-15', 'activo');
INSERT INTO `saceam`.`estudiante` (`id_persona`, `es_articulacion`, `fecha_ingreso`, `estado`) VALUES (67, 1, '2023-01-15', 'activo');
INSERT INTO `saceam`.`estudiante` (`id_persona`, `es_articulacion`, `fecha_ingreso`, `estado`) VALUES (68, 0, '2023-01-15', 'activo');
INSERT INTO `saceam`.`estudiante` (`id_persona`, `es_articulacion`, `fecha_ingreso`, `estado`) VALUES (69, 1, '2023-01-15', 'activo');
INSERT INTO `saceam`.`estudiante` (`id_persona`, `es_articulacion`, `fecha_ingreso`, `estado`) VALUES (70, 0, '2023-01-15', 'activo');
INSERT INTO `saceam`.`estudiante` (`id_persona`, `es_articulacion`, `fecha_ingreso`, `estado`) VALUES (71, 1, '2024-01-15', 'activo');
INSERT INTO `saceam`.`estudiante` (`id_persona`, `es_articulacion`, `fecha_ingreso`, `estado`) VALUES (72, 0, '2024-01-15', 'activo');
INSERT INTO `saceam`.`estudiante` (`id_persona`, `es_articulacion`, `fecha_ingreso`, `estado`) VALUES (73, 1, '2024-01-15', 'activo');
INSERT INTO `saceam`.`estudiante` (`id_persona`, `es_articulacion`, `fecha_ingreso`, `estado`) VALUES (74, 0, '2024-01-15', 'activo');
INSERT INTO `saceam`.`estudiante` (`id_persona`, `es_articulacion`, `fecha_ingreso`, `estado`) VALUES (75, 1, '2024-01-15', 'activo');
INSERT INTO `saceam`.`estudiante` (`id_persona`, `es_articulacion`, `fecha_ingreso`, `estado`) VALUES (76, 0, '2024-01-15', 'activo');
INSERT INTO `saceam`.`estudiante` (`id_persona`, `es_articulacion`, `fecha_ingreso`, `estado`) VALUES (77, 1, '2024-01-15', 'activo');
INSERT INTO `saceam`.`estudiante` (`id_persona`, `es_articulacion`, `fecha_ingreso`, `estado`) VALUES (78, 0, '2024-01-15', 'activo');
INSERT INTO `saceam`.`estudiante` (`id_persona`, `es_articulacion`, `fecha_ingreso`, `estado`) VALUES (79, 1, '2024-01-15', 'activo');
INSERT INTO `saceam`.`estudiante` (`id_persona`, `es_articulacion`, `fecha_ingreso`, `estado`) VALUES (80, 0, '2024-01-15', 'activo');