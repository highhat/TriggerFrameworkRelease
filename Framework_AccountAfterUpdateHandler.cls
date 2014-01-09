/*

Child of HandlerBase for handiling account trigger actions

Class:              Framework_AccountAfterUpdateHandler
Date:               12/20/2013
Version:            1
Last Updated:       12/20/2013
    * 	Stubbed for sample

This example is only to show the trigger using one line of script for multiple
events; See the Framework_AccountBeforeInsertHandler class for details on its
operation as these follow the same pattern
////////////////////////////////////////////////////////////////////////////////
*/

public with sharing class Framework_AccountAfterUpdateHandler extends 
	Framework_HandlerBase {
	
	// -------- Constants --------
	// None
	
	// -------- Constructor --------
	public Framework_AccountAfterUpdateHandler(){}
	
	// -------- Variables --------
	// None
	
	// -------- Properties --------
	// Qualified records
	private List<Account> qualifiedRecords {get; set;}
	
	// -------- Methods --------
	// Casting sObjects to actual object
	private List<Account> castTo(List<sObject> records) {
		List<Account> result = new List<Account>();
		
		for(sObject record : records) {
			result.add((Account)record);
		}
		
		return result;
	}
	
	// Qualify records
	public override void qualifyStartingRecords(List<sObject> newList, 
		List<sObject> oldList, Map<ID, sObject> newMap, Map<ID, sObject> oldMap) {
		
		List<Account> sampleCodeCoverage = castTo(newList);
		
		System.debug('=================================');
		System.debug('child qualifyStartingRecords called after update');
		System.debug('=================================');
	}
	
	// Start processing
	public override void start() {
		System.debug('=================================');
		System.debug('child start called after update');
		System.debug('=================================');
	}
	
	// -------- Internal Classes --------
	// None
}