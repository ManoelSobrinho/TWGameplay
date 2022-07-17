USE [TWGAMEPLAY]
GO

/****** Object:  StoredProcedure [dbo].[SP_CriaDiplomacia]    Script Date: 17/07/2022 10:00:51 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CriaDiplomacia]
	@id_tribo_a INT,
	@id_tribo_b INT,
	@id_tipoDiplomacia INT
AS
	IF EXISTS (SELECT 1 FROM Diplomacia WHERE(ID_Tribo_A = @id_tribo_a AND ID_Tribo_B = @id_tribo_b) OR (ID_Tribo_A = @id_tribo_b AND ID_Tribo_B = @id_tribo_a))
		BEGIN
			IF @id_tipoDiplomacia IN (SELECT ID_TipoDiplomacia FROM Diplomacia WHERE (ID_Tribo_A = @id_tribo_a AND ID_Tribo_B = @id_tribo_b) OR (ID_Tribo_A = @id_tribo_b and ID_Tribo_B = @id_tribo_a))
				BEGIN
					PRINT 'Diplomacia já existente.'
				END
		ELSE IF EXISTS (SELECT 1 FROM Diplomacia WHERE(ID_Tribo_A = @id_tribo_a AND ID_Tribo_B = @id_tribo_b) OR (ID_Tribo_A = @id_tribo_b AND ID_Tribo_B = @id_tribo_a))
			BEGIN
				PRINT 'As tribos já possuem uma diplomacia.'
				DELETE FROM Diplomacia
					WHERE (ID_Tribo_A = @id_tribo_a AND ID_Tribo_B = @id_tribo_b) OR (ID_Tribo_A = @id_tribo_b AND ID_Tribo_B = @id_tribo_a)
						PRINT 'Diplomacia Desfeita.'
					INSERT INTO Diplomacia(Status, ID_Tribo_A, ID_Tribo_B, ID_TipoDiplomacia)
						VALUES(1, @id_tribo_a, @id_tribo_b, @id_tipoDiplomacia)
					PRINT 'Nova diplomacia criada.'
			END
		END
	ELSE 
		BEGIN
			PRINT 'As tribos não possuem nenhuma diplomacia.'
			INSERT INTO Diplomacia(Status, ID_Tribo_A, ID_Tribo_B, ID_TipoDiplomacia)
			VALUES(1, @id_tribo_a, @id_tribo_b, @id_tipoDiplomacia)
			PRINT 'Diplomacia criada.'
		END
GO


