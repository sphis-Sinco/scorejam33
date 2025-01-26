package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

class Death extends FlxState
{
	override function create()
	{
		super.create();

		var ded:FlxText = new FlxText(0, 0, 0, "You ded died.");
		add(ded);
		ded.screenCenter();

		var redo:FlxButton = new FlxButton(0, 0, "Retry", () ->
		{
			FlxG.switchState(new PlayState());
		});
		redo.screenCenter();
		redo.y += ded.height + redo.height;
		add(redo);
	}
}