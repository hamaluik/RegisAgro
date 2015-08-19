import effects.GlitchEffect;
import luxe.Input;
import luxe.States;
import luxe.Parcel;
import luxe.ParcelProgress;

import effects.Effects;
import effects.VignetteEffect;

class Main extends luxe.Game {
	private static var fsm:States;
	var effects:Effects = new Effects();

    override function config(config:luxe.AppConfig) {
        config.preload.jsons.push({ id: 'assets/parcel.json' });
        return config;
    } // config

	override function ready() {
		var parcel = new Parcel();
		parcel.from_json(Luxe.resources.json('assets/parcel.json').asset.json);
		new ParcelProgress({
			parcel: parcel,
			oncomplete: assetsLoaded
		});
		parcel.load();
	} //ready

	function assetsLoaded(_) {
		Luxe.renderer.clear_color = new luxe.Color(0.5, 0.5, 0.5, 1);
		
		// set up the VFX
		effects.onload();
		effects.addEffect(new VignetteEffect());
		effects.addEffect(new GlitchEffect());

		// set up the state machine
		fsm = new States();
		fsm.add(new states.Play());
		fsm.set('Play');
	} // assetsLoaded

	override function onkeyup( e:KeyEvent ) {
		if(e.keycode == Key.escape) {
			Luxe.shutdown();
		}
	} //onkeyup

	override function update(dt:Float) {
		effects.update(dt);
	} //update

	override function onprerender() {
		effects.onprerender();
	} // onprerender

	override function onpostrender() {
		effects.onpostrender();
	} // onpostrender
} //Main
