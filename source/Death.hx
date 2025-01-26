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

		FlxG.save.data.hiscore = (PlayState.SCORE > PlayState.HISCORE) ? PlayState.SCORE : PlayState.HISCORE;

		var ded:FlxText = new FlxText(0, 0, 0, "You ded died at " + FlxG.save.data.hiscore);
		add(ded);
		ded.screenCenter();

		var redo:FlxButton = new FlxButton(0, 0, "Retry", () ->
		{
			PlayState.SCORE = 0;
			FlxG.switchState(new PlayState());
		});
		redo.screenCenter();
		redo.y += ded.height + redo.height;
		add(redo);
	}
}