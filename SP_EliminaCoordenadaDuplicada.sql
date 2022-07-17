USE [TWGAMEPLAY]
GO

/****** Object:  StoredProcedure [dbo].[SP_EliminaCoordenadaDuplicada]    Script Date: 17/07/2022 10:01:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_EliminaCoordenadaDuplicada]
AS
	WITH CTE AS 
	(SELECT x, y, ROW_NUMBER() OVER(PARTITION BY x, y ORDER BY x DESC) Linha
	FROM aux.Coordenada)
	DELETE FROM cte WHERE Linha > 1
GO


