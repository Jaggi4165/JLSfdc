public class Assignment9 {
    public void toyshop(Integer wheelsCount,Integer bodyCount,Integer figuresCount){
        System.debug('Welcome to the TOY SHOP !');
        Integer carCount=0;
        for(Integer i=wheelsCount;i>=4;i-4){
            if(wheelsCount>=4 && bodyCount>=1 && figuresCount>=2){
                        carCount++;
                        i=i-4;
                        bodyCount=bodyCount-1;
                        figuresCount=figuresCount-2;
            }
            else{
                 break;
            }
        } 
        System.debug('Number of cars we may made : '+carCount);
    }
}