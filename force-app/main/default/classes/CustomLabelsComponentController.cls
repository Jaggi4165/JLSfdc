/**
* @File Name : CustomLabelsComponentController.cls
* @Description :
* @Author :
* @Last Modified By :
* @Last Modified On : June 10, 2025
* @Modification Log :
*==============================================================================
* Ver | Date | Author | Modification
*==============================================================================
* 1.0 | June 10, 2025 |   | Initial Version
**/

public class CustomLabelsComponentController {
	@AuraEnabled(cacheable=true)
    public static List<Account> getAccountsWithContacts() {
        return [
            SELECT Id, Name, Industry, Phone, Website, 
                   (SELECT Id, Name, Title, Email, Phone FROM Contacts ORDER BY Name)
            FROM Account
            ORDER BY Name
            LIMIT 1000
        ];
    }
}