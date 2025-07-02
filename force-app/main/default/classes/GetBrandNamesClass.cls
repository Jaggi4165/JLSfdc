public class GetBrandNamesClass {
    public static List<String> getBrandNameMethod(string colour){
        
        List<String> availablebrands =  new List<String>();
        Map<String, List<String>> MapOfBrandColour = new Map<String, List<String>>();
        MapOfBrandColour.put('Benz',new List<String>{'Black','Blue','white','Grey'});
        MapOfBrandColour.put('Honda',new List<String>{'Black','Blue','white','Grey'});
        MapOfBrandColour.put('Volks',new List<String>{'white','Blue','Silver','Grey'});
        
        for(String brand : MapOfBrandColour.keyset()){
         List<String> colourList = MapOfBrandColour.get(brand);
            if(colourList.contains(colour)){
                availablebrands.add(brand);
            }
        }
        System.debug(availablebrands);
        return availablebrands; 
        
    }
}

// INPUT :  GetBrandNamesClass.getBrandNameMethod('Silver');
// OUTPUT : Volks