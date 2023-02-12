CREATE PROCEDURE [dbo].[SP_JogadorEntraNaTribo]
	
AS

	DECLARE @quantidade_jogadores_sem_tribo INT = (SELECT COUNT(0) FROM Jogador WHERE ID_Tribo IS NULL)
	DECLARE @limite_jogadores_por_tribo INT = 40
	DECLARE @id_jogador_escolhido INT
	DECLARE @id_tribo_escolhida INT

	-- Escolhe tribo que vai receber um jogador
		IF OBJECT_ID(N'tempdb..#TribosDisponiveis') IS NOT NULL
			BEGIN
				DROP TABLE #TribosDisponiveis
			END
	
		SELECT ID_Tribo
			INTO #TribosDisponiveis
			FROM Tribo
			WHERE Criada = 1

		SET @id_tribo_escolhida = (SELECT TOP 1 ID_Tribo FROM #TribosDisponiveis ORDER BY NEWID())
		PRINT @id_tribo_escolhida

	-- Escolhe jogador para entrar em tribo
		IF OBJECT_ID(N'tempdb..#JogadoresSemTribo') IS NOT NULL
			BEGIN
				DROP TABLE #JogadoresSemTribo
			END

		SELECT ID_Jogador
			INTO #JogadoresSemTribo
			FROM Jogador
			WHERE ID_Tribo IS NULL
			AND Jogavel = 0

		SET @id_jogador_escolhido = (SELECT TOP 1 ID_Jogador FROM #JogadoresSemTribo ORDER BY NEWID())
		PRINT @id_jogador_escolhido

	-- Verifica se a tribo tem menos de 40 membros
		IF (SELECT COUNT(0) FROM Jogador WHERE ID_Tribo = @id_tribo_escolhida) < 40
			BEGIN
				UPDATE Jogador
				SET ID_Tribo = @id_tribo_escolhida
				WHERE ID_Jogador = @id_jogador_escolhido
			END
GO
