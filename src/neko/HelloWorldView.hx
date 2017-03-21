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
		neko.Lib.print( message );
	}
}