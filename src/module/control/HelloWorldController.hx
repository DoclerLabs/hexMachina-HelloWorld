package module.control;

import hex.control.trigger.ICommandTrigger;
import module.control.IHelloWorldController;
import module.model.IHelloWorldModel;

/**
 * ...
 * @author Francis Bourre
 */
class HelloWorldController implements ICommandTrigger implements IHelloWorldController
{
	public function new() {}
	
	public function sayHello( who : String ) : Void
	{
		@Inject
		var model : IHelloWorldModel;
		model.setMessage( 'hello ' + who );
	}
}