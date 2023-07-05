@isTest
public class giic_PicklistDetailAFterInsertTest {
    
    @testSetup static void setup() {
        giic_Test_DataCreationUtility.testSystemPolicyCreation();
        
    }
     @isTest static void testpicklist() {
          List<gii__Warehouse__c> dcwarehouse = giic_Test_DataCreationUtility.insertWarehouse();
      
          List<Account> lstAccount =  giic_Test_DataCreationUtility.insertConsumerAccount();
        
      
          List<gii__Carrier__c> lstCarrier =  giic_Test_DataCreationUtility.createCarrier();
        
        List<gii__Warehouse__c> lstWarehouse =  giic_Test_DataCreationUtility.insertWarehouse();
         gii__SalesOrder__c so =  new gii__SalesOrder__c(
            gii__Account__c = lstAccount[0].id ,
            gii__ScheduledDate__c = SYSTEM.today(),
            gii__OrderDate__c = SYSTEM.today(),
            gii__Status__c = 'Open', 
            gii__OrderType__c='Transfer',
            gii__Warehouse__c = lstWarehouse[0].id,
            gii__TransferToWarehouse__c =dcwarehouse[1].id,
            gii__PaymentMethod__c = 'Terms',
            gii__Carrier__c = lstCarrier != null && lstCarrier.size() > 0 ? lstCarrier[0].Id : null,
            gii__Released__c = true,
            //To overcome validation rule failure
            gii__ShipToStateProvince__c = 'MO',
            gii__BillingStateProvince__c = 'MO'
        );
      
        insert so;
         gii__PickList__c pkInstance = new gii__PickList__c();
        pkInstance.gii__OrderType__c='Standard' ;
        // pkInstance.gii__SalesOrder__c=lstSalesOrder[0].id  ;
        // pkInstance.gii__Product__c=lstProd[0].id ;
        
        pkInstance.gii__PicklistSequence__c=1 ;
        pkInstance.gii__CreditStatus__c='ok' ;
        system.debug('pkInstance>>'+pkInstance);
        insert pkInstance;
        List<gii__Location__c> locat = giic_Test_DataCreationUtility.insertLocations();
        gii__Location__c loc1 = new gii__Location__c();
        loc1.id = locat[0].Id;
        loc1.gii__BinControlled__c = true;
        loc1.giic_Picklist_Sequence__c = 1;
        update loc1;
        gii__LocationBin__c locbin = new gii__LocationBin__c();
        locbin.gii__Location__c = loc1.id;
        insert locbin;
        List<gii__Product2Add__c> lstProd = giic_Test_DataCreationUtility.insertProduct();
                    
      List<gii__ProductInventory__c> lstPI =  giic_Test_DataCreationUtility.insertProductInventory();
           
        gii__SalesOrderLine__c soline;
        List<gii__SalesOrderLine__c> soLineToInsert = new List<gii__SalesOrderLine__c>();
        
       
                soline = new gii__SalesOrderLine__c(gii__SalesOrder__c = so.id, giic_TransferOrderQty__c=1 ,
                                                    gii__ReservedQuantity__c=1 ,
                                                    gii__OrderQuantity__c = 2.0, gii__Product__c = lstProd[0].id , 
                                                    gii__UnitPrice__c = 2);
                soLineToInsert.add(soline);
     
        insert soLineToInsert;
        list<gii__SalesOrderLine__c>  test =[SELECT Id ,gii__Product__c,gii__Product__r.gii__ProductReference__r.RecordType.Name
                                             FROM gii__SalesOrderLine__c where id =: soLineToInsert ];
        
        gii__InventoryReserve__c inv = new gii__InventoryReserve__c();
        inv.gii__SalesOrderLine__c=soLineToInsert[0].id;
        inv.gii__ProductInventorySequence__c =lstPI[0].id;
        inv.gii__Product__c =test[0].gii__Product__c;
         inv.gii__Location__c = loc1.id;
        inv.gii__LocationBin__c = locbin.id;
        insert inv;
        
        gii__PickListDetail__c  pkDInstance = new gii__PickListDetail__c();
        pkDInstance.gii__PickList__c=pkInstance.id ;
        pkDInstance.gii__PickQuantity__c =1;
        pkDInstance.gii__ReserveSequence__c = inv.id;
       
        insert pkDInstance;
        
        system.debug('pkInstance.id>>'+pkInstance.id);
        
         
         gii__PickListDetail__c  pkDList = [select id , gii__PickList__c  from gii__PickListDetail__c];
        
     }
      @isTest static void testpicklist1() {
        
         List<gii__Warehouse__c> dcwarehouse = giic_Test_DataCreationUtility.insertWarehouse();
      
          List<Account> lstAccount =  giic_Test_DataCreationUtility.insertConsumerAccount();
        
      
          List<gii__Carrier__c> lstCarrier =  giic_Test_DataCreationUtility.createCarrier();
        
        List<gii__Warehouse__c> lstWarehouse =  giic_Test_DataCreationUtility.insertWarehouse();
         gii__SalesOrder__c so =  new gii__SalesOrder__c(
            gii__Account__c = lstAccount[0].id ,
            gii__ScheduledDate__c = SYSTEM.today(),
            gii__OrderDate__c = SYSTEM.today(),
            gii__Status__c = 'Open', 
            gii__OrderType__c='Transfer',
            gii__Warehouse__c = lstWarehouse[0].id,
            gii__TransferToWarehouse__c =dcwarehouse[1].id,
            gii__PaymentMethod__c = 'Terms',
            gii__Carrier__c = lstCarrier != null && lstCarrier.size() > 0 ? lstCarrier[0].Id : null,
            gii__Released__c = true,
            //To overcome validation rule failure
            gii__ShipToStateProvince__c = 'MO',
            gii__BillingStateProvince__c = 'MO'
        );
      
        insert so;
         gii__PickList__c pkInstance = new gii__PickList__c();
        pkInstance.gii__OrderType__c='Standard' ;
        // pkInstance.gii__SalesOrder__c=lstSalesOrder[0].id  ;
        // pkInstance.gii__Product__c=lstProd[0].id ;
        
        pkInstance.gii__PicklistSequence__c=1 ;
        pkInstance.gii__CreditStatus__c='ok' ;
        system.debug('pkInstance>>'+pkInstance);
        insert pkInstance;
        List<gii__Location__c> locat = giic_Test_DataCreationUtility.insertLocations();
        gii__Location__c loc1 = new gii__Location__c();
        loc1.id = locat[0].Id;
        loc1.gii__BinControlled__c = false;
        loc1.giic_Picklist_Sequence__c = 1;
        update loc1;
        gii__LocationBin__c locbin = new gii__LocationBin__c();
        locbin.gii__Location__c = loc1.id;
      //  insert locbin;
        List<gii__Product2Add__c> lstProd = giic_Test_DataCreationUtility.insertProduct();
                    
      List<gii__ProductInventory__c> lstPI =  giic_Test_DataCreationUtility.insertProductInventory();
           
        gii__SalesOrderLine__c soline;
        List<gii__SalesOrderLine__c> soLineToInsert = new List<gii__SalesOrderLine__c>();
        
       
                soline = new gii__SalesOrderLine__c(gii__SalesOrder__c = so.id, giic_TransferOrderQty__c=1 ,
                                                    gii__ReservedQuantity__c=1 ,
                                                    gii__OrderQuantity__c = 2.0, gii__Product__c = lstProd[0].id , 
                                                    gii__UnitPrice__c = 2);
                soLineToInsert.add(soline);
     
        insert soLineToInsert;
        list<gii__SalesOrderLine__c>  test =[SELECT Id ,gii__Product__c,gii__Product__r.gii__ProductReference__r.RecordType.Name
                                             FROM gii__SalesOrderLine__c where id =: soLineToInsert ];
        
        gii__InventoryReserve__c inv = new gii__InventoryReserve__c();
        inv.gii__SalesOrderLine__c=soLineToInsert[0].id;
        inv.gii__ProductInventorySequence__c =lstPI[0].id;
        inv.gii__Product__c =test[0].gii__Product__c;
         inv.gii__Location__c = loc1.id;
       // inv.gii__LocationBin__c = locbin.id;
        insert inv;
        
        gii__PickListDetail__c  pkDInstance = new gii__PickListDetail__c();
        pkDInstance.gii__PickList__c=pkInstance.id ;
        pkDInstance.gii__PickQuantity__c =1;
        pkDInstance.gii__ReserveSequence__c = inv.id;
       
        insert pkDInstance;
        
        system.debug('pkInstance.id>>'+pkInstance.id);

         // test.startTest();
         gii__PickListDetail__c  pkDList = [select id , gii__PickList__c  from gii__PickListDetail__c];
        // test.stopTest();
         
     }
}