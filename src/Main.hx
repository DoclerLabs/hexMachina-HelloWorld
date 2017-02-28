package;

import hex.compiler.parser.xml.XmlCompiler;

/**
 * ...
 * @author Petya
 */
class Main 
{
	static var self : Main;
	
	public static function main()
	{
		self = new Main();
	}
	
	public function new()
	{
		XmlCompiler.compile( "configuration/context.xml" );
	}
	
}
