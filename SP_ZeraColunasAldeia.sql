USE [TWGAMEPLAY]
GO

/****** Object:  StoredProcedure [dbo].[SP_ZeraColunasAldeia]    Script Date: 23/07/2022 18:42:08 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_ZeraColunasAldeia]
AS
	UPDATE Aldeia
		SET Pontos = 0
		,TropasOfensivas = 0
		,TropasDefensivas = 0
GO


