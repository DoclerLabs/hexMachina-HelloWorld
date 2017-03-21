package module;

import hex.module.ContextModule;
import module.control.HelloWorldController;
import module.control.IHelloWorldController;
import module.model.HelloWorldModel;
import module.model.IHelloWorldModel;

/**
 * ...
 * @author Petya
 */
class HelloWorldModule extends ContextModule
{
	public function new( view ) 
	{
		super();

		this._map( IHelloWorldController, HelloWorldController, '', true );
		this._map( IHelloWorldModel, HelloWorldModel, '', true );

		this._get( IHelloWorldModel ).listeners.connect( view );
	}
	
	override function _onInitialisation() : Void 
	{
		this._get( IHelloWorldController ).sayHello( 'world' );
	}
}