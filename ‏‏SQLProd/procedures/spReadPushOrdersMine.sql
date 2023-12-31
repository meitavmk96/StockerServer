USE [igroup136_test1]
GO
/****** Object:  StoredProcedure [dbo].[spReadPushOrdersMine]    Script Date: 12/07/2023 12:02:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<LML>
-- Create date: <28-02-2023>
-- Description:	<Read PushMedOrders>
-- =============================================
ALTER PROCEDURE [dbo].[spReadPushOrdersMine]

      @depId smallint
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	--SET NOCOUNT ON;

    -- Insert statements for procedure here
	 SELECT PO.pushId as 'orderId', pUser as 'pharmacistId', PU.firstName+' '+PU.lastName AS 'pharmacistName',
			pushStatus as 'orderStatus', pushDate as 'orderDate', lastUpdate
	 FROM [PushOrders] as PO inner join [Users] as PU 
	      on PU.userId= PO.pUser
	 where PO.depId= @depId and ((pushStatus like 'I' and datediff(day, pushDate, getdate()) <=7) OR pushStatus like 'R')
	 order by PO.lastUpdate desc
END
