public with sharing class HousieTicketController {
   /* @AuraEnabled
    public static List<Integer> getHousieTicketNumbers() {
        List<Integer> numbers = new List<Integer>();
        for (Integer i = 1; i <= 15; i++) {
            numbers.add(Integer.valueOf(''));
        }
        return numbers;
    }
*/
    @AuraEnabled
    public static List<Integer> generateHousieTicketNumbers() {
        List<Integer> numbers = new List<Integer>();
        
        List<Integer> numbers1 = new List<Integer>();
        while (numbers1.size() < 5) {
            Integer HNumber = (Integer)Math.floor(Math.random() * (29 - 1 + 1) + 1);
            if (!numbers1.contains(HNumber) ) {
                numbers1.add(HNumber);
            }
        }
        
        List<Integer> numbers2 = new List<Integer>();
        while (numbers2.size() < 5) {
            Integer HNumber = (Integer)Math.floor(Math.random() * (59 - 30 + 1) + 30);
            if (!numbers2.contains(HNumber)) {
                numbers2.add(HNumber);
            }
        }
        
        List<Integer> numbers3 = new List<Integer>();
        while (numbers3.size() < 5) {
            Integer HNumber = (Integer)Math.floor(Math.random() * (90 - 60 + 1) + 60);
            if (!numbers3.contains(HNumber)) {
                numbers3.add(HNumber);
            }
        }
        
        numbers.addAll(numbers1);
        numbers.addAll(numbers2);
        numbers.addAll(numbers3);
        
        numbers.sort();
        return numbers;
    }
}