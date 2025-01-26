package;

import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
	var player:FlxSprite = new FlxSprite(0, 0).makeGraphic(32, 32, FlxColor.LIME);

	var weapon_charge:Int = 0;
	var max_weapon_charge:Int = 10;

	var bullet_group:FlxTypedGroup<FlxSprite> = new FlxTypedGroup<FlxSprite>();

	override public function create()
	{
		add(bullet_group);
		add(player);

		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
