# Thrower Alchemist

Thrower Alchemist is a game where you play as an alchemist exploring dungeons with your potions! Your mission is to reach the end and gather materials to upgrade your potions and grow stronger. Will greed lead you to lose everything, or will you become the alchemist with the best potions in the world?

## How to play

- WASD: Move
- Move mouse: Aim
- Left-click: Throw potion selected in the hotbar
- E: Interact with object
- Shift: Dash
- TAB: Pause
- Keys 1–4: Select hotbar slot

## How to mix potions

Since the tutorial doesn't clearly explain how to use potions, here is how the interface works:

Select the potion you want to place in the mixer from your hotbar (it can go in slot 1 or 2), then click the corresponding slot in the potion mixer to place it there. Once you have two potions in place, press the "join" button to mix them.

If you want to retrieve your potion, simply select an empty slot on your hotbar or swap it with another potion.

Remember to mix your potions well :)

## What tools did I use?

- **Game Engine**: Godot Engine 4.7
- **Drawing App**: Aseprite
- **Animations App**: Pixel Composer

## How did I make it?

I created this project to learn how to use composition instead of inheritance when structuring my classes, which helped me develop a highly organized and modular workflow.

Here is how I organized the process:

- First, I implemented the basic mechanics (health, movement, hitboxes, the main character, etc.).

- After the basics were in place, I developed the features that make the game unique: the potions and the potion-combining system.

- Next, I built the potion-mixing machine and its associated UI.

- Then, I created the interaction system to allow the player to use the mixing machine and pick up potions from the ground.

- I then created a test character (a slime) to verify that the combat and other systems were working correctly (and to learn how to use the LimboAI library).

- Finally, after finishing the core mechanics, I created the tilemap for the game world and built a tutorial level to teach players the ropes.

- I then added sound effects (SFX) to various elements.

- To wrap up the game itself, I added the death screen, health bar, and pause menu.

- Lastly, I designed the game's logo and cover art for itch.io.

That’s all for the current development of Thrower Alchemist; I plan to update it in the future!

## How to start the development environment

Since it's a Godot project, it's as simple as downloading Godot Engine 4.7 and importing the project folder into Godot!
