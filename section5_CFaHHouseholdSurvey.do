* HEADER -----------------------------------------------------
**  DO-FILE METADATA
    //  algorithm name			      section5_CFaHHouseholdSurvey.do
    //  project:				          Community Food and Health
    //  analysts:				 	        Ian HAMBLETON
    // 	date last modified	      22-OCT-2018
    //  algorithm task			      Preparing DATA: SECTION 5

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
    log using "`logpath'\section5_CFaHHouseholdSurvey", replace
** HEADER -----------------------------------------------------

** IMPORT the REDCap EXPORT (6-OCT-2018)
import delimited record_id q5_worry q5_unable q5_few q5_skip q5_less q5_ranout q5_noteat q5_noteatday q5_done q5_donereason section_5_food_insec_v_0 using "`datapath'/version01/1-input/section5_CFaHHouseholdSurvey_22oct2018.csv", varnames(nonames)
label data "CFaH Household Survey: SECTION 5"

** Merge with de-identified ID numbers
sort record_id
merge 1:1 record_id using "`datapath'/version01/2-working/section1_idlinkage.dta"
order pid, before(record_id)


** ----------------------------------------------------------------------
** PART 2: VARIABLE CATEGORY DEFINITIONS
** ----------------------------------------------------------------------
label define q5_worry_ 1 "No" 2 "Yes" 3 "Dont know" 4 "Refuse to answer"
label define q5_unable_ 1 "No" 2 "Yes" 3 "Dont know" 4 "Refuse to answer"
label define q5_few_ 1 "No" 2 "Yes" 3 "Dont know" 4 "Refuse to answer"
label define q5_skip_ 1 "No" 2 "Yes" 3 "Dont know" 4 "Refuse to answer"
label define q5_less_ 1 "No" 2 "Yes" 3 "Dont know" 4 "Refuse to answer"
label define q5_ranout_ 1 "No" 2 "Yes" 3 "Dont know" 4 "Refuse to answer"
label define q5_noteat_ 1 "No" 2 "Yes" 3 "Dont know" 4 "Refuse to answer"
label define q5_noteatday_ 1 "No" 2 "Yes" 3 "Dont know" 4 "Refuse to answer"
label define q5_done_ 1 "Yes, move on to SECTION 6 - ADDITIONAL DEMOGRAPHIC AND MEDICAL INFORMATION" 2 "No,  will not move on"
label define section_5_food_insec_v_0_ 0 "Incomplete" 1 "Unverified" 2 "Complete"

** ----------------------------------------------------------------------
** PART 3: VARIABLE CATEGORY LABEL ATTACHMENTS
** ----------------------------------------------------------------------
label values q5_worry q5_worry_
label values q5_unable q5_unable_
label values q5_few q5_few_
label values q5_skip q5_skip_
label values q5_less q5_less_
label values q5_ranout q5_ranout_
label values q5_noteat q5_noteat_
label values q5_noteatday q5_noteatday_
label values q5_done q5_done_
label values section_5_food_insec_v_0 section_5_food_insec_v_0_


** ----------------------------------------------------------------------
** PART 4: VARIABLE METADATA
** ----------------------------------------------------------------------
label variable record_id "Record ID"
label variable q5_worry "(Q1) Not have enough food to eat?"
label variable q5_unable "(Q2) Unable to eat healthy and nutritious food?"
label variable q5_few "(Q3) Only a few kinds of foods?"
label variable q5_skip "(Q4) Skip a meal?"
label variable q5_less "(Q5) Ate less than you thought you should?"
label variable q5_ranout "(Q6) Household ran out of food?"
label variable q5_noteat "(Q7) Hungry but did not eat?"
label variable q5_noteatday "(Q8) Went without eating for a whole day?"
label variable q5_done "Have you covered all relevant questions?"
label variable q5_donereason "What is your reason to not move on to the next survey?"
label variable section_5_food_insec_v_0 "Complete?"


** ----------------------------------------------------------------------
** PART 5: ORDER AND SAVE THE FILE
** ----------------------------------------------------------------------

order pid record_id q5_worry q5_unable q5_few q5_skip q5_less q5_ranout q5_noteat q5_noteatday q5_done q5_donereason section_5_food_insec_v_0

label data "CFaH Survey. Section5-DietScreener. Pre-release2. 22Oct2018"
drop record_id q5_done q5_donereason section_5_food_insec_v_0  _merge
sort pid
save "`datapath'/version01/2-working/section5_pre-release2.dta", replace

set linesize 180
describe, full
