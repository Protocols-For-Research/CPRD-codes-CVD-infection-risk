***Hypertension codelist cleaning


*** set the directory
cd "S:\Joe Lee CPRD data\1stPassCodeListsToCheck\Solid Cancer"


**load up aurum file

import delimited "Aurum_solid_cancer_codelist_040422.txt", clear


*for aurum
gen term1 = lower(term)

*for gold

**load up Gold file:
import delimited "Gold_solid_cancer_codelist_040422.txt", clear

*gen a lowercase description
gen term1 = lower(readterm)


*look for stuff that's not supposed to be there...
gen weird = 0


foreach odd in fh: fetal newborn neonatal "family history" "white coat"  "venous" "pulmonary" "more time" "transient" "reaction" "ocular" "without diagnosis" "portal" "not to have" "concomitantly" "screening" "score" "risk" "intracranial" "without hyper" "reading" "borderline" "poisoning" "antihypertensive" "maternal" "screen" "no h/o" "neonate" "hypertensive eye" "monitoring not required" "no"{
    replace weird = 1 if strmatch(term1, "*`odd'*")
	
}


sort weird 

*these look OK so nothing removed



*send the Txt files out - Aurum

