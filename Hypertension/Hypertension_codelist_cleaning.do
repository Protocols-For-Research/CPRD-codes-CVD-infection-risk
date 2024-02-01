***Hypertension codelist cleaning


*** set the directory
cd "S:\Joe Lee CPRD data\1stPassCodeListsToCheck\Hypertension"


**load up aurum file

import delimited "Aurum_Hypertension_codelist_100322.txt", clear


*for aurum
gen term1 = lower(term)

*for gold

**load up Gold file:
import delimited "Gold_Hypertension_codelist_100322.txt", clear

*gen a lowercase description
gen term1 = lower(readterm)


*look for stuff that's not supposed to be there...
gen weird = 0


foreach odd in fh: fetal newborn neonatal "family history" "white coat"  "venous" "pulmonary" "more time" "transient" "reaction" "ocular" "without diagnosis" "portal" "not to have" "concomitantly" "screening" "score" "risk" "intracranial" "without hyper" "reading" "borderline" "poisoning" "antihypertensive" "maternal" "screen" "no h/o" "neonate" "hypertensive eye" "monitoring not required"{
    replace weird = 1 if strmatch(term1, "*`odd'*")
	
}


sort weird 

*********
foreach exception in "maximal tolerated"{
	replace weird = 0 if strmatch(term1, "*`exception'*")
}


**************

*send the Txt files out - Aurum

***need to format codes!
format medcodeid observations snomedc %24.0f


preserve

drop if weird ==1 
drop weird term1 
outsheet using "Aurum_Hypertension_codelist_220322.txt", replace

restore

preserve
drop if weird ==0
drop weird term1
outsheet using "Aurum_Hypertension_codelist_Exclude_these220322.txt", replace
restore 

***send the txt files - Gold
**format
format medcode v1 clinical %24.0f


preserve

drop if weird ==1 
drop weird term1 
outsheet using "Gold_Hypertension_codelist_220322.txt", replace

restore

preserve
drop if weird ==0
drop weird term1
 outsheet using "Gold_Hypertension_codelist_Exclude_these220322.txt", replace
restore 