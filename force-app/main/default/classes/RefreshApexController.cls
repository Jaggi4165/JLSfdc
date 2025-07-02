/**
* @File Name : RefreshApexController.cls
* @Description :
* @Author :
* @Last Modified By :
* @Last Modified On : May 19, 2025
* @Modification Log :
*==============================================================================
* Ver | Date | Author | Modification
*==============================================================================
* 1.0 | May 19, 2025 |   | Initial Version
**/

public class RefreshApexController {
	@AuraEnabled
	public static void LightningStudio(){
		System.debug('Lightning Studio');
	}
	@AuraEnabled(cacheable=true)
	public static List<Opportunity> fetchOppList(){
		return [SELECT Id,Name,StageNAme,Amount FROM Opportunity Order by CreatedDate DESC limit 10];
	}
}