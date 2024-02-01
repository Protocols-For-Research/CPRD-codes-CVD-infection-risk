*****Readme file for CPRD respiratory infection codelists: Gold_FRI_types.txt and Aurum_FRI_types.txt

***These lists were developed to capture acute respiratory infections in the primary care record, for CPRD Gold and Aurum, in adults over the age of 40, and to group them into four types. 

*These codelists were originally derived from UK NHS Digital published snowmed codelists for the QoF ruleset and for COVID-19 epidemiology (July 2021 PCD refset content). As these codes don't translate directly to the CPRD codes, term searches using the CPRD browser files were also done. 

*There are very few diagnostics in use in UK primary care at the time of this project, so these codes are mostly clinical diagnoses. 

*Respiratory infections includes the whole of the respiratory tract, from the lungs to the external auditory meatus, or the nares. It does not include chronic infections, tuberculous infections, infestations and fungal/protozoal disease. Anything I considered odd or irrelevant, e.g. diptheria, was excluded. Things pertaining to children were also excluded. 

*The four types are as follows: upper respiratory tract infection, lower respiratory tract infections, influenza-like illness, and pneumonia. Upper respiratory infections are those thought to infect the larynx and above. Lower respiratory infections are those lower than the larynx. These are therfore exlcusive. Codes nominated 'pneumonia' are supposed to contain infecious pneumonia (not chemical or aspiration pneumonitis) and are a separate category to lower respiratory tract infections, one could of course combine them if so desired. The other category, influenza-like illness, is not exclusive either. In general ILI is characterised as a lower respiratory infection, but some of the codes could specify pneumonias. Note - influenza-like illness is a clinical syndrome that includes much more than influenza virus. In our datacuts the events (not codes) allocated to these categories were: Aurum - upper 63.0%, lower 34.9%, pneumonia 2.1%, influenza-like 5.0%. Gold - upper 63.2%, lower 35.0%, pneumonia 1.9%, influenza-like 5.2%

*The Stata do file I last used to clean these codes: Types_of_infections.do
*this file removed these terms: tubercul diphtheria aspergill chronic candid echinococcus kartagener emmonsia congenital neonat plague amebic fungal battey allergic anthrax parasitic mycobac windermere toxoplasma filariasis schistosom coccidio tropical pneumocyst chemical mycosis mycotic capillari malaria woakes fungus nematod ascaris byssin yaws occupational radiation granuloma periodic rhinoscleroma fasciol papilloma histoplas adhesive keratosa infestation namespace antritis attenuated

*and replaced 'chronic obstructive' which was removed by the above. 


