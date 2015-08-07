public with sharing class AttachmentUploadController {
  public static List<attachment> attachmentList{get; set;}

  public Attachment attachment {
  get {
      if (attachment == null)
        attachment = new Attachment();
      return attachment;
    }
  set;
  }

  public PageReference upload() {

    attachment.OwnerId = UserInfo.getUserId();
    attachment.ParentId = '0015000000My7qj'; // the record the file is attached to
    attachment.IsPrivate = true;

    try {
      //insert attachment;
      if(attachmentList == null){
        attachmentList = new List<attachment>();
      }
      attachmentList.add(attachment);
    } catch (DMLException e) {
      ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error uploading attachment'));
      return null;
    } finally {
      attachment = new Attachment(); 
    }

    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Attachment uploaded successfully'));
    return null;
  }
  public pagereference saveAttachments(){
     system.debug('attachment List >>>>'+ attachmentList);
     insert attachmentList;
     return null;
  }

}