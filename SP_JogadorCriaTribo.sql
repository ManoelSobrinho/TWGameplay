CREATE PROCEDURE [dbo].[SP_JogadorCriaTribo]
	
AS

	DECLARE @limite_de_tribos INT = 50
	DECLARE @quantidade_de_tribos INT = (SELECT COUNT(*) FROM Tribo)
	DECLARE @id_maximo_jogador INT = (SELECT MAX(ID_Jogador) FROM Jogador)
	DECLARE @jogada INT
	DECLARE @id_fundador INT
	DECLARE @id_tribo INT
	DECLARE @id_maximo_tribo INT = (SELECT MAX(ID_Tribo) FROM Tribo)
	DECLARE @nome_jogador VARCHAR(30)
	DECLARE @nome_tribo_criada VARCHAR(30)
	DECLARE @relatorio VARCHAR(300)

	SET @jogada = (SELECT (ABS(CHECKSUM(NEWID())) % 2) + 1)

	IF(@jogada = 1) AND @quantidade_de_tribos < @limite_de_tribos
		BEGIN
			SET @id_fundador = (SELECT (ABS(CHECKSUM(NEWID())) % @id_maximo_jogador) + 1)
			IF(SELECT ID_Tribo FROM Jogador WHERE ID_Jogador = @id_fundador) IS NULL AND (SELECT Jogavel FROM Jogador WHERE ID_Jogador = @id_fundador) = 0
				BEGIN
					SET @id_tribo = (SELECT(ABS(CHECKSUM(NEWID())) % @id_maximo_tribo) + 1)
					IF (SELECT Criada FROM Tribo WHERE ID_Tribo = @id_tribo) = 0
						BEGIN
							UPDATE Tribo
							SET Criada = 1
							WHERE ID_Tribo = @id_tribo
							UPDATE Jogador
							SET ID_Tribo = @id_tribo
							WHERE ID_Jogador = @id_fundador

							SET @nome_jogador = (SELECT Nome FROM Jogador WHERE ID_Jogador = @id_fundador)
							SET @nome_tribo_criada = (SELECT Nome FROM Tribo WHERE ID_Tribo = @id_tribo)
							SET @relatorio = 'O jogador ' + @nome_jogador + ' criou a tribo ' + @nome_tribo_criada

							PRINT @relatorio
						END
				END
		END
GO
