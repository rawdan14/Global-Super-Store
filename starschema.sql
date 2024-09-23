-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Globalsuperstore
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Globalsuperstore
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Globalsuperstore` DEFAULT CHARACTER SET utf8 ;
USE `Globalsuperstore` ;

-- -----------------------------------------------------
-- Table `Globalsuperstore`.`Customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Globalsuperstore`.`Customers` (
  `CustomerID` INT NOT NULL,
  `FullName` VARCHAR(255) NOT NULL,
  `ContactNumber` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`CustomerID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Globalsuperstore`.`Products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Globalsuperstore`.`Products` (
  `ProductID` INT NOT NULL,
  `ProductName` VARCHAR(255) NOT NULL,
  `AmountInStock` INT NOT NULL,
  `Price` DECIMAL NOT NULL,
  `Category` VARCHAR(45) NOT NULL,
  `Subcategory` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ProductID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Globalsuperstore`.`DeliveryAddress`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Globalsuperstore`.`DeliveryAddress` (
  `AddressID` INT NOT NULL,
  `Street` VARCHAR(255) NOT NULL,
  `PostCode` VARCHAR(45) NOT NULL,
  `City` VARCHAR(45) NOT NULL,
  `State` VARCHAR(45) NOT NULL,
  `Country` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`AddressID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Globalsuperstore`.`Shipping`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Globalsuperstore`.`Shipping` (
  `ShipID` INT NOT NULL,
  `ShipDate` DATE NOT NULL,
  `ShipMode` VARCHAR(45) NOT NULL,
  `AddressID` INT NOT NULL,
  `ShipCost` DECIMAL NOT NULL,
  PRIMARY KEY (`ShipID`),
  INDEX `AddressID_fk_idx` (`AddressID` ASC) VISIBLE,
  CONSTRAINT `AddressID_fk`
    FOREIGN KEY (`AddressID`)
    REFERENCES `Globalsuperstore`.`DeliveryAddress` (`AddressID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Globalsuperstore`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Globalsuperstore`.`Orders` (
  `OrderID` INT NOT NULL,
  `CustomerID` INT NOT NULL,
  `ProductID` INT NOT NULL,
  `DeliveryID` INT NOT NULL,
  `Quantity` INT NOT NULL,
  `TotalCost` DECIMAL NOT NULL,
  `OrderPriority` VARCHAR(255) NOT NULL,
  `Discount` DECIMAL NOT NULL,
  `ShipID` INT NOT NULL,
  PRIMARY KEY (`OrderID`),
  INDEX `CustomerID_fk_idx` (`CustomerID` ASC) VISIBLE,
  INDEX `ProductID_fk_idx` (`ProductID` ASC) VISIBLE,
  INDEX `ShipID_fk_idx` (`ShipID` ASC) VISIBLE,
  CONSTRAINT `CustomerID_fk`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `Globalsuperstore`.`Customers` (`CustomerID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `ProductID_fk`
    FOREIGN KEY (`ProductID`)
    REFERENCES `Globalsuperstore`.`Products` (`ProductID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `ShipID_fk`
    FOREIGN KEY (`ShipID`)
    REFERENCES `Globalsuperstore`.`Shipping` (`ShipID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Globalsuperstore`.`Location`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Globalsuperstore`.`Location` (
  `LocationID` INT NOT NULL,
  `Continent` VARCHAR(45) NOT NULL,
  `Country` VARCHAR(45) NOT NULL,
  `City` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`LocationID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Globalsuperstore`.`Products_`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Globalsuperstore`.`Products_` (
  `ProductID` INT NOT NULL,
  `ProductName` VARCHAR(255) NOT NULL,
  `Category` VARCHAR(45) NOT NULL,
  `Subcategory` VARCHAR(45) NOT NULL,
  `Description` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`ProductID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Globalsuperstore`.`Time`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Globalsuperstore`.`Time` (
  `TimeID` INT NOT NULL,
  `FullDate` DATE NOT NULL,
  `Year` INT NOT NULL,
  `Quarter` VARCHAR(45) NOT NULL,
  `Month` INT NOT NULL,
  `Event` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`TimeID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Globalsuperstore`.`Sales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Globalsuperstore`.`Sales` (
  `SalesID` INT NOT NULL,
  `Price` DECIMAL NOT NULL,
  `Coat` DECIMAL NOT NULL,
  `Shipping` DECIMAL NOT NULL,
  `Quantity` INT NOT NULL,
  `LocationID` INT NOT NULL,
  `ProductID` INT NOT NULL,
  `TimeID` INT NOT NULL,
  PRIMARY KEY (`SalesID`),
  INDEX `LocationID_fk_idx` (`LocationID` ASC) VISIBLE,
  INDEX `ProductID_idx` (`ProductID` ASC) VISIBLE,
  INDEX `TimeID_fk_idx` (`TimeID` ASC) VISIBLE,
  CONSTRAINT `LocationID_fk`
    FOREIGN KEY (`LocationID`)
    REFERENCES `Globalsuperstore`.`Location` (`LocationID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `ProductID_fk`
    FOREIGN KEY (`ProductID`)
    REFERENCES `Globalsuperstore`.`Products_` (`ProductID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `TimeID_fk`
    FOREIGN KEY (`TimeID`)
    REFERENCES `Globalsuperstore`.`Time` (`TimeID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
