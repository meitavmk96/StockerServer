-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<LML>
-- Create date: <16/03/2023>
-- Description:	<Read FULL NAME Medicines>
-- =============================================
Alter PROCEDURE spReadFullNameMedicines 
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	--SET NOCOUNT ON;

    -- Insert statements for procedure here
	Select medId, genName+' '+comName+' '+format(eaQty,'')+' '+unit+' '+given as 'medName',
	        mazNum, medStatus, lastUpdate
	from [Medicines]
	order by medName
END
GO
