USE [igroup136_test1]
GO
/****** Object:  StoredProcedure [dbo].[spInsertMedRequest]    Script Date: 10/04/2023 10:13:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<LML>
-- Create date: <25/03/2023>
-- Description:	<insert MedRequest>
-- =============================================
ALTER PROCEDURE [dbo].[spInsertMedRequest]

	@reqId smallint,
   	@cUser smallint,
	@aUser smallint,
	@cDep smallint,
	@aDep smallint,
	@medId smallint,
	@reqQty real,
	@reqStatus char(1),
	@reqDate datetime

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	--SET NOCOUNT ON;

     INSERT INTO [MedRequests] ([cUser],[aUser],[cDep],[aDep],[medId],[reqQty],[reqStatus],[reqDate]) 
     VALUES (@cUser,@aUser,@cDep,@aDep,@medId,@reqQty,'W',GETDATE()) SELECT SCOPE_IDENTITY();



END
