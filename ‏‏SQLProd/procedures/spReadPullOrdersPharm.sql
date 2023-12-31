USE [igroup136_test1]
GO
/****** Object:  StoredProcedure [dbo].[spReadPullOrdersPharm]    Script Date: 12/07/2023 11:09:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<LML>
-- Create date: <28-02-2023>
-- Description:	<Read PullOrdersPharm>
-- =============================================
ALTER PROCEDURE [dbo].[spReadPullOrdersPharm]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	--SET NOCOUNT ON;

    -- Insert statements for procedure here
	 SELECT pullId, cast(pullDate as smalldatetime) as 'orderDate', CONVERT(NVARCHAR, pullDate, 8) as 'orderTime', 
	        O.depId, depName, nUser, U2.firstName+' '+U2.lastName AS 'nurseName', pUser, 
	        CASE WHEN (pUser=0) THEN ''
			     else U1.firstName+' '+U1.lastName 
				 end as 'pharmName', 
			CASE WHEN (pullStatus like 'W') THEN N'בהמתנה'
			     WHEN (pullStatus like 'T') THEN N'בטיפול'
				 WHEN (pullStatus like 'I') THEN N'נופק'
				 end as pullStatus, reportNum, O.lastUpdate
	 FROM [PullOrders] as O INNER JOIN [Users] as U1
		  ON U1.[userId] = O.[pUser] INNER JOIN [Departments] 
		  ON O.[depId] = Departments.[depId] INNER JOIN [Users] as U2
		  ON U2.[userId] = O.[nUser]
	 where (pullStatus like 'I' and datediff(day, pullDate, getdate()) <=7) OR pullStatus in ('W', 'T')
	 order by O.pullId desc, O.lastUpdate desc
END

