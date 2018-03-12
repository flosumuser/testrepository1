public class Fridge implements KitchenUtility
{
//fields
    private String modelNumber;
    private Integer numberInStock;
    public static Integer stockThreshold = 5;
    public static final Integer STOCK_THRESHOLD = 5;
    
    public Integer ecoRating 
    {
        get { return ecoRating; }
        set { ecoRating = value; if (ecoRating < 0) ecoRating =0; }
    }
    
    
//methods
    public void updateStock(Integer justSold) 
    {
        numberInStock = numberInStock - justSold;
    }
    public void setModelNumber(String modelno)
    {
        modelNumber=modelno;
    }
    public String getModelNumber()
    {
        return modelNumber;
    }
    
    public static void toDebug(Fridge aFridge) 
    {
        System.debug ('ModelNumber = ' + aFridge.modelNumber);
        System.debug ('Number in Stock = ' + aFridge.numberInStock);
    }
//cunstuctor

    public Fridge() 
    {
        modelNumber = 'XX-XX';
        numberInStock = 0;
    }
    public Fridge(String theModelNumber, Integer theNumberInStock) 
    {
        modelNumber = theModelNumber;
        numberInStock = theNumberInStock;
    }
}