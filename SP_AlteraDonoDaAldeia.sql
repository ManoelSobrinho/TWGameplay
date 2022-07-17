USE [TWGAMEPLAY]
GO

/****** Object:  StoredProcedure [dbo].[SP_AlteraDonoDaAldeia]    Script Date: 17/07/2022 10:00:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_AlteraDonoDaAldeia]
	@id_novo_dono INT,
	@id_aldeia INT
	AS
		UPDATE Aldeia
		SET ID_Jogador = @id_novo_dono
		WHERE ID_Aldeia = @id_aldeia
GO


