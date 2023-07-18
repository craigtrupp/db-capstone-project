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
-- Table `LittleLemonDB`.`Staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Staff` (
  `EmployeeID` INT NOT NULL,
  `EmployeeName` VARCHAR(100) NOT NULL,
  `EmployeePhone` VARCHAR(50) NULL,
  `EmployeeEmail` VARCHAR(100) NULL,
  `EmployeeRole` VARCHAR(100) NOT NULL,
  `EmployeeSalary` DECIMAL(6,2) NOT NULL,
  PRIMARY KEY (`EmployeeID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Customers` (
  `CustomerID` INT NOT NULL,
  `CustomerName` VARCHAR(100) NOT NULL,
  `CustomerEmail` VARCHAR(100) NULL,
  `CustomerPhone` VARCHAR(50) NULL,
  PRIMARY KEY (`CustomerID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Bookings` (
  `BookingID` INT NOT NULL,
  `BookingDate` DATETIME NOT NULL,
  `TableNumber` INT NOT NULL,
  `BookingCustomer` INT NOT NULL,
  `BookingEmployee` INT NOT NULL,
  PRIMARY KEY (`BookingID`),
  INDEX `bk_employee_staff_idx` (`BookingEmployee` ASC) VISIBLE,
  INDEX `bk_customer_idx` (`BookingCustomer` ASC) VISIBLE,
  CONSTRAINT `bk_employee_staff`
    FOREIGN KEY (`BookingEmployee`)
    REFERENCES `LittleLemonDB`.`Staff` (`EmployeeID`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `bk_customer`
    FOREIGN KEY (`BookingCustomer`)
    REFERENCES `LittleLemonDB`.`Customers` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Menu` (
  `MenuItemID` INT NOT NULL,
  `MenuItemDescription` VARCHAR(255) NOT NULL,
  `MenuItemPrice` DECIMAL(6,2) NOT NULL,
  `MenuItemName` VARCHAR(100) NOT NULL,
  `MenuItemCategory` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`MenuItemID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Orders` (
  `OrderID` INT NOT NULL,
  `OrderDate` DATETIME NOT NULL,
  `OrderQuantity` INT NOT NULL,
  `TotalCost` DECIMAL(6,2) NOT NULL,
  `OrderBookingID` INT NOT NULL,
  `OrderCustomerID` INT NOT NULL,
  `OrderMenuItemID` INT NOT NULL,
  PRIMARY KEY (`OrderID`),
  INDEX `ord_booking_id_idx` (`OrderBookingID` ASC) VISIBLE,
  INDEX `ord_customer_id_idx` (`OrderCustomerID` ASC) VISIBLE,
  INDEX `ord_menu_id_idx` (`OrderMenuItemID` ASC) VISIBLE,
  CONSTRAINT `ord_booking_id`
    FOREIGN KEY (`OrderBookingID`)
    REFERENCES `LittleLemonDB`.`Bookings` (`BookingID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ord_customer_id`
    FOREIGN KEY (`OrderCustomerID`)
    REFERENCES `LittleLemonDB`.`Customers` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ord_menu_id`
    FOREIGN KEY (`OrderMenuItemID`)
    REFERENCES `LittleLemonDB`.`Menu` (`MenuItemID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`DeliveryStatus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`DeliveryStatus` (
  `DeliveryID` INT NOT NULL,
  `DeliveryDate` DATETIME NOT NULL,
  `DeliveryStatus` VARCHAR(100) NOT NULL,
  `OrderID` INT NOT NULL,
  `CustomerID` INT NOT NULL,
  PRIMARY KEY (`DeliveryID`),
  INDEX `dlv_orderID_idx` (`OrderID` ASC) VISIBLE,
  INDEX `dlv_customerID_idx` (`CustomerID` ASC) VISIBLE,
  CONSTRAINT `dlv_orderID`
    FOREIGN KEY (`OrderID`)
    REFERENCES `LittleLemonDB`.`Orders` (`OrderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `dlv_customerID`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `LittleLemonDB`.`Customers` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
