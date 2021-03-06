package js;

import js.Browser;
import js.html.Text;
import module.model.IHelloWorldModelListener;

/**
 * ...
 * @author Petya
 */
class HelloWorldView implements IHelloWorldModelListener
{	
	public function new() {}
	
	public function onMessage( message : String ) : Void
	{
		trace( message );
		Browser.document.body.appendChild( new Text( message ) );
	}
}