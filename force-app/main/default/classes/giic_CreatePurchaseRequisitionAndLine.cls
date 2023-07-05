/*************************************************************
*@Name: giic_CreatePurchaseRequisitionAndLine
*@Description: Demand planning PR creation: Create Purchase Requisition and Lines for Planning Purchase Order & PO Lines.
*@Test Class: giic_CreatePurchaseRequisitionAndLineTst
*@Job Name: Delete_Planning_PO_And_PR_And_PRL_Creation
*@Author: Fujitsu Dev/Sumit
**************************************************************/
global with sharing class giic_CreatePurchaseRequisitionAndLine implements database.Batchable<sObject>, database.Stateful, Database.AllowsCallouts{
	public static String poQueryStr = '';
	public static String polQueryStr = '';
	public static Map<String,String> poPR_Mapping;
	public static Map<String,String> polPRL_Mapping;
	/***************************************************************************************************************
    *@Name        :  Static block                                                          
    *@Description :  Query metadata, prepare the SOQL query String and field mapping.
    ***************************************************************************************************************/
	static{
		poPR_Mapping = new Map<String,String>();
		polPRL_Mapping = new Map<String,String>();
		for (giic_Planning_PO_And_PR_Mapping__mdt fldMap: [Select Purchase_Order_Field_API_Name__c, Purchase_Requistion_Field_API_Name__c FROM giic_Planning_PO_And_PR_Mapping__mdt where Inactive__c = false]) {
			poQueryStr = poQueryStr + fldMap.Purchase_Order_Field_API_Name__c + ',';
			poPR_Mapping.put(fldMap.Purchase_Order_Field_API_Name__c, fldMap.Purchase_Requistion_Field_API_Name__c);
		}
		
		for (giic_Planning_POL_And_PRL_Mapping__mdt fldMap : [Select PO_Line_Field_API_Name__c, PR_Line_Field_API_Name__c FROM giic_Planning_POL_And_PRL_Mapping__mdt where Inactive__c = false]) {
			polQueryStr = polQueryStr + ', '+fldMap.PO_Line_Field_API_Name__c;
			polPRL_Mapping.put(fldMap.PO_Line_Field_API_Name__c, fldMap.PR_Line_Field_API_Name__c);
		}
	}
    /***************************************************************************************************************
    *@Name        :  Start                                                          
    *@Description :  Query Planning Purchase Order and Purchase Order Line
    ***************************************************************************************************************/
    public Database.QueryLocator start(Database.BatchableContext BC) {
		//String queryStr ='Select '+poQueryStr+ ' (Select '+polQueryStr.replaceFirst(',','')+' from gii__Purchase_Order_Lines__r) from gii__PurchaseOrder__c where Id =\''+'a3U3C000000ZDk7UAG'+'\'';
		String queryStr ='Select '+poQueryStr+ ' (Select '+polQueryStr.replaceFirst(',','')+' from gii__Purchase_Order_Lines__r) from gii__PurchaseOrder__c where gii__CreatedfromSupplyPlanCPOConversion__c = true';
		//System.debug('start :: queryStr ::'+queryStr);   
		return Database.getQueryLocator(queryStr);
    }
    
    /***************************************************************************************************************
    *@Name        :  Execute                                                              
    *@Return      :  void                                                                                       
    *@Description :  Create Purchase Requisition and Lines for Planning Purchase Order                       
    ***************************************************************************************************************/
    global void execute(Database.BatchableContext BC, List<gii__PurchaseOrder__c> scope){
        //System.debug('execute :: scope ::'+scope.size());
		createPRandPRL(scope);
    }
    
    /***************************************************************************************************************
    *@Name        :  Finish                                                              
    *@Return      :  void                                                                                       
    *@Description :                               
    ***************************************************************************************************************/
    global void finish(Database.BatchableContext BC){}

	/***************************************************************************************************************
    *@Name        :  createPRandPRL                                                              
    *@Return      :  void                                                                                       
    *@Description :  Create Purchase Requisition and Purchase Requistion Line. Delete Planning Purchase Order.                          
    ***************************************************************************************************************/
	public static void createPRandPRL(List<gii__PurchaseOrder__c> poandpolData){
		try{
			//System.debug('createPRandPRL :: poandpolData ::'+poandpolData.size());
            List<gii__PurchaseRequisition__c> prList = new List<gii__PurchaseRequisition__c>();
			List<gii__PurchaseRequisitionLine__c> prlList = new List<gii__PurchaseRequisitionLine__c>();
            Map<Id,List<gii__PurchaseRequisitionLine__c>> poPRLmap = new Map<Id,List<gii__PurchaseRequisitionLine__c>>();
            for(gii__PurchaseOrder__c po: poandpolData){
                gii__PurchaseRequisition__c pr = new gii__PurchaseRequisition__c();
                for(String fldKey:poPR_Mapping.keySet()){
					pr.put(poPR_Mapping.get(fldKey), po.get(fldKey));
				}
				//System.debug('createPRandPRL :: PO ::'+po);
				//System.debug('createPRandPRL :: PR ::'+pr);
                prList.add(pr);
				prlList = new List<gii__PurchaseRequisitionLine__c>();
				gii__PurchaseRequisitionLine__c prl = new gii__PurchaseRequisitionLine__c();
				if(po.gii__Purchase_Order_Lines__r != null){
					for(gii__PurchaseOrderLine__c pol: po.gii__Purchase_Order_Lines__r){
						prl = new gii__PurchaseRequisitionLine__c();
						for(String fldKey:polPRL_Mapping.keySet()){
							prl.put(polPRL_Mapping.get(fldKey), pol.get(fldKey));
						}
						//System.debug('createPRandPRL :: POL ::'+pol);
						//System.debug('createPRandPRL :: PRL ::'+prl);
						prlList.add(prl);
					}
					//System.debug('createPRandPRL :: prlList ::'+prlList);
					if(prlList != null && !prlList.isEmpty()){
						poPRLmap.put(po.Id,prlList);
					}
				}
            }
			//System.debug('createPRandPRL :: prList ::'+prList);
			//System.debug('createPRandPRL :: poPRLmap ::'+poPRLmap);
			if(prList != null && !prList.isEmpty())
			{
				//Insert Purchase Requsition
				Database.SaveResult[] resultList = Database.insert(prList);
				List<Id> prIdList = new List<Id>();
				// Iterate through each returned result
				for (Database.SaveResult dbsr : resultList) {
					if (dbsr.isSuccess()) {
						//Operation was successful, so get the PR record Id.
						prIdList.add(dbsr.getId());						
					}
					else {
						// Operation failed, so get all errors                
						for(Database.Error err : dbsr.getErrors()) {
							System.debug('giic_CreatePurchaseRequisitionAndLine :: The error has occurred. '+err.getStatusCode() + ': ' + err.getMessage()+' Fields that affected this error: ' + err.getFields());
						}
					}
				}
				//System.debug('prIdList ::'+prIdList);
				if(prIdList!=null && !prIdList.isEmpty()){
					List<gii__PurchaseOrder__c> poDelList = new List<gii__PurchaseOrder__c>();
					List<gii__PurchaseRequisitionLine__c> prlListIns = new List<gii__PurchaseRequisitionLine__c>();
					//Query the Purchase Requisition to setup PRL relation ship field 
					for(gii__PurchaseRequisition__c prRec: [Select Id, giic_Planning_Purchase_Order__c from gii__PurchaseRequisition__c where Id IN:prIdList]){
						if(poPRLmap != null && String.isNotBlank(prRec.giic_Planning_Purchase_Order__c) && poPRLmap.containsKey(prRec.giic_Planning_Purchase_Order__c)){
            				for(gii__PurchaseRequisitionLine__c prl: poPRLmap.get(prRec.giic_Planning_Purchase_Order__c)){
								prl.gii__PurchaseRequisition__c = prRec.Id;
								prlListIns.add(prl);
							}
							poDelList.add(new gii__PurchaseOrder__c(Id = Id.valueOf(prRec.giic_Planning_Purchase_Order__c)));
						}
					}
				
					//Insert Purchase Requsition Line
					if(prlListIns != null && !prlListIns.isEmpty()){
						insert prlListIns;
					}
					//Delete Planning Purchase Order, it will also delete child purchase order line. (Master Details Relationship)
					if(!giic_BypassRulesAndApex__mdt.getInstance('Planning_Purchase_Order_Deletion').Inactive__c && poDelList != null && !poDelList.isEmpty()){
						delete poDelList;
					}
				}
			}
        }catch(System.Exception ex){
            System.debug('giic_CreatePurchaseRequisitionAndLine :: Exception :: '+ex.getMessage());
        }
	}
}