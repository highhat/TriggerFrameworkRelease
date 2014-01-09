// This would not be included in the framework as the standard testing will cover
// everything, but provided so the sample can be run and the process can be seen

@isTest
private class Framework_TestAccount {
	
	private static testMethod void frameworkTest() {
		Account testAccount = new Account();
		testAccount.Name = 'Test Framework';
		insert testAccount;
		
		List<Account> allCreatedAccounts = [SELECT ID, Name FROM Account];
		System.debug('=======================================');
		System.debug('Results of before insert trigger: ' + allCreatedAccounts);
		System.debug('=======================================');
		
		// Uncomment the following to see the after update account actions
		testAccount.Name = 'Change Name';
		update testAccount;
		
		List<Account> allUpdatedAccounts = [SELECT ID, Name FROM Account 
			WHERE ID =: testAccount.ID];
		System.debug('=======================================');
		System.debug('Results of before insert trigger: ' + allUpdatedAccounts);
		System.debug('=======================================');
		
		// Example of resetting the handler for test running; This is only
		// accessible in running tests
		Framework_AccountDispatcher.resetHandler('Framework_AccountBeforeInsertHandler');
		
		// Uncomment this, and it will throw an error as a trigger handler is 
		// not defined for this object; Create a 
		// Framework_AccountAfterDeleteHandler class that extends the 
		// Framework_HandlerBase and watch it run instead!
		
		// delete testAccount;
////////////////////////////////////////////////////////////////////////////////
	}
}