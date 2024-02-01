*****Checking codelists - Learning disability

**set directory to S where these files are
cd "S:\Joe Lee CPRD data\1stPassCodeListsToCheck"


***get the Aurum data 
import delimited "Aurum_Learning_codelist.txt", clear


*for aurum
gen term1 = lower(term)

*for gold

**load up Gold file:
import delimited "Gold_Learning_codelist.txt", clear

*gen a lowercase description
gen term1 = lower(readterm)


*look for stuff that's not supposed to be there...
gen weird = 0


foreach odd in  {
    replace weird = 1 if strmatch(term1, "*`odd'*")
	
}


sort weird 

**Aurum no changes

**Gold no changes 