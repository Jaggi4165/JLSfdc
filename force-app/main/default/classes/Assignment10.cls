public class Assignment10 {
    List<Integer> numberList = new List<Integer>{2,6,4,9,3,7,6,5,8,4};
    List<Integer> newList=new List<Integer>();
    public void method1(){
        
        for(Integer i=0;i<=numberList.size()-2;i++)
   	    {
            if((numberList[i]<numberList[i+1])&&(numberList[i+1]>numberList[i+2])){
                newList.add(numberList[i+1]);
            }
            else{
                
            }
        }
        System.debug('newly added list is : '+newList);
    }
}