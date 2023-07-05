public with sharing class giic_ShipmentHelper {
    
    
    
    @AuraEnabled(cacheable=true)
    public static gii__Shipment__c fetchData(Id recordId) {
        
        gii__Shipment__c shipmentInfo = new gii__Shipment__c();
        shipmentInfo = [SELECT id,Name,gii__SalesOrder__r.Name,gii__TransferOrder__r.Name,gii__SalesOrder__c,giic_Integration_Status__c,
                        gii__SalesOrder__r.giic_Site__r.Name,
                        gii__SalesOrder__r.giic_Site__c,
                        gii__SalesOrder__r.giic_Site__r.gii__Street__c,
                        gii__SalesOrder__r.giic_Site__r.gii__City__c,
                        gii__SalesOrder__r.giic_Site__r.gii__StateProvince__c,
                        gii__SalesOrder__r.giic_Site__r.gii__Country__c,
                        gii__SalesOrder__r.giic_Site__r.gii__ZipPostalCode__c, 
                        gii__SalesOrder__r.gii__CustomerPONumber__c,
                        gii__ShippedDate__c,gii__SalesOrder__r.giic_Site__r.gii__SiteContact__r.Account.name,
                        gii__SalesOrder__r.giic_Site__r.gii__SiteContact__r.Phone,
                        gii__SalesOrder__r.giic_Site__r.gii__SiteContact__r.Email,
                        gii__SalesOrder__r.giic_Site__r.gii__SiteContact__r.Name,gii__SalesOrder__r.gii__Warehouse__r.giic_Accessorial_Types__c,
                        gii__TransferOrder__r.gii__FromWarehouse__r.giic_Accessorial_Types__c,
                        gii__SalesOrder__r.gii__Warehouse__r.Name,gii__SalesOrder__r.gii__Warehouse__c,
                        gii__SalesOrder__r.gii__Warehouse__r.gii__WareHouseCity__c, 
                        gii__SalesOrder__r.gii__Warehouse__r.gii__WareHouseCountry__c,  
                        gii__SalesOrder__r.gii__Warehouse__r.gii__WareHouseStateProvince__c,
                        gii__SalesOrder__r.gii__Warehouse__r.gii__WareHouseStreet__c,
                        gii__SalesOrder__r.gii__Warehouse__r.gii__WareHouseZipPostalCode__c,
                        gii__SalesOrder__r.gii__Warehouse__r.giic_Contact_Name__c,
                        gii__SalesOrder__r.gii__Warehouse__r.giic_Contact_Phone__c,
                        gii__SalesOrder__r.gii__TransferToWarehouse__r.giic_Contact_Name__c,
                        gii__SalesOrder__r.gii__TransferToWarehouse__r.giic_Contact_Phone__c,
                        gii__SalesOrder__r.gii__Warehouse__r.gii__FieldServiceEngineer__r.gii__Contact__r.Phone,
                        gii__SalesOrder__r.gii__Warehouse__r.gii__FieldServiceEngineer__r.gii__Contact__r.Name,
                        gic_PackageType__c,giic_CommodityClass__c,giic_Quantity__c,giic_ProductDescription__c,
                        giic_Weight__c,giic_Height__c,giic_Width__c,giic_Length__c,
                        giic_Hazmat__c,giic_Pickup_Type__c,
                        gii__SalesOrder__r.gii__Carrier__r.Name,gii__SalesOrder__r.gii__Carrier__r.gii__Description__c,giic_ShipmentCarrier__c,giic_ShipmentCarrier__r.Name,giic_ShipmentCarrier__r.gii__Description__c,
                        gii__SalesOrder__r.gii__ShipToStreet__c,gii__SalesOrder__r.gii__ShipToCity__c,
                        gii__SalesOrder__r.gii__ShipToStateProvince__c,gii__SalesOrder__r.gii__ShipToCountry__c,
                        gii__SalesOrder__r.gii__ShipToZipPostalCode__c,gii__TransferOrder__r.gii__FromWarehouse__r.gii__WareHouseCity__c,
                        gii__TransferOrder__r.gii__Carrier__r.Name, gii__TransferOrder__r.gii__Carrier__r.gii__Description__c,
                        gii__TransferOrder__r.gii__FromWarehouse__r.Name,gii__TransferOrder__r.gii__TransferToWarehouse__r.Name,
                        gii__TransferOrder__r.gii__FromWarehouse__r.gii__WareHouseCountry__c, 
                        gii__TransferOrder__r.gii__TransferToWarehouse__c, gii__TransferOrder__r.gii__FromWarehouse__c,
                        gii__TransferOrder__r.gii__FromWarehouse__r.gii__WareHouseStateProvince__c,
                        gii__TransferOrder__r.gii__FromWarehouse__r.gii__WareHouseStreet__c,
                        gii__TransferOrder__r.gii__FromWarehouse__r.gii__WareHouseZipPostalCode__c,
                        gii__TransferOrder__r.gii__FromWarehouse__r.gii__FieldServiceEngineer__r.gii__Contact__r.Phone,
                        gii__TransferOrder__r.gii__FromWarehouse__r.gii__FieldServiceEngineer__r.gii__Contact__r.Name,
                        gii__TransferOrder__r.gii__TransferToWarehouse__r.gii__WareHouseCity__c,
                        gii__TransferOrder__r.gii__TransferToWarehouse__r.gii__WareHouseCountry__c,
                        gii__TransferOrder__r.gii__TransferToWarehouse__r.gii__WareHouseStateProvince__c,
                        gii__TransferOrder__r.gii__TransferToWarehouse__r.gii__WareHouseStreet__c,
                        gii__TransferOrder__r.gii__TransferToWarehouse__r.gii__WareHouseZipPostalCode__c,
                        gii__TransferOrder__r.gii__TransferToWarehouse__r.gii__FieldServiceEngineer__r.gii__Contact__r.Phone,
                        gii__TransferOrder__r.gii__TransferToWarehouse__r.gii__FieldServiceEngineer__r.Name,
                        gii__TransferOrder__r.gii__FromWarehouse__r.giic_Contact_Name__c,
                        gii__TransferOrder__r.gii__FromWarehouse__r.giic_Contact_Phone__c,
                        gii__TransferOrder__r.gii__TransferToWarehouse__r.giic_Contact_Name__c,
                        gii__TransferOrder__r.gii__TransferToWarehouse__r.giic_Contact_Phone__c,                        
                        gii__TransferOrder__r.gii__TransferToWarehouse__r.gii__FieldServiceEngineer__r.gii__Contact__r.Name from gii__Shipment__c  WHERE Id = :recordId LIMIT 1];
        
        
        // return [SELECT id,gii__SalesOrder__r.Id, gii__SalesOrder__r.gii__Carrier__r.Name FROM gii__Shipment__c WHERE Id = :recordId];
        // 
        if(shipmentInfo.giic_Integration_Status__c == 'PLS Shipment API completed Successfully' || shipmentInfo.giic_Integration_Status__c == 'FedEx Integration completed successfully'){
            throw new AuraHandledException('Shipment Label Is Already Generated');
        }
        
        
        if(shipmentInfo.gii__SalesOrder__r.Name != null && shipmentInfo.gii__SalesOrder__r.Name != ''){
            if (shipmentInfo.giic_ShipmentCarrier__r.Name == null || shipmentInfo.giic_ShipmentCarrier__r.Name == '') {
                throw new AuraHandledException('Carrier name is blank.');
            }
            else{    
                String CarrierName =  shipmentInfo.giic_ShipmentCarrier__r.Name;
                String CarrierDesc =  shipmentInfo.giic_ShipmentCarrier__r.gii__Description__c;
                
                if(String.isNotBlank(CarrierName))
                {
                    if(CarrierName.contains('PLS'))
                    {
                        validateSalesOrderFields(shipmentInfo);
                    }
                    if(CarrierDesc.contains('FedEx'))
                    {
                        checkMandatorySalesOrderFieldsforFedex(shipmentInfo);
                    }
                }
            }
        }
        else {
            if(shipmentInfo.gii__TransferOrder__r.Name != null && shipmentInfo.gii__TransferOrder__r.Name != ''){
                if (shipmentInfo.giic_ShipmentCarrier__r.Name == null || shipmentInfo.giic_ShipmentCarrier__r.Name == '') {
                    throw new AuraHandledException('Carrier name is blank.');
                }
                else{    
                    String CarrierName =  shipmentInfo.giic_ShipmentCarrier__r.Name;
                    String CarrierDesc =  shipmentInfo.giic_ShipmentCarrier__r.gii__Description__c;
                    
                    if(String.isNotBlank(CarrierName))
                    {
                        if(CarrierName.contains('PLS'))
                        {
                            validateTransferOrderFields(shipmentInfo);
                        }
                        if(CarrierDesc.contains('FedEx'))
                        {
                            checkMandatoryTransferOrderFieldsforFedex(shipmentInfo);
                        }
                    }
                }
            }
        }
        
        return shipmentInfo;
    }
    
    
    @auraEnabled
    public static String sendShipmentDetails(gii__Shipment__c shipmentInfo){
        System.debug('This is ->'+shipmentInfo);
        
        
        String CarrierName =  shipmentInfo.giic_ShipmentCarrier__r.Name;
        String CarrierDesc =  shipmentInfo.giic_ShipmentCarrier__r.gii__Description__c;
        String responseStatus;
        if(String.isNotBlank(CarrierName))
        {
            if(CarrierName.contains('PLS'))
            {
                responseStatus =  processPLSShipment(shipmentInfo);
            }
            if(CarrierDesc.contains('FedEx'))
            {
                
                responseStatus =  processFedexShipment(shipmentInfo);
            }
        }
        
        
        return responseStatus;
        
    }
    
    @auraEnabled
    public static String processFedexShipment(gii__Shipment__c shipmentInfo){
        
        /*    String status = giic_createShipmentFedexApi.createShipment(shipmentInfo);
system.debug('Status' + status);
return status;*/
        System.debug('Called Create Fedex Shipment Method');
        string message;
        HttpResponse response;
        Decimal totalshipingCost = 0.0;
        String trackingNumber ='';
        // try{
        
        //JMS_Integration_Setting__c    jmsIntAttr = [select id,giic_FEDEX_Pickup_Type__c,giic_FEDEX_Packaging_Type__c,giic_FEDEX_OAUTH_Endpoint__c,giic_FEDEX_Endpoint_URL__c,giic_FEDEX_CLIENT_KEY__c, giic_FEDEX_CLIENT_SECRET__c,giic_FEDEX_Account_Number__c from JMS_Integration_Setting__c limit 1];
        giic_JMSIntegrationMapping__mdt jmsIntAttr = [SELECT Id, Label, giic_Account_Number__c, giic_CLIENT_KEY__c, giic_CLIENT_SECRET__c, giic_Endpoint_URL__c, giic_Fedex_Packaging_Type__c, giic_Fedex_Pickup_Type__c, giic_USERNAME__c, giic_PASSWORD__c, giic_Integration_Type__c, giic_OAUTH_Endpoint__c FROM giic_JMSIntegrationMapping__mdt limit 1];
        String ACCOUNT_NUMBER = jmsIntAttr.giic_Account_Number__c;
        string requestBody;    
        
        requestBody=  giic_FedexRequestSchema.generateFedExRequestJson(shipmentInfo,ACCOUNT_NUMBER,jmsIntAttr);
        
        system.debug('requestBody' + requestBody);
        String accessToken = giic_getFedexOauthToken.getAccessToken(jmsIntAttr);
        system.debug('authToken' + accessToken);
        
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://apis-sandbox.fedex.com/ship/v1/shipments');
        request.setMethod('POST');
        request.setHeader('Authorization', 'Bearer ' + accessToken);
        request.setHeader('Content-Type', 'application/json');          
        
        request.setBody(requestBody.replaceall('currency_X', 'currency'));
        
        // Send the HTTP request and get the response
        Http http = new Http();
        response = http.send(request);
        
        System.debug('Status Code' + response.getStatusCode());
        String responseReceived = response.getBody();
        if (response.getStatusCode() == 200) {
            // Update the record with data from the response
            
            message = 'success';
            Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            system.debug('responseReceived' + responseReceived);
            system.debug('responseReceived' + result);
            
            Map<String, Object> outputMap = (Map<String, Object>) result.get('output');
            system.debug('outputMap' + outputMap);
            List<Object> transactionShipments = (List<Object>) outputMap.get('transactionShipments');
            system.debug('transactionShipment' + transactionShipments );
            List<Object> alerts;
            //List<Object> alerts =  List<Object>();
            boolean containsalerts = false;
            boolean containsPieceResponse = false;
            boolean containsShipmentRating = false;
            for (Object shipmentObj : transactionShipments) {
                Map<String, Object> shipment = (Map<String, Object>) shipmentObj;
                
                String masterTrackingNumber = (String) shipment.get('masterTrackingNumber');
                
                if (shipment.containsKey('alerts')) { 
                    containsalerts = true;
                }
                if (shipment.containsKey('pieceResponses')) { 
                    containsPieceResponse = true;
                }
                if (shipment.containsKey('completedShipmentDetail')) { 
                    // containsShipmentRating = true;
                    Map<String, Object> shipDetails = (Map<String, Object>) shipment.get('completedShipmentDetail');
                    system.debug('shipDetails' + shipDetails);
                    system.debug('shipDetails' + shipDetails.containsKey('shipmentRating'));
                    Map<String, Object> shipmentRating = (Map<String, Object>) shipDetails.get('shipmentRating');
                    system.debug('shipmentRating' + shipmentRating);
                    if (shipDetails.containsKey('shipmentRating')) { 
                        containsShipmentRating = true;
                    }
                }
                
            }       
            system.debug('containsalerts' + containsalerts);
            system.debug('containsPieceResponse' + containsPieceResponse);
            system.debug('containsShipmentRating' + containsShipmentRating);
            
            giic_FedexResponseSchema obj = giic_FedexResponseSchema.parse(response.getBody());            
            gii__Shipment__c shipment = [select id,gii__TrackingNumber__c from gii__Shipment__c where id =: shipmentInfo.id];
            
            
            trackingNumber = obj.output.transactionShipments[0].masterTrackingNumber;       
            system.debug('responseMap obj ==> ' + obj);
            system.debug('responseMap obj ==> ' + obj.output.transactionShipments[0].masterTrackingNumber);
            system.debug('responseMap obj ==> ' + obj.output.transactionShipments[0].pieceResponses[0].masterTrackingNumber);
            
            // Update Shipment Record                      
            shipment.gii__TrackingNumber__c = trackingNumber;
            shipment.giic_Integration_Status__c = 'FedEx Integration completed successfully';
            update shipment;
            
            //Attach Shipping Label/Commercial Invoice PDF to FILES
            //  if(pieceResponsesCheck != null && !pieceResponsesCheck.isEmpty()) {
            List<ContentVersion> contentVersionList = new List<ContentVersion>();
            for(giic_FedexResponseSchema.pieceResponseWrapper res : obj.output.transactionShipments[0].pieceResponses)        
            {
                ContentVersion cv = new ContentVersion();
                cv.VersionData = EncodingUtil.base64Decode(res.packageDocuments[0].encodedLabel);
                cv.ContentLocation = 'S';
                cv.Title =  'FEDEX' + '.' + 'ShippingLabel' + '.' + shipment.gii__TrackingNumber__c  + '.pdf';
                cv.PathOnClient = 'ionicLogo.pdf'; 
                cv.FirstPublishLocationId =shipment.Id;
                contentVersionList.add(cv);
            }  
            
            if(shipmentInfo.gii__SalesOrder__r.gii__ShipToCountry__c != 'US' && shipmentInfo.gii__SalesOrder__r.gii__ShipToCountry__c != 'USA'
               && shipmentInfo.gii__TransferOrder__r.gii__TransferToWarehouse__r.gii__WareHouseCountry__c != 'US' && shipmentInfo.gii__TransferOrder__r.gii__TransferToWarehouse__r.gii__WareHouseCountry__c != 'USA')
            {
                
                ContentVersion cv = new ContentVersion();
                cv.VersionData = EncodingUtil.base64Decode(obj.output.transactionShipments[0].shipmentDocuments[0].encodedLabel);
                cv.ContentLocation = 'S';
                cv.Title =  'FEDEX' + '.' + 'Commercial Invoice' + '.' + shipment.gii__TrackingNumber__c + '.pdf';  
                cv.PathOnClient = 'ionicLogo.pdf'; 
                cv.FirstPublishLocationId =shipment.Id;
                contentVersionList.add(cv);                
                
            }
            
            system.debug('contentVersionList.size ==>' + contentVersionList);
            if(contentVersionList.size()>0)
            {
                Database.Insert(contentVersionList);
            }
            
            
            List<ContentVersion> insertedContentVersions = [SELECT Id, ContentDocumentId FROM ContentVersion WHERE Id IN :contentVersionList];
            
            if(!Test.isRunningTest()){
                ContentWorkspace ws = [SELECT Id, RootContentFolderId FROM ContentWorkspace WHERE Name = 'FEDEX Library' LIMIT 1];
                
                List<ContentDocumentLink> contentDocumentLinks = new List<ContentDocumentLink>();
                for (ContentVersion cv : insertedContentVersions) {
                    ContentDocumentLink cdl = new ContentDocumentLink();
                    cdl.ContentDocumentId = cv.ContentDocumentId;
                    cdl.ShareType = 'I';
                    cdl.Visibility = 'AllUsers';
                    cdl.LinkedEntityId = ws.Id; 
                    contentDocumentLinks.add(cdl);
                }
                
                if(contentDocumentLinks.size()>0)
                {
                    Database.Insert(contentDocumentLinks);
                }
            }
            // }
            
            //Add shipping Charge as Additional Charge Info into Sales Order
            
            String salesOrderInfo = shipmentInfo.gii__SalesOrder__c;
            String transOrderInfo = shipmentInfo.gii__TransferOrder__c;  
            if(salesOrderInfo != '' && salesOrderInfo != null)
            {               
                system.debug(containsShipmentRating);
                //  if(obj.output.transactionShipments[0].alerts.isempty()) {
                if(containsShipmentRating){
                    System.debug('Enter ShippingCost Loop' + obj.output.transactionShipments[0].completedShipmentDetail.shipmentRating.shipmentRateDetails[0].totalNetCharge);            
                    totalshipingCost = obj.output.transactionShipments[0].completedShipmentDetail.shipmentRating.shipmentRateDetails[0].totalNetCharge;
                }
                
                system.debug('totalshipingCost'+totalshipingCost);
                if(totalshipingCost > 0)
                {
                    gii__AdditionalCharge__c shipChargeInfo = [Select Id,Name FROM gii__AdditionalCharge__c 
                                                               where Name =: System.Label.giic_ShippingCharge limit 1];
                    
                    gii__SalesOrderAdditionalCharge__c salesOrdAddChargeInfo = new gii__SalesOrderAdditionalCharge__c();
                    salesOrdAddChargeInfo.gii__SalesOrder__c = shipmentInfo.gii__SalesOrder__c;
                    salesOrdAddChargeInfo.gii__UnitPrice__c = totalshipingCost;
                    salesOrdAddChargeInfo.gii__AdditionalCharge__c = shipChargeInfo.Id;
                    salesOrdAddChargeInfo.gii__Quantity__c = 1;
                    insert salesOrdAddChargeInfo;
                }
                else
                {
                    gii__AdditionalCharge__c shipChargeInfo = [Select Id,Name FROM gii__AdditionalCharge__c 
                                                               where Name =: System.Label.giic_ShippingCharge limit 1];
                    
                    gii__SalesOrderAdditionalCharge__c salesOrdAddChargeInfo = new gii__SalesOrderAdditionalCharge__c();
                    salesOrdAddChargeInfo.gii__SalesOrder__c =  shipmentInfo.gii__SalesOrder__c;
                    salesOrdAddChargeInfo.gii__UnitPrice__c = totalshipingCost;
                    salesOrdAddChargeInfo.gii__AdditionalCharge__c = shipChargeInfo.Id;
                    salesOrdAddChargeInfo.gii__NoChargeReason__c = 'Sample';
                    salesOrdAddChargeInfo.gii__Quantity__c = 1;
                    insert salesOrdAddChargeInfo;
                    
                }
            }
            
        }
        else if (response.getStatusCode() != 200){
            Map<String, Object> errorResult = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            //Map<String, Object> ErrorCode = (Map<String, Object>) errorResult.get('errors');
            system.debug('errorResult' + errorResult);
            List<Object> errorList = (List<Object>) errorResult.get('errors');
            system.debug('errorCode' + errorList);
            String  errorString = '';
             String  errorDesc = '';
            
            for (Object errorObj : errorList) 
            {
                Map<String, Object> errorCode = (Map<String, Object>) errorObj;                
                errorString += (String) errorCode.get('code');
 				errorDesc += (String) errorCode.get('message');                
                
            }
            
            system.debug('errorString' + errorString);
            system.debug('Error thrown is ' +response.getStatusCode() +'==>'+ errorString);
            message = 'Error calling external system: ' +'StatusCode :' + response.getStatusCode()+'====>' + errorList;
            throw new AuraHandledException(message);
            
        }
        return message;
    }
    
    @auraEnabled
    public static String processPLSShipment(gii__Shipment__c shipmentInfo){
        Map<String, object> test = new Map<String, object>();
        Map<String, object> mapResult = new Map<String, object>();
        String result = '';
        String responseReceived; 
        
        
        if (shipmentInfo.giic_Weight__c == null) {
            throw new AuraHandledException('Required Field is Missing');
        }
        else {
            System.Debug('Check this helper'+shipmentInfo);
            String endPoint = '';            
            String body;
            Boolean isSuccess;
            
            body = giic_PLSRequestWrapper.getRequestedJson(shipmentInfo);
            System.Debug('Body from helper'+body);
            giic_JMSIntegrationMapping__mdt jmsIntAttr = [SELECT Id,giic_PLSOAUTHEndpoint__c,giic_PLSEndpoint_URL__c,giic_PLSPASSWORD__c,giic_PLSUSERNAME__c,giic_PLSCLIENTSECRET__c,giic_PLSCLIENTKEY__c  FROM giic_JMSIntegrationMapping__mdt limit 1];   
            string authtoken = giic_getPLSOauthToken.getAuthorizationToken(jmsIntAttr);
            system.debug('####:: '+authtoken);
            /*    String username = 'gloviaapi';
String password = 'P96FSZ1daJ5da2h';*/
            //String endpointURL = 'https://ltl.uat.plsthree.pro/restful/api/shipment/book'; 
            //JMS_Integration_Setting__c jmsIntAttr = JMS_Integration_Setting__c.getInstance();  //gettting from custom settings added by Bhuvana    
            String endpointURL = jmsIntAttr.giic_PLSEndpoint_URL__c; //getting from custom settings added by Bhuvana
            //body = '{"soNum":"SO-20221111-000007","shipmentNo":"SHP-20221116-000003","poNum":"PO4252023","pickupDate":"2022-11-16","originAddress":{"stateCode":"NJ","postalCode":"08512","name":"E & S - JMS CRANBURY NJ","countryCode":"USA","contactPhone":"1234567890","contactName":"Adam Kamerer","city":"Cranbury","addressCode":"a5c3C0000003bXrQAI","address1":"20 Haypress Rd Ste 322"},"materials":[{"width":4,"weightUnit":"LBS","weight":4,"quantity":1,"productDescription":"This is for Shipment","packagingType":"CAS","length":3,"height":3,"hazmat":false,"dimensionUnit":"INCH","commodityClass":"50"}],"destinationAddress":{"stateCode":"FL","postalCode":"33467","name":"PALOMINO GARDENS","countryCode":"USA","contactPhone":"1234567890","contactName":"Adam Kamerer","city":"Lake Worth","addressCode":"a4i3C000000YSAlQAO","address1":"9885 Palomio Dr"},"accessorialTypes":["REP"]}';
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            HttpResponse response = new HttpResponse();
            request.setEndpoint(endpointURL);
            //request.setEndpoint('callout:PLSIntegrationDev');
            request.setHeader('content-type', 'application/json');
            //request.setHeader('Accept', 'application/json');
            request.setMethod('POST');
            // Blob headerValue = Blob.valueOf(username + ':' + password);
            // added bearer token from access token response
            String authorizationHeader = 'Bearer ' + authtoken;
            request.setHeader('Authorization', authorizationHeader);//until here by Bhuvana
            system.debug('request:'+request);
            request.setBody(body);
            system.debug('body is '+body);
            request.setTimeout(30000);
            system.debug('request sent is'+request);
            response = http.send(request);
            system.debug('response received' + response );
            system.debug('response body is' + response.getBody() );  
            
            if (response.getStatusCode() == 200) {
                // Update the record with data from the response
                
                responseReceived = response.getBody();
                system.debug('Response sent is ' + responseReceived);
                updateShipmentRecord(shipmentInfo,response.getStatusCode() , response.getBody());
                return 'Success';
            } else {
                // Display an error message
                system.debug('Error thrown is ' + response.getStatus() + ' ' + response.getBody());
                throw new AuraHandledException('Error calling external system: ' +'StatusCode :'+ response.getStatusCode() + ' ====> ' + response.getBody());
            }  
        }   
    }
    
    public static void validateSalesOrderFields(gii__Shipment__c shipment) {
        
        if (shipment.gii__SalesOrder__r.giic_Site__r.Name == null || shipment.gii__SalesOrder__r.giic_Site__r.Name == '' ||
            shipment.gii__SalesOrder__r.giic_Site__r.gii__SiteContact__r.Name == null || shipment.gii__SalesOrder__r.giic_Site__r.gii__SiteContact__r.Name == '' ||
            shipment.gii__SalesOrder__r.gii__Warehouse__r.Name == null || shipment.gii__SalesOrder__r.gii__Warehouse__r.Name == ''||
            shipment.gii__SalesOrder__r.gii__Warehouse__r.gii__FieldServiceEngineer__r.gii__Contact__r.Name == null || shipment.gii__SalesOrder__r.gii__Warehouse__r.gii__FieldServiceEngineer__r.gii__Contact__r.Name == '' ||
            shipment.gic_PackageType__c == null || shipment.gic_PackageType__c == '' ||
            shipment.giic_CommodityClass__c == null || shipment.giic_CommodityClass__c == '' ||
            shipment.giic_Quantity__c == null ||
            shipment.giic_ProductDescription__c == null || shipment.giic_ProductDescription__c == '' ||
            shipment.giic_Weight__c == null ||
            shipment.giic_Height__c == null  || shipment.giic_Width__c == null || shipment.giic_Length__c == null  ||
            shipment.giic_Pickup_Type__c == null || shipment.giic_Pickup_Type__c == '' ||
            shipment.gii__SalesOrder__r.gii__Warehouse__r.giic_Accessorial_Types__c == null || shipment.gii__SalesOrder__r.gii__Warehouse__r.giic_Accessorial_Types__c == '')
        {
            throw new AuraHandledException('Required Fields Are Missing');
        }
    }
    
    public static void checkMandatorySalesOrderFieldsforFedex(gii__Shipment__c shipment) {
        if (shipment.gii__SalesOrder__r.giic_Site__r.Name == null || shipment.gii__SalesOrder__r.giic_Site__r.Name == '' ||
            shipment.gii__SalesOrder__r.giic_Site__r.gii__SiteContact__r.Name == null || shipment.gii__SalesOrder__r.giic_Site__r.gii__SiteContact__r.Name == '' ||
            shipment.gii__SalesOrder__r.gii__Warehouse__r.Name == null || shipment.gii__SalesOrder__r.gii__Warehouse__r.Name == ''||
            shipment.gii__SalesOrder__r.gii__Warehouse__r.gii__FieldServiceEngineer__r.gii__Contact__r.Name == null || shipment.gii__SalesOrder__r.gii__Warehouse__r.gii__FieldServiceEngineer__r.gii__Contact__r.Name == '' )
            
        {
            throw new AuraHandledException('Required Fields Are Missing');
        }
    }
    
    public static void checkMandatoryTransferOrderFieldsforFedex(gii__Shipment__c shipment) {
        
        if (shipment.gii__TransferOrder__r.gii__FromWarehouse__r.Name == null || shipment.gii__TransferOrder__r.gii__FromWarehouse__r.Name == '' ||
            shipment.gii__TransferOrder__r.gii__TransferToWarehouse__r.Name == null || shipment.gii__TransferOrder__r.gii__TransferToWarehouse__r.Name == ''||
            shipment.gii__TransferOrder__r.gii__TransferToWarehouse__r.giic_Contact_Name__c == null || shipment.gii__TransferOrder__r.gii__TransferToWarehouse__r.giic_Contact_Name__c == '' ||
            shipment.gii__TransferOrder__r.gii__TransferToWarehouse__r.giic_Contact_Phone__c == null || shipment.gii__TransferOrder__r.gii__TransferToWarehouse__r.giic_Contact_Phone__c == '')
        {
            throw new AuraHandledException('Required Fields Are Missing');
        }
    }
    public static void validateTransferOrderFields(gii__Shipment__c shipment) {
        
        if (shipment.gii__TransferOrder__r.gii__FromWarehouse__r.Name == null || shipment.gii__TransferOrder__r.gii__FromWarehouse__r.Name == '' ||
            shipment.gii__TransferOrder__r.gii__FromWarehouse__r.gii__FieldServiceEngineer__r.gii__Contact__r.Name == null || shipment.gii__TransferOrder__r.gii__FromWarehouse__r.gii__FieldServiceEngineer__r.gii__Contact__r.Name == '' ||
            shipment.gii__TransferOrder__r.gii__TransferToWarehouse__r.Name == null || shipment.gii__TransferOrder__r.gii__TransferToWarehouse__r.Name == ''||
            shipment.gii__TransferOrder__r.gii__TransferToWarehouse__r.gii__FieldServiceEngineer__r.gii__Contact__r.Name == null || shipment.gii__TransferOrder__r.gii__TransferToWarehouse__r.gii__FieldServiceEngineer__r.gii__Contact__r.Name == '' ||
            shipment.gic_PackageType__c == null || shipment.gic_PackageType__c == '' ||
            shipment.giic_CommodityClass__c == null || shipment.giic_CommodityClass__c == '' ||
            shipment.giic_Quantity__c == null ||
            shipment.giic_ProductDescription__c == null || shipment.giic_ProductDescription__c == '' ||
            shipment.giic_Weight__c == null ||
            shipment.giic_Height__c == null  || shipment.giic_Width__c == null || shipment.giic_Length__c == null  ||
            shipment.giic_Pickup_Type__c == null || shipment.giic_Pickup_Type__c == '' ||
            shipment.gii__TransferOrder__r.gii__FromWarehouse__r.giic_Accessorial_Types__c == null || shipment.gii__TransferOrder__r.gii__FromWarehouse__r.giic_Accessorial_Types__c == '')
        {
            throw new AuraHandledException('Required Fields Are Missing');
        }
    }    
    @AuraEnabled
    public static void updateShipmentRecord(gii__Shipment__c shipment, Integer statusCode, String message) {
        System.Debug('This is shipment Record'+shipment);
        System.Debug('This is Status Code'+statusCode); 
        System.Debug('message ---- >'+message);
        Integer  loadId;
        String bol = '';
        if(message != '' && message != null){
            String responseBodyReceived = message;
            Map<String, Object> responseMap = (Map<String, Object>)JSON.deserializeUntyped(responseBodyReceived);
            System.Debug('responseMap  is ---- >'+responseMap);
            loadId = (Integer)responseMap.get('loadId');
            bol = (String)responseMap.get('bol');
        }
        gii__Shipment__c shipmentRecord = new gii__Shipment__c();
        shipmentRecord = [select id,giic_loadId__c,giic_BOL__c, giic_Integration_Status__c from gii__Shipment__c WHERE ID =: shipment.id];
        System.Debug('This is message received'+message);
        
        if(shipmentRecord != null) {
            if(statusCode == 200) {
                shipmentRecord.giic_Integration_Status__c = 'PLS Shipment API completed Successfully';
                if(loadId != null){
                    System.Debug('Load ID is ---- >'+loadId);
                    String loadIdString = String.valueOf(loadId);
                    shipmentRecord.giic_loadId__c = loadIdString;
                }
                if(bol != '' && bol != null){
                    System.Debug('bol ID is ---- >'+bol);
                    shipmentRecord.giic_BOL__c = bol;
                }
                if(!Test.isRunningTest()){
                    update shipmentRecord;
                }
                System.Debug('Updated this record ---- >'+shipmentRecord);
            }
            else {
                
                /*    shipmentRecord.giic_Integration_Status__c = 'Completed with Error';
update shipmentRecord;
System.Debug('Error in this record ---- >'+shipmentRecord);

gii__ErrorLog__c errorlog = new gii__ErrorLog__c();
errorlog.giic_ErrorMessage__c = message;
errorlog.gii__ErrorMessage__c = message;
errorlog.giic_Shipment__c = shipmentRecord.id;
errorlog.gii__ErrorCode__c = '400';
insert errorlog; */
                
            }
        }
    }
    
    @AuraEnabled
    public static void updateErrorRecord(ID shipment, String message) {
        
        gii__Shipment__c shipmentRecord = new gii__Shipment__c();
        shipmentRecord = [select id, giic_ShipmentCarrier__r.gii__Description__c,giic_Integration_Status__c,giic_ShipmentCarrier__r.Name from gii__Shipment__c WHERE ID =: shipment];
        
      
        
        if(shipmentRecord.giic_ShipmentCarrier__r.Name == 'PLS'){
            Integer plsStatusCode = extractStatusCode(message);
            shipmentRecord.giic_Integration_Status__c = 'PLS Shipment API completed with errors';
            if(!test.isRunningTest()){
                update shipmentRecord;
            }
            System.Debug('Error in this record ---- >'+shipmentRecord);
            System.Debug('Error Message is ---- >'+message);
             System.Debug('plsStatusCode is ---- >'+plsStatusCode);
            
            gii__ErrorLog__c errorlog = new gii__ErrorLog__c();
            errorlog.giic_ErrorMessage__c = message;
            errorlog.giic_ErrorstatusDescription__c = message;
            
            if(message.contains('errors":')){
                List<string> errmsglst = message.split('errors":');
                errorlog.gii__ErrorMessage__c = errmsglst[1];
            }
            errorlog.gii__ErrorCode__c = String.valueOf(plsStatusCode);
            errorlog.giic_Shipment__c = shipmentRecord.id;
            if(!test.isRunningTest()){
                insert errorlog;
            }
        }
        else if(shipmentRecord.giic_ShipmentCarrier__r.gii__Description__c.contains('FedEx')){
            system.debug('Fedex Error block');
            System.Debug('Error Message is ---- >'+message);         
             Integer fedexStatusCode = extractStatusCode(message);    
            
            shipmentRecord.giic_Integration_Status__c = 'FedEx Shipment API Invoked with errors';
            update shipmentRecord;
            
            System.Debug('Error in this record ---- >'+shipmentRecord);
            
            gii__ErrorLog__c errorlog = new gii__ErrorLog__c();
            errorlog.giic_ErrorMessage__c =  message;   
           // errorlog.gii__ErrorMessage__c = message;
            errorlog.giic_Shipment__c = shipmentRecord.id;
            errorlog.gii__ErrorCode__c = String.valueOf(fedexstatusCode);
               System.Debug('Error in this record ---- >'+errorlog);
            insert errorlog;          
            
        }
        
    }
    
    public static Integer extractStatusCode(String inputString) {
        Integer statusCode = null;
        System.Debug('inputString ---- >'+inputString);
        Integer indexOfStatus = inputString.indexOf('StatusCode :');
          System.Debug('indexOfStatus ---- >'+indexOfStatus);
       
        if (indexOfStatus != -1) {
            Integer startIndex = indexOfStatus + 12; // 9 is the length of "Status :"
            Integer endIndex = inputString.indexOf('====>', startIndex);
            
            if (endIndex != -1) {
                String statusCodeString = inputString.substring(startIndex, endIndex).trim();
                statusCode = Integer.valueOf(statusCodeString);
            }
        }
        system.debug('statusCode' + statusCode);
        return statusCode;
    }
    
}