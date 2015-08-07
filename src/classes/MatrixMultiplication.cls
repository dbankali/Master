public class MatrixMultiplication
{

 /* public MatrixMultiplication() {

    }
    public MatrixMultiplication( Integer rows ) {
        this( rows, 1 );
    }*/


List<List<Double>> commissionArray;

public MatrixMultiplication( Integer rows, Integer cols ) {
        
        setMatrixMultiplication(rows,cols);
    }

public void setMatrixMultiplication( Integer rows, Integer cols ) {
        commissionArray = new List<List<Double>>();
        //System.debug('=================='+My_Array.size());
        for( Integer row = 0; row < rows; row++ ) {
        List<Double> columns=new List<Double>();
        for(Integer col=0;col<cols;col++)
        {
              
             columns.add(0.0);
        }
        commissionArray.add(columns);
            
        }
        
      
    }
    public Double getValue( Integer row, Integer col ) {
        return commissionArray.get(row).get(col);
    }
public void setValue( Integer row, Integer col, Double value ) {
//System.debug('&&&&&&&&&'+My_Array.size());
        commissionArray.get(row).set(col,value);
    }
    List<List<Double>> c;
public List<List<Double>> matrixMultiplication(List<List<Double>> inverse_Array)
{

c = new List<List<Double>>();
        //System.debug('=================='+My_Array.size());
        for( Integer row = 0; row <inverse_Array.size(); row++ ) {
          List<Double> columns=new List<Double>();
        for(Integer col=0;col<commissionArray.get(0).size();col++)
        {
              
             columns.add(0.0);
             
       
        }
        c.add(columns);
            
        }
     
     // Multiply both matrics........
     Double d=0;
     for(Integer i=0;i<inverse_Array.size();i++)
     {
         for(Integer j=0;j<commissionArray.get(0).size();j++)
         {
             d=0;
             for(Integer k=0;k<commissionArray.size();k++)
             {
             double s1=inverse_Array.get(i).get(k);
             double s2=commissionArray.get(k).get(j);
                 d+=s1*s2;
                 
                 c.get(i).set(j,d);
                 
             }
         }
     }
     for(Integer i=0;i<2;i++)
        {
            for(Integer j=0;j<1;j++)
            {
                System.debug('             '+c.get(i).get(j));
            }
            //System.out.println();
        }
        return c;


}
















}