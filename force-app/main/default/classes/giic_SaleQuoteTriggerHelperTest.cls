@isTest
public class giic_SaleQuoteTriggerHelperTest {
    @testSetup static void setup() {
        giic_Test_DataCreationUtility.testSystemPolicyCreation();   
    }
    @isTest static void testMethodGetServiceTicketLine() {
        
        
        List<gii__Warehouse__c> dcwarehouse =  giic_Test_DataCreationUtility.insertWarehouse();
        List<Account> lstAccount = giic_Test_DataCreationUtility.insertConsumerAccount();
        List<gii__Product2Add__c> lstProd =  giic_Test_DataCreationUtility.insertProduct();
        List<gii__Site__c> lstSite = giic_Test_DataCreationUtility.insertSite();
        
        Opportunity opp = new Opportunity();
        opp.name = 'test123' ;
        opp.AccountId = lstAccount[0].id ;
        opp.StageName = 'Qualification' ;
        opp.CloseDate = system.today() ;
        opp.CurrencyIsoCode = 'USD' ;
        insert opp;
        
        gii__SalesQuote__c quote = new gii__SalesQuote__c();
        
        quote.gii__Account__c  =  lstAccount[0].id ;
        quote.giic_Site__c      =lstSite[0].id ;
        quote.giic_Placement_Reason__c      ='Ancillary Order';
        quote.giic_InstallRequired__c      ='No';
        quote.giic_Account_Type__c      ='National Other';
        quote.gii__Status__c      ='Open';
        //quote.gii__CloseReason__c      ='Won';
        quote.giic_NAM_approval_Status__c      ='Submitted'; //Approved
        quote.giic_Overall_Status__c      ='InProgress - Rejected' ;//Completed	  InProgress - Pending Approvals	
        quote.giic_RSM_approval_Status__c       ='Submitted' ;//Approved
        quote.giic_SQ_Integrity_Approval_Status__c       ='Submitted';//Approved
        quote.giic_Sub_Status__c       =  'Draft'  ;//Active - Pending Equipment Integrity Completed	
        quote.giic_NAM_Approved__c       =false;
       //quote.giic_RSM_Approved__c       =true;
      //  quote.giic_Is_Approval_For_Non_NAM__c     = false;
        insert quote;
        
        List<gii__SalesQuote__c> quoteList = new List<gii__SalesQuote__c>();
        quoteList.add(quote);
        Map<id ,gii__SalesQuote__c> quoteMap = new Map<id ,gii__SalesQuote__c>();
        Set<Id>  setEquipmentRequestIds = new Set<Id>();
        setEquipmentRequestIds.add(quote.id);
        //select Id ,gii__Account__c , giic_Site__c, giic_Placement_Reason__c, giic_InstallRequired__c, giic_Account_Type__c, gii__Status__c, gii__CloseReason__c, giic_NAM_approval_Status__c,giic_Overall_Status__c, giic_RSM_approval_Status__c, giic_SQ_Integrity_Approval_Status__c, giic_Sub_Status__c,  giic_NAM_Approved__c, giic_Is_Approval_For_NAM__c, giic_Is_Approval_For_Non_NAM__c  from gii__SalesQuote__c
        test.startTest();
        giic_SaleQuoteTriggerHelper.updateApprovedFieldsFOrApproval(quoteList);
        giic_SaleQuoteTriggerHelper.resetApprovedFieldsByApprovers(quoteList ,quoteMap );
        giic_SaleQuoteTriggerHelper.initiateApprovalProcess(quoteList ,quoteMap );
        giic_SaleQuoteTriggerHelper.submitForApproval(quote.id ,'Test' );
        giic_SaleQuoteTriggerHelper.processedRecordsToSendEmail(setEquipmentRequestIds,quoteList ,quoteMap );
      //  giic_SaleQuoteTriggerHelper.initiateEmailNotificationRequest(quoteList ,quoteMap );
      //  giic_SaleQuoteTriggerHelper.customNotificationToOwner(quoteList ,quoteMap );
              quote.giic_Overall_Status__c      ='New' ;
        update quote;
        List<gii__SalesQuote__c> quoteList1 = new List<gii__SalesQuote__c>();
        quoteList1.add(quote);
        giic_SaleQuoteTriggerHelper.resetApprovedFieldsByApprovers(quoteList1 ,quoteMap );
       
        quote.giic_Sub_Status__c = 'Active - Pending RSM' ;
        quote.giic_RSM_approval_Status__c = 'Submitted' ;
        //quote.giic_Manager_Details__c = 'Fujitsu Admin@@manogna.sunkireddy@fujitsu.com@@0053C000004qm7g' ;
        update quote;
        List<gii__SalesQuote__c> quoteList2 = new List<gii__SalesQuote__c>();
        quoteList2.add(quote);
         giic_SaleQuoteTriggerHelper.processedRecordsToSendEmail(setEquipmentRequestIds,quoteList2 ,quoteMap );
        
        quote.giic_RSM_approval_Status__c = 'Approved' ;
        //quote.giic_SQ_Integrity_Approval_Status__c = 'Approved' ;
         update quote;
         List<gii__SalesQuote__c> quoteList3 = new List<gii__SalesQuote__c>();
        quoteList3.add(quote);
         giic_SaleQuoteTriggerHelper.customNotificationToOwner(quoteList3 ,quoteMap );
        
       // quote.giic_RSM_approval_Status__c = 'Approved' ;
        quote.giic_SQ_Integrity_Approval_Status__c = 'Approved' ;
         update quote;
         List<gii__SalesQuote__c> quoteList4 = new List<gii__SalesQuote__c>();
        quoteList4.add(quote);
         giic_SaleQuoteTriggerHelper.customNotificationToOwner(quoteList4 ,quoteMap );
        test.stopTest();
    }
}