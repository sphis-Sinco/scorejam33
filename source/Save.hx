package;

import flixel.FlxG;

class Save
{
	public static var HIGHSCORE:Int = 0;

	public static function updateValue(value:String, ?newvalue:Dynamic, ?pos:haxe.PosInfos)
	{
		var errors:Array<String> = [];

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
					errors.push('newvalue should be Int for highscore field. Given value: "${newvalue}"');
				}
		}
		if (errors.length != 0)
		{
			trace('${errors.length} error(s) found while updating save values:');

			for (err in errors)
			{
				trace('- $err');
			}
		}

		updateFlxGSaves();
	}

	private static function updateFlxGSaves()
	{
		FlxG.save.data.hiscore = HIGHSCORE;
	}
}