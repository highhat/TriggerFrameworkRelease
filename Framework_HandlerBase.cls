/*

Base handler class for framework triggers, which all handler classes extend

Class:              Framework_HandlerBase
Date:               12/19/2013
Version:            1
Last Updated:       12/19/2013
    * 	Stubbed for sample

// All handler classes extend this class and must implement required overrides;
// This class records if the handler is already running, and provides optional
// methods for overriding if needed; For example, the handler class must override
// qualifyStartingRecords or there is a save and runtime error, but they may
// choose to override qualifyReEntryRecords as most of the time they will not
// need the trigger to call back into itself

// Once implement in an instance, this class never needs changed 
// New line
////////////////////////////////////////////////////////////////////////////////
*/

public abstract class Framework_HandlerBase implements Framework_IHandler {
	
	// -------- Constants --------
	// None
	
	// -------- Constructor --------
    public Framework_HandlerBase(){}

    // -------- Variables --------
	// Record if running
	private Boolean initiaited = false;
	
	// -------- Properties --------
	// None
	
	// -------- Methods --------
	// Return if the handler is running
	public Boolean isRunning() {
		return initiaited;
	}
	
	// Set the running to true, called from the dispatcher
	public void startRunning() {
		initiaited = true;
	}
	
	// Set the running back to false, called from the dispatcher
	public void stopRunning() {
		initiaited = false;
	}
	
	// Required overrides
	public abstract void qualifyStartingRecords(List<sObject> newList, 
		List<sObject> oldList, Map<ID, sObject> newMap, Map<ID, sObject> oldMap);
	public abstract void start();
	
	// Optional overrides
	public virtual void qualifyReEntryRecords(List<sObject> newList, 
		List<sObject> oldList, Map<ID, sObject> newMap, 
		Map<ID, sObject> oldMap) {
		
		System.debug('=================================');
		System.debug('base qualify reentry called');
		System.debug('=================================');
	}
	
	public virtual void reEntry() {
		System.debug('=================================');
		System.debug('base rentry called');
		System.debug('=================================');
	}
	
	public virtual void finish(Boolean fromStart) {
		System.debug('=================================');
		System.debug('base finish called, from start? : ' + fromStart);
		System.debug('=================================');
	}
	
	// -------- Internal Classes --------
	// None
}