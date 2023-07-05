/*************************************************************************
*Covers Code Coverage for 
*@Apex Class: giic_CreatePurchaseRequisitionAndLine, giic_CreatePurchaseRequisitionAndLineSch
*@Apex Trigger:
*@Description: Demand planning Purchase Requisition creation
*@Author: Fujitsu Dev/Sumit
**************************************************************************/
@isTest
public class giic_CreatePurchaseRequisitionAndLineTst {
	@testSetup static void setup() {
       giic_Test_DataCreationUtility.testSystemPolicyCreation();   
    }
    
	@isTest 
	static void testMethod1() {
        List<gii__Location__c> locLst = new List<gii__Location__c>();
		List<gii__LocationBin__c> locBinLst = new List<gii__LocationBin__c>();
		List<gii__ProductInventory__c> pdInLst = new List<gii__ProductInventory__c>();
		List<gii__ABCClass__c> abcClsLst = new List<gii__ABCClass__c>();
		List<gii__PurchaseOrderLine__c> poLineLst = new List<gii__PurchaseOrderLine__c>();
		List<String> purchaseOrder = new List<String>();
		List<String> purchaseOrderLine = new List<String>();
		List<String> Quantity = new List<String>();
		List<String> Location = new List<String>();
		List<String> LocationBin = new List<String>();
        List<Account> lstAcc = giic_Test_DataCreationUtility.insertConsumerAccount();
        List<gii__Warehouse__c> wareHouseList = giic_Test_DataCreationUtility.insertWarehouse();
        List<gii__Product2Add__c> lstProd = giic_Test_DataCreationUtility.insertProduct();
		//ABC Class
        abcClsLst.add(new gii__ABCClass__c(Name = 'Test_ABC_Class'));
		abcClsLst.add(new gii__ABCClass__c(Name = 'Test_123_Class'));
		insert abcClsLst;
		//Location
        locLst.add(new gii__Location__c(Name = 'Test_Loc_WH0', gii__Warehouse__c = wareHouseList[0].Id, giic_ABC_Class__c = abcClsLst[0].Id, gii__BinControlled__c = true));
		locLst.add(new gii__Location__c(Name = 'Test_Loc_WH0_1', gii__Warehouse__c = wareHouseList[0].Id, giic_ABC_Class__c = abcClsLst[0].Id));
        locLst.add(new gii__Location__c(Name = 'Test_Loc_WH1', gii__Warehouse__c = wareHouseList[1].Id, giic_ABC_Class__c = abcClsLst[1].Id));
        Insert locLst;
		//Location Bin
        locBinLst.add(new gii__LocationBin__c(gii__Location__c = locLst[0].Id, giic_ABC_Class__c = abcClsLst[0].Id));
		locBinLst.add(new gii__LocationBin__c(gii__Location__c = locLst[0].Id, giic_ABC_Class__c = abcClsLst[1].Id));
        insert locBinLst;
		//Product Inventory
        pdInLst.add(new gii__ProductInventory__c(gii__PrimaryLocation__c = locLst[0].Id, gii__Product__c = lstProd[0].Id, gii__Warehouse__c = wareHouseList[0].Id, gii__SalesOrderQuantity__c = 50, giic_ABC_Class__c = abcClsLst[0].Id));
		pdInLst.add(new gii__ProductInventory__c(gii__PrimaryLocation__c = locLst[0].Id, gii__Product__c = lstProd[1].Id, gii__Warehouse__c = wareHouseList[0].Id, gii__SalesOrderQuantity__c = 5, giic_ABC_Class__c = abcClsLst[1].Id));
		pdInLst.add(new gii__ProductInventory__c(gii__PrimaryLocation__c = locLst[2].Id, gii__Product__c = lstProd[0].Id, gii__Warehouse__c = wareHouseList[1].Id, gii__SalesOrderQuantity__c = 30, giic_ABC_Class__c = abcClsLst[1].Id));
        Insert pdInLst;
        gii__PurchaseOrder__c objPO = new gii__PurchaseOrder__c(gii__Supplier__c = lstAcc[0].Id, gii__ShipTo__c = wareHouseList[0].Id, gii__CreatedfromSupplyPlanCPOConversion__c = true);
        insert objPO;
        gii__PurchaseOrder__c objPO1 = [Select Id, Name from gii__PurchaseOrder__c where Id =: objPO.Id];
        poLineLst.add(new gii__PurchaseOrderLine__c(gii__OrderQuantity__c = 2, gii__PurchaseOrder__c = objPO.Id, gii__ReceiptStatus__c	= 'Open', gii__Product__c = lstProd[0].Id, gii__NoChargeReason__c = 'Test Run', gii__ShipTo__c = wareHouseList[0].Id));
		poLineLst.add(new gii__PurchaseOrderLine__c(gii__OrderQuantity__c = 2, gii__PurchaseOrder__c = objPO.Id, gii__ReceiptStatus__c	= 'Open', gii__Product__c = lstProd[1].Id, gii__NoChargeReason__c = 'Test Run', gii__ShipTo__c = wareHouseList[0].Id));
        insert poLineLst;
        test.startTest();
            System.schedule('Run_TestClass_PR_PLR_Creation_For_Planning_PO', '0 01 00 * * ?', new giic_CreatePurchaseRequisitionAndLineSch());
	    test.stopTest();
    }
}