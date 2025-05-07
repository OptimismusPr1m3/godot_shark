class_name MovableObject extends CharacterBody2D

var movementSpeed: float = 1.0
var was_hit: bool = false
var health: int = 100
var coins: int = 0
var potions: int = 0
var isAggro: bool = false
var isAggroTrans: bool = false
var hasSlapped: bool = false
var isColliding: bool = false
var isDead: bool = false
var dieAnimationCount = 0
var hasLaunched: bool = false
var isSlapping: bool = false
var isAttacking: bool = false

func moveChar(direction: Vector2, sprite: AnimatedSprite2D, swimAnim: String, idleAnim: String):
	if direction != Vector2.ZERO:
		velocity = direction * 100 * movementSpeed
		if !was_hit && !hasSlapped && !hasLaunched && !isSlapping:
			sprite.play(swimAnim)
		if direction.x != 0:
			sprite.flip_h = direction.x < 0
	else:
		velocity = Vector2.ZERO
		if !was_hit && !hasSlapped && !hasLaunched && !isSlapping:
			sprite.play(idleAnim)

func hit(damage: int, sprite: AnimatedSprite2D, hurtAnim: String):
	print('Got dmg: ', damage)
	health -= damage
	was_hit = true
	sprite.play(hurtAnim)

func checkHealth():
	if health <=0:
		isDead = true
