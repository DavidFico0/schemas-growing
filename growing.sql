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
  `nome_completo` VARCHAR(200) NOT NULL,
  `nome_social` VARCHAR(150) NULL,
  `genero` CHAR(1) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `senha` VARCHAR(256) NOT NULL,
  `foto_perfil` VARCHAR(200) NULL,
  `cpf` VARCHAR(14) NOT NULL,
  `datanasc` DATE NULL,
  `descricao_bio` VARCHAR(500) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC) VISIBLE)
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
  `tipo_logradouro` VARCHAR(50) NOT NULL,
  `logradouro` VARCHAR(150) NOT NULL,
  `numero` INT NOT NULL,
  `complemento` VARCHAR(45) NULL,
  `bairro` VARCHAR(150) NOT NULL,
  `cep` VARCHAR(9) NOT NULL,
  `municipio` VARCHAR(150) NOT NULL,
  `uf_estado` CHAR(2) NOT NULL,
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
-- Table `growingdb`.`dados_profissionais`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `growingdb`.`dados_profissionais` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cnpj` VARCHAR(18) NOT NULL,
  `razao_social` VARCHAR(250) NULL,
  `nome_fantasia` VARCHAR(150) NULL,
  `inscricao_estadual` VARCHAR(14) NOT NULL,
  `inscricao_municipal` VARCHAR(14) NULL,
  `usuarios_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_dados_profissionais_usuarios1_idx` (`usuarios_id` ASC) VISIBLE,
  CONSTRAINT `fk_dados_profissionais_usuarios1`
    FOREIGN KEY (`usuarios_id`)
    REFERENCES `growingdb`.`usuarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `growingdb`.`preferencias_gerais`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `growingdb`.`preferencias_gerais` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `servico` VARCHAR(50) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `growingdb`.`postagens`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `growingdb`.`postagens` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `texto` VARCHAR(500) NOT NULL,
  `data_postagem` DATETIME NOT NULL,
  `imagem` VARCHAR(200) NULL,
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
  `imagem` VARCHAR(200) NULL,
  `postagens_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_comentarios_postagens1_idx` (`postagens_id` ASC) VISIBLE,
  CONSTRAINT `fk_comentarios_postagens1`
    FOREIGN KEY (`postagens_id`)
    REFERENCES `growingdb`.`postagens` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `growingdb`.`registro_portfolio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `growingdb`.`registro_portfolio` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(300) NULL,
  `usuarios_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_registro_portfolio_usuarios1_idx` (`usuarios_id` ASC) VISIBLE,
  CONSTRAINT `fk_registro_portfolio_usuarios1`
    FOREIGN KEY (`usuarios_id`)
    REFERENCES `growingdb`.`usuarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `growingdb`.`servicos_especificos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `growingdb`.`servicos_especificos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `servico` VARCHAR(50) NULL,
  `preferencias_servicos_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_servicos_especificos_preferencias_servicos1_idx` (`preferencias_servicos_id` ASC) VISIBLE,
  CONSTRAINT `fk_servicos_especificos_preferencias_servicos1`
    FOREIGN KEY (`preferencias_servicos_id`)
    REFERENCES `growingdb`.`preferencias_gerais` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `growingdb`.`usuarios__servicos_especificos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `growingdb`.`usuarios__servicos_especificos` (
  `usuarios_id` INT NOT NULL,
  `servicos_especificos_id` INT NOT NULL,
  `valor` DOUBLE(6,2) NOT NULL,
  `imagem` VARCHAR(200) NOT NULL,
  `descricao` VARCHAR(500) NOT NULL,
  PRIMARY KEY (`usuarios_id`, `servicos_especificos_id`),
  INDEX `fk_usuarios_has_servicos_especificos_servicos_especificos1_idx` (`servicos_especificos_id` ASC) VISIBLE,
  INDEX `fk_usuarios_has_servicos_especificos_usuarios1_idx` (`usuarios_id` ASC) VISIBLE,
  CONSTRAINT `fk_usuarios_has_servicos_especificos_usuarios1`
    FOREIGN KEY (`usuarios_id`)
    REFERENCES `growingdb`.`usuarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuarios_has_servicos_especificos_servicos_especificos1`
    FOREIGN KEY (`servicos_especificos_id`)
    REFERENCES `growingdb`.`servicos_especificos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `growingdb`.`avaliacao_servico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `growingdb`.`avaliacao_servico` (
  `id` INT NOT NULL,
  `nota` INT NULL,
  `prestador_id` INT NOT NULL,
  `servico_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_avaliacao_servico_usuarios__servicos_especificos1_idx` (`prestador_id` ASC, `servico_id` ASC) VISIBLE,
  CONSTRAINT `fk_avaliacao_servico_usuarios__servicos_especificos1`
    FOREIGN KEY (`prestador_id` , `servico_id`)
    REFERENCES `growingdb`.`usuarios__servicos_especificos` (`usuarios_id` , `servicos_especificos_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `growingdb`.`compromissos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `growingdb`.`compromissos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `data_inicio` DATETIME NOT NULL,
  `horario_fim` DATETIME NOT NULL,
  `observacoes` VARCHAR(400) NULL,
  `consumidor_id` INT NOT NULL,
  `prestador_id` INT NOT NULL,
  `servico_id` INT NOT NULL,
  `avaliação_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_compromissos_usuarios1_idx` (`consumidor_id` ASC) VISIBLE,
  INDEX `fk_compromissos_usuarios__servicos_especificos1_idx` (`prestador_id` ASC, `servico_id` ASC) VISIBLE,
  INDEX `fk_compromissos_avaliação1_idx` (`avaliação_id` ASC) VISIBLE,
  CONSTRAINT `fk_compromissos_usuarios1`
    FOREIGN KEY (`consumidor_id`)
    REFERENCES `growingdb`.`usuarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_compromissos_usuarios__servicos_especificos1`
    FOREIGN KEY (`prestador_id` , `servico_id`)
    REFERENCES `growingdb`.`usuarios__servicos_especificos` (`usuarios_id` , `servicos_especificos_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_compromissos_avaliação1`
    FOREIGN KEY (`avaliação_id`)
    REFERENCES `growingdb`.`avaliacao_servico` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `growingdb`.`usuarios_preferencias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `growingdb`.`usuarios_preferencias` (
  `usuarios_id` INT NOT NULL,
  `preferencias_id` INT NOT NULL,
  PRIMARY KEY (`usuarios_id`, `preferencias_id`),
  INDEX `fk_usuarios_has_preferencias_preferencias1_idx` (`preferencias_id` ASC) VISIBLE,
  INDEX `fk_usuarios_has_preferencias_usuarios1_idx` (`usuarios_id` ASC) VISIBLE,
  CONSTRAINT `fk_usuarios_has_preferencias_usuarios1`
    FOREIGN KEY (`usuarios_id`)
    REFERENCES `growingdb`.`usuarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuarios_has_preferencias_preferencias1`
    FOREIGN KEY (`preferencias_id`)
    REFERENCES `growingdb`.`preferencias_gerais` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `growingdb`.`imagens_portfolio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `growingdb`.`imagens_portfolio` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `imagem` VARCHAR(200) NOT NULL,
  `portfolio_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_imagens_portfolio_portfolio1_idx` (`portfolio_id` ASC) VISIBLE,
  CONSTRAINT `fk_imagens_portfolio_portfolio1`
    FOREIGN KEY (`portfolio_id`)
    REFERENCES `growingdb`.`registro_portfolio` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `growingdb`.`avaliacao_usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `growingdb`.`avaliacao_usuario` (
  `id` INT NOT NULL,
  `nota` INT NULL,
  `usuarios_id` INT NOT NULL,
  `compromissos_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_avaliacao_usuario_usuarios1_idx` (`usuarios_id` ASC) VISIBLE,
  INDEX `fk_avaliacao_usuario_compromissos1_idx` (`compromissos_id` ASC) VISIBLE,
  CONSTRAINT `fk_avaliacao_usuario_usuarios1`
    FOREIGN KEY (`usuarios_id`)
    REFERENCES `growingdb`.`usuarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_avaliacao_usuario_compromissos1`
    FOREIGN KEY (`compromissos_id`)
    REFERENCES `growingdb`.`compromissos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
