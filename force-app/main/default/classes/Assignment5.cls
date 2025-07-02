public class Assignment5 {
    public void game(String player1,String player2){
        if(player1==player2){
            System.debug('match TIE');
        }
        else if((player1.equals('rock') && player2.equals('scissors'))||
                ((player1.equals('paper') && player2.equals('rock')))||
                 ((player1.equals('scissors') && player2.equals('paper')))){
            System.debug('Player-1 wins');
        }
        else{
            system.debug('Player-2 wins');
        }
    }
}