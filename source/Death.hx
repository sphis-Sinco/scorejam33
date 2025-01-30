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

		Save.updateValue('highscore', (PlayState.SCORE > PlayState.HISCORE) ? PlayState.SCORE : PlayState.HISCORE);

		var ded:FlxText = new FlxText(0, 0, 0, "You ded died at " + PlayState.SCORE, 32);
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