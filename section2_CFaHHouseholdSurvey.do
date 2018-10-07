* HEADER -----------------------------------------------------
**  DO-FILE METADATA
    //  algorithm name			    section2_CFaHHouseholdSurvey.do
    //  project:				    Community Food and Health
    //  analysts:					Ian HAMBLETON
    // 	date last modified	        06-OCT-2018
    //  algorithm task			    Preparing DATA: SECTION 2

    ** General algorithm set-up
    version 15
    clear all
    macro drop _all
    set more 1
    set linesize 80

    ** Set working directories: this is for DATASET and LOGFILE import and export
    ** DATASETS to encrypted SharePoint folder
    local datapath "X:/The University of the West Indies/DataGroup - repo_data/data_p100"
    ** LOGFILES to unencrypted OneDrive folder (.gitignore set to IGNORE log files on PUSH to GitHub)
    local logpath X:/OneDrive - The University of the West Indies/repo_datagroup/repo_p100

    ** Close any open log file and open a new log file
    capture log close
    log using "`logpath'\section2_CFaHHouseholdSurvey", replace
** HEADER -----------------------------------------------------


** IMPORT the REDCap EXPORT (6-OCT-2018)
import delimited record_id q2_usualday q2_unusualhow___1 q2_unusualhow___2 q2_unusualhow___3 q2_unusualhow___4 q2_unusualhow___5 q2_unusualoth q2_recall1 q2_recall2 q2_recall3 q2_recall4 q2_grains q2_roots q2_pulses q2_nuts q2_milk q2_ormeat q2_pmeat q2_ppoul q2_upmeat q2_uppoul q2_fish q2_eggs q2_gveg q2_vitaveg q2_vitafruit q2_vegoth q2_fruitoth q2_insects q2_palmoil q2_oils q2_snacks q2_sweets q2_ssb q2_cond q2_drinkoth q2_grains2 q2_roots2 q2_pulses2 q2_nuts2 q2_milk2 q2_ormeat2 q2_pmeat2 q2_ppoul2 q2_upmeat2 q2_uppoul2 q2_fish2 q2_eggs2 q2_gveg2 q2_vitaveg2 q2_vitafruit2 q2_vegoth2 q2_fruitoth2 q2_insects2 q2_palmoil2 q2_oils2 q2_snacks2 q2_sweets2 q2_ssb2 q2_cond2 q2_eatout q2_done q2_donereason section_2_diet_diver_v_0 using "`datapath'/version01/1-input/section2_CFaHHouseholdSurvey.csv", varnames(nonames)
label data "CFaH Household Survey: SECTION 2"

** Merge with de-identified ID numbers
sort record_id
merge 1:1 record_id using "`datapath'/version01/2-working/section1_idlinkage.dta"
order pid, before(record_id)


** ----------------------------------------------------------------------
** PART 2: VARIABLE CATEGORY DEFINITIONS
** ----------------------------------------------------------------------
label define q2_usualday_ 1 "Yes" 2 "No"
label define q2_unusualhow___1_ 0 "Unchecked" 1 "Checked"
label define q2_unusualhow___2_ 0 "Unchecked" 1 "Checked"
label define q2_unusualhow___3_ 0 "Unchecked" 1 "Checked"
label define q2_unusualhow___4_ 0 "Unchecked" 1 "Checked"
label define q2_unusualhow___5_ 0 "Unchecked" 1 "Checked"
label define q2_recall1_ 1 "Yes" 2 "No"
label define q2_recall2_ 1 "Yes" 2 "No"
label define q2_recall3_ 1 "Yes" 2 "No"
label define q2_recall4_ 1 "Yes" 2 "No"
label define q2_grains_ 1 "Yes, greater than 15g consumed" 2 "Yes, less than 15g consumed" 3 "No, not consumed"
label define q2_roots_ 1 "Yes, greater than 15g consumed" 2 "Yes, less than 15g consumed" 3 "No, not consumed"
label define q2_pulses_ 1 "Yes, greater than 15g consumed" 2 "Yes, less than 15g consumed" 3 "No, not consumed"
label define q2_nuts_ 1 "Yes, greater than 15g consumed" 2 "Yes, less than 15g consumed" 3 "No, not consumed"
label define q2_milk_ 1 "Yes, greater than 15g consumed" 2 "Yes, less than 15g consumed" 3 "No, not consumed"
label define q2_ormeat_ 1 "Yes, greater than 15g consumed" 2 "Yes, less than 15g consumed" 3 "No, not consumed"
label define q2_pmeat_ 1 "Yes, greater than 15g consumed" 2 "Yes, less than 15g consumed" 3 "No, not consumed"
label define q2_ppoul_ 1 "Yes, greater than 15g consumed" 2 "Yes, less than 15g consumed" 3 "No, not consumed"
label define q2_upmeat_ 1 "Yes, greater than 15g consumed" 2 "Yes, less than 15g consumed" 3 "No, not consumed"
label define q2_uppoul_ 1 "Yes, greater than 15g consumed" 2 "Yes, less than 15g consumed" 3 "No, not consumed"
label define q2_fish_ 1 "Yes, greater than 15g consumed" 2 "Yes, less than 15g consumed" 3 "No, not consumed"
label define q2_eggs_ 1 "Yes, greater than 15g consumed" 2 "Yes, less than 15g consumed" 3 "No, not consumed"
label define q2_gveg_ 1 "Yes, greater than 15g consumed" 2 "Yes, less than 15g consumed" 3 "No, not consumed"
label define q2_vitaveg_ 1 "Yes, greater than 15g consumed" 2 "Yes, less than 15g consumed" 3 "No, not consumed"
label define q2_vitafruit_ 1 "Yes, greater than 15g consumed" 2 "Yes, less than 15g consumed" 3 "No, not consumed"
label define q2_vegoth_ 1 "Yes, greater than 15g consumed" 2 "Yes, less than 15g consumed" 3 "No, not consumed"
label define q2_fruitoth_ 1 "Yes, greater than 15g consumed" 2 "Yes, less than 15g consumed" 3 "No, not consumed"
label define q2_insects_ 1 "Yes, greater than 15g consumed" 2 "Yes, less than 15g consumed" 3 "No, not consumed"
label define q2_palmoil_ 1 "Yes, greater than 15g consumed" 2 "Yes, less than 15g consumed" 3 "No, not consumed"
label define q2_oils_ 1 "Yes, greater than 15g consumed" 2 "Yes, less than 15g consumed" 3 "No, not consumed"
label define q2_snacks_ 1 "Yes, greater than 15g consumed" 2 "Yes, less than 15g consumed" 3 "No, not consumed"
label define q2_sweets_ 1 "Yes, greater than 15g consumed" 2 "Yes, less than 15g consumed" 3 "No, not consumed"
label define q2_ssb_ 1 "Yes, greater than 15g consumed" 2 "Yes, less than 15g consumed" 3 "No, not consumed"
label define q2_cond_ 1 "Yes, greater than 15g consumed" 2 "Yes, less than 15g consumed" 3 "No, not consumed"
label define q2_drinkoth_ 1 "Yes, greater than 15g consumed" 2 "Yes, less than 15g consumed" 3 "No, not consumed"
label define q2_grains2_ 1 "Yes, greater than 15g consumed" 2 "Yes, less than 15g consumed" 3 "No, not consumed"
label define q2_roots2_ 1 "Yes, greater than 15g consumed" 2 "Yes, less than 15g consumed" 3 "No, not consumed"
label define q2_pulses2_ 1 "Yes, greater than 15g consumed" 2 "Yes, less than 15g consumed" 3 "No, not consumed"
label define q2_nuts2_ 1 "Yes, greater than 15g consumed" 2 "Yes, less than 15g consumed" 3 "No, not consumed"
label define q2_milk2_ 1 "Yes, greater than 15g consumed" 2 "Yes, less than 15g consumed" 3 "No, not consumed"
label define q2_ormeat2_ 1 "Yes, greater than 15g consumed" 2 "Yes, less than 15g consumed" 3 "No, not consumed"
label define q2_pmeat2_ 1 "Yes, greater than 15g consumed" 2 "Yes, less than 15g consumed" 3 "No, not consumed"
label define q2_ppoul2_ 1 "Yes, greater than 15g consumed" 2 "Yes, less than 15g consumed" 3 "No, not consumed"
label define q2_upmeat2_ 1 "Yes, greater than 15g consumed" 2 "Yes, less than 15g consumed" 3 "No, not consumed"
label define q2_uppoul2_ 1 "Yes, greater than 15g consumed" 2 "Yes, less than 15g consumed" 3 "No, not consumed"
label define q2_fish2_ 1 "Yes, greater than 15g consumed" 2 "Yes, less than 15g consumed" 3 "No, not consumed"
label define q2_eggs2_ 1 "Yes, greater than 15g consumed" 2 "Yes, less than 15g consumed" 3 "No, not consumed"
label define q2_gveg2_ 1 "Yes, greater than 15g consumed" 2 "Yes, less than 15g consumed" 3 "No, not consumed"
label define q2_vitaveg2_ 1 "Yes, greater than 15g consumed" 2 "Yes, less than 15g consumed" 3 "No, not consumed"
label define q2_vitafruit2_ 1 "Yes, greater than 15g consumed" 2 "Yes, less than 15g consumed" 3 "No, not consumed"
label define q2_vegoth2_ 1 "Yes, greater than 15g consumed" 2 "Yes, less than 15g consumed" 3 "No, not consumed"
label define q2_fruitoth2_ 1 "Yes, greater than 15g consumed" 2 "Yes, less than 15g consumed" 3 "No, not consumed"
label define q2_insects2_ 1 "Yes, greater than 15g consumed" 2 "Yes, less than 15g consumed" 3 "No, not consumed"
label define q2_palmoil2_ 1 "Yes, greater than 15g consumed" 2 "Yes, less than 15g consumed" 3 "No, not consumed"
label define q2_oils2_ 1 "Yes, greater than 15g consumed" 2 "Yes, less than 15g consumed" 3 "No, not consumed"
label define q2_snacks2_ 1 "Yes, greater than 15g consumed" 2 "Yes, less than 15g consumed" 3 "No, not consumed"
label define q2_sweets2_ 1 "Yes, greater than 15g consumed" 2 "Yes, less than 15g consumed" 3 "No, not consumed"
label define q2_ssb2_ 1 "Yes, greater than 15g consumed" 2 "Yes, less than 15g consumed" 3 "No, not consumed"
label define q2_cond2_ 1 "Yes, greater than 15g consumed" 2 "Yes, less than 15g consumed" 3 "No, not consumed"
label define q2_eatout_ 1 "Yes" 2 "No"
label define q2_done_ 1 "Yes, move on to SECTION 3 - DIET SCREENER" 2 "No,  will not move on"
label define section_2_diet_diver_v_0_ 0 "Incomplete" 1 "Unverified" 2 "Complete"

** ----------------------------------------------------------------------
** PART 3: VARIABLE CATEGORY LABEL ATTACHMENTS
** ----------------------------------------------------------------------
label values q2_usualday q2_usualday_
label values q2_unusualhow___1 q2_unusualhow___1_
label values q2_unusualhow___2 q2_unusualhow___2_
label values q2_unusualhow___3 q2_unusualhow___3_
label values q2_unusualhow___4 q2_unusualhow___4_
label values q2_unusualhow___5 q2_unusualhow___5_
label values q2_recall1 q2_recall1_
label values q2_recall2 q2_recall2_
label values q2_recall3 q2_recall3_
label values q2_recall4 q2_recall4_
label values q2_grains q2_grains_
label values q2_roots q2_roots_
label values q2_pulses q2_pulses_
label values q2_nuts q2_nuts_
label values q2_milk q2_milk_
label values q2_ormeat q2_ormeat_
label values q2_pmeat q2_pmeat_
label values q2_ppoul q2_ppoul_
label values q2_upmeat q2_upmeat_
label values q2_uppoul q2_uppoul_
label values q2_fish q2_fish_
label values q2_eggs q2_eggs_
label values q2_gveg q2_gveg_
label values q2_vitaveg q2_vitaveg_
label values q2_vitafruit q2_vitafruit_
label values q2_vegoth q2_vegoth_
label values q2_fruitoth q2_fruitoth_
label values q2_insects q2_insects_
label values q2_palmoil q2_palmoil_
label values q2_oils q2_oils_
label values q2_snacks q2_snacks_
label values q2_sweets q2_sweets_
label values q2_ssb q2_ssb_
label values q2_cond q2_cond_
label values q2_drinkoth q2_drinkoth_
label values q2_grains2 q2_grains2_
label values q2_roots2 q2_roots2_
label values q2_pulses2 q2_pulses2_
label values q2_nuts2 q2_nuts2_
label values q2_milk2 q2_milk2_
label values q2_ormeat2 q2_ormeat2_
label values q2_pmeat2 q2_pmeat2_
label values q2_ppoul2 q2_ppoul2_
label values q2_upmeat2 q2_upmeat2_
label values q2_uppoul2 q2_uppoul2_
label values q2_fish2 q2_fish2_
label values q2_eggs2 q2_eggs2_
label values q2_gveg2 q2_gveg2_
label values q2_vitaveg2 q2_vitaveg2_
label values q2_vitafruit2 q2_vitafruit2_
label values q2_vegoth2 q2_vegoth2_
label values q2_fruitoth2 q2_fruitoth2_
label values q2_insects2 q2_insects2_
label values q2_palmoil2 q2_palmoil2_
label values q2_oils2 q2_oils2_
label values q2_snacks2 q2_snacks2_
label values q2_sweets2 q2_sweets2_
label values q2_ssb2 q2_ssb2_
label values q2_cond2 q2_cond2_
label values q2_eatout q2_eatout_
label values q2_done q2_done_
label values section_2_diet_diver_v_0 section_2_diet_diver_v_0_



** ----------------------------------------------------------------------
** PART 4: VARIABLE METADATA
** ----------------------------------------------------------------------
label variable record_id "Record ID"
label variable q2_usualday "(Q1a) typical/usual day for you?"
label variable q2_unusualhow___1 "(Q1b) Please describe how it was unusual. (choice=Any celebration)"
label variable q2_unusualhow___2 "(Q1b) Please describe how it was unusual. (choice=Fasting)"
label variable q2_unusualhow___3 "(Q1b) Please describe how it was unusual. (choice=Unwell)"
label variable q2_unusualhow___4 "(Q1b) Please describe how it was unusual. (choice=Funeral)"
label variable q2_unusualhow___5 "(Q1b) Please describe how it was unusual. (choice=Other)"
label variable q2_unusualoth "(Q1c) Describe other reason for having an unusual day for eating."
label variable q2_recall1 "(Q2a) Describe ALL the foods (meals and snacks) that you ate or drank yesterday"
label variable q2_recall2 "(Q2b) Main ingredients in the [dish/food] that you ate yesterday?"
label variable q2_recall3 "(Q2c) Anything else that you ate or drank between meals or before bed?"
label variable q2_recall4 "(Q2d) Less than a tablespoon (15g)?"
label variable q2_grains "(Q3A) - Food made from grains"
label variable q2_roots "(Q3B) - White roots, tubers and plantains"
label variable q2_pulses "(Q3C) - Pulses (beans, peas and lentils)"
label variable q2_nuts "(Q3D) - Nuts and seeds"
label variable q2_milk "(Q3E) - Milk and milk products"
label variable q2_ormeat "(Q3F) Organ meat"
label variable q2_pmeat "(Q3G1) - Processed red meat"
label variable q2_ppoul "(Q3G2) - Processed poultry"
label variable q2_upmeat "(Q3G3) - Unprocessed red meat"
label variable q2_uppoul "(Q3G4) - Unprocessed poultry"
label variable q2_fish "(Q3H) - Fish and seafood"
label variable q2_eggs "(Q3I) - Eggs"
label variable q2_gveg "(Q3J) - Dark green leafy vegetables"
label variable q2_vitaveg "(Q3K) - Vitamin A-rich vegetables and tubers"
label variable q2_vitafruit "(Q3L) - Vitamin A-rich fruits"
label variable q2_vegoth "(Q3M) - Other vegetable"
label variable q2_fruitoth "(Q3N) - Other fruits"
label variable q2_insects "(Q3O) - Insects and other small protein foods"
label variable q2_palmoil "(Q3P) - Red palm oil"
label variable q2_oils "(Q3Q) - Other oils and fats"
label variable q2_snacks "(Q3R) - Savoury and fried snacks"
label variable q2_sweets "(Q3S) - Sweets"
label variable q2_ssb "(Q3T) - Sugar-sweetened beverages"
label variable q2_cond "(Q3U) - Condiments and seasonings"
label variable q2_drinkoth "(Q3V) - Other beverages and foods"
label variable q2_grains2 "(Q4A) food made from grains?"
label variable q2_roots2 "(Q4B) White roots, tubers and plantains?"
label variable q2_pulses2 "(Q4C) Pulses (beans, peas and lentils)?"
label variable q2_nuts2 "(Q4D) Nuts and seeds yesterday?"
label variable q2_milk2 "(Q4E) Milk or milk products?"
label variable q2_ormeat2 "(Q4F) Organ meat?"
label variable q2_pmeat2 "(Q4G1) Red meat?"
label variable q2_ppoul2 "(Q4G2) Processed poultry?"
label variable q2_upmeat2 "(Q4G3) Unprocessed red meat?"
label variable q2_uppoul2 "(Q4G4) Unprocessed poultry?"
label variable q2_fish2 "(Q4H) Fish and seafood?"
label variable q2_eggs2 "(Q4I) Eggs?"
label variable q2_gveg2 "(Q4J) Dark green leafy vegetables?"
label variable q2_vitaveg2 "(Q4K) Vitamin-A-rich vegetables?"
label variable q2_vitafruit2 "(Q4L) Vitamin-A rich fruits?"
label variable q2_vegoth2 "(Q4M) Other vegetables?"
label variable q2_fruitoth2 "(Q4N) Other fruits?"
label variable q2_insects2 "(Q4O) Insects and other small protein foods?"
label variable q2_palmoil2 "(Q4P) Red palm oil?"
label variable q2_oils2 "(Q4Q) Oils and fats?"
label variable q2_snacks2 "(Q4R) Savoury and fried snacks?"
label variable q2_sweets2 "(Q4S) Sweets?"
label variable q2_ssb2 "(Q4T) Sugar-sweetened beverages?"
label variable q2_cond2 "(Q4U) Condiments and seasonings?"
label variable q2_eatout "(Q5) Food or drink outside the home yesterday?"
label variable q2_done "Have you covered all relevant questions?"
label variable q2_donereason "What is your reason to not move on to the next survey?"
label variable section_2_diet_diver_v_0 "Complete?"


** ----------------------------------------------------------------------
** PART 5: ORDER AND SAVE THE FILE
** ----------------------------------------------------------------------
order pid record_id q2_usualday q2_unusualhow___1 q2_unusualhow___2 q2_unusualhow___3 q2_unusualhow___4 q2_unusualhow___5 q2_unusualoth q2_recall1 q2_recall2 q2_recall3 q2_recall4 q2_grains q2_roots q2_pulses q2_nuts q2_milk q2_ormeat q2_pmeat q2_ppoul q2_upmeat q2_uppoul q2_fish q2_eggs q2_gveg q2_vitaveg q2_vitafruit q2_vegoth q2_fruitoth q2_insects q2_palmoil q2_oils q2_snacks q2_sweets q2_ssb q2_cond q2_drinkoth q2_grains2 q2_roots2 q2_pulses2 q2_nuts2 q2_milk2 q2_ormeat2 q2_pmeat2 q2_ppoul2 q2_upmeat2 q2_uppoul2 q2_fish2 q2_eggs2 q2_gveg2 q2_vitaveg2 q2_vitafruit2 q2_vegoth2 q2_fruitoth2 q2_insects2 q2_palmoil2 q2_oils2 q2_snacks2 q2_sweets2 q2_ssb2 q2_cond2 q2_eatout q2_done q2_donereason section_2_diet_diver_v_0
set more off
describe

drop record_id q2_unusualoth q2_done q2_donereason section_2_diet_diver_v_0 _merge
label data "CFaH Survey. Dataset01-DietDiversity. Pre-release1. 07Oct2018"
sort pid
datasignature set, saving(cfah2_pr1, replace) reset
save "`datapath'/version01/2-working/section2_pre-release1.dta", replace

set linesize 180
describe, full
