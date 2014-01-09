/*

Child of HandlerBase for handiling account trigger actions

Class:              Framework_AccountBeforeInsertHandler
Date:               12/20/2013
Version:            1
Last Updated:       12/20/2013
    * 	Stubbed for sample

While the Dispatcher (Framework_AccountDispatcher) would need implemented once
per object, a class such as this would need implemented once per event, 
following a defined naming convention so it can be created by the Dispatcher

These classes extend Framework_HandlerBase, enforcing the fact that our predfined
calls from the dispatcher are handled, and that the required overrides are put
in place.

Other than the two method listed here, there is really no other difference
between this and a standard trigger handler utility class; it determines which
records from the trigger qualify for which operation, than does something 
with the records
////////////////////////////////////////////////////////////////////////////////
*/

public with sharing class Framework_AccountBeforeInsertHandler extends 
	Framework_HandlerBase {
	
	// -------- Constants --------
	// None
	
	// -------- Constructor --------
	public Framework_AccountBeforeInsertHandler(){}
	
	// -------- Variables --------
	// None
	
	// -------- Properties --------
	// A list of account objects that qualify for example x, populated by the
	// qualifyStartingRecords method
	private List<Account> biExampleXRecordList {get; set;}
	
	// -------- Methods --------
	// Casting sObjects to actual object
	private List<Account> castTo(List<sObject> records) {
		List<Account> result = new List<Account>();
		
		for(sObject record : records) {
			result.add((Account)record);
		}
		
		return result;
	}
	
	// This method is specifically for defining which records qualify for the 
	// various operations that will take place; with our quick example its all
	// of them; Depending on the trigger type, the list or map will want to be
	// casted
	public override void qualifyStartingRecords(List<sObject> newList, 
		List<sObject> oldList, Map<ID, sObject> newMap, Map<ID, sObject> oldMap) {
		List<Account> casting = castTo(newList);
		biExampleXRecordList = casting;
		
		System.debug('=================================');
		System.debug('child qualifyStartingRecords called before insert');
		System.debug('biExampleXRecordList: ' + biExampleXRecordList);
		System.debug('=================================');
	}
	
	// This would be the start of our legitimate actions to happen on the 
	// trigger; 
		// For this example, I'll take the qualified list, make an account
		// with the same name plus "DUP", and save the account - this is only
		// for example, which will show the trigger refiring and calling
		// the qualifyReEntryRecords and reEntry methods
			// As qualifyReEntryRecords and reEntry and not overrideen in the
			// child, you will see the bebug output that the base methods are
			// being called but nothing is happening
	public override void start() {
		
		System.debug('=================================');
		System.debug('child start called before insert');
		System.debug('=================================');
		
		/*
		List<Account> dupAccountExample = new List<Account>();
		
		for(Account record : biExampleXRecordList) {
			Account newExample = new Account();
			newExample.Name = record.Name + 'DUP';
			dupAccountExample.add(newExample);
		}
		
		insert dupAccountExample;
		*/
	}
	
	// And for fun, we will do an optional override example where we show which
	// finishing method (from starting run or rentry run) occures
	public override void finish(Boolean fromStart) {
		System.debug('=================================');
		System.debug('child finish called before insert, from start? : ' + 
			fromStart);
		System.debug('=================================');
	}
	
	// -------- Internal Classes --------
	// None
}