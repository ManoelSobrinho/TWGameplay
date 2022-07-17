USE [TWGAMEPLAY]
GO

/****** Object:  StoredProcedure [dbo].[SP_CriaJogadorJogavel]    Script Date: 17/07/2022 10:00:56 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CriaJogadorJogavel]
	@nome VARCHAR(20)
AS
	INSERT INTO Jogador(Nome, Lealdade, Nivel, Jogavel)
	VALUES(@nome, 0, 0, 1)
GO


