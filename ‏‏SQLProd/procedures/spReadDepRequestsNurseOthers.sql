USE [igroup136_test1]
GO
/****** Object:  StoredProcedure [dbo].[spReadDepRequestsNurseOthers]    Script Date: 18/03/2023 13:37:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<LML>
-- Create date: <09/03/2023>
-- Description:	<Read DepRequests Nurse Others>
-- =============================================
ALTER PROCEDURE [dbo].[spReadDepRequestsNurseOthers]
	@cDep smallint
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	--SET NOCOUNT ON;

    -- Insert statements for procedure here

select reqId, depName, firstName+' '+lastName AS 'cNurseName', reqDate, Users.depId as 'cDepId',
	   genName+' '+comName+' '+format(eaQty,'')+' '+unit+' '+given as 'medName', 
	   reqQty, depReqs.stcQty,depReqs.reqStatus, depReqs.aDep 
from [Medicines] inner join
		         (select MedRequests.[reqId], MedRequests.[medId], depName, MedRequests.[cUser], reqDate, reqQty, 
				         sum(STC.stcQty) as 'stcQty',reqStatus, aDep
				  FROM [DepRequests] INNER JOIN [MedRequests] 
	                   ON MedRequests.[reqId]=DepRequests.[reqId] INNER JOIN [Departments] 
                       ON MedRequests.[cDep] = Departments.[depId] INNER JOIN [Users] 
		               ON Users.[userId] = MedRequests.[cUser] LEFT JOIN 
					                             (Select Stocks.[medId], stcQty
					                              from [Stocks]
					                              where Stocks.depId=@cDep) as STC
		               ON MedRequests.[medId]=STC.[medId]
				  WHERE DepRequests.reqDep=@cDep and (MedRequests.reqStatus='W' OR MedRequests.reqStatus='A') and STC.stcQty>=reqQty
			      group by MedRequests.[reqId], MedRequests.[medId], depName, MedRequests.[cUser], reqDate, reqQty, 
				           reqStatus,aDep) as depReqs
	ON depReqs.[medId] = Medicines.[medId] INNER JOIN [Users] 
	ON Users.[userId] = depReqs.[cUser]
	order by depReqs.reqDate desc

END
GO




select reqId, Users.depId, depName, firstName+' '+lastName AS 'cNurseName', reqDate, 
	   genName+' '+comName+' '+format(eaQty,'')+' '+unit+' '+given as 'medName', 
	   reqQty, depReqs.stcQty,depReqs.reqStatus, depReqs.aDep 
from [Medicines] inner join
		         (select MedRequests.[reqId], MedRequests.[medId], depName, MedRequests.[cUser], reqDate, reqQty, 
				         sum(STC.stcQty) as 'stcQty',reqStatus, aDep
				  FROM [DepRequests] INNER JOIN [MedRequests] 
	                   ON MedRequests.[reqId]=DepRequests.[reqId] INNER JOIN [Departments] 
                       ON MedRequests.[cDep] = Departments.[depId] INNER JOIN [Users] 
		               ON Users.[userId] = MedRequests.[cUser] LEFT JOIN 
					                             (Select Stocks.[medId], stcQty
					                              from [Stocks]
					                              where Stocks.depId=3) as STC
		               ON MedRequests.[medId]=STC.[medId]
				  WHERE DepRequests.reqDep=3 and (MedRequests.reqStatus='W' OR MedRequests.reqStatus='A') and STC.stcQty>=reqQty
			      group by MedRequests.[reqId], MedRequests.[medId], depName, MedRequests.[cUser], reqDate, reqQty, 
				           reqStatus,aDep) as depReqs
	ON depReqs.[medId] = Medicines.[medId] INNER JOIN [Users] 
	ON Users.[userId] = depReqs.[cUser]
	order by depReqs.reqDate desc
