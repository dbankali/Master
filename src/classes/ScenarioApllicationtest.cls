/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class ScenarioApllicationtest {

    static testMethod void myUnitTest() {
        
        ScenarioApplication senario=new ScenarioApplication();
        senario.setSelectedYear('2008');
        senario.setSelectedcriteria('Declines By');
        String option='';
        for(Agent__c agent:[select Id,AgentName__c from Agent__c order by AgentName__c]){
                 option=agent.Id;    
       }
        senario.setSelectedoption(option);           
        
        senario.setPercent(10.0);
        senario.setSelectedMonth('0');
        
        
        senario.save();
        
        senario.getMonths();
        senario.getYears();
        senario.getCriteria();
        senario.getOptions();
        senario.getSelectedMonth();
        senario.getSelectedYear();
        senario.getPercent();
        senario.getSelectedcriteria();
        senario.getSelectedoption();
        senario.getSelectedmetric();
        senario.getCommissionMax();
        senario.getRevenueMax();
        senario.getRevenueDataForGraph();
        senario.getCommissionDataForGraph();
        senario.getCommissionDataForBestFeetGraph();
        senario.getSelectedMonthCommission();
        senario.getGrowthCommission();
        senario.setSelectedmetric('hello');
        senario.getSelectedmetric();
        
// Test Case For Matrix.cls class

    
    /*Matrix inverseMatrix=new Matrix(12,2);
    MatrixMultiplication multiplicationMatrix=new MatrixMultiplication(12,1);
    MatrixMultiplication multiplicationMatrixRevenue=new MatrixMultiplication(12,1);
    for(Integer i=0;i<12;i++)
        {
            for(Integer j=0;j<2;j++)
            {
                inverseMatrix.setValue(i, j, 500);
                
            }
        }   
            
        inverseMatrix.inverse();*/
    Matrix matrix=new Matrix();
    Matrix matrix1=new Matrix(5);
    Matrix matrix2=new Matrix(12,2);
    Matrix matrix3=new Matrix(12,2);
    matrix3=matrix2.getSimpleResponseMatrix(matrix3);
    matrix2=matrix2.transpose();
    matrix2=matrix2.times(matrix2);
    matrix2=matrix2.negate();
        
// Test Case For MatrixMultiplication.cls class     
        MatrixMultiplication multi=new MatrixMultiplication(12,2);
        multi.setMatrixMultiplication(12,2);
        multi.getValue(0,0);
        UserInformation user=new UserInformation();
        UserInformation.getContextUserName();
        UserInformation.getContextUserFirstName();
        UserInformation.getContextProfileId();
        
        
        // TO DO: implement unit test
    }
}