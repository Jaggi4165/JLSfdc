public class StringArrayTest {
     public static String[] generateStringArray(Integer n) {
       
        String[] myArray = new List<String>();
for(Integer i=0;i<n;i++) {
           
            myArray.add('Test '+i);
        } 

        return myArray;
    }   
}