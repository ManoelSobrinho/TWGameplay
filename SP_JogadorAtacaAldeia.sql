USE [TWGAMEPLAY]
GO

/****** Object:  StoredProcedure [dbo].[SP_JogadorAtacaAldeia]    Script Date: 12/02/2023 16:13:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[SP_JogadorAtacaAldeia]
	@id_aldeia_origem INT
AS
	DECLARE @retorno INT
	DECLARE @forca_ataque INT
	DECLARE @forca_defesa INT
	DECLARE @porcentagem INT
	DECLARE @id_jogador_ataque INT
	DECLARE @id_jogador_defesa INT
	DECLARE @id_tribo_jogador_ataque INT
	DECLARE @id_tribo_jogador_defesa INT

	EXEC SP_CalculaAldeiaMaisProximaAtacavel 
	@id_aldeia_origem = @id_aldeia_origem,
	@retorno = @retorno OUTPUT

	SET @forca_ataque = (SELECT TropasOfensivas FROM Aldeia WHERE ID_Aldeia = @id_aldeia_origem)
	SET @forca_defesa = (SELECT TropasOfensivas * 0.2 + TropasDefensivas + Pontos * 0.1 FROM Aldeia WHERE ID_Aldeia = @retorno)
	SET @porcentagem = (SELECT (@forca_defesa - @forca_ataque) * 100 / TropasOfensivas + TropasDefensivas FROM Aldeia WHERE ID_Aldeia = @retorno)
	SET @id_jogador_ataque = (SELECT ID_Jogador FROM Aldeia WHERE ID_Aldeia = @id_aldeia_origem)
	SET @id_jogador_defesa = (SELECT ID_Jogador FROM Aldeia WHERE ID_Aldeia = @retorno)
	SET @id_tribo_jogador_ataque = (SELECT ID_Tribo FROM Jogador WHERE ID_Jogador = @id_jogador_ataque)
	SET @id_tribo_jogador_defesa = (SELECT ID_Tribo FROM Jogador WHERE ID_Jogador = @id_jogador_defesa)

	IF @forca_ataque > @forca_defesa
		BEGIN -- TropasOfensor, TropasDefensor, ODA, ODD, GuerraJogador
			UPDATE Aldeia
			SET TropasOfensivas = 0, TropasDefensivas = 0 WHERE ID_Aldeia = @retorno
			UPDATE Aldeia
			SET TropasOfensivas = @forca_ataque - @forca_defesa WHERE ID_Aldeia = @id_aldeia_origem
			UPDATE Jogador 
			SET ODA = ODA + @forca_defesa WHERE ID_Jogador = @id_jogador_ataque
			UPDATE Jogador 
			SET ODD = ODD + @forca_defesa WHERE ID_Jogador = @id_jogador_defesa
		-- Se a aldeia do jogador atacante tiver mais de 100 pontos vai conquistar a aldeia
			IF (SELECT Pontos FROM Aldeia WHERE ID_Aldeia = @id_aldeia_origem) >= 100
				BEGIN
				-- Verifica se os jogadores já tem uma guerra entre si
					IF EXISTS (SELECT 1 FROM GuerraJogador WHERE ID_Jogador_A = @id_jogador_ataque AND ID_Jogador_B = @id_jogador_defesa) OR EXISTS (SELECT 1 FROM GuerraJogador WHERE ID_Jogador_A = @id_jogador_defesa AND ID_Jogador_B = @id_jogador_ataque)
						BEGIN
							IF (SELECT ID_Jogador_A FROM GuerraJogador) = @id_jogador_ataque
								BEGIN
									UPDATE GuerraJogador
									SET AldeiasConquistadas_Jogador_A = AldeiasConquistadas_Jogador_A + 1
									WHERE ID_GuerraJogador = (SELECT ID_GuerraJogador FROM GuerraJogador WHERE ID_Jogador_A = @id_jogador_ataque AND ID_Jogador_B = @id_jogador_defesa)
								END
							ELSE IF (SELECT ID_Jogador_B FROM GuerraJogador) = @id_jogador_ataque
								BEGIN
									UPDATE GuerraJogador
									SET AldeiasConquistadas_Jogador_B = AldeiasConquistadas_Jogador_B + 1
									WHERE ID_GuerraJogador = (SELECT ID_GuerraJogador FROM GuerraJogador WHERE ID_Jogador_A = @id_jogador_defesa AND ID_Jogador_B = @id_jogador_ataque)
								END
						END
				-- Se não existe uma guerra entre os jogadores, cria uma nova
					ELSE 
						BEGIN
							INSERT INTO GuerraJogador (AldeiasConquistadas_Jogador_A, AldeiasConquistadas_Jogador_B, ID_Jogador_A, ID_Jogador_B)
							VALUES (1, 0, @id_jogador_ataque, @id_jogador_defesa)
						END
				
				-- Verifica se as tribos dos jogadores está em guerra
					IF EXISTS (SELECT ID_Tribo_A, ID_Tribo_B FROM GuerraTribo 
						WHERE (ID_Tribo_A = (SELECT ID_Tribo FROM Jogador WHERE ID_Jogador = @id_jogador_ataque) AND (ID_Tribo_B = (SELECT ID_Tribo FROM Jogador WHERE ID_Jogador = @id_jogador_defesa))
						OR (ID_Tribo_A = (SELECT ID_Tribo FROM Jogador WHERE ID_Jogador = @id_jogador_defesa) AND (ID_Tribo_B = (SELECT ID_Tribo FROM Jogador WHERE ID_Jogador = @id_jogador_ataque)))))
						BEGIN
							UPDATE GuerraTribo
							SET NoblagensTribo_A = NoblagensTribo_A + 1,
							ODA_Tribo_A = ODA_Tribo_A + @forca_defesa,
							ODD_Tribo_B = ODD_Tribo_B + @forca_defesa
							WHERE ID_Tribo_A = @id_tribo_jogador_ataque AND ID_Tribo_B = @id_tribo_jogador_defesa
							UPDATE GuerraTribo
							SET NoblagensTribo_B = NoblagensTribo_B + 1,
							ODA_Tribo_B = ODA_Tribo_B + @forca_defesa,
							ODD_Tribo_A = ODD_Tribo_A + @forca_defesa
							WHERE ID_Tribo_B = @id_tribo_jogador_ataque AND ID_Tribo_A = @id_tribo_jogador_defesa
						END
				-- Jogador nobla a aldeia
					UPDATE Aldeia
					SET ID_Jogador = @id_jogador_ataque WHERE ID_Aldeia = @retorno
				END
		END

	ELSE IF @forca_defesa > @forca_ataque
		BEGIN -- TropasOfensor, TropasDefensor, ODA, ODD, GuerraJogador
			UPDATE Aldeia
			SET TropasOfensivas = 0 WHERE ID_Aldeia = @id_aldeia_origem
			UPDATE Aldeia
			SET TropasOfensivas = (@porcentagem * TropasOfensivas) / 100 WHERE ID_Aldeia = @retorno
			UPDATE Aldeia
			SET TropasDefensivas = (@porcentagem * TropasDefensivas) / 100 WHERE ID_Aldeia = @retorno
			UPDATE Jogador
			SET ODA = ODA + @forca_ataque WHERE ID_Jogador = @id_jogador_ataque
			UPDATE Jogador
			SET ODD = ODD + @forca_ataque WHERE ID_Jogador = @id_jogador_defesa
		-- Verifica se as tribos dos jogadores está em guerra
			IF EXISTS (SELECT ID_Tribo_A, ID_Tribo_B FROM GuerraTribo 
				WHERE (ID_Tribo_A = (SELECT ID_Tribo FROM Jogador WHERE ID_Jogador = @id_jogador_ataque) AND (ID_Tribo_B = (SELECT ID_Tribo FROM Jogador WHERE ID_Jogador = @id_jogador_defesa))
				OR (ID_Tribo_A = (SELECT ID_Tribo FROM Jogador WHERE ID_Jogador = @id_jogador_defesa) AND (ID_Tribo_B = (SELECT ID_Tribo FROM Jogador WHERE ID_Jogador = @id_jogador_ataque)))))
				BEGIN
					UPDATE GuerraTribo
					SET ODA_Tribo_A = ODA_Tribo_A + @forca_defesa,
					ODD_Tribo_B = ODD_Tribo_B + @forca_defesa
					WHERE ID_Tribo_A = @id_tribo_jogador_ataque AND ID_Tribo_B = @id_tribo_jogador_defesa
					UPDATE GuerraTribo
					SET ODA_Tribo_B = ODA_Tribo_B + @forca_defesa,
					ODD_Tribo_A = ODD_Tribo_A + @forca_defesa
					WHERE ID_Tribo_B = @id_tribo_jogador_ataque AND ID_Tribo_A = @id_tribo_jogador_defesa
				END
		END

	ELSE IF @forca_defesa = @forca_ataque
		BEGIN -- TropasOfensor, TropasDefensor, ODA, ODD, GuerraJogador
			UPDATE Aldeia
			SET TropasOfensivas = 0 WHERE ID_Aldeia = @id_aldeia_origem
			UPDATE Aldeia
			SET TropasOfensivas = 0 WHERE ID_Aldeia = @retorno
			UPDATE Aldeia
			SET TropasOfensivas = 0 WHERE ID_Aldeia = @retorno
			UPDATE Jogador
			SET ODA = ODA + @forca_ataque WHERE ID_Jogador = @id_jogador_ataque
			UPDATE Jogador
			SET ODA = ODA + @forca_ataque WHERE ID_Jogador = @retorno
		-- Verifica se as tribos dos jogadores está em guerra
			IF EXISTS (SELECT ID_Tribo_A, ID_Tribo_B FROM GuerraTribo 
				WHERE (ID_Tribo_A = (SELECT ID_Tribo FROM Jogador WHERE ID_Jogador = @id_jogador_ataque) AND (ID_Tribo_B = (SELECT ID_Tribo FROM Jogador WHERE ID_Jogador = @id_jogador_defesa))
				OR (ID_Tribo_A = (SELECT ID_Tribo FROM Jogador WHERE ID_Jogador = @id_jogador_defesa) AND (ID_Tribo_B = (SELECT ID_Tribo FROM Jogador WHERE ID_Jogador = @id_jogador_ataque)))))
				BEGIN
					UPDATE GuerraTribo
					SET ODA_Tribo_A = ODA_Tribo_A + @forca_defesa,
					ODD_Tribo_B = ODD_Tribo_B + @forca_defesa
					WHERE ID_Tribo_A = @id_tribo_jogador_ataque AND ID_Tribo_B = @id_tribo_jogador_defesa
					UPDATE GuerraTribo
					SET ODA_Tribo_B = ODA_Tribo_B + @forca_defesa,
					ODD_Tribo_A = ODD_Tribo_A + @forca_defesa
					WHERE ID_Tribo_B = @id_tribo_jogador_ataque AND ID_Tribo_A = @id_tribo_jogador_defesa
				END
		END
GO


