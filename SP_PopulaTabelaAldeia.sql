USE [TWGAMEPLAY]
GO

/****** Object:  StoredProcedure [dbo].[SP_PopulaTabelaAldeia]    Script Date: 17/07/2022 10:01:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_PopulaTabelaAldeia]
AS
	INSERT INTO Aldeia (x, y)
	SELECT x, y
	FROM aux.Coordenada 
GO


