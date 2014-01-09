/*

Handler interface, listing the required methods for implementation

Class:              Framework_IHandler
Date:               12/19/2013
Version:            1
Last Updated:       12/19/2013
    * 	Stubbed for sample

// This is simply for listing the required methods and for using as the var
// type when a handler is created in the Framework_AccountDispatcher class;
// On any implementation, this never needs changed
////////////////////////////////////////////////////////////////////////////////
*/

public interface Framework_IHandler {
	Boolean isRunning();
	void startRunning();
	void stopRunning();
	void qualifyStartingRecords(List<sObject> newList, List<sObject> oldList, 
		Map<ID, sObject> newMap, Map<ID, sObject> oldMap);
	void start();
	void qualifyReEntryRecords(List<sObject> newList, List<sObject> oldList, 
		Map<ID, sObject> newMap, Map<ID, sObject> oldMap);
	void reEntry();
	void finish(Boolean fromStart);
}