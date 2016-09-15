package module;

import hex.module.Module;
import model.HelloWorldModel;
import model.IHelloWorldModel;
import view.HelloWorldViewHelper;
import hex.config.stateless.StatelessModelConfig;
import hex.config.stateless.StatelessCommandConfig;

/**
 * ...
 * @author Petya
 */
class HelloWorldModule extends Module implements IHelloWorldModule
{

	public function new() 
	{
		super();
		this._addStatelessConfigClasses( [ HelloWorldCommandConfig, HelloWorldModelConfig ] );
		this.buildView();
	}
	
	function buildView() : Void
	{
		this.buildViewHelper( HelloWorldViewHelper, new view.HelloWorldJS( js.Browser.document.querySelector( ".infoField" ) ) );
	}
}

private class HelloWorldCommandConfig extends StatelessCommandConfig
{
	override public function configure():Void
	{
		
	}
}

private class HelloWorldModelConfig extends StatelessModelConfig
{
	override public function configure() : Void
	{
		this.map( IHelloWorldModel, HelloWorldModel );
	}
}