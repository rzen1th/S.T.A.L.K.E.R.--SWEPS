$modelname "weapons\stalker\c_stalker_f2000.mdl"
 
$bodygroup "studio" {
	studio "fn2000.smd"
	studio "fn2000_upper_railed.smd"
}

$bodygroup "1" {
	studio "fn2000_barrel.smd"
	studio "fn2000_barrel_long.smd"
	studio "fn2000_barrel_short.smd"
}

$bodygroup "2" {
	studio "fn2000_mag_30.smd"
	studio "fn2000_mag_45.smd"
}

$bodygroup "3" {
	blank
	studio "fn2000_ironsights.smd"
}


$bodygroup "4" {
	blank
	studio "fn2000_rails.smd" // Handguard rails
}

$bodygroup "5" {
	studio "fn2000_handguard.smd" 
	blank
}

$cdmaterials "models\weapons\stalker"
$cdmaterials "models\weapons\stalker\addons\"

$attachment "1" "root" 0 0 15 rotate -90 0 0
$attachment "2" "charginghandle" 0 0 0 rotate -10 140 180
$attachment "3" "Camera" 0 0 10 rotate -90 0 0
 
$surfaceprop "default"
 
$contents "solid"
 
$illumposition 0 0 0

$bbox 0 0 0 0 0 0
 
$cbox 0 0 0 0 0 0


$sequence "idle"{
	"anims\idle.smd" 
	fps 60
	"ACT_VM_IDLE" 1
	loop
	snap
}

$sequence "fire" {
	"anims\fire.smd"
	fps 60
	"ACT_VM_PRIMARYATTACK" 1
	fadein 0.03
	fadeout 0.03
	{ event 5001 0 "1" }
}

$sequence "ready" "anims\ready.smd" {
	fps 60
	"ACT_VM_DRAW" 1
	snap
}

$sequence "draw" "anims\draw.smd" {
	fps 60
	"ACT_VM_DRAW" 1
	snap
}


$sequence "reload" {
	"anims\reload.smd"
	fps 60
	"ACT_VM_RELOAD" 1
	snap
}

$sequence "reload_empty" {
	"anims\reload_empty.smd"
	fps 60
	"ACT_VM_RELOAD" 1
	snap
}


$sequence "reload_45" {
	"anims\reload_45.smd"
	fps 60
	"ACT_VM_RELOAD" 1
	snap
}

$sequence "reload_empty_45" {
	"anims\reload_empty_45.smd"
	fps 60
	"ACT_VM_RELOAD" 1
	snap
}



$bonemerge "ValveBiped.Bip01_Spine4"
$bonemerge "ValveBiped.Bip01_L_Clavicle"
$bonemerge "ValveBiped.Bip01_L_UpperArm"
$bonemerge "ValveBiped.Bip01_L_Forearm"
$bonemerge "ValveBiped.Bip01_L_Hand"
$bonemerge "ValveBiped.Bip01_L_Finger4"
$bonemerge "ValveBiped.Bip01_L_Finger41"
$bonemerge "ValveBiped.Bip01_L_Finger42"
$bonemerge "ValveBiped.Bip01_L_Finger3"
$bonemerge "ValveBiped.Bip01_L_Finger31"
$bonemerge "ValveBiped.Bip01_L_Finger32"
$bonemerge "ValveBiped.Bip01_L_Finger2"
$bonemerge "ValveBiped.Bip01_L_Finger21"
$bonemerge "ValveBiped.Bip01_L_Finger22"
$bonemerge "ValveBiped.Bip01_L_Finger1"
$bonemerge "ValveBiped.Bip01_L_Finger11"
$bonemerge "ValveBiped.Bip01_L_Finger12"
$bonemerge "ValveBiped.Bip01_L_Finger0"
$bonemerge "ValveBiped.Bip01_L_Finger01"
$bonemerge "ValveBiped.Bip01_L_Finger02"
$bonemerge "ValveBiped.Bip01_R_Clavicle"
$bonemerge "ValveBiped.Bip01_R_UpperArm"
$bonemerge "ValveBiped.Bip01_R_Forearm"
$bonemerge "ValveBiped.Bip01_R_Hand"
$bonemerge "ValveBiped.Bip01_R_Wrist"
$bonemerge "ValveBiped.Bip01_R_Finger4"
$bonemerge "ValveBiped.Bip01_R_Finger41"
$bonemerge "ValveBiped.Bip01_R_Finger42"
$bonemerge "ValveBiped.Bip01_R_Finger3"
$bonemerge "ValveBiped.Bip01_R_Finger31"
$bonemerge "ValveBiped.Bip01_R_Finger32"
$bonemerge "ValveBiped.Bip01_R_Finger2"
$bonemerge "ValveBiped.Bip01_R_Finger21"
$bonemerge "ValveBiped.Bip01_R_Finger22"
$bonemerge "ValveBiped.Bip01_R_Finger1"
$bonemerge "ValveBiped.Bip01_R_Finger11"
$bonemerge "ValveBiped.Bip01_R_Finger12"
$bonemerge "ValveBiped.Bip01_R_Finger0"
$bonemerge "ValveBiped.Bip01_R_Finger01"
$bonemerge "ValveBiped.Bip01_R_Finger02"