-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema cs340_catellim
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema cs340_catellim
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `cs340_catellim` DEFAULT CHARACTER SET utf8 ;
USE `cs340_catellim` ;

-- -----------------------------------------------------
-- Table `cs340_catellim`.`Books`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cs340_catellim`.`Books` (
  `book_id` INT AUTO_INCREMENT,
  `author` VARCHAR(145) NOT NULL,
  `title` VARCHAR(145) NOT NULL,
  `genre` VARCHAR(145) NOT NULL,
  `num_in_stock` INT NOT NULL DEFAULT 0,
  `price` DECIMAL(19,2) NOT NULL,
  PRIMARY KEY (`book_id`),
  UNIQUE INDEX `title_UNIQUE` (`title` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cs340_catellim`.`Customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cs340_catellim`.`Customers` (
  `customer_id` INT AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `email` VARCHAR(145) NOT NULL,
  `address` VARCHAR(145) NOT NULL,
  PRIMARY KEY (`customer_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cs340_catellim`.`Payments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cs340_catellim`.`Payments` (
  `payment_id` INT AUTO_INCREMENT,
  `customer_id` INT,
  `date` DATE NOT NULL,
  `credit_card` VARCHAR(145) NOT NULL,
  `exp_date` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`payment_id`),
  INDEX `fk_Payments_Customers_idx` (`customer_id` ASC) VISIBLE,
  CONSTRAINT `fk_Payments_Customers`
    FOREIGN KEY (`customer_id`)
    REFERENCES `cs340_catellim`.`Customers` (`customer_id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cs340_catellim`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cs340_catellim`.`Orders` (
  `order_id` INT AUTO_INCREMENT,
  `customer_id` INT,
  `payment_id` INT,
  `date` DATE NOT NULL,
  `total_price` DECIMAL(19,2) NOT NULL,
  PRIMARY KEY (`order_id`),
  INDEX `fk_Orders_Customers_idx` (`customer_id` ASC) VISIBLE,
  INDEX `fk_Orders_Payments_idx` (`payment_id` ASC) VISIBLE,
  CONSTRAINT `fk_Orders_Customers`
    FOREIGN KEY (`customer_id`)
    REFERENCES `cs340_catellim`.`Customers` (`customer_id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Orders_Payments`
    FOREIGN KEY (`payment_id`)
    REFERENCES `cs340_catellim`.`Payments` (`payment_id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cs340_catellim`.`OrderDetails`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cs340_catellim`.`OrderDetails` (
  `order_details_id` INT AUTO_INCREMENT,
  `book_id` INT,
  `order_id` INT NOT NULL,
  `book_quantity` INT NOT NULL,
  `unit_price` DECIMAL(19,2) NOT NULL,
  `line_total` DECIMAL(19,2) NOT NULL,
  `status` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`order_details_id`),
  INDEX `fk_Order_Details_Orders_idx` (`order_id` ASC) VISIBLE,
  INDEX `fk_Order_Details_Books_idx` (`book_id` ASC) VISIBLE,
  CONSTRAINT `fk_Order_Details_Books`
    FOREIGN KEY (`book_id`)
    REFERENCES `cs340_catellim`.`Books` (`book_id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Order_Details_Orders`
    FOREIGN KEY (`order_id`)
    REFERENCES `cs340_catellim`.`Orders` (`order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;