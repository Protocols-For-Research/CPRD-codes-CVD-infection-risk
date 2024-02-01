***COPD disease: remove unwanted codes


*** set the directory
cd "H:\JOE\DPhil\Codelists\For data spec\Back from Cynthia\comorbidities\COPD" 


**load up aurum file

import delimited "Aurum_COPD_codelist.txt", clear


*for aurum
gen term1 = lower(term)

*for gold

**load up Gold file:
import delimited "Gold_COPD_codelist.txt", clear

*gen a lowercase description
gen term1 = lower(readterm)


*look for stuff that's not supposed to be there...
gen weird = 0


foreach odd in bronchiectasis bronchiolithiasis silicosis "interstitial pneumonia" james {
    replace weird = 1 if strmatch(term1, "*`odd'*")
	
}


sort weird 

*********

*not actually necessary to replace any terms
**************



*send the Txt files out - Aurum

***need to format codes!
format medcode v1 observations snomed %24.0f

preserve

drop if weird ==1 
drop weird term1 
outsheet using "COPD_Aurum_prelim_v1_110222.txt", replace

restore

preserve
drop if weird ==0
drop weird term1
 outsheet using "COPD_Aurum_prelim_v1_exclude_these_110222.txt", replace
restore 

***send the txt files - Gold

*format them
format medcode clinical %24.0f

preserve

drop if weird ==1 
drop weird term1 
outsheet using "COPD_Gold_prelim_v1_110222.txt", replace

restore

preserve
drop if weird ==0
drop weird term1
 outsheet using "COPD_Gold_prelim_v1_exclude_these_110222.txt", replace
restore 