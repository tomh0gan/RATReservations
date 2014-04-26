Login table, may have done this wrong!

CREATE TABLE `rat_schema`.`login` (

`Username` VARCHAR(20) NOT NULL,

  `Password` VARCHAR(20) NOT NULL,

  `Type` ENUM('employee','manager','customer') NOT NULL,

  `Id` INT NULL,

  PRIMARY KEY (`Username`),

  UNIQUE INDEX `Username_UNIQUE` (`Username` ASC),

  INDEX `LoginId_idx` (`Id` ASC),

  CONSTRAINT `LoginId`
    FOREIGN KEY (`Id`)
    REFERENCES `rat_schema`.`person` (`id`)

    ON DELETE NO ACTION
    
ON UPDATE NO ACTION);


Insert the customers

INSERT INTO login 
VALUES("cooljane1", "pw1", 'customer', 1),("cooljohn2", "pw2", 'customer', 2),("coolrick3", "pw3", 'customer', 3);

!!Drop the isManager value from the employee table? I don't think its really needed since we're just using it to decide this

INSERT INTO login 
VALUES("annatheemployee", "pw4", 'employee', 4),("pattrickmanager", "pw5", 'manager', 5);