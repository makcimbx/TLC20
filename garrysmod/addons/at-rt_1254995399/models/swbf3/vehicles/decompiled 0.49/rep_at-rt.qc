// Created by Crowbar 0.49.0.0

$modelname "swbf3\vehicles\rep_at-rt.mdl"

$bodygroup "Body"
{
	studio "rep_at-rt.smd"
}


$surfaceprop "metal"

$contents "solid"

$maxeyedeflection 90

$cdmaterials "models\starwars\swbf3\vehicles\rep_at-rt\"

$cbox 0 0 0 0 0 0

$bbox -154.281 -110.382 -0.007 253.079 110.459 528.479

// $hboxset "default"
// $hbox 0 "root" -81.869003 -28.653999 0 81.869003 109.817001 157.703995 ""
// $hbox 0 "legA1" -14.274 -10.544 -100.656998 13.392 69.207001 3.002 ""
// $hbox 0 "legA2" -18.518999 -46.819 -90.286003 18.462999 18.393999 18.261 ""
// $hbox 0 "legA3" -47.433998 -125.297997 -46.272999 46.575001 4.986 1.157 ""
// $hbox 0 "rotator" -52.227001 -124.926003 -24.983999 52.227001 114.470001 281.036011 ""
// $hbox 0 "pulsegun" -10.869 -138.792999 -15.658 10.869 54.728001 19.066 ""
// $hbox 0 "buttonC" -1.451 -0.874 -1.095 1.654 1.667 1.728 ""
// $hbox 0 "buttonD" -1.614 -0.874 -1.095 1.632 1.667 1.728 ""
// $hbox 0 "buttonA" -1.576 -0.874 -1.095 1.671 1.667 1.728 ""
// $hbox 0 "buttonB" -1.499 -0.874 -1.095 1.606 1.667 1.728 ""
// $hbox 0 "LeverB1" -4.458 -7.295 -7.569 32.665001 38.722 23.625999 ""
// $hbox 0 "LeverA1" -32.799 -7.295 -7.569 4.324 38.722 23.625999 ""
// $hbox 0 "legB1" -13.812 -10.544 -100.656998 13.854 69.207001 3.002 ""
// $hbox 0 "legB2" -19.667 -46.819 -90.286003 17.315001 18.393999 18.261 ""
// $hbox 0 "legB3" -46.976002 -125.297997 -46.277 47.032001 4.986 1.157 ""


$sequence "idle" {
	"rep_at-rt_anims\idle.smd"
	activity "ACT_IDLE" 1
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "digi" {
	"rep_at-rt_anims\digi.smd"
	activity "ACT_WALK" 1
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$collisionmodel "rep_at-rt_physics.smd"
{
	$mass 800
	$inertia 1
	$damping 0
	$rotdamping 0
	$rootbone " "
	$concave

}
