package module.model;

import hex.event.ITrigger;
import hex.event.ITriggerOwner;

/**
 * ...
 * @author Petya
 */
interface IHelloWorldModel extends ITriggerOwner
{
	var listeners ( default, never ) : ITrigger<IHelloWorldModelListener>;
	function setMessage( message : String ) : Void;
}