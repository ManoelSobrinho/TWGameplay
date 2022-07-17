USE [TWGAMEPLAY]
GO

/****** Object:  StoredProcedure [dbo].[SP_GeraCoordenada]    Script Date: 17/07/2022 10:01:09 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_GeraCoordenada]
	@menor INT,
	@maior INT
AS
	SET @menor = 100 ---- menor número
	SET @maior = 999 ---- maior número
	SELECT ROUND(((@maior - @menor -1) * RAND() + @menor), 0) AS x, ROUND(((@maior - @menor -1) * RAND() + @menor), 0) AS y
GO


