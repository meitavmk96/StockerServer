USE [igroup136_test1]
GO
/****** Object:  StoredProcedure [dbo].[spReadMedRequestsNurseMine]    Script Date: 15/03/2023 10:42:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<LML>
-- Create date: <27/02/2023>
-- Description:	<read MedRequest Nurse Mine>
-- =============================================
ALTER PROCEDURE [dbo].[spReadMedRequestsNurseMine]
      @cDep smallint
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	--SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT reqId, reqDate, MedRequests.medId AS 'medId', genName+' '+comName+' '+format(eaQty,'')+' '+unit+' '+given as 'medName',
		  MedRequests.cUser AS 'cUserId', U1.firstName+' '+U1.lastName AS 'cNurseName',
		  MedRequests.aDep AS 'aDepId', depName AS 'aDepName', MedRequests.aUser AS 'aUserId', 
		  U2.firstName+' '+U2.lastName AS 'aNurseName',reqStatus, reqQty
	FROM [MedRequests] INNER JOIN [Medicines]
         ON MedRequests.[medId] = Medicines.[medId] INNER JOIN [Users] as U1
		 ON U1.[userId] = MedRequests.[cUser] left JOIN [Departments] 
		 ON [MedRequests].[aDep] = Departments.[depId] INNER JOIN [Users] as U2
		 ON U2.[userId] = MedRequests.[aUser]
   WHERE (MedRequests.reqStatus='W' OR MedRequests.reqStatus='A') and MedRequests.cDep=@cDep
   order by [MedRequests].reqDate desc

END
