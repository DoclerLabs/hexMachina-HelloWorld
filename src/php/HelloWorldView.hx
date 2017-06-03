package php;

import module.model.IHelloWorldModelListener;

class HelloWorldView implements IHelloWorldModelListener
{	
	public function new() {}
	
	public function onMessage( message : String ) : Void
	{
		trace( message );
		php.Lib.print( message );
	}
}