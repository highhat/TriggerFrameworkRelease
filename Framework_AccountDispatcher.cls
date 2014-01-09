/*

Dispatcher for accounts; This class is responsible for creating the handler
object and calling the handler based on the trigger execution context

Class:              Framework_AccountDispatcher
Date:               12/20/2013
Version:            1
Last Updated:       12/20/2013
    * 	Stubbed for sample

// This class is responsible for initializing the appropriate handler, and 
// calling the enforced, predefined methods. It provides us the following:

// Benefits:
	// Once implemented for an object, it never needs changed

	// To implement brand new for an object following our naming convention, the
	// file can literally be copied and pasted, and the only change needed is the
	// constant value OBJECT_TYPE; for example, changing Account to Contact
		// If the client has a specific naming convention we must follow, then
		// we can change the name assignment in the activateHandler method

// Order of operation:
	// On Execute (called from trigger), it calls the activateHandler to create
	// a handler instance of a predefined name; Note these are children of
	// Framework_HandlerBase, which implements the interface Framework_IHandler,
	// allowing us to assign any specific class initiated to one variable of
	// type Framework_IHandler
	
	// If the handler is null, as in the handler class 
	// Framework_AccountBeforeInsertHandler does not exist, the 
	// Framework_NoHandlerException is thrown;
	
	// If the handler already exists because the trigger is being reentered,
	// it retrieves the same handler class instance when it started
	
	// If the handler is not running, more on that in the Framework_HandlerBase,
	// the handler calls the enforced required method qualifyStartingRecords;
	// more on that in the specific handlers; Framework_AccountBeforeInsertHandler;
	// that the enforced required method start is called
	
	// If the handler is running, it calls the optional qualifyReEntryRecords
	// and optional reEntry methods in the specific handlers; More on that
	// in the Framework_HandlerBase
	
	// Finally, the handler calls the optional finished method, indicating if
	// its a finish from the original start or from the reentry
////////////////////////////////////////////////////////////////////////////////
*/

public class Framework_AccountDispatcher {
	// -------- Constants --------
	// Dispatcher object name; used for standard naming convention initilization
	// of the handler classes; This is the only thing that needs changed when
	// using this as a template
	private static final String OBJECT_TYPE = 'Account';
	
	// -------- Constructor --------
    // None

    // -------- Variables --------
    // Map for matching running handlers
    private static Map<String, Framework_IHandler> handlers = 
    	new Map<String, Framework_IHandler>();
    
	// -------- Properties --------
	// None
	
	// -------- Methods --------
	// Only method called from the trigger; this determines the handler to
	// create and calls the methods in the handler based on its status
	public static void execute(List<sObject> newList, List<sObject> oldList, 
		Map<ID, sObject> newMap, Map<ID, sObject> oldMap) {
		
		Framework_IHandler handler = activateHandler();
		
		if(handler == null) {
			throw new Framework_NoHandlerException('Handler is Null');
		} else {
			System.debug('=================================');
			System.debug('handlers: ' + handlers);
			System.debug('=================================');
				
			if(!handler.isRunning()) {
				System.debug('=================================');
				System.debug('handler is not running');
				System.debug('=================================');
					
				handler.startRunning();
				handler.qualifyStartingRecords(newList, oldList, newMap, oldMap);
				handler.start();
				handler.finish(true);
				handler.stopRunning();
			} else {
				System.debug('=================================');
				System.debug('handler is running');
				System.debug('=================================');
				
				handler.qualifyReEntryRecords(newList, oldList, newMap, oldMap);
				handler.reEntry();
				handler.finish(false);
			}
		}
	}
	
	// Return the appropriate handler if exists, or creates a new one
	private static Framework_IHandler activateHandler() {
		Framework_IHandler result;
		String handlerName = '';
		
		if(Trigger.isBefore) {
			if(Trigger.isInsert) {
				handlerName = 'Framework_' + OBJECT_TYPE + 'BeforeInsertHandler';
				
				if(handlers.containsKey(handlerName)) {
					result = handlers.get(handlerName);
				}
			} else if(Trigger.isUpdate) {
				handlerName = 'Framework_' + OBJECT_TYPE + 'BeforeUpdateHandler';
				
				if(handlers.containsKey(handlerName)) {
					result = handlers.get(handlerName);
				}
			} else if (Trigger.isDelete) {
				handlerName = 'Framework_' + OBJECT_TYPE + 'BeforeDeleteHandler';
				
				if(handlers.containsKey(handlerName)) {
					result = handlers.get(handlerName);
				}
			}
		} else if(Trigger.isAfter) {
			if(Trigger.isInsert) {
				handlerName = 'Framework_' + OBJECT_TYPE + 'AfterInsertHandler';
				
				if(handlers.containsKey(handlerName)) {
					result = handlers.get(handlerName);
				}
			} else if(Trigger.isUpdate) {
				handlerName = 'Framework_' + OBJECT_TYPE + 'AfterUpdateHandler';
				
				if(handlers.containsKey(handlerName)) {
					result = handlers.get(handlerName);
				}
			} else if (Trigger.isDelete) {
				handlerName = 'Framework_' + OBJECT_TYPE + 'AfterDeleteHandler';
				
				if(handlers.containsKey(handlerName)) {
					result = handlers.get(handlerName);
				}
			} else if(Trigger.isUnDelete) {
				handlerName = 'Framework_' + OBJECT_TYPE + 'AfterUnDeleteHandler';
				
				if(handlers.containsKey(handlerName)) {
					result = handlers.get(handlerName);
				}
			}
		} 
		
		if(result == null) {
			Type classType = Type.forName(handlerName);
			result = (classType == null) ? null : 
				(Framework_IHandler)classType.newInstance();
			handlers.put(handlerName, result);
		}
		
		return result;
	}
	
	// For other classes to determine if a handler is running
	public static Boolean isHandlerRunning(String handlerName) {
		Boolean result = false;
		
		if(handlers.containsKey(handlerName)) {
			result = handlers.get(handlerName).isRunning();
		}
		
		return result;
	}
	
	// For resetting the trigger dispatcher during testing
	@TestVisible
	private static Boolean resetHandler(String handlerName) {
		Boolean result = false;
		
		Framework_IHandler handler = handlers.get(handlerName);
		
		if(handler != null) {
			handler.stopRunning();
			result = true;
		}
		
		return result;
	}
	
	// -------- Internal Classes --------
	// None
}