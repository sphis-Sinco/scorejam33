package;

import flixel.FlxG;
import flixel.FlxGame;
import lime.app.Application;
import openfl.display.Sprite;

class Main extends Sprite
{
	public function new()
	{
		FlxG.save.bind('chargedblast', Application.current.meta.get('company'));
		Save.updateValue('highscore');
		
		super();
		addChild(new FlxGame(0, 0, PlayState));
	}
}
