# hexHelloWorld
Hello World project for hexMachina
Find more information about hexMachina on [hexmachina.org](http://hexmachina.org)

0. [install Haxe](http://haxe.org/download/) minimum support Haxe 3.4
1. download or clone git project `git clone https://github.com/DoclerLabs/hexMachina-HelloWorld.git`
2. in folder `cd hexMachina-HelloWorld`
3. install hexMachina framework with haxelib, locally in .haxelib folder `haxelib newrepo && haxelib install build/build.hxml`
4. Compile JavaScript target with [HXML](http://haxe.org/manual/compiler-usage-hxml.html) `haxe build/build-js.hxml`
5. Open index.html file in the bin folder to see the result of your build: 'Hello World'!

## Project structure
* Entry point -> [Main](https://github.com/DoclerLabs/hexMachina-HelloWorld/blob/master/src/Main.hx)
* DSL in xml file -> [configuration/context.xml](https://github.com/DoclerLabs/hexMachina-HelloWorld/blob/master/src/configuration/context.xml)
* view for Javascript target -> [js.HelloWorldView](https://github.com/DoclerLabs/hexMachina-HelloWorld/blob/master/src/js/HelloWorldView.hx)
* view for Neko target -> [neko.HelloWorldView](https://github.com/DoclerLabs/hexMachina-HelloWorld/blob/master/src/neko/HelloWorldView.hx)
* view for PHP target -> [php.HelloWorldView](https://github.com/DoclerLabs/hexMachina-HelloWorld/blob/master/src/php/HelloWorldView.hx)
* view for Flash target -> [flash.HelloWorldView](https://github.com/DoclerLabs/hexMachina-HelloWorld/blob/master/src/flash/HelloWorldView.hx)
* module -> [module.HelloWorldModule](https://github.com/DoclerLabs/hexMachina-HelloWorld/blob/master/src/module/HelloWorldModule.hx)

## Compile and run
The project can compile in Javascript, Flash, PHP and Neko targets. 
### Neko
```bash
# compile and run
haxe build/build-neko.hxml && neko bin/helloWorld.n
```
### PHP
```bash
# compile and run on Mac or Linux
haxe build/build-php.hxml && php bin/helloWorld-php/index.php
```
### JS
```bash
# compile and run
haxe build/build-js.hxml && open bin/index.html
```

### Flash
```bash
# compile and run
haxe build/build-flash.hxml && open bin/helloWorld.swf
```

## What happen ?
### At compiletime 
```haxe
var code = BasicStaticXmlCompiler.compile( new ApplicationAssembler(), "configuration/context.xml" );
```
When we compile the project, the XML file is converted in pure haxe code, and `code` variable contains the applicationContext describe in XML. 

### code.execute()
At runtime, when we call `code.execute();`, everything describe in DSL is executed (build objects, call methods, initialize modules...)

### configuration/context.xml
By default, HexMachina support two ways to describe DSL : 
* XML, the one used in HelloWorld example; [Xml DSL](https://github.com/DoclerLabs/hexDSL/blob/master/src/hex/compiletime/xml/README.md)
* Flow, mimic haxe language syntax, [Flow DSL](https://github.com/DoclerLabs/hexDSL/blob/master/src/hex/compiletime/flow/README.md)
The DSL describes configure of the application. 

In Hello World example, DSL usage is limited to one view instantiation passe in the constructor of `HelloWorldModule`. [configuration/context.xml](https://github.com/DoclerLabs/hexMachina-HelloWorld/blob/master/src/configuration/context.xml)

DSL support conditional compiler, in this project is used to select which view class should be used by targets, based on **Compiler Flag**. 
```xml
<view if="target-js" id="view" type="js.HelloWorldView" />
<view if="target-neko" id="view" type="neko.HelloWorldView"/>
<view if="target-php" id="view" type="php.HelloWorldView"/>
<view if="target-flash" id="view" type="flash.HelloWorldView"/>
```
If you look into `build-js.hxml`, you will see : 
```bash
-D target-js
-D target-neko=false
-D target-php=false
-D target-flash=false
```
When we compile the project with `build-js.hxml`, `view` will be an instance of `js.HelloWorldView`, the other view will be ignored base on `if` attribute value. 

And the `view` is passed as a constructor argument in `HelloWorldModule`. 

Let see the final result of XML convert in Haxe and compile to JavaScript : 
```xml
<module id="module" type="module.HelloWorldModule">
    <argument ref="view" />
</module>

<view if="target-js" id="view" type="js.HelloWorldView" />
<view if="target-neko" id="view" type="neko.HelloWorldView"/>
<view if="target-php" id="view" type="php.HelloWorldView"/>
<view if="target-flash" id="view" type="flash.HelloWorldView"/>
```

```javascript
var view = new js_HelloWorldView();
coreFactory.register("view",view);
this.view = view;
var module1 = new module_HelloWorldModule(view);
coreFactory.register("module",module1);
this.module = module1;
```
### HelloWorldModule
hexMachina is organised around modules. 
A module could be seen as a micro-application, use to encapsulate our code, everything in the module is private. 
A module has is own domain, eventBus, controllers, models, injector, logger, not accessible outside themselves. 

In `HelloWorldModule` constructor, we map `HelloWorldController` and `HelloWorldModel` as `Singleton` in the module injector. 
With that configuration, each time we will require `HelloWorldController` or `HelloWorldModel`, we aks injector to return the instance map by key (`IHelloWorldController`, `IHelloWorldModel`), like `this._injector.getInstance( IHelloWorldModel, '' )`. Instanciation will be done at the first `getInstance` call. 

Now, the model and the module controller are mapped, the next step is to link model and view (passed in the constructor from DSL). 
For that we will use hexMachina triggers (describe below).  
```haxe
public function new( view ) 
{
    super();

    this._map( IHelloWorldController, HelloWorldController, '', true );
    this._map( IHelloWorldModel, HelloWorldModel, '', true );

    this._get( IHelloWorldModel ).listeners.connect( view );
}
```

### HelloWorldController
HelloWorldController only contains one method, uses to set message in the model. 
As we can see, `HelloWorldModel` instance can be got by injection, the one map in `HelloWorldModule` constructor. 
```haxe
public function sayHello( who : String ) : Void
{
    @Inject
    var model : IHelloWorldModel;
    model.setMessage( 'hello ' + who );
}
```

### HelloWorldModel
In our HelloWorld example the model, each time that `setMessage` is called, we execute `onMessage` on every `listeners` connected by trigger (remember `this._get( IHelloWorldModel ).listeners.connect( view )` in module constructor). 
```haxe
public var listeners ( default, never ) : ITrigger<IHelloWorldModelListener>;

public function new() {}

public function setMessage( message : String ) : Void 
{
    this.listeners.onMessage( message );
}
```

### In nutshell
* **bin/helloWorld.js** is loaded in html;
* `Main.main` is called
* then `code.execute()` does everything describe in DSL; 
* when everything is instancied, `module.initialize()` is called by DSL;
* then `this._get( IHelloWorldController ).sayHello( 'world' );` is executed in the module; 
* then `model.setMessage( 'hello ' + who );` is executed in the controller;
* then `this.listeners.onMessage( message );` is executed in the model;
* and finally `onMessage` is called on target view. 
