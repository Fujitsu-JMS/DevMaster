/*************************************************************
*@Name: giic_CreatePurchaseRequisitionAndLineSch
*@Description: To Schedule giic_CreatePurchaseRequisitionAndLine Execution. Demand planning PR creation: Create Purchase Requisition and Lines for Planning Purchase Order & PO Line.
*@Test Class: giic_CreatePurchaseRequisitionAndLineTst
*@Job Name: Delete_Planning_PO_And_PR_And_PRL_Creation
*@Author: Fujitsu Dev/Sumit
**************************************************************/
public class giic_CreatePurchaseRequisitionAndLineSch implements Schedulable {
    public void execute(SchedulableContext sc){
        try{
            giic_CreatePurchaseRequisitionAndLine objBatch = new giic_CreatePurchaseRequisitionAndLine();
            Database.executeBatch(objBatch,1);
		}catch(Exception ex){
            System.debug('giic_CreatePurchaseRequisitionAndLineSch :: Exception :: '+ex);
        }
    }//End of Method
}