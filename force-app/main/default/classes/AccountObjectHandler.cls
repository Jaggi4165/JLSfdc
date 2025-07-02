/**
* @File Name : AccountObjectHandler.cls
* @Description :
* @Author :
* @Last Modified By :
* @Last Modified On : December 9, 2024
* @Modification Log :
*==============================================================================
* Ver | Date | Author | Modification
*==============================================================================
* 1.0 | December 9, 2024 |   | Initial Version
**/

public class AccountObjectHandler {
	@AuraEnabled
	Public static void returnAccounts(Integer numberOfAccountsToBeReturned){
		List<Id> accountIds_list = new List<Id>();
		for(Account acc : SoqlSelector.accountQuery(numberOfAccountsToBeReturned)){
			System.debug('Each Account Name : '+acc.Name);
			accountIds_list.add(acc.Id);
		}
		for(Contact con : SoqlSelector.contactQuery(accountIds_list.size(),accountIds_list)){
			System.debug('Each Contact Name : '+con.LastName+' :===: '+con.Account.Name);
		}
	}
}