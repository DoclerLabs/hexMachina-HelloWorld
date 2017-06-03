package flash;

import flash.Lib;
import flash.text.TextField;
import module.model.IHelloWorldModelListener;

class HelloWorldView implements IHelloWorldModelListener
{	
	public function new() {}
	
	public function onMessage( message : String ) : Void
	{
		trace( message );
		var stage = Lib.current.stage;
		var tf = new TextField();
		tf.text = message;
		stage.addChild( tf );
	}
}