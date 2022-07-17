USE [TWGAMEPLAY]
GO

/****** Object:  StoredProcedure [dbo].[SP_AldeiaRecebeJogador]    Script Date: 17/07/2022 10:00:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_AldeiaRecebeJogador]
	AS
		INSERT INTO Aldeia(ID_Jogador)
		SELECT ID_Jogador FROM Jogador
GO


