package;

import flixel.FlxG;

class Save
{
	public static var HIGHSCORE:Int = 0;

	public static function updateValue(value:String, ?newvalue:Dynamic)
	{
		switch (value.toLowerCase())
		{
			case 'highscore', 'hiscore':
				if (newvalue == Float)
				{
					HIGHSCORE = newvalue;
					HIGHSCORE ??= 0;
					FlxG.save.data.hiscore = HIGHSCORE;
				}
				else
				{
					throw 'newvalue should be Float for field: ${value.toLowerCase()}';
				}
		}
	}
}