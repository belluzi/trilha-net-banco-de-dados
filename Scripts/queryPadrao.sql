USE ExemploDB
GO

--SELECT * FROM Clientes
--ORDER BY Id DESC;

--INSERT INTO Clientes
--(Nome, Sobrenome, Email, AceitaComunicados, DataCadastro)
--VALUES('Lucas','Belluzi','email@email.com',1,GETDATE())

--INSERT INTO Clientes
--VALUES('Leonardo','Buta','email@email.com',0,GETDATE())

--SELECT * FROM Clientes
--WHERE Id = 1003;

--UPDATE Clientes
--SET Email = 'cheryl.pompa@email.com',
--AceitaComunicados = 1
--WHERE Id = 1003;

--UPDATE Clientes
--SET AceitaComunicados = 0
--WHERE Nome = 'Leonardo'

--DELETE FROM Clientes
--WHERE Id = 1001;

--CREATE TABLE Produtos (
--	Id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
--	Nome VARCHAR(255) NOT NULL,
--	Cor VARCHAR(50) NULL,
--	Preco DECIMAL(13,2) NOT NULL,
--	Tamanho VARCHAR(5) NULL,
--	Genero CHAR(1) NULL
--)

--SELECT COUNT(*) QuantidadeRegistros FROM Produtos
--WHERE Genero = 'M';

--SELECT SUM(Preco) PrecoTotal FROM Produtos;
--SELECT SUM(Preco) PrecoTotal FROM Produtos
--WHERE Tamanho = 'M';

--SELECT MIN(Preco) MaisBarato FROM Produtos;
--SELECT MAX(Preco) MaisCaro FROM Produtos;
--SELECT AVG(Preco) Media FROM Produtos;

--SELECT Nome + ' - ' + UPPER(Cor) FROM Produtos; -- Concatenando colunas
--SELECT LOWER(Nome) FROM Produtos;

--ALTER TABLE Produtos
--ADD DataCadastro DATETIME2;

--ALTER TABLE Produtos
--DROP COLUMN DataCadastro;

--UPDATE Produtos SET DataCadastro = GETDATE();

-- Formatando Data:
--SELECT FORMAT(DataCadastro, 'dd-MM-yyyy HH:mm') DataCadastro FROM Produtos;

--SELECT Tamanho, COUNT(*) AS [Quantidade]
--FROM Produtos
--WHERE Tamanho <> '' -- <> É DIFERENTE DE
--GROUP BY Tamanho
--ORDER BY Quantidade DESC;

--CREATE TABLE Enderecos(
--	Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
--	IdCliente INT NULL,
--	Rua VARCHAR(255) NULL,
--	Bairro VARCHAR(255) NULL,
--	Cidade VARCHAR(255) NULL,
--	Estado CHAR(2) NULL,
--	CONSTRAINT FK_Enderecos_Clientes FOREIGN KEY(IdCliente)
--	REFERENCES Clientes(Id)
--);

--SELECT * FROM Clientes;
--SELECT * FROM Enderecos;

--INSERT INTO Enderecos VALUES (4, 'Rua Teste', 'Bairro Nobre', 'São Paulo', 'SP');

--SELECT C.Id, C.Nome, C.Sobrenome, C.Email, E.Rua, E.Bairro, E.Cidade, E.Estado FROM
--Clientes C
--INNER JOIN Enderecos E
--ON C.Id = E.IdCliente
--WHERE C.Id = 4;

--SELECT * FROM Produtos;

--ALTER TABLE Produtos
--ADD UNIQUE(Nome);

--INSERT INTO Produtos (Nome, Preco, Tamanho, Genero, DataCadastro)
--VALUES ('Mountain Bike Socks, M', 9.50, 'M', 'U', GETDATE());

--CREATE PROCEDURE InserirNovoProduto
--@Nome VARCHAR(255),
--@Cor VARCHAR(50),
--@Preco DECIMAL,
--@Tamanho VARCHAR(5),
--@Genero CHAR(1)

--AS

--INSERT INTO Produtos (Nome, Preco, Tamanho, Genero, DataCadastro)
--VALUES (@Nome, @Cor, @Preco, @Tamanho, @Genero);

EXEC InserirNovoProduto 
'NOVO PRODUTO PROCEDURE',
'COLORIDO',
50,
'G',
'U';

SELECT * FROM Produtos ORDER BY Id DESC;

SELECT * FROM Produtos
WHERE Tamanho = 'M';

--CREATE PROCEDURE ObterProdutosPorTamanho
--@TamanhoProd VARCHAR(5)
--AS
--SELECT * FROM Produtos WHERE Tamanho = @TamanhoProd

EXEC ObterProdutosPorTamanho 'M';

SELECT Nome, Preco, FORMAT(Preco - Preco / 100 * 10, 'N2') PrecoComDesconto
FROM Produtos WHERE Tamanho = 'M';

CREATE FUNCTION CalcularDesconto(@Preco DECIMAL(13, 2), @Porcentagem INT)
RETURNS DECIMAL(13, 2)

BEGIN
	RETURN @Preco - @Preco / 100 * @Porcentagem
END

-- Agora, com a function criada:
SELECT Nome, Preco, dbo.CalcularDesconto(Preco, 50) PrecoComDesconto
FROM Produtos WHERE Tamanho = 'M';