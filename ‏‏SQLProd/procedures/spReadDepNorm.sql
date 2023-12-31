USE [igroup136_test1]
GO
/****** Object:  StoredProcedure [dbo].[spReadDepNorm]    Script Date: 13/07/2023 16:00:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<LML>
-- Create date: <27/02/2023>
-- Description:	<Read Dep MedNorms>
-- =============================================
ALTER PROCEDURE [dbo].[spReadDepNorm]
     @depId smallint

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	--SET NOCOUNT ON;

	SELECT N.normId as 'NormId', depId, N.lastUpdate as 'LastUpdate', MN.medId, normQty, MN.mazNum,
	       genName+' '+comName+' '+format(eaQty,'')+' '+unit+' '+given as 'medName'
	 FROM [Norms] as N 
	 inner join [MedNorms] as MN on N.normId= MN.normId
	 inner join [Medicines] as M on MN.medId=M.medId
	 where N.depId=@depId
	 order by N.normId desc, lastUpdate desc
END
