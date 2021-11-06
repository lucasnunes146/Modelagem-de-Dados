--- Criação Tabelas Faculdade ---

CREATE DATABASE faculdade;

USE DATABASE faculdade;

CREATE TABLE IF NOT EXISTS tbl_departamento (
id_departamento smallint not null primary key auto_increment,
nome_departamento varchar(40) not null
) ENGINE=InnoDB auto_increment=1 default char set = utf8;

CREATE TABLE IF NOT EXISTS tbl_professor (
id_professor smallint not null primary key auto_increment,
nome_professor varchar(20) not null,
sobrenome_professor varchar(50) not null,
id_departamento smallint not null, 
situacao boolean not null,
foreign key(id_departamento) references tbl_departamento(id_departamento)
) ENGINE=InnoDB auto_increment=1 default char set = utf8;

CREATE TABLE IF NOT EXISTS tbl_curso (
id_curso smallint not null primary key auto_increment,
nome_curso varchar(40) not null,
id_departamento smallint not null,
foreign key(id_departamento) references tbl_departamento(id_departamento)
) ENGINE=InnoDB auto_increment=1 DEFAULT CHAR SET = utf8;

CREATE TABLE IF NOT EXISTS tbl_aluno(
matricula_aluno smallint not null primary key auto_increment,
nome_aluno varchar(20) not null,
sobrenome_aluno varchar(40) not null, 
sexo varchar(1) not null,
cpf varchar(11) not null unique,
situacao boolean not null,
nome_pai varchar(80) null, 
nome_mae varchar(80) not null, 
whatsapp varchar(11) not null,
email varchar(60) not null,
id_turma smallint not null,
id_curso smallint not null,
foreign key(id_turma) references tbl_turma(id_turma),
foreign key(id_curso) references tbl_curso(id_curso)
) ENGINE=InnoDB auto_increment=1 DEFAULT CHAR SET = utf8;

CREATE TABLE IF NOT EXISTS tbl_turma (
id_turma smallint not null primary key auto_increment,
id_curso smallint not null,
periodo varchar(5) not null,
num_alunos smallint not null,
data_inicio date not null,
data_fim date not null,
foreign key(id_curso) references tbl_curso(id_curso)
) ENGINE=InnoDB auto_increment=1 DEFAULT CHAR SET = utf8;

CREATE TABLE IF NOT EXISTS tbl_historico (
id_historico smallint not null primary key auto_increment,
data_inicio date not null,
data_fim date null,
matricula_aluno smallint not null,
foreign key(matricula_aluno) references tbl_aluno(matricula_aluno)
) ENGINE=InnoDB auto_increment=1 DEFAULT CHAR SET = utf8; 

CREATE TABLE IF NOT EXISTS tbl_disciplina (
id_disciplina smallint not null auto_increment primary key,
id_disciplina_depende smallint null,
nome_disciplina varchar(30) not null,
descricao varchar(200) null,
id_departamento smallint not null,
carga_horaria smallint not null, 
num_alunos smallint not null,
foreign key(id_departamento) references tbl_departamento(id_departamento),
foreign key(id_disciplina_depende) references tbl_disciplina(id_disciplina)
) ENGINE=InnoDB auto_increment=1 DEFAULT CHAR SET = utf8;

CREATE TABLE IF NOT EXISTS tbl_curso_disc (
id_curso smallint not null,
id_disciplina smallint not null,
primary key (id_curso, id_disciplina),
foreign key(id_curso) references tbl_curso(id_curso),
foreign key(id_disciplina) references tbl_disciplina(id_disciplina)
) ENGINE=InnoDB auto_increment=1 DEFAULT CHAR SET = utf8;

CREATE TABLE IF NOT EXISTS tbl_disciplina_prof (
id_disciplina smallint not null,
id_professor smallint not null,
primary key (id_disciplina, id_professor),
foreign key(id_disciplina) references tbl_disciplina(id_disciplina),
foreign key(id_professor) references tbl_professor(id_professor)
) ENGINE=InnoDB auto_increment=1 DEFAULT CHAR SET = utf8;

CREATE TABLE IF NOT EXISTS tbl_hist_disc (
id_historico smallint not null, 
id_disciplina smallint not null,
primary key (id_disciplina, id_historico),
foreign key(id_historico) references tbl_historico(id_historico),
foreign key(id_disciplina) references tbl_disciplina(id_disciplina)
) ENGINE=InnoDB auto_increment=1 DEFAULT CHAR SET = utf8;

CREATE TABLE IF NOT EXISTS tbl_aluno_disc (
matricula_aluno smallint not null,
id_disciplina smallint not null,
primary key (id_disciplina, matricula_aluno),
foreign key(matricula_aluno) references tbl_aluno(matricula_aluno),
foreign key(id_disciplina) references tbl_disciplina(id_disciplina)
) ENGINE=InnoDB auto_increment=1 DEFAULT CHAR SET = utf8;

CREATE TABLE IF NOT EXISTS tbl_telefones_aluno (
id_telefones_aluno smallint not null primary key auto_increment,
matricula_aluno smallint not null, 
id_tipo_telefone smallint not null, 
num_telefone varchar(11) not null,
foreign key(matricula_aluno) references tbl_aluno(matricula_aluno),
foreign key(id_tipo_telefone) references tbl_tipo_telefone(id_tipo_telefone)
) ENGINE=InnoDB auto_increment=1 DEFAULT CHAR SET = utf8;

CREATE TABLE IF NOT EXISTS tbl_tipo_telefone (
id_tipo_telefone smallint not null auto_increment primary key,
tipo_telefone varchar(12) not null
) ENGINE=InnoDB auto_increment=1 DEFAULT CHAR SET = utf8;

CREATE TABLE IF NOT EXISTS tbl_endereco_aluno (
id_endereco_aluno smallint not null primary key auto_increment,
matricula_aluno smallint not null,
nome_rua varchar(50) not null,
num_rua smallint not null,
complemento varchar(50) null,
cep varchar(8) not null,
foreign key(matricula_aluno) references tbl_aluno(matricula_aluno)
) ENGINE=InnoDB auto_increment=1 DEFAULT CHAR SET = utf8;


--- dados_DB_faculdade ---

INSERT INTO tbl_departamento (nome_departamento) VALUES
('Humanas'),
('Exatas'), 
('Saúde'),
('Tecnologia'),
('Biológicas');

SELECT* FROM tbl_departamento;

INSERT INTO tbl_professor (nome_professor, sobrenome_professor, situacao, id_departamento) VALUES
('Zé', 'da Bio', 1, 5),
('Suse', 'Mat', 1, 2),
('Aline', 'Almeida', 0, 1),
('Sonia', 'Arão', 1, 4),
('João', 'Solimões', 1, 3);

SELECT* FROM tbl_professor;

INSERT INTO tbl_curso (nome_curso, id_departamento) VALUES
('Análise e Desenvolvimento de Sistemas', 4),
('Psicologia', 1),
('Biologia', 5),
('Letras Inglês', 1),
('Enfermagem', 3),
('Engenharia Civil', 2);

SELECT* FROM tbl_curso;

INSERT INTO tbl_turma (id_curso, periodo, num_alunos, data_inicio, data_fim) VALUES 
(1, 'manhã', 20, '2021-02-20', '2021-07-20'),
(2, 'noite', 25, '2021-02-20', '2021-07-20'),
(3, 'manhã', 15, '2021-08-21', '2021-11-25'),
(5, 'tarde', 25, '2021-02-20', '2021-07-20');

SELECT* FROM tbl_turma;

INSERT INTO tbl_disciplina (nome_disciplina, id_departamento, descricao, num_alunos, carga_horaria, id_disciplina_depende) VALUES
('Cálculo I', 2, 'Funções, Limite, Derivada, Integral', 50, 1200, null),
('Psicologia Cognitiva', 1, 'Entender o funcionamento do aprendizado', 40, 	1400, null),
('Banco de Dados', 4, 'Manipulação e modelagem de dados para banco de dados', 40, 1200, null),
('Citologia', 5, 'Estudo das células', 30, 1200, null),
('Cálculo II', 2, 'Sequências, Integral, Integrais Múltiplas, Técnicas de Integração', 30, 1200, 1),
('Lingua Inglesa', 1, 'História da lingua inglesa', 30, 1200, null);

SELECT* FROM tbl_disciplina;

INSERT INTO tbl_aluno (nome_aluno, sobrenome_aluno, sexo, cpf, situacao, nome_pai, nome_mae, whatsapp, email, id_turma, id_curso) VALUES 
('Joao', 'Junior Luter King', 'M', 12345678910, 1, 'Lindison Luter King', 'Gorete Araujo King', '11123445676', 'jojoking@gmail.com', 1, 1),
('Sandra', 'Silva Moura', 'F', 12357906471, 1, '', 'Julia Silva Moura', '11930104123', 'sandrinhas2@outlook.com', 2, 2),
('Beatriz', 'Almeida', 'F', 47389281787, 1, 'Samuel Leitão', 'Sara Almeida', '11737682819', 'biadotchan@outlook.com', 4, 5);
 
SELECT* FROM tbl_aluno;

INSERT INTO tbl_historico (matricula_aluno, data_inicio, data_fim) VALUES
(1, '2021-02-20', null),
(2, '2021-02-20', null),
(3, '2021-02-20', null);

SELECT* FROM tbl_historico;

INSERT INTO tbl_aluno_disc (matricula_aluno, id_disciplina) VALUES
(1, 1),
(1, 3),
(2, 2),
(3, 4);

SELECT* FROM tbl_aluno_disc;

INSERT INTO tbl_curso_disc (id_curso, id_disciplina) VALUES
(1, 3),
(1, 1),
(2, 2), 
(3, 1),
(3, 4),
(4, 6),
(5, 4),
(6, 1),
(6, 5);

SELECT* FROM curso_disc;

INSERT INTO tbl_disciplina_prof (id_professor, id_disciplina) VALUES
(1, 4),
(2, 1),
(2, 5), 
(3, 6), 
(4, 3),
(5, 2);

SELECT* FROM tbl_disciplina_prof;

INSERT INTO tbl_hist_disc (id_historico, id_disciplina) VALUES
(1, 1),
(1, 3),
(2, 2),
(3, 4);

SELECT* FROM tbl_hist_disc;

INSERT INTO tbl_endereco_aluno (matricula_aluno, nome_rua, num_rua, complemento, cep, estado) VALUES
(1, 'Rua 3 de outubro', 3, 'Jardim Helena', '08090284', 'São Paulo'),
(2, 'Rua 13 de Maio', 13, 'Cantinho do Céu', '04849529', 'São Paulo'), 
(3, 'Viela 16', 16, 'Parque São José', '04843425', 'São Paulo');

SELECT* FROM tbl_endereco_aluno;

INSERT tbl_tipo_telefone (tipo_telefone) VALUES
('celular'),
('celular2'),
('residencial'),
('trabalho');

SELECT* FROM tbl_tipo_telefone;

INSERT INTO tbl_telefones_aluno (matricula_aluno, id_tipo_telefone, num_telefone) VALUES
(1, 1, 1198364878),
(1, 3, 1136479982),
(2, 1, 1196847728),
(2, 4, 1146738989),
(3, 1, 1198876482);
