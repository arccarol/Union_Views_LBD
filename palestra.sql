CREATE DATABASE palestra 
GO
USE palestra 
GO
CREATE TABLE curso (
codigo_curso INT NOT NULL,
nome VARCHAR(70) NOT NULL,
sigla VARCHAR(10) NOT NULL
PRIMARY KEY (codigo_curso)
)
GO 
CREATE TABLE aluno (
ra CHAR(07) NOT NULL,
nome VARCHAR(250) NOT NULL,
codigo_curso INT NOT NULL
PRIMARY KEY(ra)
FOREIGN KEY (codigo_curso) REFERENCES curso(codigo_curso)
)
GO 
CREATE TABLE palestrante (
codigo_palestrante INT IDENTITY,
nome VARCHAR(250) NOT NULL,
empresa VARCHAR(100) NOT NULL
PRIMARY KEY(codigo_palestrante)
)
GO 
CREATE TABLE palestra(
codigo_palestra INT IDENTITY,
titulo VARCHAR(MAX) NOT NULL,
carga_horaria INT NOT NULL,
data DATETIME NOT NULL,
codigo_palestrante INT NOT NULL
PRIMARY KEY(codigo_palestra) 
FOREIGN KEY (codigo_palestrante) REFERENCES palestrante(codigo_palestrante)
)
GO 
CREATE TABLE alunos_inscritos (
ra CHAR(07) NOT NULL,
codigo_palestra INT IDENTITY
FOREIGN KEY(ra) REFERENCES aluno(ra),
FOREIGN KEY(codigo_palestra) REFERENCES palestra(codigo_palestra)
)
GO 
CREATE TABLE nao_alunos (
rg VARCHAR(09) NOT NULL,
orgao_exp CHAR(05) NOT  NULL,
nome VARCHAR(250) NOT NULL
PRIMARY KEY(rg, orgao_exp)
)
GO 
CREATE TABLE nao_alunos_inscritos (
codigo_palestra INT NOT NULL,
rg VARCHAR(09) NOT NULL,
orgao_exp CHAR(05) NOT  NULL
FOREIGN KEY(codigo_palestra) REFERENCES palestra(codigo_palestra),
FOREIGN KEY(rg, orgao_exp) REFERENCES nao_alunos(rg, orgao_exp)
)

CREATE VIEW v_palestra 
AS
SELECT A.ra AS num_documento, A.nome AS nome_pessoa, P.titulo AS titulo_palestra, PA.nome AS nome_palestrante, P.carga_horaria AS carga_horaria, P.data AS data
FROM aluno A
INNER JOIN alunos_inscritos AI ON AI.ra = A.ra
INNER JOIN palestra P ON P.codigo_palestra = AI.codigo_palestra
INNER JOIN palestrante PA ON PA.codigo_palestrante = p.codigo_palestrante
UNION 
SELECT NAI.rg + '-' + NAI.orgao_exp AS num_documento, NA.nome AS nome_pessoa, P.titulo AS titulo_palestra, PA.nome AS nome_palestrante, P.carga_horaria AS carga_horaria, P.data AS data
FROM nao_alunos_inscritos NAI
INNER JOIN nao_alunos NA ON NA.rg = NAI.rg
INNER JOIN palestra P ON P.codigo_palestra = NAI.codigo_palestra
INNER JOIN palestrante PA ON PA.codigo_palestrante = P.codigo_palestrante

Select * from v_palestra
order by nome_pessoa




