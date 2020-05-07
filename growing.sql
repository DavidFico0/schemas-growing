-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema growingdb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema growingdb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `growingdb` DEFAULT CHARACTER SET utf8 ;
USE `growingdb` ;

-- -----------------------------------------------------
-- Table `growingdb`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `growingdb`.`usuarios` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(150) NOT NULL,
  `sobrenome` VARCHAR(150) NULL,
  `username` VARCHAR(150) NOT NULL,
  `password` VARCHAR(256) NOT NULL,
  `apelido` VARCHAR(150) NULL,
  `genero` VARCHAR(50) NULL,
  `image` VARCHAR(150) NULL,
  `rg` VARCHAR(14) NULL,
  `cpf` VARCHAR(14) NULL,
  `datanasc` DATE NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `growingdb`.`contatos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `growingdb`.`contatos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `tipo_contato` VARCHAR(50) NOT NULL,
  `telefone` VARCHAR(15) NOT NULL,
  `email` VARCHAR(150) NULL,
  `status` INT NOT NULL,
  `usuarios_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_contato_usuarios_idx` (`usuarios_id` ASC) VISIBLE,
  CONSTRAINT `fk_contato_usuarios`
    FOREIGN KEY (`usuarios_id`)
    REFERENCES `growingdb`.`usuarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `growingdb`.`enderecos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `growingdb`.`enderecos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `tipo_endereco` VARCHAR(50) NOT NULL,
  `tipo` VARCHAR(50) NOT NULL,
  `logradouro` VARCHAR(150) NOT NULL,
  `numero` VARCHAR(10) NOT NULL,
  `bairro` VARCHAR(150) NULL,
  `cep` VARCHAR(15) NULL,
  `municipio` VARCHAR(150) NULL,
  `estado` VARCHAR(50) NULL,
  `usuarios_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_endereco_usuarios1_idx` (`usuarios_id` ASC) VISIBLE,
  CONSTRAINT `fk_endereco_usuarios1`
    FOREIGN KEY (`usuarios_id`)
    REFERENCES `growingdb`.`usuarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `growingdb`.`tipo_usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `growingdb`.`tipo_usuario` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `tipo_usuario` VARCHAR(50) NOT NULL,
  `status` INT NOT NULL,
  `usuarios_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tipo_usuario_usuarios1_idx` (`usuarios_id` ASC) VISIBLE,
  CONSTRAINT `fk_tipo_usuario_usuarios1`
    FOREIGN KEY (`usuarios_id`)
    REFERENCES `growingdb`.`usuarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `growingdb`.`perfil`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `growingdb`.`perfil` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `tipo_perfil` VARCHAR(50) NOT NULL,
  `razaosocial` VARCHAR(250) NOT NULL,
  `nome_fantasia` VARCHAR(150) NULL,
  `cnpj_cpf` VARCHAR(14) NOT NULL,
  `ie_rg` VARCHAR(14) NOT NULL,
  `im` VARCHAR(14) NULL,
  `descricao` VARCHAR(500) NULL,
  `image` VARCHAR(150) NULL,
  `tipo_usuario_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_perfil_tipo_usuario1_idx` (`tipo_usuario_id` ASC) VISIBLE,
  CONSTRAINT `fk_perfil_tipo_usuario1`
    FOREIGN KEY (`tipo_usuario_id`)
    REFERENCES `growingdb`.`tipo_usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `growingdb`.`categorias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `growingdb`.`categorias` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `categorias` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `growingdb`.`preferencias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `growingdb`.`preferencias` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `preferencia` VARCHAR(150) NULL,
  `tipo_usuario_id` INT NOT NULL,
  `categorias_id` INT NOT NULL,
  `perfil_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_preferencias_tipo_usuario1_idx` (`tipo_usuario_id` ASC) VISIBLE,
  INDEX `fk_preferencias_categorias1_idx` (`categorias_id` ASC) VISIBLE,
  INDEX `fk_preferencias_perfil1_idx` (`perfil_id` ASC) VISIBLE,
  CONSTRAINT `fk_preferencias_tipo_usuario1`
    FOREIGN KEY (`tipo_usuario_id`)
    REFERENCES `growingdb`.`tipo_usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_preferencias_categorias1`
    FOREIGN KEY (`categorias_id`)
    REFERENCES `growingdb`.`categorias` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_preferencias_perfil1`
    FOREIGN KEY (`perfil_id`)
    REFERENCES `growingdb`.`perfil` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `growingdb`.`postagens`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `growingdb`.`postagens` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `postagem` VARCHAR(500) NOT NULL,
  `data_postagem` DATETIME NOT NULL,
  `usuarios_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_postagens_usuarios1_idx` (`usuarios_id` ASC) VISIBLE,
  CONSTRAINT `fk_postagens_usuarios1`
    FOREIGN KEY (`usuarios_id`)
    REFERENCES `growingdb`.`usuarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `growingdb`.`comentarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `growingdb`.`comentarios` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `data_cometario` DATETIME NOT NULL,
  `comentario` VARCHAR(500) NOT NULL,
  `postagens_id` INT NOT NULL,
  `usuarios_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_comentarios_postagens1_idx` (`postagens_id` ASC) VISIBLE,
  INDEX `fk_comentarios_usuarios1_idx` (`usuarios_id` ASC) VISIBLE,
  CONSTRAINT `fk_comentarios_postagens1`
    FOREIGN KEY (`postagens_id`)
    REFERENCES `growingdb`.`postagens` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comentarios_usuarios1`
    FOREIGN KEY (`usuarios_id`)
    REFERENCES `growingdb`.`usuarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `growingdb`.`servicos_produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `growingdb`.`servicos_produto` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `servico` VARCHAR(150) NOT NULL,
  `image1` VARCHAR(150) NULL,
  `image2` VARCHAR(150) NULL,
  `descricao` VARCHAR(500) NULL,
  `valor` DECIMAL(5,2) NULL,
  `tipo` INT NOT NULL,
  `status` INT NOT NULL,
  `perfil_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_servicos_perfil1_idx` (`perfil_id` ASC) VISIBLE,
  CONSTRAINT `fk_servicos_perfil1`
    FOREIGN KEY (`perfil_id`)
    REFERENCES `growingdb`.`perfil` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `growingdb`.`portfoleo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `growingdb`.`portfoleo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(500) NULL,
  `image1` VARCHAR(150) NULL,
  `image2` VARCHAR(150) NULL,
  `image3` VARCHAR(150) NULL,
  `image4` VARCHAR(150) NULL,
  `status` INT NOT NULL,
  `data_exec` DATETIME NOT NULL,
  `perfil_id` INT NOT NULL,
  `servicos_produto_id` INT NOT NULL,
  `usuarios_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_portfoleo_perfil1_idx` (`perfil_id` ASC) VISIBLE,
  INDEX `fk_portfoleo_servicos_produto1_idx` (`servicos_produto_id` ASC) VISIBLE,
  INDEX `fk_portfoleo_usuarios1_idx` (`usuarios_id` ASC) VISIBLE,
  CONSTRAINT `fk_portfoleo_perfil1`
    FOREIGN KEY (`perfil_id`)
    REFERENCES `growingdb`.`perfil` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_portfoleo_servicos_produto1`
    FOREIGN KEY (`servicos_produto_id`)
    REFERENCES `growingdb`.`servicos_produto` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_portfoleo_usuarios1`
    FOREIGN KEY (`usuarios_id`)
    REFERENCES `growingdb`.`usuarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `growingdb`.`agenda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `growingdb`.`agenda` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `data_inicio` DATETIME NOT NULL,
  `data_fim` DATETIME NOT NULL,
  `recorrente` INT NOT NULL,
  `tipo_recorrencia` VARCHAR(50) NULL,
  `titulo` VARCHAR(150) NULL,
  `descricao` VARCHAR(400) NULL,
  `servicos_produto_id` INT NOT NULL,
  `usuarios_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_agenda_servicos_produto1_idx` (`servicos_produto_id` ASC) VISIBLE,
  INDEX `fk_agenda_usuarios1_idx` (`usuarios_id` ASC) VISIBLE,
  CONSTRAINT `fk_agenda_servicos_produto1`
    FOREIGN KEY (`servicos_produto_id`)
    REFERENCES `growingdb`.`servicos_produto` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_agenda_usuarios1`
    FOREIGN KEY (`usuarios_id`)
    REFERENCES `growingdb`.`usuarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `growingdb`.`chat`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `growingdb`.`chat` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `sessao` VARCHAR(245) NOT NULL,
  `chat_sessao` VARCHAR(50) NULL,
  `data_chat` DATETIME NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `growingdb`.`mensagens_chat`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `growingdb`.`mensagens_chat` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `mensagens` VARCHAR(450) NOT NULL,
  `data_mensagem` DATETIME NOT NULL,
  `chat_id` INT NOT NULL,
  `usuarios_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_mensagens_chat_chat1_idx` (`chat_id` ASC) VISIBLE,
  INDEX `fk_mensagens_chat_usuarios1_idx` (`usuarios_id` ASC) VISIBLE,
  CONSTRAINT `fk_mensagens_chat_chat1`
    FOREIGN KEY (`chat_id`)
    REFERENCES `growingdb`.`chat` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_mensagens_chat_usuarios1`
    FOREIGN KEY (`usuarios_id`)
    REFERENCES `growingdb`.`usuarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
