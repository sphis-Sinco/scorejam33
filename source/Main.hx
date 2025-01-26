package;

import flixel.FlxG;
import flixel.FlxGame;
import lime.app.Application;
import openfl.display.Sprite;

class Main extends Sprite
{
	public function new()
	{
		FlxG.save.bind('scorejam33', Application.current.meta.get('company'));
		FlxG.save.data.hiscore ??= 0;
		
		super();
		addChild(new FlxGame(0, 0, PlayState));
	}
}
