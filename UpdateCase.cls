public with sharing class UpdateCase {

  public static Decimal updateCase(){
    List<Case> caseslst = [SELECT Id, Status FROM Case WHERE Status='New'];
    List<Case> updatelst = new List<Case>();
    Decimal updateSuccesRecord = 0;

    if(caseslst.size() < 0){
      return 0;
    }else{
      for (Case c : caseslst) {
        c.Status = 'not resolved, need to resolve quickly';
        updatelst.add(c);
      }
      Database.SaveResult[] srList = Database.update(updatelst, false);

      for (Database.SaveResult sr : srList) {
          if (sr.isSuccess()) {
            updateSuccesRecord++;
          }
          else {
              // Operation failed, so get all errors                
              for(Database.Error err : sr.getErrors()) {
                  System.debug('The following error has occurred.');                    
                  System.debug(err.getStatusCode() + ': ' + err.getMessage());
                  System.debug('Account fields that affected this error: ' + err.getFields());
              }
          }
      }

      return updateSuccesRecord;
    }
  }

}