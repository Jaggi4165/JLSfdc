/**
* @File Name : soqlSelector.cls
* @Description : This class handles all the soql queries and return the result
* @Author : Jagadeeswara Rao Kusumuru
* @Last Modified By : Jagadeeswara Rao Kusumuru
* @Last Modified On : December 9, 2024
* @Modification Log :
* @Handler class : AccountObjectHandler
*==============================================================================
* Ver | Date | Author | Modification
*==============================================================================
* 1.0 | December 9, 2024 |  Jagadeeswara Rao Kusumuru | Initial Version
**/

public class SoqlSelector {
	@AuraEnabled
	Public static List<Account> accountQuery(Integer size){
		Return [SELECT Id,Name FROM Account Where Name != NULL LIMIT :size];
	}

	@AuraEnabled
	Public static List<Contact> contactQuery(Integer size,List<Id> accountId_List){
		Return [SELECT Id,LastName,AccountId,Account.Name FROM Contact Where AccountId IN : accountId_List LIMIT :size];
	}
}