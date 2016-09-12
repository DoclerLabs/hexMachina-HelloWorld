package model;
import hex.model.Model;
import hex.model.ModelDispatcher;
/**
 * ...
 * @author Petya
 */
class HelloWorldModel extends Model<HelloWorldModelDispatcher, IHelloWorldModelListener> implements IHelloWorldModel
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