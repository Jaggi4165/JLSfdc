public class Assignment7 {
    public void reverseOrder(){
        List<Integer> integerList = new List<Integer>{1,2,3,4,5,6,7,8,9,10};
            System.debug(integerList);
        List<Integer> reversedList = new List<Integer>();
		for(Integer i = integerList.size() - 1; i >= 0; i--){
    		reversedList.add(integerList[i]);
		}
        System.debug(reversedList);
    }
}