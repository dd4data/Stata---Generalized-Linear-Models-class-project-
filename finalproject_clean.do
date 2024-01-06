********************************************************************
* GLM Final Project -- Data Cleaning
********************************************************************

cd "C:\Users\kaiji\OneDrive - University of Virginia\GLM study buddy\Final Project"

use NELS88_reduced, clear

keep BYS44B STU_ID BYS12 BYCNCPT1 BYSES BYTXRPRO BYTXMPRO

* Overview
codebook BYS44B BYS12 BYCNCPT1 BYSES BYTXRPRO BYTXMPRO
desc BYS44B BYS12 BYCNCPT1 BYSES BYTXRPRO BYTXMPRO
su BYS44B BYS12 BYCNCPT1 BYSES BYTXRPRO BYTXMPRO

* Recode and drop missing values
recode BYS44B (8=.) (6=.)
recode BYS12 8 = .
recode BYTXRPRO 8 = .
recode BYTXMPRO 8 = .
drop if BYS44B == . | BYS12 == . | BYCNCPT1 == .| BYSES == .| BYTXRPRO ==.| BYTXMPRO ==.

rename BYS44B control
recode BYS12 2=0
rename BYS12 gender
label define gender 0 "Female" 1 "Male"
label val gender gender
rename STU_ID studentid
rename BYCNCPT1 selfconcept
rename BYSES SES
rename BYTXRPRO reading
rename BYTXMPR math

recode control (1=0)(2=1)(3=2)(4=3)
recode reading (1=0)(2=1)(3=2)
recode math (1=0)(2=1)(3=2)(4=3)
label define agree 0 "Strongly agree" 1 "Agree" 2 "Disagree" 3 "Strongly disagree"
label val control agree
label define level 0 "Below level 1" 1 "Level 1" 2 "Level 2" 3 "All 3 levels"
label val reading level
label val math level
codebook math reading control

save NELS88_cleaned, replace
