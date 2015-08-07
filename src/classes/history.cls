/* 
 * This class is used by the CaseHistoryCon controller class and the CaseHistory
 * and CaseHistoryPrint Visualforce pages. The purpose is to hold heterogenous
 * sobject information that allows multiple types to be presented in a uniform manner.
 */
public class history {

    /* Properties of the class */
    public datetime historydt { get; private set; }
    public boolean ispublic   { get; private set; }
    public string actorname   { get; private set; }
    public string historyType { get; private set; }
    public string to          { get; private set; }
    public string fr          { get; private set; }
    
    /* Class constructor */
    public History(Datetime d, boolean p, String actor, String ht, String f, String t) {
        historydt   = d;
        historydate = d.format();
        ispublic    = p;
        actorname   = actor;
        historyType = ht;
        fr          = f;
        to          = t;
    }
    
    /* Formatting methods utilized primarily by the CaseHistoryPrint Visualforce page*/
    public string historydate { get; set; }
    public string dtmonthyr   { get { return historydt.format('MMMMM yyyy'); } }
    public string dttime      { get { return historydt.format('h:mm a');} }
    public string dtdayfmt    { get { return historydt.format('d - EEEE'); } }
    public integer dtmonth    { get { return historydt.month();} }
    public integer dtyear     { get { return historydt.year();} }
    public integer dtday      { get { return historydt.day();} }
    
}