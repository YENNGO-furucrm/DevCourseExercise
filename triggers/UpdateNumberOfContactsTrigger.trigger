trigger UpdateNumberOfContactsTrigger on Contact (after insert, after delete) {

    Set<Id> accountIds = new Set<Id>();
    
    if(Trigger.isInsert){
		for(Contact con:trigger.new){
			accountIds.add(con.accountID);
		}
	}

    if(Trigger.isDelete){
		for(Contact con:trigger.old){
			accountIds.add(con.accountID);
		}
	}
	
    // call future method
    UpdateNumberOfContactFutureMethod.UpdateFieldNumberOfContact(accountIds);	
}