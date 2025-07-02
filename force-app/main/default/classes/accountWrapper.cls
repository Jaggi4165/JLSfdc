public class accountWrapper {
    // @AuraEnabled public Boolean isSelected;
    // @AuraEnabled public Boolean isExpanded;
    // @AuraEnabled public Boolean isChildCreated;
    @AuraEnabled public String  recordId;
    @AuraEnabled public String  recordName;
    // @AuraEnabled public String  clientName;
    // @AuraEnabled public String  clientId;
    // @AuraEnabled public String  conflictCheckId;
    // @AuraEnabled public String  status;
    // @AuraEnabled public String  areaOfLaw;
    // @AuraEnabled public Integer approveCount;
    // @AuraEnabled public Integer discussCount;
    // @AuraEnabled public Integer totalCount;
    // @AuraEnabled public String  contributors;
    // @AuraEnabled public String  keywords;
    // @AuraEnabled public String  adverseParties;
    // @AuraEnabled public String relatedParties;
    // @AuraEnabled public String  clientReferenceNumber;
    // @AuraEnabled public Boolean isProBono;
    // @AuraEnabled public String  matterNames;
    // @AuraEnabled public String  description;
    // @AuraEnabled public Boolean  isRecordCreator;
    // @AuraEnabled public Boolean  isOriginatingAttorney;
    
    // @AuraEnabled public LIST<clientRecord> clientRecords = new List<clientRecord> ();
    // @AuraEnabled public LIST<contributorRecord> contributorRecords = new List<contributorRecord> ();
    // @AuraEnabled public LIST<keywordRecord> keywordRecords = new List<keywordRecord> ();
    // @AuraEnabled public LIST<entityRecord> entityRecords = new List<entityRecord> ();
    // @AuraEnabled public LIST<chainOfTitleRecord> chainOfTitleRecords = new List<chainOfTitleRecord> ();
    
    

    public class clientRecord { 
        @AuraEnabled public String recordId;
        @AuraEnabled public String  clientName;
        @AuraEnabled public String  clientId;
        @AuraEnabled public String  clientNumber;
        @AuraEnabled public String  groupNumber;
        @AuraEnabled public String  classification;
        @AuraEnabled public Boolean isActive;
        @AuraEnabled public Boolean isVerified;
    }

    public class contributorRecord {
        @AuraEnabled public String recordId;
        @AuraEnabled public String contributorName;
        @AuraEnabled public String contributorType;
        @AuraEnabled public String inventorId;
        @AuraEnabled public String patentName;
        @AuraEnabled public String patentFamilyName;
        @AuraEnabled public String designName;
        @AuraEnabled public String designFamilyName;
        @AuraEnabled public String copyrightName;
        @AuraEnabled public Boolean isVerified;
    }

    public class keywordRecord { 
        @AuraEnabled public String recordId;
        @AuraEnabled public String keyword;
        @AuraEnabled public String keywordId;
        @AuraEnabled public String agreementName;
        @AuraEnabled public String copyrightName;
        @AuraEnabled public String designName;
        @AuraEnabled public String designFamilyName;
        @AuraEnabled public String disputeName;
        @AuraEnabled public String generalMatter;
        @AuraEnabled public String mark;
        @AuraEnabled public String patentName;
        @AuraEnabled public String patentFamilyName;
        @AuraEnabled public String trademarkName;
        @AuraEnabled public Boolean isVerified;

    }

    public class entityRecord { 
        @AuraEnabled public String recordId;
        @AuraEnabled public String entityName;
        @AuraEnabled public String entityId;
        @AuraEnabled public String entityType;
        @AuraEnabled public String entityState;
        @AuraEnabled public String entityCountry;
        @AuraEnabled public String entityContact;
        @AuraEnabled public Boolean entityActive;
        @AuraEnabled public Boolean isVerified;

    }

    public class chainOfTitleRecord { 
        @AuraEnabled public String recordId;
        @AuraEnabled public String title;    
        @AuraEnabled public String applicantName;
        @AuraEnabled public String chainOfTitleId;
        @AuraEnabled public String classification;
        @AuraEnabled public String role;
        @AuraEnabled public Date fromDate;
        @AuraEnabled public Date toDate;
        @AuraEnabled public String agreementName;
        @AuraEnabled public String copyright;
        @AuraEnabled public String design;
        @AuraEnabled public String designFamily;
        @AuraEnabled public String dispute;
        @AuraEnabled public String generalMatter;
        @AuraEnabled public String mark; 
        @AuraEnabled public String patent;
        @AuraEnabled public String patentFamily;
        @AuraEnabled public String trademark; 
        @AuraEnabled public Boolean isVerified;   
    }
    

}