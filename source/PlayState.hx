package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
	var player:FlxSprite = new FlxSprite(0, 0).makeGraphic(32, 32, FlxColor.LIME);

	var weapon_charge:Int = 0;
	var max_weapon_charge:Int = 10;

	var weaponChargeText:FlxText = new FlxText(0, 0, 0, "CHARGE: 69", 16);

	var bullet_group:FlxTypedGroup<FlxSprite> = new FlxTypedGroup<FlxSprite>();

	override public function create()
	{
		add(bullet_group);
		add(player);

		weaponChargeText.setPosition(8, 8);
		add(weaponChargeText);

		super.create();
	}
	var key_space:Bool;

	override public function update(elapsed:Float)
	{
		key_space = FlxG.keys.justReleased.SPACE;

		if (key_space)
		{
			weapon_charge++;
			if (weapon_charge > max_weapon_charge)
				weapon_charge = max_weapon_charge;
		}

		weaponChargeText.text = "CHARGE: " + weapon_charge;

		super.update(elapsed);
	}
}
