package;

import flixel.FlxG;

class Save
{
	public static var HIGHSCORE:Int = 0;

	public static function updateValue(value:String, ?newvalue:Dynamic)
	{
		updateFlxGSaves();
		
		switch (value.toLowerCase())
		{
			case 'highscore', 'hiscore':
				try
				{
					HIGHSCORE = newvalue;
				}
				catch (e)
				{
					HIGHSCORE = (FlxG.save.data.hiscore > HIGHSCORE) ? FlxG.save.data.hiscore : 0;
					throw 'newvalue should be Int for field: ${value.toLowerCase()}';
				}
		}
		updateFlxGSaves();
	}

	private static function updateFlxGSaves()
	{
		FlxG.save.data.hiscore = HIGHSCORE;
	}
}