public class Assignment11 {
    Integer count=0;
    Set<Integer> setString = new Set<Integer>();
    public void assignment11(String one,String two){
        for(Integer i=0;i<=one.length()-1;i++){
            for(Integer j=0;j<=two.length()-1;j++){
                if(one.charAt(i)==two.charAt(j)){
                    setString.add(one.charAt(i));
                    
                }
            }
        }
        System.debug('number of characters shared between two words: '+setString.size());
    }
}