*dementia codelist cleaning
**set directory to S where these files are
cd "S:\Joe Lee CPRD data\1stPassCodeListsToCheck"


***get the Aurum data 
import delimited "Aurum_Dementia_codelist_210222.txt", clear


**for aurum
gen term1 = lower(term)


**for Gold

**load up Gold file:
import delimited "Gold_Dementia_codelist_180222.txt", clear

*gen a lowercase description
gen term1 = lower(readterm)


*look for stuff that's not supposed to be there...
gen weird = 0


foreach odd in risk assessment clinic* macular hyperkeratosis arotic vaginitis debride cataract heart  anodontia screening cocaine niemann pruritis angioma choroid xeroderma eater presbyac retina cervix cornea adenoma eczema pickwick lentigo cardiac worker keratoma gangrene wart carer opioid test exhaustion skin ovary ectropion naevus pedest collision fh: pick-up purpura asthenia leaflet debility dermatitis entropion scale {
    replace weird = 1 if strmatch(term1, "*`odd'*")
	
}


sort weird 


*/*no need for exceptions in Aurum or Gold

foreach exception in {
	replace weird = 0 if strmatch(term1, "*`exception'*")
}

sort weird
*/



***need to format codes!
format medcode v1 observations snomed %24.0f

preserve

drop if weird ==1 
drop weird term1 
outsheet using "Aurum_Dementia_codelist_030322.txt", replace

restore

preserve
drop if weird ==0
drop weird term1
 outsheet using "Aurum_Dementia_codelist_030322_exclude.txt", replace
restore 

***send the txt files - Gold 

*format them
format medcode clinical %24.0f

preserve

drop if weird ==1 
drop weird term1 
outsheet using "Gold_Dementia_codelist_030322.txt", replace

restore

preserve
drop if weird ==0
drop weird term1
 outsheet using "Gold_Dementia_codelist_030322_exclude.txt", replace
restore 


***subtypes of dementia
*gold

import delimited "S:\Joe Lee CPRD data\1stPassCodeListsToCheck\Dementia\Gold_Dementia_codelist_030322.txt"


gen vascular = 0
gen Alzheimer = 0
gen other = 0

gen term1 = lower(readterm)


local vasctype vascular arterio infarct athero
foreach word in `vasctype'{
	replace vascular= 1 if strmatch(term1, "*`word'*")
}

local alzh alzh 
foreach word in `alzh'{
	replace Alzheimer= 1 if strmatch(term1, "*`word'*")
}



local other alcohol binswanger psychosis review "other cerebral" amyloid creutz referral pick leucoenc parkinson monitoring kuru senility "cerebral degeneration in disease" degeneration paranoid psychot arizona lewy "care plan" "h/o: dementia" syphilis "cortical dementia" suspected language kendrick exception hiv hunting drug-induced "senile dementia" "presenile dementia" "dementia in" quality "primary degenerative" "unspecified dementia" "senile confusion" wernicke korsa "delirium superimposed on dement"
foreach word in `other'{
	replace other = 1 if strmatch(term1, "*`word'*")
}



local exception alzh cerebrovascular
foreach word in `exception'{
	replace other = 0 if strmatch(term1, "*`word'*" )
}

sort other vasc Alzheimer

drop term1

export excel using "S:\STRATIFY Data\SS_Readcodes\GOLD\dementia\TakeshiDementiatypes.xls", firstrow(variables) replace
