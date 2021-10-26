$modelname "weapons\stalker\c_stalker_akm.mdl"
 
$bodygroup "studio" {
	studio "akm.smd"
}

$bodygroup "1" {
	studio "akm_barrel.smd"
	studio "akm_barrel_rpk.smd"
	studio "akm_barrel_long.smd"
	studio "akm_barrel_short.smd"
}

$bodygroup "2" {
	studio "akm_mag_30.smd"
	studio "akm_mag_60.smd"
	studio "akm_mag_45.smd"
	studio "akm_mag_10.smd"
}

$bodygroup "3" {
	studio "akm_handguard_wood.smd"
	studio "akm_handguard_polymer.smd"
	studio "akm_handguard_green.smd"
	studio "akm_handguard_plum.smd"
}

$bodygroup "4" {
	studio "akm_stock_wood.smd"
	studio "akm_stock_rpk.smd"
	studio "akm_stock_polymer.smd"
	studio "akm_stock_skeleton.smd"
	studio "akm_stock_skeletonfolded.smd"
	studio "akm_stock_green.smd"
	studio "akm_stock_plum.smd"
}

$bodygroup "5" {
	blank
	studio "akm_rails_side.smd"
}

$bodygroup "6" {
	blank
	studio "akm_rails_low.smd"
}

$bodygroup "7" {
	blank
	studio "akm_rails_top.smd"
}

$bodygroup "8" {
	studio "ak74_mag_bullets.smd"
	blank
}

$cdmaterials "models\weapons\stalker"
$cdmaterials "models\weapons\stalker\addons\"

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
	"anims\reload_empty_iron.smd"
	blend "sights" 0 1
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
	"anims\inspect_iron_01.smd"
	blend "sights" 0 1
	"ACT_VM_IDLE" 1
	fadein 0.03
	fadeout 0.03
	fps 25
}

$sequence "inspect_02" {
	"anims\inspect_02.smd"
	"anims\inspect_iron_02.smd"
	blend "sights" 0 1
	"ACT_VM_IDLE" 1
	fadein 0.03
	fadeout 0.03
	fps 25
}

$sequence "inspect_03" {
	"anims\inspect_03.smd"
	"anims\inspect_iron_03.smd"
	blend "sights" 0 1
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