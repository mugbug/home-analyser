-- MySQL Script generated by MySQL Workbench
-- Sun Apr 23 12:07:18 2017
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`User` (
  `cpf` VARCHAR(14) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `isAdmin` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`cpf`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Client` (
  `idClient` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL DEFAULT '',
  `address` VARCHAR(100) NULL DEFAULT '',
  `age` INT NULL DEFAULT 0,
  `cpf` VARCHAR(14) NOT NULL,
  PRIMARY KEY (`idClient`, `cpf`),
  INDEX `fk_Client_User1_idx` (`cpf` ASC),
  UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC),
  CONSTRAINT `fk_Client_User1`
    FOREIGN KEY (`cpf`)
    REFERENCES `mydb`.`User` (`cpf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Agency`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Agency` (
  `idAgency` INT NOT NULL AUTO_INCREMENT,
  `address` VARCHAR(100) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idAgency`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Manager`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Manager` (
  `idManager` INT NOT NULL AUTO_INCREMENT,
  `Agency_idAgency` INT NOT NULL,
  `cpf` VARCHAR(14) NOT NULL,
  PRIMARY KEY (`idManager`, `cpf`, `Agency_idAgency`),
  INDEX `fk_Manager_Agency1_idx` (`Agency_idAgency` ASC),
  INDEX `fk_Manager_User1_idx` (`cpf` ASC),
  UNIQUE INDEX `Agency_idAgency_UNIQUE` (`Agency_idAgency` ASC),
  UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC),
  CONSTRAINT `fk_Manager_Agency1`
    FOREIGN KEY (`Agency_idAgency`)
    REFERENCES `mydb`.`Agency` (`idAgency`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Manager_User1`
    FOREIGN KEY (`cpf`)
    REFERENCES `mydb`.`User` (`cpf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Equipment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Equipment` (
  `idEquipment` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `power` INT NOT NULL,
  `User_cpf` VARCHAR(14) NOT NULL,
  PRIMARY KEY (`idEquipment`),
  INDEX `fk_Equipment_User1_idx` (`User_cpf` ASC),
  CONSTRAINT `fk_Equipment_User1`
    FOREIGN KEY (`User_cpf`)
    REFERENCES `mydb`.`User` (`cpf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Consumption`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Consumption` (
  `idConsumption` INT NOT NULL AUTO_INCREMENT,
  `day` DATE NULL DEFAULT NULL,
  `kwh_price` FLOAT NULL DEFAULT 0,
  `daily_usage` FLOAT NULL DEFAULT 0,
  `quantity` INT NULL DEFAULT 0,
  `Equipment_idEquipment` INT NULL,
  `User_cpf` VARCHAR(14) NOT NULL,
  PRIMARY KEY (`idConsumption`),
  INDEX `fk_Consumption_Equipment1_idx` (`Equipment_idEquipment` ASC),
  INDEX `fk_Consumption_User1_idx` (`User_cpf` ASC),
  UNIQUE INDEX `day_UNIQUE` (`day` ASC),
  CONSTRAINT `fk_Consumption_Equipment1`
    FOREIGN KEY (`Equipment_idEquipment`)
    REFERENCES `mydb`.`Equipment` (`idEquipment`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Consumption_User1`
    FOREIGN KEY (`User_cpf`)
    REFERENCES `mydb`.`User` (`cpf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Support`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Support` (
  `idSupport` INT NOT NULL,
  `isAvailable` TINYINT NULL DEFAULT 1,
  `phone` VARCHAR(15) NULL DEFAULT '',
  `protocol` VARCHAR(45) NULL DEFAULT '',
  `Agency_idAgency` INT NULL DEFAULT NULL,
  `Client_idClient` INT NULL DEFAULT NULL,
  PRIMARY KEY (`idSupport`),
  INDEX `fk_Support_Agency1_idx` (`Agency_idAgency` ASC),
  INDEX `fk_Support_Client1_idx` (`Client_idClient` ASC),
  CONSTRAINT `fk_Support_Agency1`
    FOREIGN KEY (`Agency_idAgency`)
    REFERENCES `mydb`.`Agency` (`idAgency`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Support_Client1`
    FOREIGN KEY (`Client_idClient`)
    REFERENCES `mydb`.`Client` (`idClient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;