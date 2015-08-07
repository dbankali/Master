public class Matrix
{

    public Matrix() {

    }
    public Matrix( Integer rows ) {
        this( rows, 1 );
    }


List<List<Double>> My_Array;
Integer i=0;
public Matrix( Integer rows, Integer cols ) {
        
        setMatrix(rows,cols);
    }

private void setMatrix( Integer rows, Integer cols ) {
        My_Array = new List<List<Double>>();
        
        //System.debug('=================='+My_Array.size());
        for( Integer row = 0; row < rows; row++ ) {
          List<Double> columns=new List<Double>();
        for(Integer col=0;col<cols;col++)
        {
              
             columns.add(0.0);
             
       
        }
        My_Array.add(columns);
            
        }
        }

    public Integer getRows() { // SLewis

        return My_Array.size();
    }
    public Integer getCols() {
   
        return My_Array.get(0).size(); // SLewis
    }
    
    
    
public Double getValue( Integer row, Integer col ) {
        return My_Array.get(row).get(col);
    }
public void setValue( Integer row, Integer col, Double value ) {
//System.debug('&&&&&&&&&'+My_Array.size());
        My_Array.get(row).set(col,value);
    }


public Matrix getSimpleResponseMatrix( Matrix matrix2 ) {
        Matrix response = null;
        if( sameSize( matrix2 ) ) {
            response = new Matrix( getRows(), getCols() );
        }
        return response;
    }
    
    public boolean sameSize( Matrix matrix2 ) { // SLewis
        return (getRows() == matrix2.getRows() && getCols() == matrix2.getCols());
    }
    
    public Matrix identity() {
        Integer size = Math.min( getRows(), getCols() );
        return identity( size );
    }
    public static Matrix identity( Integer size ) {
        size = size > 0 ? size : 1;
        Matrix response = new Matrix( size, size );
        for( Integer diag = 0; diag < size; ++diag ) {
            response.setValue( diag, diag, 1.0 );
        }
        return response;
    }
    public Matrix transpose() {
        Matrix response = new Matrix( getCols(), getRows() );
        for( Integer row = 0; row < getRows(); ++row ) {
            for( Integer col = 0; col < getCols(); ++col ) {
                response.setValue( col, row, getValue( row, col ) );
            }
        }
        return response;
    }
    public Matrix times( Matrix matrix2 ) {
        Integer timesInner = Math.min( getCols(), matrix2.getRows() );
        return times( matrix2, timesInner );
    }

    
    private Matrix times( Matrix matrix2, Integer timesInner ) {
        Integer timesRows = getRows();
        Integer timesCols = matrix2.getCols();
        Matrix response = new Matrix( timesRows, timesCols );
        for( Integer row = 0; row < timesRows; ++row ) {
            for( Integer col = 0; col < timesCols; ++col ) {
                for( Integer inner1 = 0; inner1 < timesInner; ++inner1 ) {
                    response.setValue( row, col, this.getValue( row, inner1 ) * matrix2.getValue( inner1, col )
                            + response.getValue( row, col ) );
                }
            }
        }
        return response;
    }
    public Matrix negate() {
        Matrix response = new Matrix( getRows(), getCols() );
        for( Integer row = 0; row < getRows(); ++row ) {
            for( Integer col = 0; col < getCols(); ++col ) {
                response.setValue( row, col, -getValue( row, col ) );
            }
        }
        return response;
    }
    
    
    
    

private void swapPivot( Integer diag, Matrix s, Matrix t ) {
        // get swap row and col
        Integer swapRow = diag;
        Integer swapCol = diag;
        Double maxValue = Math.abs( getValue( diag, diag ) );
        for( Integer row = diag; row < getRows(); ++row ) {
            for( Integer col = diag; col < getCols(); ++col ) {
                if( Math.abs( getValue( row, col ) ) > maxValue ) {
                    maxValue = Math.abs( getValue( row, col ) );
                    swapRow = row;
                    swapCol = col;
                }
            }
        }
        
        // swap rows and columns
        if( swapRow != diag ) {
            swapRows( swapRow, diag );
            t.swapRows( swapRow, diag );
        }
        if( swapCol != diag ) {
            swapCols( swapCol, diag );
            s.swapCols( swapCol, diag );
        }
    }

private void swapRows( Integer row1, Integer row2 ) {
        System.debug('swap Rows');
       List<double> temp = this.My_Array.get(row1);
        this.My_Array.set(row1,this.My_Array.get(row2));
        this.My_Array.set(row2,temp);
    }
    private void swapCols( Integer col1, Integer col2 ) {
    System.debug('swap Cols');
        Double temp;
        for( Integer row = 0; row < getRows(); ++row ) {
            temp = this.getValue( row, col1 );
            this.setValue( row, col1, this.getValue( row, col2 ) );
            this.setValue( row, col2, temp );
        }
    }
    
    
    
    
    
    
    private Matrix inverse( Integer maxDiag, Matrix s, Matrix t ) {
        Integer diag = 0;
        while( diag < maxDiag ) {
            // get the largest value for the pivot
            swapPivot( diag, s, t );
            if( 0 == getValue( diag, diag ) )
                break;
            // divide through to make pivot identity
            Double divisor = getValue( diag, diag );
            if( Math.abs( divisor ) < 0 ) {
                setValue( diag, diag, 0.0 );
                break;
            }
            divideRowBy( diag, diag, divisor );
            t.divideRowBy( diag, 0, divisor );
            setValue( diag, diag, 1.0 );
            // remove values down remaining rows
            for( Integer row = diag + 1; row < getRows(); ++row ) {
                Double factor = getValue( row, diag );
                if( 0 != factor ) {
                    addRowTimes( diag, diag, row, factor );
                    t.addRowTimes( diag, 0, row, factor );
                    setValue( row, diag, 0 );
                }
            }
            // remove values across remaining cols - some optimization could
            // be done here because the changes to the original matrix at this
            // point only touch the current diag column
            for( Integer col = diag + 1; col < getCols(); ++col ) {
                Double factor = getValue( diag, col );
                if( 0 != factor ) {
                    addColTimes( diag, diag, col, factor );
                    s.addColTimes( diag, 0, col, factor );
                    setValue( diag, col, 0 );
                }
            }
            ++diag;
        }
        return s.times( t, diag );
    }
    private void divideRowBy( Integer aRow, Integer fromCol, Double value ) {
        for( Integer col = fromCol; col < getCols(); ++col ) {
            setValue( aRow, col, getValue( aRow, col ) / value );
        }
    }
private void addRowTimes( Integer diag, Integer fromCol, Integer row, Double factor ) {
        for( Integer col = fromCol; col < getCols(); ++col ) {
            setValue( row, col, getValue( row, col ) - factor * getValue( diag, col ) );
        }
    }
private void addColTimes( Integer diag, Integer fromRow, Integer col, Double factor ) {
        for( Integer row = fromRow; row < getRows(); ++row ) {
            setValue( row, col, getValue( row, col ) - factor * getValue( row, diag ) );
        }
    }
public Matrix inverse() {
                
        Matrix s = new Matrix( getCols(), getCols() ).identity();
        Matrix t = new Matrix( getRows(), getRows() ).identity();
        Integer maxDiag = Math.min( getRows(), getCols() );
        // this is because the operations are destructive to the input matrix:
        return this.duplicate().inverse( maxDiag, s, t );
    }
public Matrix duplicate() {
        Matrix response = new Matrix( getRows(), getCols() );
        for( Integer row = 0; row < getRows(); ++row ) {
            for( Integer col = 0; col < getCols(); ++col ) {
                response.setValue( row, col, getValue( row, col ) );
            }
        }
        return response;
    }

/* public Matrix subtract( Matrix matrix2 ) {
        Matrix response = getSimpleResponseMatrix( matrix2 );

        if( null != response ) {
            for( Integer row = 0; row < response.getRows(); ++row ) {
                for( Integer col = 0; col < response.getCols(); ++col ) {
                    response.setValue( row, col, getValue( row, col ) - matrix2.getValue( row, col ) );
                }
            }
        }
        return response;
    }

 public Matrix arbitrariness( Matrix inverse ) {
        Matrix intermediate = inverse.times( this );
        return intermediate.identity().subtract( intermediate );
    }*/





}