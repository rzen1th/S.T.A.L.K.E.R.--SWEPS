$modelname "weapons\stalker\c_stalker_an94.mdl"
 
$bodygroup "studio" {
	studio "an94.smd"
}

$bodygroup "1" {
	studio "an94_barrel.smd"
	studio "an94_barrel_long.smd"
	studio "an94_barrel_short.smd"
}

$bodygroup "2" {
	studio "an94_mag_30.smd"
	studio "an94_mag_60.smd"
	studio "an94_mag_10.smd"
}

$bodygroup "3" {
	blank
	studio "an94_mount_dovetail.smd"
	studio "an94_mount_nato.smd"
}

$bodygroup "4" {
	studio "an94_polymer_stock.smd"
	studio "an94_polymerfolded_stock.smd"
	studio "an94_skeleton_stock.smd"
	studio "an94_skeletonfolded_stock.smd"
}

$bodygroup "5" {
	blank
	studio "an94_rails.smd" // Handguard rails
}

$bodygroup "6" {
	studio "ak74_mag_bullets.smd" // Didn't parent them to the mags just in case
}

$cdmaterials "models\weapons\stalker"

$attachment "1" "barrel" 0 0 0 rotate -90 0 0
$attachment "2" "bolt" 0 0 0 rotate -10 140 180
$attachment "3" "Camera" 0 0 10 rotate -90 0 0
 
$surfaceprop "default"
 
$contents "solid"
 
$illumposition 0 0 0

$bbox 0 0 0 0 0 0
 
$cbox 0 0 0 0 0 0

$poseparameter "sights" 0 1 loop 0

$sequence "idle"{
	"anims\idle.smd" 
	"anims\idle_iron.smd"
	fps 25
	"ACT_VM_IDLE" 1
 	blend "sights" 0 1
	loop
	snap
	node "Ready"
}

$sequence "fire" {
	"anims\fire.smd"
	"anims\fire_iron.smd"
	fps 25
	"ACT_VM_PRIMARYATTACK" 1
 	blend "sights" 0 1
	fadein 0.03
	fadeout 0.03
	{ event 5001 0 "1" }
}

$sequence "ready" "anims\ready.smd" {
	fps 25
	"ACT_VM_DRAW" 1
	snap
}

// 30 R

$sequence "reload" {
	"anims\reload.smd"
	"anims\reload_iron.smd"
	blend "sights" 0 1
	fps 25
	"ACT_VM_RELOAD" 1
	snap
}

$sequence "reload_empty" {
	"anims\reload_empty.smd"
	//"anims\reload_empty_iron.smd"
	//blend "sights" 0 1
	fps 25
	"ACT_VM_RELOAD" 1
	snap
}

// 60 R

$sequence "reload_60" {
	"anims\reload_60.smd"
	//"anims\reload_iron_60.smd"
	//blend "sights" 0 1
	fps 25
	"ACT_VM_RELOAD" 1
	snap
}

$sequence "reload_empty_60" {
	"anims\reload_empty_60.smd"
	//"anims\reload_empty_iron_60.smd"
	//blend "sights" 0 1
	fps 25
	"ACT_VM_RELOAD" 1
	snap
}

// 10 R Mag

$sequence "reload_10" {
	"anims\reload_10.smd"
	//"anims\reload_iron_10.smd"
	//blend "sights" 0 1
	fps 25
	"ACT_VM_RELOAD" 1
	snap
}

$sequence "reload_empty_10" {
	"anims\reload_empty_10.smd"
	//"anims\reload_empty_iron_10.smd"
	//blend "sights" 0 1
	fps 25
	"ACT_VM_RELOAD" 1
	snap
}

$sequence "inspect_01" {
	"anims\inspect_01.smd"
	"ACT_VM_IDLE" 1
	fadein 0.03
	fadeout 0.03
	fps 25
}

$sequence "inspect_02" {
	"anims\inspect_02.smd"
	"ACT_VM_IDLE" 1
	fadein 0.03
	fadeout 0.03
	fps 25
}

$sequence "inspect_03" {
	"anims\inspect_03.smd"
	"ACT_VM_IDLE" 1
	fadein 0.03
	fadeout 0.03
	fps 25
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