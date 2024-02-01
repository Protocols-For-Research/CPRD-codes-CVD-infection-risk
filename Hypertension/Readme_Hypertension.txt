***Readme Hypertension Coidelists 22/3/22

***These code lists are designed to identify hypertension codes in the primary care records, for a project concerning infection-related CVD. 

***Note, this is to identify people with arterial hypertension diagnoses, not blood pressure readings which would qualify them for a diagnosis, as these data with quantitative aspects are stored and dealt with separately in the CPRD datasets. 


***Included are hypertension of pregnancy, but not 'maternal hypertension' which might refer to the mother of the patient, nor the foetal and neonatal consequences of maternal hypertension. 'transient hypertension of pregnancy' is also excluded. 

***Hypertension screening is not included (as it may be negative), moitoring is included (as one only monitors once it exists). Hypertension clinic codes are similarly included. Adverese vents and poisonings due to antihypertensives are not included, as these drugs have many other uses and indications than hypertension. Poisoning might not even relate to drugs prescribed for the poisoned patient. 

***They were originally derived from UK goverment published lists of snomed codes for CVD QoF rules - the 2021 PCD_Refset_Content files published by NHS Digital. These were examined to identify acute relevant events, and then translated to codes for Gold and Aurum. SNOMED codes were translated to CPRD medcodes by merging on both readcodes and terms, and resulting lists were supplemented with additional term searches using the CPRD Gold and Aurum dictionaries. 

***The lists of codes included a lot of hypertension in other organs (eye, pumonary arteries, veins) which had to be excluded, as well as negative terms ('no hypertension') and things about family history etc. This stata code lists the terms used to screen this stuff out:

*look for stuff that's not supposed to be there and label it: 
gen weird = 0

foreach odd in fh: fetal newborn neonatal "family history" "white coat"  "venous" "pulmonary" "more time" "transient" "reaction" "ocular" "without diagnosis" "portal" "not to have" "concomitantly" "screening" "score" "risk" "intracranial" "without hyper" "reading" "borderline" "poisoning" "antihypertensive" "maternal" "screen" "no h/o" "neonate" "hypertensive eye" "monitoring not required"{
    replace weird = 1 if strmatch(term1, "*`odd'*")
	
}


sort weird 

**relabel stuff labelled in error:

foreach exception in "maximal tolerated"{
	replace weird = 0 if strmatch(term1, "*`exception'*")
}

