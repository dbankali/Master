/*
 *  The purpose of this class is to take a given case or case record Id and perform a query 
 *  to retrieve the appropriate related objects which will then be added to a collection of
 *  history (apex) objects and ordered chronologically.
 *
 *  This class is used by the caseHistory and caseHistoryPrint Visualforce pages. 
 * 
 *  Note: this class, as per all of Apex, runs in system mode and will currently return all 
 *        records in the system in the query it performs regardless of any sharing rules.
 *        If you want the queries to respect the visibility settings in the application 
 *        (sharing rules) you must append the "WITH SHARING" modifier to the class definition.
 *        Additionally, any fields or objects which are restricted via CRUD or FLS 
 *        (profile security permissions) will be exposed because the binding from the Visualforce 
 *        pages uses the history (apex) object and not the respective SObjects (Case, Task, etc.).
 *        If you wish to have these security settings enforced refer to the Schema.Describe types
 *        in the Apex developer guide for additional information.
 */
public class CaseHistoryCon {
    
    /* Property value that controls the truncation of case comments */
    public boolean fullComments { get; private set; }

    /* Property value that controls visibility of related objects which
       are not visible in the customer portal. */
    public boolean hidePrivate  { get; private set; }

    /* Constructor of the class where we default the above property values */
    public CaseHistoryCon() {
        fullComments           = true;
        hidePrivate            = false;
        truncatedCommentLength = 100;
    }
    
    /* Action method for toggling the fullComments property */
    public void toggleComments() { fullcomments = !fullcomments; }

    /* Action method for toggling the visibility control for private related objects.*/
    public void togglePrivate()  { hidePrivate  = !hidePrivate;  }    
    
    /* Action method for navigating the user back to the case page. */
    public PageReference backToCase() {
        return new ApexPages.StandardController(c).view();
    }

    /* Accessor for retrieving the case object and its related items. If the cid property is null this
       method will return a new, empty case object. The functionality in this method could have been placed
       in the get property accessor for the private property named 'c' below but for simplicity of the page
       author in referencing the current case object this method was created because it is not possible to
       create a variable named 'case' since it is a reserved term in Apex.*/
    public Case getcase() { 
    
        if(cid == null) return new Case();
        return [SELECT casenumber, subject, contact.name, contact.email,
                       (SELECT CreatedBy.Name, CreatedDate, CommentBody,IsPublished          FROM CaseComments ORDER BY CreatedDate      ASC),
                       (SELECT CreatedBy.Name, CreatedDate, Field, NewValue, OldValue        FROM Histories    ORDER BY CreatedDate      ASC),
                       (SELECT CreatedBy.Name, CreatedDate, Name                             FROM Attachments  ORDER BY CreatedDate      ASC),
                       (SELECT Owner.Name, ActivityDateTime, Subject, IsVisibleInSelfService FROM Events       WHERE ActivityDateTime <= :System.Now()   ORDER BY ActivityDateTime ASC),
                       (SELECT Owner.Name, LastModifiedDate, Subject, IsVisibleInSelfService FROM Tasks        WHERE ActivityDate     <= :System.Today() 
                                                                                                                 AND IsClosed = true                     ORDER BY LastModifiedDate ASC)
                FROM case 
                WHERE id = :cid]; 
    }
    
    /* This accessor provides the page with the ordered collection of history (apex) objects for display in the page. 
       it also processes the truncation of case comments as specified by the fullComments property value.*/
    public History[] getHistories() {
        History[] histories = new history[]{};
        for (CaseComment comment:c.casecomments) { 
            if (!hidePrivate || comment.ispublished) {
                addHistory(histories, new history(comment.createdDate, comment.ispublished, comment.createdby.name, 'Comment Added', '' , truncateValue(comment.commentbody))); 
            }
        }
        
        for (Event e:c.events) { 
            if (!hidePrivate || e.isvisibleinselfservice) {
                addHistory(histories, new history(e.activitydatetime,  e.isvisibleinselfservice, e.owner.name,'Event Completed', '' , e.subject)); 
            }
        }
        
        for (Task t:c.tasks) { 
            if (!hidePrivate || t.isvisibleinselfservice) {
                addHistory(histories, new history(t.lastmodifieddate,  t.isvisibleinselfservice, t.owner.name,'Task Completed',  '' , t.subject)); 
            }
        }

        for (CaseHistory ch:c.histories) { 
            addHistory(histories, new history(ch.createdDate, true, ch.createdby.name, ch.field + ' Change', String.valueOf(ch.oldvalue), String.valueOf(ch.newvalue))); 
        }

        for (Attachment a:c.attachments) { 
            addHistory(histories, new history(a.createdDate,  true, a.createdby.name, 'Attachment Added', '' , a.name)); 
        }
        
        return histories;
    }
    
    /* This method adds the newHistory object to the given histories collection in the appropriate order. 
       The order provided here places the oldest records at the front of the list, i.e. by date ascending. */
    private void addHistory(History[] histories, History newHistory) {
        Integer position = histories.size();
        for (Integer i = 0; i < histories.size(); i++) {
            if (newHistory.historydt < histories[i].historydt) {
                position = i;
                break;
            }
        }
        
        if (position == histories.size()) {
            histories.add(newHistory);
        } else {
            histories.add(position, newHistory);
        }
    }
    
    /* Returns the truncated string value if that is specified in the current state (!fullComments)
       and the current length is greater than the value of the private truncatedCommentLength property. */
    private String truncateValue(String s) {
        if (!fullComments && s.length() > truncatedCommentLength) {
            s = s.substring(0,truncatedCommentLength) + '...';
        }
        
        return s;
    }
    
    /* The ID value of the case that will be used by the getCase() method to query for the related
       objects used to generate the ordered history collection. The value will be based on the request 
       parameter, if available. */
    private Id cid { 
        get { 
            if(ApexPages.currentPage().getparameters().get('cid') != null) {
                cid = ApexPages.currentPage().getparameters().get('cid');
            }
            return cid;
        }
        set { 
            if(value != null) cid = value;
        }
    }
    
    /* The case object set by the getCase method and used by the getHistories method to acquire
       the related records.  */
    private Case c { 
        get { return getCase(); }
        set; 
    }
    
    /* The length of "Short Comments" which is used by the truncateValue method in this class to
       truncate case comments when specified by the user. */
    private Integer truncatedCommentLength { get; set; }   
}