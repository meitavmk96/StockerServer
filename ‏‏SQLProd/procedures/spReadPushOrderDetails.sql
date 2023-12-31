USE [igroup136_test1]
GO
/****** Object:  StoredProcedure [dbo].[spReadPullOrderDetails]    Script Date: 29/03/2023 20:04:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON

GO
-- =============================================
-- Author:		<LML>
-- Create date: <28-02-2023>
-- Description:	<Read PushOrderDetails>
-- =============================================
ALTER PROCEDURE [dbo].[spReadPushOrderDetails]

      @orderId smallint
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	--SET NOCOUNT ON;

    -- Insert statements for procedure here
	 SELECT M.medId, genName+' '+comName+' '+format(eaQty,'')+' '+unit+' '+given as 'medName', poQty, supQty
	 FROM [PushOrders] as PO inner join [PushMedOrders] as MO
	      on PO.pushId= MO.orderId inner join [Medicines] as M
		  on MO.medId=M.medId 
	 where PO.pushId=@orderId
	 order by PO.pushDate desc
END
