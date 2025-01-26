package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
	public static var SCORE:Int = 0;
	public static var HISCORE:Int = 0;
	var score_text:FlxText = new FlxText(8, 16, 0, "Score: 0", 16);
	var hiscore_text:FlxText = new FlxText(8, 32, 0, "Hi Score: 0", 16);

	var player:FlxSprite = new FlxSprite(0, 0).makeGraphic(32, 32, FlxColor.LIME);
	var player_offscreen_padding:Float = 16;

	var weapon_charge:Int = 0;
	var max_weapon_charge:Int = 10;

	var weaponChargeText:FlxText = new FlxText(0, 0, 0, "CHARGE: 69", 16);

	var bullet_group:FlxTypedGroup<FlxSprite> = new FlxTypedGroup<FlxSprite>();
	var bullet_offscreen_addition:Float = 16;

	var enemies_group:FlxTypedGroup<FlxSprite> = new FlxTypedGroup<FlxSprite>();
	var enemy_offscreen_padding:Float = 64;

	override public function create()
	{
		HISCORE = FlxG.save.data.hiscore;

		add(bullet_group);
		add(player);
		add(enemies_group);

		player.screenCenter(XY);
		player.x -= player.width * 4;

		weaponChargeText.setPosition(8, 0);
		add(weaponChargeText);

		add(score_text);
		add(hiscore_text);

		super.create();
	}
	var key_space:Bool;
	var key_z:Bool;

	var key_up:Bool;
	var key_down:Bool;

	override public function update(elapsed:Float)
	{
		score_text.text = "SCORE: " + SCORE;
		hiscore_text.text = "HIGH SCORE: " + HISCORE;
		score_text.color = (SCORE > HISCORE) ? FlxColor.LIME : 0xffffff;

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

		if (FlxG.random.int(0, 20) == 10)
		{
			var new_enemy:FlxSprite = new FlxSprite();

			new_enemy.makeGraphic(40, 40, FlxColor.RED);

			new_enemy.setPosition(FlxG.width + new_enemy.width * 2, player.y + FlxG.random.float(-60, 60));
			if (new_enemy.y < 0 + enemy_offscreen_padding)
				new_enemy.y = 0 + enemy_offscreen_padding;
			if (new_enemy.y > FlxG.height - new_enemy.height - enemy_offscreen_padding)
				new_enemy.y = FlxG.height - new_enemy.height - enemy_offscreen_padding;

			enemies_group.add(new_enemy);
		}

		for (enemy in enemies_group.members)
		{
			try
			{
				enemy.x -= enemy.width / 6;

				if (enemy.x < 0 - enemy.width * 2)
				{
					enemy.destroy();
					enemies_group.members.remove(enemy);
				}
				for (bullet in bullet_group.members)
				{
					if (enemy.overlaps(bullet))
					{
						SCORE += 100 * bullet.ID;

						enemy.destroy();
						enemies_group.members.remove(enemy);
						if (bullet.ID == 0)
						{
							bullet.destroy();
							bullet_group.members.remove(bullet);
						}
						else
						{
							bullet.ID--;
						}
					}
				}
				if (enemy.overlaps(player))
					FlxG.switchState(new Death());
			}
			catch (e)
			{
				trace(e);
			}
		}

		super.update(elapsed);
	}
}
