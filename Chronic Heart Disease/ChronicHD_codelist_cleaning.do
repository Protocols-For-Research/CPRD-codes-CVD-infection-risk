*****Checking codelists - CHD 

**set directory to S where these files are
cd "S:\Joe Lee CPRD data\1stPassCodeListsToCheck"


***get the Aurum data 
import delimited "Aurum_CHD_codelist.txt", clear


**for aurum
gen term1 = lower(term)


**for Gold

**load up Gold file:
import delimited "Gold_CHD_codelist.txt", clear

*gen a lowercase description
gen term1 = lower(readterm)


*look for stuff that's not supposed to be there...
gen weird = 0


foreach odd in "coronary" function triple patent "vessel disease" bypass isch*mi* asthma "ventricular fun*" fibrillation "cor pulmonale" "arteriosclerotic" {
    replace weird = 1 if strmatch(term1, "*`odd'*")
	
}


sort weird 

foreach exception in "single coronary aretery" "closure" "aneurysm" "congenital" "anomaly" "secundum" "pulmonary trunk" "persisting"{
	replace weird = 0 if strmatch(term1, "*`exception'*")
}

sort weird




***need to format codes!
format medcode v1 observations snomed %24.0f

preserve

drop if weird ==1 
drop weird term1 
outsheet using "CHD_Aurum_prelim_v1_020322.txt", replace

restore

preserve
drop if weird ==0
drop weird term1
 outsheet using "CHD_Aurum_prelim_v1_020322_exclude_these.txt", replace
restore 

***send the txt files - Gold 

*format them
format medcode clinical %24.0f

preserve

drop if weird ==1 
drop weird term1 
outsheet using "CHD_Gold_prelim_V1_020322.txt", replace

restore

preserve
drop if weird ==0
drop weird term1
 outsheet using "CHD_Gold_prelim_V1_Exclude_these_020322.txt", replace
restore 


