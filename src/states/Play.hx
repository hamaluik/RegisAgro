package states;

import luxe.States;
import luxe.Scene;
import luxe.Vector;

class Play extends State {
	var lastStateScene:Scene;
	var stateScene:Scene;

	public function new() {
		super({ name: 'Play' });
		stateScene = new Scene('Play');
	}

	override function onenter<T>(_:T) {
		Luxe.camera.center = new Vector();
		lastStateScene = Luxe.scene;
		Luxe.scene = stateScene;
	}

	override function onleave<T>(_:T) {
		stateScene.empty();
		Luxe.scene = lastStateScene;
	}
}