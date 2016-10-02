package module.model;

import hex.model.BasicModel;
import hex.model.ModelDispatcher;
/**
 * ...
 * @author Petya
 */
class HelloWorldModel extends BasicModel<HelloWorldModelDispatcher, IHelloWorldModelListener> implements IHelloWorldModel
{
	public function new() 
	{
		super();
	}
}

private class HelloWorldModelDispatcher extends ModelDispatcher<IHelloWorldModelListener> implements IHelloWorldModelListener
{
	public function new() 
	{
		super();
	}
}