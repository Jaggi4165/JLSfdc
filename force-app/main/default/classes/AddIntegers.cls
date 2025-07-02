/**
* @File Name : AddIntegers.cls
* @Description :
* @Author :
* @Last Modified By :
* @Last Modified On : December 10, 2024
* @Modification Log :
*==============================================================================
* Ver | Date | Author | Modification
*==============================================================================
* 1.0 | December 10, 2024 |   | Initial Version
**/

public class AddIntegers{
	@AuraEnabled
	Public static void addNumbers(){
		UnitOfWorkLibrary uow = new UnitOfWorkLibrary();
		Integer total = uow.addNumbers(new List<Integer>{9,5,7});
		System.debug('Unit Of Work Total : '+total);
	}
}