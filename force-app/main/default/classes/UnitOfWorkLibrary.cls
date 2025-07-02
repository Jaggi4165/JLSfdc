/**
* @File Name : UnitOfWorkLibrary.cls
* @Description :
* @Author : Kusumuru JagadeeswaraRao
* @Last Modified By :
* @Last Modified On : December 10, 2024
* @Modification Log :
*==============================================================================
* Ver | Date | Author | Modification
*==============================================================================
* 1.0 | December 10, 2024 | Kusumuru Jagadeeswara Rao  | Initial Version
**/

global class UnitOfWorkLibrary {
	
	Public UnitOfWorkLibrary(){
		System.debug('Unit Of Work Library Initialized...');
	}

	global Integer addNumbers(List<Integer> params){
		Integer total = 0;
		if(params.isEmpty()){
			 return 0 ;
		}
		for(Integer i : params){
			total = total+i;
		}
		return total;
	}
}