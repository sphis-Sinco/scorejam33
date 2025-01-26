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
	var player_offscreen_padding:Float = 16;

	var weapon_charge:Int = 0;
	var max_weapon_charge:Int = 10;

	var weaponChargeText:FlxText = new FlxText(0, 0, 0, "CHARGE: 69", 16);

	var bullet_group:FlxTypedGroup<FlxSprite> = new FlxTypedGroup<FlxSprite>();
	var bullet_offscreen_addition:Float = 16;

	override public function create()
	{
		add(bullet_group);
		add(player);

		player.screenCenter(XY);
		player.x -= player.width * 4;

		weaponChargeText.setPosition(8, 8);
		add(weaponChargeText);

		super.create();
	}
	var key_space:Bool;
	var key_z:Bool;

	var key_up:Bool;
	var key_down:Bool;

	override public function update(elapsed:Float)
	{
		key_space = FlxG.keys.justReleased.SPACE;
		key_z = FlxG.keys.justReleased.Z;

		key_up = FlxG.keys.pressed.UP;
		key_down = FlxG.keys.pressed.DOWN;

		if (key_up)
		{
			player.y -= 10;
			if (player.y < 0 + player_offscreen_padding)
				player.y = 0 + player_offscreen_padding;
		}
		if (key_down)
		{
			player.y += 10;
			if (player.y > FlxG.height - player.height - player_offscreen_padding)
				player.y = FlxG.height - player.height - player_offscreen_padding;
		}

		if (key_z)
		{
			weapon_charge++;
			if (weapon_charge > max_weapon_charge)
				weapon_charge = max_weapon_charge;
		}
		else if (key_space)
		{
			var new_bullet:FlxSprite = new FlxSprite();
			new_bullet.makeGraphic(24, 24, FlxColor.YELLOW);
			new_bullet.setPosition(player.x, player.y);
			new_bullet.ID = weapon_charge;
			bullet_group.add(new_bullet);
			weapon_charge = 0;
		}

		weaponChargeText.text = "CHARGE: " + weapon_charge;

		for (bullet in bullet_group)
		{
			try
			{
				bullet.x += bullet.width;
				if (bullet.x > FlxG.width + bullet_offscreen_addition)
				{
					bullet.destroy();
					bullet_group.members.remove(bullet);
				}
			}
			catch (e) {}
		}

		super.update(elapsed);
	}
}
