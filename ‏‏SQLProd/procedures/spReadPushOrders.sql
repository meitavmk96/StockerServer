USE [igroup136_test1]
GO
/****** Object:  StoredProcedure [dbo].[spReadPushOrders]    Script Date: 08/04/2023 18:02:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<LML>
-- Create date: <28-02-2023>
-- Description:	<Read PushOrders>
-- =============================================
ALTER PROCEDURE [dbo].[spReadPushOrders]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	--SET NOCOUNT ON;

    -- Insert statements for procedure here
	 SELECT O.pushId as 'O.PushId', pUser, depId, reportNum, pushStatus, pushDate, lastUpdate,
	        MO.orderId as 'MO.PushId', medId, poQty, supQty, mazNum
	 FROM [PushOrders] as O left outer join [PushMedOrders] as MO
	 on O.pushId= MO.orderId
	 order by O.pushId desc, O.lastUpdate desc
END
