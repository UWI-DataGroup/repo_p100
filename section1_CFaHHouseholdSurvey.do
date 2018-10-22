** HEADER -----------------------------------------------------
**  DO-FILE METADATA
    //  algorithm name			    section1_CFaHHouseholdSurvey.do
    //  project:				    Community Food and Health
    //  analysts:					Ian HAMBLETON
    // 	date last modified	        22-OCT-2018
    //  algorithm task			    Preparing DATA: SECTION 1

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
    log using "`logpath'\section1_CFaHHouseholdSurvey", replace
** HEADER -----------------------------------------------------

** IMPORT the REDCap EXPORT (6-OCT-2018)
 import delimited record_id q1_share q1_intid1 q1_intid2 q1_pid q1_surveydt q1_country q1_district q1_village q1_house q1_phone q1_sex q1_dobpartial q1_dob q1_dobday q1_dobmonth q1_dobyear q1_agecalc q1_age q1_cook___1 q1_cook___2 q1_cook___3 q1_cook___4 q1_housetotal q1_p1sex q1_p1age q1_p2sex q1_p2age q1_p3sex q1_p3age q1_p4sex q1_p4age q1_p5sex q1_p5age q1_p6sex q1_p6age q1_p7sex q1_p7age q1_p8sex q1_p8age q1_p9sex q1_p9age q1_p10sex q1_p10age q1_p11sex q1_p11age q1_p12sex q1_p12age q1_done q1_donereason section_1_participan_v_0 using "`datapath'/version01/1-input/section1_CFaHHouseholdSurvey_22oct2018.csv", varnames(nonames)
label data "CFaH Household Survey: SECTION 1"

** Create Record IDs. COUNTRY SPECIFIC ID and INTERNAL UNIQUE ID
** BY country = cid
** Unique = pid
** ERROR: Fill missing Fiji country indicator
replace q1_country = 1 if q1_country==. &   regexm(record_id,"47-")
gen cid = real(regexr(record_id,"47-",""))
order q1_country cid
sort q1_country cid
gen pid = _n
order q1_country cid pid

** Convert SVG district and FJI village into a single "region" variable
gen q1_region = .
** FJI
replace q1_region = 1 if q1_country==1 & q1_village==1
replace q1_region = 2 if q1_country==1 & q1_village==2
replace q1_region = 3 if q1_country==1 & q1_village==3
replace q1_region = 4 if q1_country==1 & q1_village==4
** SVG
replace q1_region = 5 if q1_country==2 & q1_district==1
replace q1_region = 6 if q1_country==2 & q1_district==2
replace q1_region = 7 if q1_country==2 & q1_district==3
replace q1_region = 8 if q1_country==2 & q1_district==4

** New Household indicator
egen q1_hh = group(q1_country q1_region q1_house)
order q1_country q1_region q1_house q1_hh cid pid

** Within household ID
sort q1_country q1_region q1_hh q1_sex q1_agecalc
bysort q1_country q1_region q1_hh: gen hid = _n
order q1_country q1_region q1_hh hid q1_sex q1_agecalc

** Convert "Do you Cook" (q1_cook) Binary Indicators into a single categorical variable
gen q1_cook = .
replace q1_cook = 1 if q1_cook___1==1
replace q1_cook = 2 if q1_cook___2==1
replace q1_cook = 3 if q1_cook___3==1
replace q1_cook = 4 if q1_cook___4==1


** ----------------------------------------------------------------------
** PART 2: VARIABLE CATEGORY DEFINITIONS
** ----------------------------------------------------------------------
label define q1_share_ 1 "No" 2 "Yes"
label define q1_country_ 1 "Fiji" 2 "St. Vincent"
label define q1_region_ 1 "Rural formal" 2 "Rural informal" 3 "Urban formal" 4 "Urban informal" 5 "Cane Garden" 6 "Fair Hall" 7 "New Grounds" 8 "Overland"
label define q1_sex_ 1 "Male" 2 "Female" 3 "Not stated"
label define q1_dobpartial_ 1 "Yes" 2 "No"
label define q1_cook___1_ 0 "Unchecked" 1 "Checked"
label define q1_cook___2_ 0 "Unchecked" 1 "Checked"
label define q1_cook___3_ 0 "Unchecked" 1 "Checked"
label define q1_cook___4_ 0 "Unchecked" 1 "Checked"
label define q1_cook_ 1 "myself" 2 "relative" 3 "cohabiting partner" 4 "other ono-relative"
label define q1_p1sex_ 1 "Male" 2 "Female" 3 "Not stated"
label define q1_p2sex_ 1 "Male" 2 "Female" 3 "Not stated"
label define q1_p3sex_ 1 "Male" 2 "Female" 3 "Not stated"
label define q1_p4sex_ 1 "Male" 2 "Female" 3 "Not stated"
label define q1_p5sex_ 1 "Male" 2 "Female" 3 "Not stated"
label define q1_p6sex_ 1 "Male" 2 "Female" 3 "Not stated"
label define q1_p7sex_ 1 "Male" 2 "Female" 3 "Not stated"
label define q1_p8sex_ 1 "Male" 2 "Female" 3 "Not stated"
label define q1_p9sex_ 1 "Male" 2 "Female" 3 "Not stated"
label define q1_p10sex_ 1 "Male" 2 "Female" 3 "Not stated"
label define q1_p11sex_ 1 "Male" 2 "Female" 3 "Not stated"
label define q1_p12sex_ 1 "Male" 2 "Female" 3 "Not stated"
label define q1_done_ 1 "Yes, move on to SECTION 2 - DIET DIVERSITY" 2 "No,  will not move on"
label define section_1_participan_v_0_ 0 "Incomplete" 1 "Unverified" 2 "Complete"

** ----------------------------------------------------------------------
** PART 3: VARIABLE CATEGORY LABEL ATTACHMENTS
** ----------------------------------------------------------------------
label values q1_share q1_share_
label values q1_intid1 q1_intid1_
label values q1_intid2 q1_intid2_
label values q1_country q1_country_
label values q1_region q1_region_
label values q1_sex q1_sex_
label values q1_dobpartial q1_dobpartial_
label values q1_dobday q1_dobday_
label values q1_dobmonth q1_dobmonth_
label values q1_cook___1 q1_cook___1_
label values q1_cook___2 q1_cook___2_
label values q1_cook___3 q1_cook___3_
label values q1_cook___4 q1_cook___4_
label values q1_cook q1_cook_
label values q1_p1sex q1_p1sex_
label values q1_p2sex q1_p2sex_
label values q1_p3sex q1_p3sex_
label values q1_p4sex q1_p4sex_
label values q1_p5sex q1_p5sex_
label values q1_p6sex q1_p6sex_
label values q1_p7sex q1_p7sex_
label values q1_p8sex q1_p8sex_
label values q1_p9sex q1_p9sex_
label values q1_p10sex q1_p10sex_
label values q1_p11sex q1_p11sex_
label values q1_p12sex q1_p12sex_
label values q1_done q1_done_
label values section_1_participan_v_0 section_1_participan_v_0_

** ----------------------------------------------------------------------
** PART 4: DATE PREPARATION
** 06-OCT-2018. These potentially identifying variables
**              removed from dataset for now
** ----------------------------------------------------------------------
cap {
  tostring q1_surveydt, replace
  gen double _temp_ = Clock(q1_surveydt,"YMDhm")
  drop q1_surveydt
  rename _temp_ q1_surveydt
  format q1_surveydt %tCMonth_dd,_CCYY_HH:MM
}
cap {
  tostring q1_dob, replace
  gen _date_ = date(q1_dob,"YMD")
  drop q1_dob
  rename _date_ q1_dob
  format q1_dob %dM_d,_CY
}

** ----------------------------------------------------------------------
** PART 5: VARIABLE METADATA
** ----------------------------------------------------------------------
label variable record_id "Record ID"
label variable q1_share "(Q1a) Data collection shared with another field staff?"
label variable q1_intid1 "(Q1b) Select interviewer ID"
label variable q1_intid2 "(Q1c) Select 2nd interviewer ID"
label variable q1_pid "(Q2) State participant ID"
label variable q1_surveydt "(Q3) Select date and time survey administered"
label variable q1_country "(Q4) Survey country"
label variable q1_district "(Q5) Select district"
label variable q1_village "(Q5) Select settlement/village"
label variable q1_house "(Q6) State house number"
label variable q1_phone "(Q7) Verification phone number?"
label variable q1_sex "(Q8) What is your sex?"
label variable q1_dobpartial "(Q9a) Do you know your full date of birth?  "
label variable q1_dob "(Q9b) What is your date of birth?"
label variable q1_dobday "(Q9b) What is your day of birth?"
label variable q1_dobmonth "(Q9c) What is your month of birth?"
label variable q1_dobyear "(Q9d) What is your year of birth?"
label variable q1_agecalc "(Q10) Age at time of survey (nearest year)"
label variable q1_age "(Q10) How old are you now?"
label variable q1_cook___1 "(Q11) Main cook in household? (choice=Myself)"
label variable q1_cook___2 "(Q11) Main cook in household? (choice=Relative)"
label variable q1_cook___3 "(Q11) Main cook in household? (choice=Cohabiting partner)"
label variable q1_cook___4 "(Q11) Main cook in household? (choice=Other non-relative)"
label variable q1_cook "(Q11) Main cook in household? (1-4)"
label variable q1_housetotal "(Q12a) # people living in household (excluding yourself)?"
label variable q1_p1sex "(Q12b) What is the sex of Person 1?"
label variable q1_p1age "(Q12c) What is the age of Person 1?"
label variable q1_p2sex "(Q12d) What is the sex of Person 2?"
label variable q1_p2age "(Q12e) What is the age of Person 2?"
label variable q1_p3sex "(Q12f) What is the sex of Person 3?"
label variable q1_p3age "(Q12g) What is the age of Person 3?"
label variable q1_p4sex "(Q12h) What is the sex of Person 4?"
label variable q1_p4age "(Q12i) What is the age of Person 4?"
label variable q1_p5sex "(Q12j) What is the sex of Person 5?"
label variable q1_p5age "(Q12k) What is the age of Person 5?"
label variable q1_p6sex "(Q12l) What is the sex of Person 6?"
label variable q1_p6age "(Q12m) What is the age of Person 6?"
label variable q1_p7sex "(Q12n) What is the sex of Person 7?"
label variable q1_p7age "(Q12o) What is the age of Person 7?"
label variable q1_p8sex "(Q12p) What is the sex of Person 8?"
label variable q1_p8age "(Q12q) What is the age of Person 8?"
label variable q1_p9sex "(Q12r) What is the sex of Person 9?"
label variable q1_p9age "(Q12s) What is the age of Person 9?"
label variable q1_p10sex "(Q12t) What is the sex of Person 10?"
label variable q1_p10age "(Q12u) What is the age of Person 10?"
label variable q1_p11sex "(Q12v) What is the sex of Person 11?"
label variable q1_p11age "(Q12w) What is the age of Person 11?"
label variable q1_p12sex "(Q12x) What is the sex of Person 12?"
label variable q1_p12age "(Q12y) What is the age of Person 12?"
label variable q1_done "Have you covered all relevant questions?"
label variable q1_donereason "What is your reason to not move on to the next survey?"
label variable section_1_participan_v_0 "Complete?"
label var cid "Within country unique ID"
label var pid "Unique ID"
label var hid "Within household unique ID (ordered by sex, age)"
label var q1_hh "Household number"
label var q1_region "Country region (FJI:1-4, SVG:5-8)"
** ----------------------------------------------------------------------
** PART 1: REMOVAL OF IDENTIFIERS
** ----------------------------------------------------------------------
** Identifiers are registered in REDCap, so could be removed on Export.
** In case this happens, we remove one at a time, and enclose in CAPTURE block to ensure operation
** De-identify House number - running from 1 in each country
local vardrop "q1_phone q1_dob q1_dobday q1_dobmonth q1_dobyear q1_village q1_district q1_surveydt"
foreach var in `vardrop' {
  cap drop `var'
}

** ----------------------------------------------------------------------
** PART 7: ORDER AND SAVE THE FILE
** ----------------------------------------------------------------------

** SAVE IDENTIFIER DATASET TO MERGE WITH OTHER DATASETS
preserve
    keep record_id pid
    label data "CFaH Survey. ID linkage. 07Oct2018"
    save "`datapath'/version01/2-working/section1_idlinkage.dta", replace
restore

order q1_country q1_region q1_house q1_hh hid cid pid record_id q1_share q1_intid1 q1_intid2 q1_pid q1_sex q1_dobpartial q1_agecalc q1_age q1_cook q1_cook___1 q1_cook___2 q1_cook___3 q1_cook___4 q1_housetotal q1_p1sex q1_p1age q1_p2sex q1_p2age q1_p3sex q1_p3age q1_p4sex q1_p4age q1_p5sex q1_p5age q1_p6sex q1_p6age q1_p7sex q1_p7age q1_p8sex q1_p8age q1_p9sex q1_p9age q1_p10sex q1_p10age q1_p11sex q1_p11age q1_p12sex q1_p12age q1_done q1_donereason section_1_participan_v_0
** Further dropping unecessary variables
drop  q1_house q1_share q1_intid1 q1_intid2 q1_pid q1_age q1_dobpartial q1_done q1_donereason section_1_participan_v_0 q1_cook___1 q1_cook___2 q1_cook___3 q1_cook___4
drop record_id

label data "CFaH Survey. Section1-Participant Information. Pre-release2. 22Oct2018"
save "`datapath'/version01/2-working/section1_pre-release2.dta", replace

set linesize 180
describe, full
