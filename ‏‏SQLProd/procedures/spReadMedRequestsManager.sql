USE [igroup136_test1]
GO
/****** Object:  StoredProcedure [dbo].[spReadMedRequestsManager]    Script Date: 12/07/2023 12:17:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<LML>
-- Create date: <27/02/2023>
-- Description:	<read MedRequest Manager>
-- =============================================
ALTER PROCEDURE [dbo].[spReadMedRequestsManager]
   
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	--SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT cast(reqDate as date) as 'reqDate', Medicines.mazNum, 
	       genName+' '+comName+' '+format(eaQty,'')+' '+unit+' '+given as 'medName',
		   D2.depName as 'cDepName',
		   CASE WHEN (MedRequests.aDep !=0) THEN D1.depName
			    WHEN (MedRequests.aDep =0) THEN ''
				end as aDepName, reqQty,
		   CASE WHEN (reqStatus like 'D') THEN N'נדחתה'
			    WHEN (reqStatus like 'A') THEN N'אושרה'
				WHEN (reqStatus like 'T') THEN N'הועברה'
				WHEN (reqStatus like 'W') THEN N'ממתינה'
				end as reqStatus
	FROM [MedRequests] INNER JOIN [Medicines]
         ON MedRequests.[medId] = Medicines.[medId] left JOIN [Departments] D1
		 ON [MedRequests].[aDep] = D1.[depId] inner JOIN [Departments] D2
		 ON [MedRequests].[cDep] = D2.[depId] 
   where year(getdate())=year(reqDate)
   order by [MedRequests].reqDate desc

END
