USE [TWGAMEPLAY]
GO

/****** Object:  StoredProcedure [dbo].[SP_CriaTribo]    Script Date: 17/07/2022 10:01:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CriaTribo]
	@nome VARCHAR(30),
	@tag CHAR(6)
AS
	INSERT INTO Tribo(Nome, Tag)
	VALUES(@nome, @tag)
GO


