package neko;

import module.model.IHelloWorldModelListener;

/**
 * ...
 * @author Francis Bourre
 */
class HelloWorldView implements IHelloWorldModelListener
{	
	public function new() {}
	
	public function onMessage( message : String ) : Void
	{
		trace( message );
		neko.Lib.print( message );
	}
}