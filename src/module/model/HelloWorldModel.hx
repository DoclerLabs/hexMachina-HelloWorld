package module.model;
import hex.event.ITrigger;

/**
 * ...
 * @author Petya
 */
class HelloWorldModel implements IHelloWorldModel
{
	public var listeners ( default, never ) : ITrigger<IHelloWorldModelListener>;
	
	public function new() 
	{
		
	}

	public function setMessage( message : String ) : Void 
	{
		this.listeners.onMessage( message );
	}
}