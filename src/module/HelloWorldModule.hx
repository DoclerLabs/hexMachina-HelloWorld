package module;

import hex.module.Module;
import module.model.HelloWorldModel;
import module.model.IHelloWorldModel;
import module.view.HelloWorldViewHelper;
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
		this.buildViewHelper( HelloWorldViewHelper, new js.view.HelloWorld( js.Browser.document.querySelector( ".infoField" ) ) );
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