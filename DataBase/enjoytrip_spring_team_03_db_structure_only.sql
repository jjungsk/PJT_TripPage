-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema enjoytrip
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `enjoytrip` ;

-- -----------------------------------------------------
-- Schema enjoytrip
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `enjoytrip` DEFAULT CHARACTER SET utf8mb3 ;
USE `enjoytrip` ;

-- -----------------------------------------------------
-- Table `enjoytrip`.`users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `enjoytrip`.`users` ;

CREATE TABLE IF NOT EXISTS `enjoytrip`.`users` (
  `user_id` VARCHAR(16) NOT NULL,
  `user_password` VARCHAR(20),
  `user_name` VARCHAR(20) NOT NULL,
  `user_email` VARCHAR(45),
  `user_tel` VARCHAR(20),
  `manager` TINYINT NOT NULL,
  `token` VARCHAR(1000) NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `enjoytrip`.`board`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `enjoytrip`.`board` ;

CREATE TABLE IF NOT EXISTS `enjoytrip`.`board` (
  `article_no` INT NOT NULL AUTO_INCREMENT,
  `user_id` VARCHAR(16) NOT NULL,
  `subject` VARCHAR(100) NOT NULL,
  `content` VARCHAR(2000) NOT NULL,
  `hit` INT NOT NULL DEFAULT '0',
  `register_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`article_no`),
  INDEX `board_users_user_id_fk_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `board_users_user_id_fk`
    FOREIGN KEY (`user_id`)
    REFERENCES `enjoytrip`.`users` (`user_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `enjoytrip`.`do`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `enjoytrip`.`do` ;

CREATE TABLE IF NOT EXISTS `enjoytrip`.`do` (
  `area_code` INT NOT NULL,
  `name` TEXT NOT NULL,
  PRIMARY KEY (`area_code`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `enjoytrip`.`sigungu`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `enjoytrip`.`sigungu` ;

CREATE TABLE IF NOT EXISTS `enjoytrip`.`sigungu` (
  `area_code` INT NOT NULL,
  `sigungu_code` INT NOT NULL,
  `name` TEXT NOT NULL,
  PRIMARY KEY (`area_code`, `sigungu_code`),
  CONSTRAINT `sigungu_do_area_code_fk`
    FOREIGN KEY (`area_code`)
    REFERENCES `enjoytrip`.`do` (`area_code`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `enjoytrip`.`tour_list`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `enjoytrip`.`tour_list` ;

CREATE TABLE IF NOT EXISTS `enjoytrip`.`tour_list` (
  `idx` INT NULL,
  `area_code` INT NULL DEFAULT NULL,
  `sigungu_code` INT NULL DEFAULT NULL,
  `title` TEXT NULL DEFAULT NULL,
  `addr1` TEXT NULL DEFAULT NULL,
  `addr2` TEXT NULL DEFAULT NULL,
  `content_type_id` INT NULL DEFAULT NULL,
  `content_id` INT NOT NULL,
  `mapx` DOUBLE NULL DEFAULT NULL,
  `mapy` DOUBLE NULL DEFAULT NULL,
  `image` TEXT NULL DEFAULT NULL,
  `tel` TEXT NULL DEFAULT NULL,
  `zipcode` VARCHAR(30) NULL DEFAULT NULL,
  PRIMARY KEY (`content_id`),
  INDEX `tour_list_sigungu_area_code_fk_idx` (`area_code` ASC, `sigungu_code` ASC) VISIBLE,
  CONSTRAINT `tour_list_sigungu_area_code_sigungu_code_fk`
    FOREIGN KEY (`area_code` , `sigungu_code`)
    REFERENCES `enjoytrip`.`sigungu` (`area_code` , `sigungu_code`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `enjoytrip`.`content_id_detail`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `enjoytrip`.`content_id_detail` ;

CREATE TABLE IF NOT EXISTS `enjoytrip`.`content_id_detail` (
  `content_id` INT NOT NULL,
  `content_description` VARCHAR(2000) NULL DEFAULT NULL,
  PRIMARY KEY (`content_id`),
  CONSTRAINT `a_b_id`
    FOREIGN KEY (`content_id`)
    REFERENCES `enjoytrip`.`tour_list` (`content_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `enjoytrip`.`notice`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `enjoytrip`.`notice` ;

CREATE TABLE IF NOT EXISTS `enjoytrip`.`notice` (
  `article_no` INT NOT NULL AUTO_INCREMENT,
  `user_id` VARCHAR(16) NOT NULL,
  `subject` VARCHAR(100) NOT NULL,
  `content` VARCHAR(2000) NOT NULL,
  `hit` INT NOT NULL DEFAULT '0',
  `register_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`article_no`),
  INDEX `notice_users_user_id_fk_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `notice_users_user_id_fk`
    FOREIGN KEY (`user_id`)
    REFERENCES `enjoytrip`.`users` (`user_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `enjoytrip`.`plan`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `enjoytrip`.`plan` ;

CREATE TABLE IF NOT EXISTS `enjoytrip`.`plan` (
  `plan_no` INT NOT NULL AUTO_INCREMENT,
  `user_id` VARCHAR(16) NULL,
  `plan_subject` VARCHAR(100) NULL,
  `plan_content` VARCHAR(2000) NULL,
  `hit` INT NULL,
  `register_time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`plan_no`),
  INDEX `plan_user_user_id_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `plan_user_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `enjoytrip`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `enjoytrip`.`plan_inform`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `enjoytrip`.`plan_inform` ;

CREATE TABLE IF NOT EXISTS `enjoytrip`.`plan_inform` (
  `plan_no` INT NOT NULL,
  `idx` INT NOT NULL,
  `content_id` INT NULL,
  INDEX `plan_inform_plan_plan_no_idx` (`plan_no` ASC) VISIBLE,
  PRIMARY KEY (`plan_no`, `idx`),
  CONSTRAINT `plan_inform_plan_plan_no`
    FOREIGN KEY (`plan_no`)
    REFERENCES `enjoytrip`.`plan` (`plan_no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `plan_inform_tour_list_content_id`
    FOREIGN KEY (`content_id`)
    REFERENCES `enjoytrip`.`tour_list` (`content_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
