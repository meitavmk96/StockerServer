USE [igroup136_test1]
GO
/****** Object:  StoredProcedure [dbo].[spReadPullOrderDetails]    Script Date: 03/04/2023 12:25:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<LML>
-- Create date: <28-02-2023>
-- Description:	<Read PullOrderDetails>
-- =============================================
ALTER PROCEDURE [dbo].[spReadPullOrderDetails]

      @orderId smallint
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	--SET NOCOUNT ON;

    -- Insert statements for procedure here
	 SELECT M.medId, genName+' '+comName+' '+format(eaQty,'')+' '+unit+' '+given as 'medName', poQty, supQty
	 FROM [PullOrders] as PO inner join [PullMedOrders] as MO
	      on PO.pullId= MO.orderId inner join [Medicines] as M
		  on MO.medId=M.medId 
	 where PO.pullId=@orderId
	 order by PO.pullDate desc
END

 