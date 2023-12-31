USE [igroup136_test1]
GO
/****** Object:  StoredProcedure [dbo].[spReadPullOrders]    Script Date: 08/04/2023 17:59:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<LML>
-- Create date: <28-02-2023>
-- Description:	<Read PullOrders>
-- =============================================
ALTER PROCEDURE [dbo].[spReadPullOrders]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	--SET NOCOUNT ON;

    -- Insert statements for procedure here
	 SELECT O.pullId as 'O.PullId', pUser, nUser, depId, reportNum, pullStatus, pullDate, lastUpdate,  
	        MO.orderId as 'MO.PullId', medId, poQty, supQty, mazNum
	 FROM [PullOrders] as O left outer join [PullMedOrders] as MO
	 on O.pullId= MO.orderId
	 order by O.pullId desc, O.lastUpdate desc
END
