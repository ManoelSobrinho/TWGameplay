USE [TWGAMEPLAY]
GO

/****** Object:  StoredProcedure [dbo].[SP_ZeraColunasTribo]    Script Date: 24/07/2022 08:38:16 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_ZeraColunasTribo]
AS
	UPDATE Tribo
		SET Pontos = 0
		,ODA = 0
		,ODD = 0
GO


