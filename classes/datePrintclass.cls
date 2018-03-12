public class datePrintclass{
    public void showDate(){
       System.debug('Today DAte is - '+Date.today());
        System.debug('System_Today_Formate DAte is - '+System.today().format());
        System.debug('Today_Format DAte is - '+Date.today().format());
        String dt=String.valueOf(Date.today().format());
       
    }

}