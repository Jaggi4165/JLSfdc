/**
* @File Name : IsLeapYearLWC.cls
* @Description : This apex class
* @Author : Jagadeeswara Rao Kusumuru
* @Last Modified By :
* @Last Modified On : November 4, 2024
* @Modification Log :
*==============================================================================
* Ver | Date | Author | Modification
*==============================================================================
* 1.0 | November 4, 2024 |   | Initial Version
**/

public class IsLeapYearLWC {
	@AuraEnabled
	Public static boolean checkLeapYearOrNot(Integer year){
		System.debug('Year ===>'+year);
		return Date.isLeapYear(year);
	}
}