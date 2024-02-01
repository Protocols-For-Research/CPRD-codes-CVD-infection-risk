***Brian's cancer codelists to text file and classified


*his groupings
g final_cancer = .
label define final_cancer 0 "no cancer" 1 "h&n" 2 "Oesoph" 3 "Gastr" 4 "SmInt" 5 "Colon" 6 "Rectum" 7 "Anal" 8 "Liver" 9 "Gallb" 10 "Biliary" 11 "Panc" 12 "OtherDig" 13 "Lung" 14 "Thorac" 15 "OtherThoracic" 16 "Bone" 17 "Melanoma" 18 "OtherSkin" 19 "ConnecSoft" 20 "Breast" 21 "Vulvovaginal" 22 "Cervix" 23 "Uterine" 24 "Ovary" 25 "OtherFemale" 26 "Penis" 27 "Prostate" 28 "Testis" 29 "OtherMale" 30 "RenalTr" 31 "Bladder" 32 "OtherUrin" 33 "Eye" 34 "Meninge" 35 "Brain" 36 "SpinalC" 37 "Endocrine" 38 "SecdryIll" 39 "Lymphoma" 40 "OtherHaem" 41 "Myeloma" 42 "Leukaemia" 43 "Multi" 44 "InSitu" 45 "Benign" 46 "Uncertain"
label values final_cancer final_cancer



***load it up
use "H:\JOE\DPhil\Codelists\For data spec\cancer_codesBN.dta", clear

generate solidcancer = 0
generate haematological = 0

replace haematological = 1 if can_group >38 & can_group <43

replace solidcancer = 1 if haematological ==0

***export it to txt files 

cd "H:\JOE\DPhil\Codelists\For data spec\Back from Cynthia\comorbidities\Cancers"

format medcode %24.0f

preserve
drop if haematological ==1
drop can_group solid haematological
outsheet using "BN_solid_cancers.txt", replace
restore

preserve
drop if haematological ==0
drop can_group solid haematological
outsheet using "BN_Haematological_cancers.txt", replace
restore

