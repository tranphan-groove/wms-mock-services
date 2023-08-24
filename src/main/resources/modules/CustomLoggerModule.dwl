%dw 2.0

fun generateLogger(priority, flowName, tracePoint, logMessage, payload: Any, error: Any, correlationId, vars: Any, attributes: Any) = {
	
	"correlationId": correlationId,
	"message": logMessage,
	"tracePoint": tracePoint,
	"priority": priority,
	
	"locationInfo": {
		
		"component": "mulesoft logger",
		"flow": flowName,		
	},
	"timestamp": (now() >> "Australia/Brisbane") as String,
	
	"content": {
		(payload: payload) if(payload != null),
		("attributes" : attributes) if(attributes != null),
    	("variables" : vars) if(vars != null)
		//("payload": payload) if((payload != null) and (lower(priority) == "debug")),
	},
	
	"applicationName": Mule::p('json.logger.application.name'),
	"applicationVersion" : Mule::p('json.logger.application.version'),
	"environment": Mule::p('mule.env'),
	threadName: write(java!java::lang::Thread::currentThread(),"application/java"),
		
	// Populating KeyFields
	// Currently there is a provision for logging 8 KeyFields. Currently it seems to be enough to capture the state of a transaction.
	("$(Mule::p('logger.keyFields.keyField01'))": vars[Mule::p('logger.keyFields.keyField01')]) 
					if(!isEmpty(Mule::p('json.logger.keyFields.keyField01')) and !isEmpty(vars[Mule::p('json.logger.keyFields.keyField01')])),
	("$(Mule::p('json.logger.keyFields.keyField02'))": vars[Mule::p('json.logger.keyFields.keyField02')]) 
					if(!isEmpty(Mule::p('json.logger.keyFields.keyField02')) and !isEmpty(vars[Mule::p('json.logger.keyFields.keyField02')])),
	("$(Mule::p('json.logger.keyFields.keyField03'))": vars[Mule::p('json.logger.keyFields.keyField03')]) 
					if(!isEmpty(Mule::p('json.logger.keyFields.keyField03')) and !isEmpty(vars[Mule::p('json.logger.keyFields.keyField03')])),
	("$(Mule::p('json.logger.keyFields.keyField04'))": vars[Mule::p('json.logger.keyFields.keyField04')]) 
					if(!isEmpty(Mule::p('json.logger.keyFields.keyField04')) and !isEmpty(vars[Mule::p('json.logger.keyFields.keyField04')])),
	("$(Mule::p('json.logger.keyFields.keyField05'))": vars[Mule::p('json.logger.keyFields.keyField05')]) 
					if(!isEmpty(Mule::p('json.logger.keyFields.keyField05')) and !isEmpty(vars[Mule::p('json.logger.keyFields.keyField05')])),
	("$(Mule::p('json.logger.keyFields.keyField06'))": vars[Mule::p('json.logger.keyFields.keyField06')]) 
					if(!isEmpty(Mule::p('json.logger.keyFields.keyField06')) and !isEmpty(vars[Mule::p('json.logger.keyFields.keyField06')])),
	("$(Mule::p('json.logger.keyFields.keyField07'))": vars[Mule::p('json.logger.keyFields.keyField07')]) 
					if(!isEmpty(Mule::p('json.logger.keyFields.keyField07')) and !isEmpty(vars[Mule::p('json.logger.keyFields.keyField07')])),
	("$(Mule::p('json.logger.keyFields.keyField08'))": vars[Mule::p('json.logger.keyFields.keyField08')]) 
					if(!isEmpty(Mule::p('json.logger.keyFields.keyField08')) and !isEmpty(vars[Mule::p('json.logger.keyFields.keyField08')])),
					
	
	
	// Mapping error object. Please check the if condition at the end!!
	("error": {"errorType": error.errorType,
					"childErrors": error.childErrors ,
					"errorMessage": error.errorMessage,
					"cause": (error.cause mapObject (value, key) -> (
						// Ignoring "stackTrace" and "suppressed" elements because of two reasons:
						// 1. They increase the log message size beyond 8192 characters. Dynatrace trims any message beyond 8192 chars
						// 2. These elements contains Java stack trace, which mostly is not useful in debugging MuleSoft errors  
						if(!(key startsWith "cause") and !(key startsWith "stackTrace") and !(key startsWith "suppressed")) {
							(key): (value)
						} else {
							(	
								if(key startsWith "cause") {
									("cause": (value mapObject(v,k) -> (
										// Ignore nested "cause" elements because Mule tends to repeat the elements. So there is no benefit in logging those nested causes 
										if(!(key startsWith "cause") and !(key startsWith "stackTrace") and !(key startsWith "suppressed")) {
											(key): (value)
										} else { }
									)))
								} else {}
								
							)
						}
					)),
					"description": error.description,
					"detailedDescription": error.detailedDescription,
					"failingComponent": error.failingComponent }) if((error != null) and (lower(priority) == "error")) 
				 
}

fun testfun() = "This is a test function"