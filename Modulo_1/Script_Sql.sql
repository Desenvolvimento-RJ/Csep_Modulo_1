create database senac_music;
use senac_music;

/*UESCIVA*/
/*---------------------------------------------          CRIAÇÃO       --------------------------------------------------------------------------------*/
CREATE TABLE usuario (
	id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cpf CHAR(11) UNIQUE NOT NULL,
    email VARCHAR(100) NOT NULL,
    senha VARCHAR(100) NOT NULL,
    perfil ENUM ("Administrador","Vendedor","Validador")
);

CREATE TABLE evento (
	id_evento INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(100) NOT NULL,
    data DATETIME NOT NULL,
    capacidade_max INT NOT NULL
);

CREATE TABLE setor (
	id_setor INT PRIMARY KEY AUTO_INCREMENT,
    id_evento INT NOT NULL,
    perfil_setor ENUM("Publico Geral","VIP","Imprensa"),
	capacidade_setor INT NOT NULL,
    FOREIGN KEY (id_evento) REFERENCES evento(id_evento),
    INDEX idx_setor_id_evento(id_evento)
);

CREATE TABLE cliente(
	id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cpf CHAR(11) UNIQUE NOT NULL,
    email VARCHAR(100) NOT NULL
);

CREATE TABLE ingresso(
	id_ingresso INT PRIMARY KEY AUTO_INCREMENT,
    id_evento INT NOT NULL,
    id_setor INT NOT NULL,
    id_cliente INT NOT NULL,
    codigo VARCHAR(100) UNIQUE NOT NULL,
    status_ingresso ENUM("Emitido","Pendente","Validado"),
    FOREIGN KEY (id_evento) REFERENCES evento(id_evento) ON DELETE CASCADE,
    FOREIGN KEY (id_setor) REFERENCES setor(id_setor), 
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    INDEX idx_ingresso_id_evento(id_evento),
    INDEX idx_ingresso_id_setor(id_setor),
    INDEX idx_ingresso_id_cliente(id_cliente)
);

CREATE TABLE validacao(
	id_validacao INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    id_ingresso INT NOT NULL,
    data DATETIME NOT NULL,
	FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
    FOREIGN KEY (id_ingresso) REFERENCES ingresso(id_ingresso), 
    INDEX idx_validacao_id_usuario(id_usuario),
    INDEX idx_validacao_id_ingresso(id_ingresso)
);

CREATE TABLE atividade (
	id_log_atividade INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    acao VARCHAR(100) NOT NULL,
    data TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario), 
    INDEX idx_log_atividade_id_usuario(id_usuario)
);



 /*---------------------------------------------          INSERÇÃO       --------------------------------------------------------------------------------*/
 
 /*USUARIO*/
 
INSERT INTO usuario(nome , cpf , email , senha , perfil)
VALUES ("Joao" , "12345678901","joao@email.com","2$!abcdefgh$@" , "Administrador"),
("Pedro" , "78945612300","pedro@email.com","2$!qafuierw$@" , "Validador"),
("Laura" , "36985214708","laura@email.com","2$!qoamsjet$@" , "Vendedor"),
("Mariana" , "84159623045","mariana@email.com","2$!aetaghjk$@" , "Administrador"),
("Fernanda" , "69587412365","fernanda@email.com","2$!taeiwjfb$@" , "Validador");

 /*EVENTO*/
 
INSERT INTO evento(id_evento , nome , data , capacidade_max)
VALUES (1, "O Grande Show",20-09-2025,5000),
(2, "Rock The Mountain",11-08-2025,8000),
(3 , "Rock in Rio",15-06-2025,7000),
(4 , "Lollapaloza",08-07-2025,8500 ),
(5, "The Town",19-11-2025,9500);

 /*SETOR*/
 
INSERT INTO setor(id_setor , id_evento , perfil_setor , capacidade_setor )
VALUES (1, 2,"Publico Geral",3000),
(2, 3,"VIP",1500 ),
(3, 1,"Imprensa",2000),
(4 , 2,"Publico Geral", 2200 ),
(5, 3,"VIP",1000 );

 /*CLIENTE*/
 
INSERT INTO cliente(nome , cpf , email)
VALUES ("Joao" , "12345678901","joao@email.com"),
("Pedro" , "78945612300","pedro@email.com"),
("Joaquim" , "89554763210","joaquim@email.com"),
("Luiza" , "56874125890","luiza@email.com"),
("Mariana" , "84159623045","mariana@email.com");

 /*INGRESSO*/
 
INSERT INTO ingresso(id_ingresso, id_evento , id_setor , id_cliente , codigo , status_ingresso)
VALUES (1, 2,2,3 , "ABC246#!","Emitido"),
(2 , 3,5,1 , "ABD3869#!", "Pendente"),
(3, 1,1,4 , "ABE2647#!","Validado"),
(4, 2,3,2 , "ABF4569#!", "Emitido"),
(5 , 4,4,2 , "ABG8755#!", "Validado");

 /*VALIDAÇÃO*/
 
INSERT INTO validacao(id_validacao , id_ingresso , id_usuario , data)
VALUES (1 , 2, 4 , 20-07-2025 ),
(2, 4 , 3 , 05-12-2025),
(3 , 3 , 1 , 07-10-2025),
(4 , 1 , 2 , 13-02-2025),
(5 , 3 , 5 , 14-09-2025);

 /*ATIVIDADE*/
 
INSERT INTO atividade(id_log_atividade , id_usuario , acao , data)
VALUES (1 , 2,"	Efetuou Login",05-12-2025),
(2 , 4,"Cadastro Admin",25-01-2025 ),
(3, 3,"Efetuou Logout",22-11-2025),
(4, 1,"Validou Ingresso",11-11-2025 ),
(5, 5,"Cadastrou Evento",09-03-2025);
