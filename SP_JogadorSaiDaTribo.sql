CREATE PROCEDURE [dbo].[SP_JogadorSaiDaTribo]
	
AS

	DECLARE @id_jogador_escolhido INT
	DECLARE @id_tribo_jogador_escolhido INT
	DECLARE @lealdade INT
	DECLARE @aldeias_perdidas_em_guerra INT
	DECLARE @quantidade_de_tribos_inimigas INT
	DECLARE @ranking_da_tribo INT
	DECLARE @pontuacao_da_tribo INT

	-- Escolhe jogador para entrar em tribo
		IF OBJECT_ID(N'tempdb..#JogadoresComTribo') IS NOT NULL
			BEGIN
				DROP TABLE #JogadoresComTribo
			END

		SELECT ID_Jogador
			INTO #JogadoresComTribo
			FROM Jogador
			WHERE ID_Tribo IS NOT NULL
			AND Jogavel = 0

		SET @id_jogador_escolhido = (SELECT TOP 1 ID_Jogador FROM #JogadoresComTribo ORDER BY NEWID())
		SET @id_tribo_jogador_escolhido = (SELECT ID_Tribo FROM Jogador WHERE ID_Jogador = @id_jogador_escolhido)
		SET @lealdade = (SELECT Lealdade FROM Jogador WHERE ID_Jogador = @id_jogador_escolhido)
		SET @aldeias_perdidas_em_guerra = (SELECT NoblagensTribo_A FROM GuerraTribo WHERE ID_Tribo_B = @id_tribo_jogador_escolhido) + (SELECT NoblagensTribo_B FROM GuerraTribo WHERE ID_Tribo_A = @id_tribo_jogador_escolhido)
		SET @quantidade_de_tribos_inimigas = (SELECT COUNT(0) FROM Diplomacia WHERE ID_Tribo_A = @id_tribo_jogador_escolhido AND ID_TipoDiplomacia = 6 AND Status = 1) + (SELECT COUNT(0) FROM Diplomacia WHERE ID_Tribo_B = @id_tribo_jogador_escolhido AND ID_TipoDiplomacia = 6 AND Status = 1)
		SET @pontuacao_da_tribo = (SELECT Pontos FROM Tribo WHERE ID_Tribo = @id_tribo_jogador_escolhido)
		SET @ranking_da_tribo = (SELECT COUNT(0) FROM Tribo WHERE Pontos > @pontuacao_da_tribo AND ID_Tribo <> @id_tribo_jogador_escolhido) + 1

		IF @lealdade = 1 AND @aldeias_perdidas_em_guerra > 50 AND @quantidade_de_tribos_inimigas > 2 AND @ranking_da_tribo > 5
			BEGIN
				UPDATE Jogador
				SET ID_Tribo = NULL 
				WHERE ID_Jogador = @id_jogador_escolhido
			END

		IF @lealdade = 2 AND @aldeias_perdidas_em_guerra > 100 AND @quantidade_de_tribos_inimigas > 3 AND @ranking_da_tribo > 10
			BEGIN
				UPDATE Jogador
				SET ID_Tribo = NULL 
				WHERE ID_Jogador = @id_jogador_escolhido
			END

		IF @lealdade = 3 AND @aldeias_perdidas_em_guerra > 150 AND @quantidade_de_tribos_inimigas > 4 AND @ranking_da_tribo > 15
			BEGIN
				UPDATE Jogador
				SET ID_Tribo = NULL 
				WHERE ID_Jogador = @id_jogador_escolhido
			END

		IF @lealdade = 4  AND @aldeias_perdidas_em_guerra > 300 AND @quantidade_de_tribos_inimigas > 6 AND @ranking_da_tribo > 20
			BEGIN
				UPDATE Jogador
				SET ID_Tribo = NULL 
				WHERE ID_Jogador = @id_jogador_escolhido
			END

		IF @lealdade = 5 AND @aldeias_perdidas_em_guerra > 500 AND @quantidade_de_tribos_inimigas > 8 AND @ranking_da_tribo > 25
			BEGIN
				UPDATE Jogador
				SET ID_Tribo = NULL 
				WHERE ID_Jogador = @id_jogador_escolhido
			END
GO