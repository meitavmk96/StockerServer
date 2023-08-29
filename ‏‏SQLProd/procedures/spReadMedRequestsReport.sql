-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE spReadMedRequestsReport
	-- Add the parameters for the stored procedure here
    @depId smallint
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	--SET NOCOUNT ON;

    -- Insert statements for procedure here
	with temp
	as
	(SELECT Medicines.mazNum, genName+' '+comName+' '+format(eaQty,'')+' '+unit+' '+given as 'medName', reqQty,
		   CASE WHEN (reqStatus like 'D') THEN N'�����'
			    WHEN (reqStatus like 'A') THEN N'�����'
				WHEN (reqStatus like 'T') THEN N'������'
				WHEN (reqStatus like 'W') THEN N'������'
				end as reqStatus,
		   CASE WHEN (month(reqDate)=1) THEN N'�����'
			    WHEN (month(reqDate)=2) THEN N'������'
				WHEN (month(reqDate)=3) THEN N'���'
				WHEN (month(reqDate)=4) THEN N'�����'
				WHEN (month(reqDate)=5) THEN N'���'
				WHEN (month(reqDate)=6) THEN N'����'
				WHEN (month(reqDate)=7) THEN N'����'
				WHEN (month(reqDate)=8) THEN N'������'
				WHEN (month(reqDate)=9) THEN N'������'
				WHEN (month(reqDate)=10) THEN N'�������'
				WHEN (month(reqDate)=11) THEN N'������'
				WHEN (month(reqDate)=12) THEN N'�����'
				end as reqMonth
	FROM [MedRequests] INNER JOIN [Medicines]
         ON MedRequests.[medId] = Medicines.[medId] 
   where year(reqDate)=year(getDate()) and cDep= @depId)
  
  select mazNum, medName, reqMonth, reqStatus, sum(reqQty) as sumQty
  from temp
  group by mazNum, medName, reqMonth, reqStatus
  Union
  select mazNum, medName, N'����', '', sum(reqQty) as sumQty
  from temp
  group by mazNum, medName
  order by medName, reqMonth, reqStatus

END






	