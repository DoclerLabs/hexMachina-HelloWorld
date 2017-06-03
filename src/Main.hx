package;

import hex.compiletime.xml.BasicStaticXmlCompiler;
import hex.runtime.ApplicationAssembler;

/**
 * ...
 * @author Petya
 */
class Main 
{
	public static function main()
	{
		// convert XML DSL to haxe code by Macro
		var code = BasicStaticXmlCompiler.compile( new ApplicationAssembler(), "configuration/context.xml" );
		// run code
		code.execute();
	}
}
