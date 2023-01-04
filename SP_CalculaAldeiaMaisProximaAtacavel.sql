USE [TWGAMEPLAY]
GO

/****** Object:  StoredProcedure [dbo].[SP_CalculaAldeiaMaisProximaAtacavel]    Script Date: 28/12/2022 15:29:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CalculaAldeiaMaisProximaAtacavel]
	@id_aldeia_origem INT,
	@retorno INT OUTPUT
AS
	DECLARE @x_a INT
	DECLARE @x_b INT
	DECLARE @y_a INT
	DECLARE @y_b INT
	DECLARE @id_jogador_acao INT
	DECLARE @id_tribo_acao INT = 1
	DECLARE @aux INT = 1
	DECLARE @quantidade_de_aldeias INT = (SELECT COUNT(*) FROM Aldeia)
	DECLARE @id_jogador INT = 1
	DECLARE @id_aldeia INT = 1
	DECLARE @id_tribo INT = 1
	DECLARE @dab TABLE(Distancia FLOAT, ID_Aldeia INT, ID_Jogador INT)
	DECLARE @distancia_minima FLOAT
	DECLARE @escolha INT = NULL

	SET @x_a = (SELECT x FROM Aldeia WHERE ID_Aldeia = @id_aldeia_origem)
	SET @y_a = (SELECT y FROM Aldeia WHERE ID_Aldeia = @id_aldeia_origem)
	SET @id_jogador_acao = (SELECT ID_Jogador FROM Aldeia WHERE ID_Aldeia = @id_aldeia_origem)
	SET @id_tribo_acao = (SELECT ID_Tribo FROM Jogador WHERE ID_Jogador = @id_jogador_acao)

		WHILE (@aux < @quantidade_de_aldeias)
			BEGIN
				SET @id_jogador = (SELECT ID_Jogador FROM Aldeia WHERE ID_Aldeia = @id_aldeia)
				SET @id_tribo = (SELECT ID_Tribo FROM Jogador WHERE ID_Jogador = @id_jogador)
				SET @x_b = (SELECT x FROM Aldeia WHERE ID_Aldeia = @id_aldeia)
				SET @y_b = (SELECT y FROM Aldeia WHERE ID_Aldeia = @id_aldeia)
		
				-- O jogador não pode se atacar
				IF @id_jogador <> @id_jogador_acao OR @id_jogador IS NULL
					BEGIN
						-- O jogador não pode atacar jogadores da mesma tribo
						IF @id_tribo <> @id_tribo_acao OR @id_tribo IS NULL
							BEGIN
								-- O jogador não pode atacar jogadores de tribos aliadas ou PNA
								IF (SELECT ID_TipoDiplomacia FROM Diplomacia WHERE (ID_Tribo_A = @id_tribo AND ID_Tribo_B = @id_tribo_acao)) = 3 
								OR (SELECT ID_TipoDiplomacia FROM Diplomacia WHERE (ID_Tribo_B = @id_tribo AND ID_Tribo_A = @id_tribo_acao)) = 3 
								OR (SELECT ID_TipoDiplomacia FROM Diplomacia WHERE (ID_Tribo_A = @id_tribo AND ID_Tribo_B = @id_tribo_acao)) = 4
								OR (SELECT ID_TipoDiplomacia FROM Diplomacia WHERE (ID_Tribo_B = @id_tribo AND ID_Tribo_A = @id_tribo_acao)) = 4
									PRINT 'Jogadores não podem se atacar'
								ELSE
									INSERT INTO @dab (Distancia, ID_Aldeia, ID_Jogador) VALUES (SQRT(POWER((@x_b - @x_a), 2) + POWER((@y_b - @y_a), 2)), @id_aldeia, @id_jogador)
							END
					END

				SET @aux = @aux + 1
				SET @id_aldeia = @id_aldeia + 1
			END

	-- Escolha de qual aldeia atacar
	SET @distancia_minima = (SELECT MIN(Distancia) FROM @dab WHERE Distancia <> 0)
	SELECT TOP 5 * INTO #TopCincoAldeiasProximas FROM @dab ORDER BY Distancia ASC
	ALTER TABLE #TopCincoAldeiasProximas ADD Escolha TINYINT IDENTITY(1,1)
	SET @escolha = (SELECT ABS(CHECKSUM(NEWID())) % 5 + 1 AS Resultado)

	SET @retorno = (SELECT ID_Aldeia FROM #TopCincoAldeiasProximas WHERE Escolha = @escolha)

	DROP TABLE #TopCincoAldeiasProximas
GO