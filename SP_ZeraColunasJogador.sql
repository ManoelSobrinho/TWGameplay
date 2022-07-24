USE [TWGAMEPLAY]
GO

/****** Object:  StoredProcedure [dbo].[SP_ZeraColunasJogador]    Script Date: 24/07/2022 08:37:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_ZeraColunasJogador]
AS
	UPDATE Jogador
		SET Pontos = 0
		,ODA = 0
		,ODD = 0
GO


