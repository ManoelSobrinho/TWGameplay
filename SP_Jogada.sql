CREATE PROCEDURE [dbo].[SP_Jogada]
	
AS

	DECLARE @id_jogador INT = 1
	DECLARE @id_aldeia INT = 1
	DECLARE @aux INT= 1
	DECLARE @numero_de_aldeias INT = (SELECT COUNT(*) FROM Aldeia)
	DECLARE @nivel_jogador INT
	DECLARE @valor_sobrando INT
	DECLARE @jogada INT

	WHILE (@aux <= 15)
	BEGIN
		SET @jogada = (SELECT (ABS(CHECKSUM(NEWID())) % 3) + 1)
		SET @id_jogador = (SELECT ID_Jogador FROM Aldeia WHERE ID_Aldeia = @id_aldeia)
		--SET @jogada = 3

	-- Update se jogada for pontos

		IF @jogada = 1
			BEGIN
				-- Jogadores de nível 1

				IF (SELECT Pontos FROM Aldeia WHERE ID_Aldeia = @id_aldeia) < 500
					BEGIN
						UPDATE Aldeia
						SET Pontos = Pontos + 1
						WHERE ID_Aldeia = @id_aldeia
						AND (SELECT Nivel FROM Jogador WHERE ID_Jogador = @id_jogador) = 1
						AND (SELECT Jogavel FROM Jogador WHERE ID_Jogador = @id_jogador) = 0
						AND @jogada = 1
						IF (SELECT Pontos FROM Aldeia WHERE ID_Aldeia = @id_aldeia) > 500
							BEGIN
								SET @valor_sobrando = (SELECT Pontos FROM Aldeia WHERE ID_Aldeia = @id_aldeia) - 500
								UPDATE Aldeia
								SET Pontos = 500
								WHERE ID_Aldeia = @id_aldeia
								IF (SELECT TropasOfensivas + TropasDefensivas FROM Aldeia WHERE ID_Aldeia = @id_aldeia) < 200
									BEGIN
										UPDATE Aldeia
										SET TropasOfensivas = TropasOfensivas + @valor_sobrando
										WHERE ID_Aldeia = @id_aldeia
										IF (SELECT TropasOfensivas + TropasDefensivas FROM Aldeia WHERE ID_Aldeia = @id_aldeia) > 200
											BEGIN
												UPDATE Aldeia
												SET TropasOfensivas = TropasOfensivas + 1
												WHERE ID_Aldeia = @id_aldeia
											END
									END
							END
					END

				-- Jogadores de nível 2

				IF (SELECT Pontos FROM Aldeia WHERE ID_Aldeia = @id_aldeia) < 500
					BEGIN
						UPDATE Aldeia
						SET Pontos = Pontos + 1
						WHERE ID_Aldeia = @id_aldeia
						AND (SELECT Nivel FROM Jogador WHERE ID_Jogador = @id_jogador) = 2
						AND (SELECT Jogavel FROM Jogador WHERE ID_Jogador = @id_jogador) = 0
						AND @jogada = 1
						IF (SELECT Pontos FROM Aldeia WHERE ID_Aldeia = @id_aldeia) > 500
							BEGIN
								SET @valor_sobrando = (SELECT Pontos FROM Aldeia WHERE ID_Aldeia = @id_aldeia) - 500
								UPDATE Aldeia
								SET Pontos = 500
								WHERE ID_Aldeia = @id_aldeia
								IF (SELECT TropasOfensivas + TropasDefensivas FROM Aldeia WHERE ID_Aldeia = @id_aldeia) < 200
									BEGIN
										UPDATE Aldeia
										SET TropasOfensivas = TropasOfensivas + @valor_sobrando
										WHERE ID_Aldeia = @id_aldeia
										IF (SELECT TropasOfensivas + TropasDefensivas FROM Aldeia WHERE ID_Aldeia = @id_aldeia) > 200
											BEGIN
												UPDATE Aldeia
												SET TropasOfensivas = TropasOfensivas + 1
												WHERE ID_Aldeia = @id_aldeia
											END
									END
							END
					END

				-- Jogadores de nível 3

				IF (SELECT Pontos FROM Aldeia WHERE ID_Aldeia = @id_aldeia) < 500
					BEGIN
						UPDATE Aldeia
						SET Pontos = Pontos + 2
						WHERE ID_Aldeia = @id_aldeia
						AND (SELECT Nivel FROM Jogador WHERE ID_Jogador = @id_jogador) = 3
						AND (SELECT Jogavel FROM Jogador WHERE ID_Jogador = @id_jogador) = 0
						AND @jogada = 1
						IF (SELECT Pontos FROM Aldeia WHERE ID_Aldeia = @id_aldeia) > 500
							BEGIN
								SET @valor_sobrando = (SELECT Pontos FROM Aldeia WHERE ID_Aldeia = @id_aldeia) - 500
								UPDATE Aldeia
								SET Pontos = 500
								WHERE ID_Aldeia = @id_aldeia
								IF (SELECT TropasOfensivas + TropasDefensivas FROM Aldeia WHERE ID_Aldeia = @id_aldeia) < 200
									BEGIN
										UPDATE Aldeia
										SET TropasOfensivas = TropasOfensivas + @valor_sobrando
										WHERE ID_Aldeia = @id_aldeia
										IF (SELECT TropasOfensivas + TropasDefensivas FROM Aldeia WHERE ID_Aldeia = @id_aldeia) > 200
											BEGIN
												UPDATE Aldeia
												SET TropasOfensivas = TropasOfensivas + 1
												WHERE ID_Aldeia = @id_aldeia
											END
									END
							END
					END

				-- Jogadores de nível 4

				IF (SELECT Pontos FROM Aldeia WHERE ID_Aldeia = @id_aldeia) < 500
					BEGIN
						UPDATE Aldeia
						SET Pontos = Pontos + 2
						WHERE ID_Aldeia = @id_aldeia
						AND (SELECT Nivel FROM Jogador WHERE ID_Jogador = @id_jogador) = 4
						AND (SELECT Jogavel FROM Jogador WHERE ID_Jogador = @id_jogador) = 0
						AND @jogada = 1
						IF (SELECT Pontos FROM Aldeia WHERE ID_Aldeia = @id_aldeia) > 500
							BEGIN
								SET @valor_sobrando = (SELECT Pontos FROM Aldeia WHERE ID_Aldeia = @id_aldeia) - 500
								UPDATE Aldeia
								SET Pontos = 500
								WHERE ID_Aldeia = @id_aldeia
								IF (SELECT TropasOfensivas + TropasDefensivas FROM Aldeia WHERE ID_Aldeia = @id_aldeia) < 200
									BEGIN
										UPDATE Aldeia
										SET TropasOfensivas = TropasOfensivas + @valor_sobrando
										WHERE ID_Aldeia = @id_aldeia
										IF (SELECT TropasOfensivas + TropasDefensivas FROM Aldeia WHERE ID_Aldeia = @id_aldeia) > 200
											BEGIN
												UPDATE Aldeia
												SET TropasOfensivas = TropasOfensivas + 1
												WHERE ID_Aldeia = @id_aldeia
											END
									END
							END
					END

				-- Jogadores de nível 5

				IF (SELECT Pontos FROM Aldeia WHERE ID_Aldeia = @id_aldeia) < 500
					BEGIN
						UPDATE Aldeia
						SET Pontos = Pontos + 3
						WHERE ID_Aldeia = @id_aldeia
						AND (SELECT Nivel FROM Jogador WHERE ID_Jogador = @id_jogador) = 5
						AND (SELECT Jogavel FROM Jogador WHERE ID_Jogador = @id_jogador) = 0
						AND @jogada = 1
						IF (SELECT Pontos FROM Aldeia WHERE ID_Aldeia = @id_aldeia) > 500
							BEGIN
								SET @valor_sobrando = (SELECT Pontos FROM Aldeia WHERE ID_Aldeia = @id_aldeia) - 500
								UPDATE Aldeia
								SET Pontos = 500
								WHERE ID_Aldeia = @id_aldeia
								IF (SELECT TropasOfensivas + TropasDefensivas FROM Aldeia WHERE ID_Aldeia = @id_aldeia) < 200
									BEGIN
										UPDATE Aldeia
										SET TropasOfensivas = TropasOfensivas + @valor_sobrando
										WHERE ID_Aldeia = @id_aldeia
										IF (SELECT TropasOfensivas + TropasDefensivas FROM Aldeia WHERE ID_Aldeia = @id_aldeia) > 200
											BEGIN
												UPDATE Aldeia
												SET TropasOfensivas = TropasOfensivas + 1
												WHERE ID_Aldeia = @id_aldeia
											END
									END
							END
					END
			END

	-- Update se jogada for tropas ofensivas
	
		ELSE IF @jogada = 2
			BEGIN
				-- Jogadores de nível 1

				IF (SELECT TropasOfensivas + TropasDefensivas FROM Aldeia WHERE ID_Aldeia = @id_aldeia) < 200 AND (SELECT Pontos FROM Aldeia WHERE ID_Aldeia = @id_aldeia) > 10
					BEGIN
						UPDATE Aldeia
						SET TropasOfensivas = TropasOfensivas + 1
						WHERE ID_Aldeia = @id_aldeia
						AND (SELECT Nivel FROM Jogador WHERE ID_Jogador = @id_jogador) = 1
						AND (SELECT Jogavel FROM Jogador WHERE ID_Jogador = @id_jogador) = 0
						AND @jogada = 2
						IF (SELECT TropasOfensivas + TropasDefensivas FROM Aldeia WHERE ID_Aldeia = @id_aldeia) > 200 
							BEGIN
								SET @valor_sobrando = (SELECT TropasOfensivas + TropasOfensivas FROM Aldeia WHERE ID_Aldeia = @id_aldeia) - 200
								UPDATE Aldeia
								SET Pontos = Pontos + @valor_sobrando
								WHERE ID_Aldeia = @id_aldeia
								IF (SELECT Pontos FROM Aldeia WHERE ID_Aldeia = @id_aldeia) > 500
									BEGIN
										UPDATE Aldeia
										SET Pontos = 500
										WHERE ID_Aldeia = @id_aldeia
									END
							END
					END

				-- Jogadores de nível 2

				IF (SELECT TropasOfensivas + TropasDefensivas FROM Aldeia WHERE ID_Aldeia = @id_aldeia) < 200 AND (SELECT Pontos FROM Aldeia WHERE ID_Aldeia = @id_aldeia) > 10
					BEGIN
						UPDATE Aldeia
						SET TropasOfensivas = TropasOfensivas + 1
						WHERE ID_Aldeia = @id_aldeia
						AND (SELECT Nivel FROM Jogador WHERE ID_Jogador = @id_jogador) = 2
						AND (SELECT Jogavel FROM Jogador WHERE ID_Jogador = @id_jogador) = 0
						AND @jogada = 2
						IF (SELECT TropasOfensivas + TropasDefensivas FROM Aldeia WHERE ID_Aldeia = @id_aldeia) > 200 
							BEGIN
								SET @valor_sobrando = (SELECT TropasOfensivas + TropasOfensivas FROM Aldeia WHERE ID_Aldeia = @id_aldeia) - 200
								UPDATE Aldeia
								SET Pontos = Pontos + @valor_sobrando
								WHERE ID_Aldeia = @id_aldeia
								IF (SELECT Pontos FROM Aldeia WHERE ID_Aldeia = @id_aldeia) > 500
									BEGIN
										UPDATE Aldeia
										SET Pontos = 500
										WHERE ID_Aldeia = @id_aldeia
									END
							END
					END

				-- Jogadores de nível 3

				IF (SELECT TropasOfensivas + TropasDefensivas FROM Aldeia WHERE ID_Aldeia = @id_aldeia) < 200 AND (SELECT Pontos FROM Aldeia WHERE ID_Aldeia = @id_aldeia) > 10
					BEGIN
						UPDATE Aldeia
						SET TropasOfensivas = TropasOfensivas + 2
						WHERE ID_Aldeia = @id_aldeia
						AND (SELECT Nivel FROM Jogador WHERE ID_Jogador = @id_jogador) = 3
						AND (SELECT Jogavel FROM Jogador WHERE ID_Jogador = @id_jogador) = 0
						AND @jogada = 2
						IF (SELECT TropasOfensivas + TropasDefensivas FROM Aldeia WHERE ID_Aldeia = @id_aldeia) > 200 
							BEGIN
								SET @valor_sobrando = (SELECT TropasOfensivas + TropasOfensivas FROM Aldeia WHERE ID_Aldeia = @id_aldeia) - 200
								UPDATE Aldeia
								SET Pontos = Pontos + @valor_sobrando
								WHERE ID_Aldeia = @id_aldeia
								IF (SELECT Pontos FROM Aldeia WHERE ID_Aldeia = @id_aldeia) > 500
									BEGIN
										UPDATE Aldeia
										SET Pontos = 500
										WHERE ID_Aldeia = @id_aldeia
									END
							END
					END

				-- Jogadores de nível 4

				IF (SELECT TropasOfensivas + TropasDefensivas FROM Aldeia WHERE ID_Aldeia = @id_aldeia) < 200 AND (SELECT Pontos FROM Aldeia WHERE ID_Aldeia = @id_aldeia) > 10
					BEGIN
						UPDATE Aldeia
						SET TropasOfensivas = TropasOfensivas + 2
						WHERE ID_Aldeia = @id_aldeia
						AND (SELECT Nivel FROM Jogador WHERE ID_Jogador = @id_jogador) = 4
						AND (SELECT Jogavel FROM Jogador WHERE ID_Jogador = @id_jogador) = 0
						AND @jogada = 2
						IF (SELECT TropasOfensivas + TropasDefensivas FROM Aldeia WHERE ID_Aldeia = @id_aldeia) > 200 
							BEGIN
								SET @valor_sobrando = (SELECT TropasOfensivas + TropasOfensivas FROM Aldeia WHERE ID_Aldeia = @id_aldeia) - 200
								UPDATE Aldeia
								SET Pontos = Pontos + @valor_sobrando
								WHERE ID_Aldeia = @id_aldeia
								IF (SELECT Pontos FROM Aldeia WHERE ID_Aldeia = @id_aldeia) > 500
									BEGIN
										UPDATE Aldeia
										SET Pontos = 500
										WHERE ID_Aldeia = @id_aldeia
									END
							END
					END

				-- Jogadores de nível 5

				IF (SELECT TropasOfensivas + TropasDefensivas FROM Aldeia WHERE ID_Aldeia = @id_aldeia) < 200 AND (SELECT Pontos FROM Aldeia WHERE ID_Aldeia = @id_aldeia) > 10
					BEGIN
						UPDATE Aldeia
						SET TropasOfensivas = TropasOfensivas + 3
						WHERE ID_Aldeia = @id_aldeia
						AND (SELECT Nivel FROM Jogador WHERE ID_Jogador = @id_jogador) = 5
						AND (SELECT Jogavel FROM Jogador WHERE ID_Jogador = @id_jogador) = 0
						AND @jogada = 2
						IF (SELECT TropasOfensivas + TropasDefensivas FROM Aldeia WHERE ID_Aldeia = @id_aldeia) > 200 
							BEGIN
								SET @valor_sobrando = (SELECT TropasOfensivas + TropasOfensivas FROM Aldeia WHERE ID_Aldeia = @id_aldeia) - 200
								UPDATE Aldeia
								SET Pontos = Pontos + @valor_sobrando
								WHERE ID_Aldeia = @id_aldeia
								IF (SELECT Pontos FROM Aldeia WHERE ID_Aldeia = @id_aldeia) > 500
									BEGIN
										UPDATE Aldeia
										SET Pontos = 500
										WHERE ID_Aldeia = @id_aldeia
									END
							END
					END
				END

	-- Update se jogada for tropas defensivas
	
		ELSE IF @jogada = 3
			BEGIN
				-- Jogadores de nível 1

				IF (SELECT TropasOfensivas + TropasDefensivas FROM Aldeia WHERE ID_Aldeia = @id_aldeia) < 200 AND (SELECT Pontos FROM Aldeia WHERE ID_Aldeia = @id_aldeia) > 10
					BEGIN
						UPDATE Aldeia
						SET TropasDefensivas = TropasDefensivas + 1
						WHERE ID_Aldeia = @id_aldeia
						AND (SELECT Nivel FROM Jogador WHERE ID_Jogador = @id_jogador) = 1
						AND (SELECT Jogavel FROM Jogador WHERE ID_Jogador = @id_jogador) = 0
						AND @jogada = 3
						IF (SELECT TropasOfensivas + TropasDefensivas FROM Aldeia WHERE ID_Aldeia = @id_aldeia) > 200 
							BEGIN
								SET @valor_sobrando = (SELECT TropasOfensivas + TropasDefensivas FROM Aldeia WHERE ID_Aldeia = @id_aldeia) - 200
								UPDATE Aldeia
								SET Pontos = Pontos + @valor_sobrando
								WHERE ID_Aldeia = @id_aldeia
								IF (SELECT Pontos FROM Aldeia WHERE ID_Aldeia = @id_aldeia) > 500
									BEGIN
										UPDATE Aldeia
										SET Pontos = 500
										WHERE ID_Aldeia = @id_aldeia
									END
							END
					END

				-- Jogadores de nível 2

				IF (SELECT TropasOfensivas + TropasDefensivas FROM Aldeia WHERE ID_Aldeia = @id_aldeia) < 200 AND (SELECT Pontos FROM Aldeia WHERE ID_Aldeia = @id_aldeia) > 10
					BEGIN
						UPDATE Aldeia
						SET TropasDefensivas = TropasDefensivas + 1
						WHERE ID_Aldeia = @id_aldeia
						AND (SELECT Nivel FROM Jogador WHERE ID_Jogador = @id_jogador) = 2
						AND (SELECT Jogavel FROM Jogador WHERE ID_Jogador = @id_jogador) = 0
						AND @jogada = 3
						IF (SELECT TropasOfensivas + TropasDefensivas FROM Aldeia WHERE ID_Aldeia = @id_aldeia) > 200 
							BEGIN
								SET @valor_sobrando = (SELECT TropasOfensivas + TropasDefensivas FROM Aldeia WHERE ID_Aldeia = @id_aldeia) - 200
								UPDATE Aldeia
								SET Pontos = Pontos + @valor_sobrando
								WHERE ID_Aldeia = @id_aldeia
								IF (SELECT Pontos FROM Aldeia WHERE ID_Aldeia = @id_aldeia) > 500
									BEGIN
										UPDATE Aldeia
										SET Pontos = 500
										WHERE ID_Aldeia = @id_aldeia
									END
							END
					END

				-- Jogadores de nível 3

				IF (SELECT TropasOfensivas + TropasDefensivas FROM Aldeia WHERE ID_Aldeia = @id_aldeia) < 200 AND (SELECT Pontos FROM Aldeia WHERE ID_Aldeia = @id_aldeia) > 10
					BEGIN
						UPDATE Aldeia
						SET TropasDefensivas = TropasDefensivas + 2
						WHERE ID_Aldeia = @id_aldeia
						AND (SELECT Nivel FROM Jogador WHERE ID_Jogador = @id_jogador) = 3
						AND (SELECT Jogavel FROM Jogador WHERE ID_Jogador = @id_jogador) = 0
						AND @jogada = 3
						IF (SELECT TropasOfensivas + TropasDefensivas FROM Aldeia WHERE ID_Aldeia = @id_aldeia) > 200 
							BEGIN
								SET @valor_sobrando = (SELECT TropasOfensivas + TropasDefensivas FROM Aldeia WHERE ID_Aldeia = @id_aldeia) - 200
								UPDATE Aldeia
								SET Pontos = Pontos + @valor_sobrando
								WHERE ID_Aldeia = @id_aldeia
								IF (SELECT Pontos FROM Aldeia WHERE ID_Aldeia = @id_aldeia) > 500
									BEGIN
										UPDATE Aldeia
										SET Pontos = 500
										WHERE ID_Aldeia = @id_aldeia
									END
							END
					END

				-- Jogadores de nível 4

				IF (SELECT TropasOfensivas + TropasDefensivas FROM Aldeia WHERE ID_Aldeia = @id_aldeia) < 200 AND (SELECT Pontos FROM Aldeia WHERE ID_Aldeia = @id_aldeia) > 10
					BEGIN
						UPDATE Aldeia
						SET TropasDefensivas = TropasDefensivas + 2
						WHERE ID_Aldeia = @id_aldeia
						AND (SELECT Nivel FROM Jogador WHERE ID_Jogador = @id_jogador) = 4
						AND (SELECT Jogavel FROM Jogador WHERE ID_Jogador = @id_jogador) = 0
						AND @jogada = 3
						IF (SELECT TropasOfensivas + TropasDefensivas FROM Aldeia WHERE ID_Aldeia = @id_aldeia) > 200 
							BEGIN
								SET @valor_sobrando = (SELECT TropasOfensivas + TropasDefensivas FROM Aldeia WHERE ID_Aldeia = @id_aldeia) - 200
								UPDATE Aldeia
								SET Pontos = Pontos + @valor_sobrando
								WHERE ID_Aldeia = @id_aldeia
								IF (SELECT Pontos FROM Aldeia WHERE ID_Aldeia = @id_aldeia) > 500
									BEGIN
										UPDATE Aldeia
										SET Pontos = 500
										WHERE ID_Aldeia = @id_aldeia
									END
							END
					END

				-- Jogadores de nível 5

				IF (SELECT TropasOfensivas + TropasDefensivas FROM Aldeia WHERE ID_Aldeia = @id_aldeia) < 200 AND (SELECT Pontos FROM Aldeia WHERE ID_Aldeia = @id_aldeia) > 10
					BEGIN
						UPDATE Aldeia
						SET TropasDefensivas = TropasDefensivas + 3
						WHERE ID_Aldeia = @id_aldeia
						AND (SELECT Nivel FROM Jogador WHERE ID_Jogador = @id_jogador) = 5
						AND (SELECT Jogavel FROM Jogador WHERE ID_Jogador = @id_jogador) = 0
						AND @jogada = 3
						IF (SELECT TropasOfensivas + TropasDefensivas FROM Aldeia WHERE ID_Aldeia = @id_aldeia) > 200 
							BEGIN
								SET @valor_sobrando = (SELECT TropasOfensivas + TropasDefensivas FROM Aldeia WHERE ID_Aldeia = @id_aldeia) - 200
								UPDATE Aldeia
								SET Pontos = Pontos + @valor_sobrando
								WHERE ID_Aldeia = @id_aldeia
								IF (SELECT Pontos FROM Aldeia WHERE ID_Aldeia = @id_aldeia) > 500
									BEGIN
										UPDATE Aldeia
										SET Pontos = 500
										WHERE ID_Aldeia = @id_aldeia
									END
							END
					END
			END

		SET @aux = @aux + 1
		SET @id_aldeia = @id_aldeia + 1
	END
GO