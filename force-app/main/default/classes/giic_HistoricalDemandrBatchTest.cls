@isTest 
public class giic_HistoricalDemandrBatchTest {
  @testSetup static void setup() {
        giic_Test_DataCreationUtility.testSystemPolicyCreation(); 
      
    }
    @isTest static void getThequantityCountTest(){
        
        List<gii__Warehouse__c> dcwarehouse =  giic_Test_DataCreationUtility.insertWarehouse();
        List<Account> lstAccount = giic_Test_DataCreationUtility.insertConsumerAccount();
        List<gii__SalesOrder__c> lstSalesOrder = giic_Test_DataCreationUtility.insertSalesOrder();
        List<gii__SalesOrderLine__c> lstSalesOrderLine = giic_Test_DataCreationUtility.insertSOLine(lstSalesOrder);
       
      List<gii__ProductInventory__c> updateResult=  [select id,gii__Product__r.gii__ProductReference__r.Make__c,
                                         gii__Warehouse__r.name,gii__Product__r.gii__Family__c,
                                         gii__Product__c,gii__AvailableQuantity__c,
                                         giic_MinQtyCalculated__c,gii__InTransitQuantity__c,
                                         gii__PurchaseOrderQuantity__c, giic_SafetyStockCalculated__c,
                                         giic_MaxQtyCalculated__c,giic_NumberOfMonth__c,  
                                         giic_12MonthsDemand__c, giic_HistoricalSO__c, 
									     giic_HistoricalTO__c, giic_HistoricalWO__c ,
                                          gii__Product__r.gii__Service__c,gii__Product__r.Name
                                          
                                         FROM gii__ProductInventory__c];
        System.debug('updateResult>>>'+updateResult);
         System.debug('updateResult.size()>>>'+updateResult.size());
        System.debug('updateResult[0].1>>>'+updateResult[0].gii__Warehouse__c);
         System.debug('updateResult[0].2>>>'+updateResult[0].gii__Product__c);
         System.debug('updateResult[0].3>>>'+updateResult[0].giic_NumberOfMonth__c);
         System.debug('updateResult[0].4>>>'+updateResult[0].gii__Product__r.gii__Service__c);
         System.debug('updateResult[0].5>>>'+updateResult[0].gii__Product__r.Name);
         System.debug('updateResult[0].6>>>'+updateResult[0].gii__Warehouse__r.Name);
        

        gii__WorkOrder__c  wo = new gii__WorkOrder__c();
        wo.gii__Product__c =updateResult[0].gii__Product__c;
        wo.gii__ProductInventory__c =updateResult[0].id;
        wo.gii__Warehouse__c =updateResult[0].gii__Warehouse__c;
        wo.gii__OrderQuantity__c  = 1 ;
        wo.gii__DueDate__c   =system.today()+5 ;
        insert wo;
         System.debug('wo>>>'+wo);
        
       
        
        gii__Carrier__c oCarr1 = new gii__Carrier__c();
        oCarr1.Name = 'test222';
        oCarr1.gii__Description__c = 'test111';
        oCarr1.gii__NoChargeReason__c = 'Promotion';
        insert oCarr1;


       gii__TransferOrder__c to =  new gii__TransferOrder__c();
        to.gii__Account__c = lstAccount[0].id ;
        to.gii__OrderDate__c = SYSTEM.today();
        to.gii__TransferToWarehouse__c = dcwarehouse[0].id;
        to.gii__FromWarehouse__c = dcwarehouse[1].id;     //rt start
        to.gii__Carrier__c = oCarr1.id;
        insert to;
        
       gii__TransferOrderLine__c toLine= new gii__TransferOrderLine__c();
        toLine.gii__TransferOrder__c = to.Id;
        toLine.gii__TransferToWarehouse__c = updateResult[0].gii__Warehouse__c;
        toLine.gii__Product__c = updateResult[0].gii__Product__c;
        toLine.gii__Quantity__c = 10;
        toLine.gii__Warehouse__c = updateResult[0].gii__Warehouse__c;
    insert toLine;
        
      /*     List<gii__Product2Add__c>  lstProd12 =giic_Test_DataCreationUtility.insertProduct();
          List<gii__Product2Add__c>  lstProd12  =[select id, gii__SerialControlled__c   from  gii__Product2Add__c] 
              
    gii__ProductSerial__c prdSr = new gii__ProductSerial__c(Name = 'TEST-SN-TO-X1C2Z1', 
                                                            gii__Product__c = updateResult[0].gii__Product__c, 
                                                            gii__ProductInventory__c = updateResult[0].Id, 
                                                            gii__Warehouse__c = updateResult[0].gii__Warehouse__c);
    insert prdSr;
      */  
        gii__ReceiptQueue__c toRQ = new gii__ReceiptQueue__c();
        toRQ.gii__InTransitWarehouse__c = updateResult[0].gii__Warehouse__c;
        toRQ.gii__TransferOrder__c = to.Id;
        toRQ.gii__TransferOrderLine__c = toLine.Id;
        toRQ.gii__OrderType__c = 'Transfer';
        toRQ.gii__ProductInventorySequence__c = updateResult[0].Id;
        toRQ.gii__ReceiptQuantity__c = 1;
       // toRQ.gii__ProductSerial__c = prdSr.Id;
        insert toRQ;
        

        test.startTest();
          giic_HistoricalDemandQntCalHandlerBatch HDQCalHandlerBatch = new giic_HistoricalDemandQntCalHandlerBatch();
            DataBase.executeBatch(HDQCalHandlerBatch); 
        
          // Create an instance of ApexPages.StandardSetController (or use a mock)
        ApexPages.StandardSetController controller = new ApexPages.StandardSetController(updateResult);
        
        // Instantiate the giic_HistoricalDemandQntCalBatchExecute class
        giic_HistoricalDemandQntCalBatchExecute batchExecute = new giic_HistoricalDemandQntCalBatchExecute(controller);
        PageReference result = batchExecute.runBatch();
      
        
        test.stopTest();
        //list<gii__ProductInventory__c> lstPI=giic_Test_DataCreationUtility.insertProductInventory();
    }
}