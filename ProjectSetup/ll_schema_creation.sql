-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema LittleLemonDB
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema LittleLemonDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `LittleLemonDB` DEFAULT CHARACTER SET utf8 ;
USE `LittleLemonDB` ;

-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Customers` (
  `CustomerID` INT NOT NULL,
  `CustomerName` VARCHAR(100) NOT NULL,
  `CustomerEmail` VARCHAR(155) NULL,
  PRIMARY KEY (`CustomerID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Staff` (
  `EmployeeID` INT NOT NULL,
  `EmployeeName` VARCHAR(155) NOT NULL,
  `EmployeeRole` VARCHAR(100) NOT NULL,
  `EmployeeSalary` DECIMAL(6,2) NOT NULL,
  `EmployeeEmail` VARCHAR(75) NOT NULL,
  PRIMARY KEY (`EmployeeID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Bookings` (
  `BookingID` INT NOT NULL,
  `BookingDate` DATETIME NOT NULL,
  `TableNo` INT NOT NULL,
  `BookingCustomerID` INT NOT NULL,
  `EmployeeID` INT NULL,
  PRIMARY KEY (`BookingID`),
  INDEX `bk_customer_idx` (`BookingCustomerID` ASC) VISIBLE,
  INDEX `bk_staff_idx` (`EmployeeID` ASC) VISIBLE,
  CONSTRAINT `bk_customer`
    FOREIGN KEY (`BookingCustomerID`)
    REFERENCES `LittleLemonDB`.`Customers` (`CustomerID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `bk_staff`
    FOREIGN KEY (`EmployeeID`)
    REFERENCES `LittleLemonDB`.`Staff` (`EmployeeID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`MenuItems`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`MenuItems` (
  `MenuItemID` INT NOT NULL,
  `Course` VARCHAR(150) NOT NULL,
  `Starter` VARCHAR(150) NOT NULL,
  `Desert` VARCHAR(150) NOT NULL,
  PRIMARY KEY (`MenuItemID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Menu` (
  `MenuID` INT NOT NULL,
  `MenuName` VARCHAR(150) NOT NULL,
  `CuisineCategoyr` VARCHAR(150) NOT NULL,
  `MenuItemID` INT NOT NULL,
  PRIMARY KEY (`MenuID`),
  INDEX `menu_menuitem_idx` (`MenuItemID` ASC) VISIBLE,
  CONSTRAINT `menu_menuitem`
    FOREIGN KEY (`MenuItemID`)
    REFERENCES `LittleLemonDB`.`MenuItems` (`MenuItemID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Orders` (
  `OrderID` INT NOT NULL,
  `OrderDate` DATETIME NOT NULL,
  `OrderQuantity` INT NOT NULL,
  `OrderBillAmount` DECIMAL(6,2) NOT NULL,
  `OrderingCustomerID` INT NOT NULL,
  `OrderMenuID` INT NOT NULL,
  PRIMARY KEY (`OrderID`),
  INDEX `ord_customer_idx` (`OrderingCustomerID` ASC) VISIBLE,
  INDEX `ord_menu_idx` (`OrderMenuID` ASC) VISIBLE,
  CONSTRAINT `ord_customer`
    FOREIGN KEY (`OrderingCustomerID`)
    REFERENCES `LittleLemonDB`.`Customers` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `ord_menu`
    FOREIGN KEY (`OrderMenuID`)
    REFERENCES `LittleLemonDB`.`Menu` (`MenuID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Delivery`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Delivery` (
  `DeliveryID` INT NOT NULL,
  `DeliveryStatus` VARCHAR(150) NOT NULL,
  `DeliveryTime` DATETIME NOT NULL,
  `DeliveryOrderID` INT NOT NULL,
  `EmployeeID` INT NOT NULL,
  PRIMARY KEY (`DeliveryID`),
  INDEX `delivery_orders_idx` (`DeliveryOrderID` ASC) VISIBLE,
  INDEX `delivery_emplyee_idx` (`EmployeeID` ASC) VISIBLE,
  CONSTRAINT `delivery_orders`
    FOREIGN KEY (`DeliveryOrderID`)
    REFERENCES `LittleLemonDB`.`Orders` (`OrderID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `delivery_emplyee`
    FOREIGN KEY (`EmployeeID`)
    REFERENCES `LittleLemonDB`.`Staff` (`EmployeeID`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
