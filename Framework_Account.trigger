/*

Trigger framework using accounts as an example

Class:              Framework_Account
Date:               12/20/2013
Version:            1
Last Updated:       12/20/2013
    * 	Stubbed for sample
    
////////////////////////////////////////////////////////////////////////////////
*/

// Any trigger will only contain one line of code with the framework, which is
// the execute call to the object Dispatcher class. In this example, we are
// running before insert and after update.
	// Combined with the visualforce page showing triggers running, a client
	// could confirm that another developer is not adding a second trigger on
	// an object
	
	// A developer using this trigger who adds an event, such as after update,
	// but does not follow the framework (implementing the 
	// Framework_AccountAfterUpdateHandler in this example), will have an error
	// thrown when trying to run the trigger, further enforcing the framework
	
	// For future additions to the same trigger, the only work here is to add
	// the event
trigger Framework_Account on Account (before insert, after update) {
	
	System.debug('==================================');
	System.debug('Trigger called');
	System.debug('==================================');
	
	Framework_AccountDispatcher.execute(Trigger.new, Trigger.old, 
		Trigger.newMap, Trigger.oldMap);
}