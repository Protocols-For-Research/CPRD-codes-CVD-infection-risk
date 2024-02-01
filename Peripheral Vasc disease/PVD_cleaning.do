***Peripheral vascular disease: remove unwanted codes


*** set the directory
cd "S:\Joe Lee CPRD data\1stPassCodeListsToCheck"


**load up aurum file

import delimited "Aurum_PAD_codelist_180222.txt", clear


*for aurum
gen term1 = lower(term)

*for gold

**load up Gold file:
import delimited "Gold_PAD_codelist_180222.txt", clear

*gen a lowercase description
gen term1 = lower(readterm)


*look for stuff that's not supposed to be there...
gen weird = 0


foreach odd in raynaud neurogenic acrocyanosis erythromelalgia erythrocyanosis bruce aortography vibratory shock vibration acroparaesthesia actinic beals capilliar retina monckeberg spermato aortogram vagina aortograp erythralgia proteus reconstruction angiogra infant diving injury fibrosis venous dental cylinder jaw coarctation cisticerc cystice myocutaneous capillar orthodont training hernia umbilical developmental advice pregnancy exercise question gases "oral surgeon" screening glaucoma neoplas arterioles "genital organ" "vascular ring" "p.p high" dislocation aortitis interrupted spasm vaccine influenza{
    replace weird = 1 if strmatch(term1, "*`odd'*")
	
}


sort weird 

*********

*not actually necessary to replace any terms exlculded by this
**************

*send the Txt files out - Aurum

***need to format codes!
format medcodeid observations snomedc %24.0f


preserve

drop if weird ==1 
drop weird term1 
outsheet using "Aurum_PAD_codelist_080322.txt", replace

restore

preserve
drop if weird ==0
drop weird term1
outsheet using "Aurum_PAD_codelist_Exclude_080322.txt", replace
restore 

***send the txt files - Gold
**format
format medcode v1 clinical %24.0f


preserve

drop if weird ==1 
drop weird term1 
outsheet using "Gold_PAD_codelist_080322.txt", replace

restore

preserve
drop if weird ==0
drop weird term1
 outsheet using "Gold_PAD_codelist_exclude_080322.txt", replace
restore 