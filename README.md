# Berkzitti Pinball

A pinball-machine roguelike, built in Godot 4. This repo is the MVP — a single playable table with flippers, bumpers, scoring, and ball draining. Roguelike progression layers will be added on top.

## Run

1. Install [Godot 4.3+](https://godotengine.org/download).
2. Open Godot, click **Import**, and select this folder's `project.godot`.
3. Press **F5** (or the play button) to run.

## Controls

| Action | Key |
|---|---|
| Left flipper  | `A` or `Left Arrow` |
| Right flipper | `D` or `Right Arrow` |
| Launch ball   | `Space` |
| Restart       | `R` |

## What's in the MVP

- 720x1280 vertical playfield with side walls, slanted bottom guides, and a plunger lane on the right.
- Two `AnimatableBody2D` flippers that snap up while the input is held.
- Three `Area2D` bumpers that push the ball outward, flash on hit, and award points (100 / 100 / 150).
- A `RigidBody2D` ball with capped max speed and a launch impulse.
- 3 balls per game, score HUD, drain detection, and game-over restart.

## Project layout

```
project.godot         # Godot project config + input map
icon.svg              # App icon
scenes/
  main.tscn           # Playfield, walls, bumpers, flippers, HUD
  ball.tscn           # RigidBody2D ball
  flipper.tscn        # AnimatableBody2D flipper (mirrored via is_left)
  bumper.tscn         # Area2D bumper
scripts/
  main.gd             # Game state: score, balls, spawning, draining
  ball.gd             # Speed cap + draw
  flipper.gd          # Rotation snap based on input
  bumper.gd           # Impulse + flash + score
```

## Physics layers

| Layer | Used for |
|---|---|
| 1 | Walls |
| 2 | Ball |
| 3 | Bumpers (Area2D) |
| 4 | Flippers |

The ball masks layers 1, 3, and 4 so it collides with walls and flippers and is detected by bumpers.

## Roadmap (post-MVP)

- Plunger with chargeable launch power.
- Multiple table layouts / room transitions.
- Per-run upgrades: extra balls, multipliers, new bumper types, flipper mods.
- Enemy / target objects that take damage from ball impacts.
- Meta-progression between runs.
