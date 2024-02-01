*Diabetes_cleaning.do 


**H:\JOE\DPhil\Codelists\For data spec\Back from Cynthia\comorbidities\Diabetes

**cd
cd "S:\Joe Lee CPRD data\1stPassCodeListsToCheck\Diabetes"


**load up aurum file

import delimited "Aurum_Diabetes_codelist_040322.txt", clear


*for aurum
gen term1 = lower(term)

*for gold

**load up Gold file:
import delimited "Gold_Diabetes_codelist_040322.txt", clear

*gen a lowercase description
gen term1 = lower(readterm)


***************************************here - doing the types
*identify type 1 and type 2

gen Typei = 0
gen Typeii = 0
gen unknowntype = 0

foreach one in 1 one ketoacidosis DKA "type i " juvenile "diabetes of the young" "gastroparesis due to diabetes mellitus type i" "with ketoacidotic coma" "diabetes mellitus type i"{
	replace Typei = 1 if strmatch(term1, "*`one'*")
}

foreach notone in a1c ii "type 2" "adult onset, with ketoacidosis" "diabetic retinopathy 12 month review" "gestational" "non-insulin dependent" "diabetic mononeuropathy" "liverpool" "joint consultation" "17 item" "telephone" "practitioner" "insulin dependent diabetes mellitus with mononeuropathy" "mononeuritis multiplex" "screen" "1 receptor" "maturity onset diabetes of the young, type 1" "maturity onset diabetes in youth type 1" "with general practitioner" "maturity onset diabetes of the young type 5" {
	replace Typei = 0 if strmatch(term1, "*`notone'*")
}

foreach two in ii 2 two hyperosmotic honk "adult onset" "drug induced" "conversion to insulin" gestational "insulin resistance" steroid reaven hyperosmolar resolved hyperosmolar non-insulin niddm "syndrome x" "maturity onset diabetes" "walking away" pregnancy {
	replace Typeii = 1 if strmatch(term1, "*`two'*")
}

foreach nottwo in juvenile "diabetic retinopathy 12 month review" "pre-existing type 1 diabetes mellitus in pregnancy" "maturity onset diabetes of the young, type 1" "diabetes mellitus, adult onset, with ketoacidotic coma"{
	replace Typeii = 0 if strmatch(term1, "*`nottwo'*")
}


sort Typei Typeii 

replace unknowntype = 1 if Typei==0 &Typeii==0

******************************************
*look for stuff that's not supposed to be there...
gen weird = 0


foreach odd in hypogly "not to have" score "diabetes prevention" scale "stress induced" signpost antibody leaflet insulinoma liverpool insulin-like test fh family "at risk" pilot insipidus staff non-diabetic written iatrogenic hyperglycaemiaa hyperinsulinism "insulin autoimmune" hyperglyceridaemia "not detected" mother prediabetes poisoning "hyperglycaemic disorder" hyperglycerol relative "high risk" pre-diabetes neonatal paediatric hyperglycinaemia hyperpro nondiabetic  hyperglycaemia hyperglycemia ectopic diet "no diabetic autonomic" borderline transient a1c "insulin like" starvation malnutrition "adverse reaction" "screening" overdose auras "sensitivity factor" electroshock qdiabetes "maternal" "key contact" clinic education quality qof "complications trial aligned" "serum insulin - c-polypeptide level" non-diabetes "c-peptide measurement"{
    replace weird = 1 if strmatch(term1, "*`odd'*")
	
}



*replace terms captured with wierd that should be in there

foreach exception in warning "insulin dependent" "diabetic severe hyper" "diet only" "type 2 diabetes" "diabetic foot" "mellitus with" "due to diabetes" "type 1 diabetic" "type 2 diabetic" "type i diabetic" "type ii diabetic" "maternally inherited" "diabetic foot high risk" "7-10% - borderline" "7% - good control" "good diabetic control" "bad control" "high risk non proliferative diabetic retinopathy" "clinical diabetic nephropathy" "malnutrition"{
	replace weird = 0 if strmatch(term1, "*`exception'*")
}

**************
replace unknown = 1 if Typeii ==0 & Typei ==0 

sort weird Typei Typeii

*drop if weird==1
****

*send the Txt files out - Aurum 

***need to format codes!
format medcodeid observations snomedc %24.0f


preserve

drop if weird ==1 
drop weird term1 
outsheet using "Aurum_Diabetes_codelist_070422.txt", replace

restore

preserve
drop if weird ==0
drop weird term1
outsheet using "Aurum_Diabetes_codelist_Exclude_070422.txt", replace
restore 

***send the txt files - Gold
**format
format medcode v1 clinical %24.0f


preserve

drop if weird ==1 
drop weird term1 
outsheet using "Gold_Diabetes_codelist_070422.txt", replace

restore

preserve
drop if weird ==0
drop weird term1
 outsheet using "Gold_Diabetes_codelist_exclude_070422.txt", replace
restore 