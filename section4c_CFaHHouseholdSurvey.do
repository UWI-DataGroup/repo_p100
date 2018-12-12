* HEADER -----------------------------------------------------
**  DO-FILE METADATA
   //  algorithm name			      section4c_CFaHHouseholdSurvey.do
   //  project:				          Community Food and Health
   //  analysts:				 	        Ian HAMBLETON
   // 	date last modified	      11-DEC-2018
   //  algorithm task			      Preparing DATA: SECTION 4C

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
   log using "`logpath'\section4c_CFaHHouseholdSurvey", replace
** HEADER -----------------------------------------------------


** IMPORT the REDCap EXPORT (11-DEC-2018)
import delimited record_id q4c_borrow q4c_borrowtype___1 q4c_borrowtype___2 q4c_borrowtype___3 q4c_borrowtype___4 q4c_borrowtype___5 q4c_borrowtype___6 q4c_borrowtype___7 q4c_borrowtype___8 q4c_borrowtype___9 q4c_borrowtype___10 q4c_borrowtype___11 q4c_borrowtype___12 q4c_borrowtype___13 q4c_borrowtype___14 q4c_borrowtype___15 q4c_borrowtype___16 q4c_borrowtype___17 q4c_borrowtype___18 q4c_borrowtype___19 q4c_borrowtype___20 q4c_borrowtype___21 q4c_borrowtype___22 q4c_cerealtime q4c_rootstime q4c_vegtime q4c_fruittime q4c_pmeattime q4c_upmeattime q4c_eggstime q4c_fishtime q4c_insecttime q4c_pulsestime q4c_nutstime q4c_milktime q4c_oilstime q4c_sweetstime q4c_snackstime q4c_ssbtime q4c_nalctime q4c_alctime q4c_condtime q4c_mealstime q4c_done q4c_donereason section_4c_food_sour_v_0 using "`datapath'/version01/1-input/section4c_CFaHHouseholdSurvey_11dec2018.csv", varnames(nonames)
label data "CFaH Household Survey: SECTION 4C"

** Merge with de-identified ID numbers
sort record_id
merge 1:1 record_id using "`datapath'/version01/2-working/section1_idlinkage.dta"
order pid, before(record_id)

** ----------------------------------------------------------------------
** PART 2: VARIABLE CATEGORY DEFINITIONS
** ----------------------------------------------------------------------
label define q4c_borrow_ 1 "Yes" 2 "No"
label define q4c_borrowtype___1_ 0 "Unchecked" 1 "Checked"
label define q4c_borrowtype___2_ 0 "Unchecked" 1 "Checked"
label define q4c_borrowtype___3_ 0 "Unchecked" 1 "Checked"
label define q4c_borrowtype___4_ 0 "Unchecked" 1 "Checked"
label define q4c_borrowtype___5_ 0 "Unchecked" 1 "Checked"
label define q4c_borrowtype___6_ 0 "Unchecked" 1 "Checked"
label define q4c_borrowtype___7_ 0 "Unchecked" 1 "Checked"
label define q4c_borrowtype___8_ 0 "Unchecked" 1 "Checked"
label define q4c_borrowtype___9_ 0 "Unchecked" 1 "Checked"
label define q4c_borrowtype___10_ 0 "Unchecked" 1 "Checked"
label define q4c_borrowtype___11_ 0 "Unchecked" 1 "Checked"
label define q4c_borrowtype___12_ 0 "Unchecked" 1 "Checked"
label define q4c_borrowtype___13_ 0 "Unchecked" 1 "Checked"
label define q4c_borrowtype___14_ 0 "Unchecked" 1 "Checked"
label define q4c_borrowtype___15_ 0 "Unchecked" 1 "Checked"
label define q4c_borrowtype___16_ 0 "Unchecked" 1 "Checked"
label define q4c_borrowtype___17_ 0 "Unchecked" 1 "Checked"
label define q4c_borrowtype___18_ 0 "Unchecked" 1 "Checked"
label define q4c_borrowtype___19_ 0 "Unchecked" 1 "Checked"
label define q4c_borrowtype___20_ 0 "Unchecked" 1 "Checked"
label define q4c_borrowtype___21_ 0 "Unchecked" 1 "Checked"
label define q4c_borrowtype___22_ 0 "Unchecked" 1 "Checked"
label define q4c_cerealtime_ 1 "Daily" 2 "2-3 times per week" 3 "Weekly (once per week)" 4 "Fortnightly (once every two weeks)" 5 "Monthly" 6 "Special Occasions  (e.g. wedding, party, funeral)" 7 "Infrequently" 8 "Never" 9 "Dont know"
label define q4c_rootstime_ 1 "Daily" 2 "2-3 times per week" 3 "Weekly (once per week)" 4 "Fortnightly (once every two weeks)" 5 "Monthly" 6 "Special Occasions  (e.g. wedding, party, funeral)" 7 "Infrequently" 8 "Never" 9 "Dont know"
label define q4c_vegtime_ 1 "Daily" 2 "2-3 times per week" 3 "Weekly (once per week)" 4 "Fortnightly (once every two weeks)" 5 "Monthly" 6 "Special Occasions  (e.g. wedding, party, funeral)" 7 "Infrequently" 8 "Never" 9 "Dont know"
label define q4c_fruittime_ 1 "Daily" 2 "2-3 times per week" 3 "Weekly (once per week)" 4 "Fortnightly (once every two weeks)" 5 "Monthly" 6 "Special Occasions  (e.g. wedding, party, funeral)" 7 "Infrequently" 8 "Never" 9 "Dont know"
label define q4c_pmeattime_ 1 "Daily" 2 "2-3 times per week" 3 "Weekly (once per week)" 4 "Fortnightly (once every two weeks)" 5 "Monthly" 6 "Special Occasions  (e.g. wedding, party, funeral)" 7 "Infrequently" 8 "Never" 9 "Dont know"
label define q4c_upmeattime_ 1 "Daily" 2 "2-3 times per week" 3 "Weekly (once per week)" 4 "Fortnightly (once every two weeks)" 5 "Monthly" 6 "Special Occasions  (e.g. wedding, party, funeral)" 7 "Infrequently" 8 "Never" 9 "Dont know"
label define q4c_eggstime_ 1 "Daily" 2 "2-3 times per week" 3 "Weekly (once per week)" 4 "Fortnightly (once every two weeks)" 5 "Monthly" 6 "Special Occasions  (e.g. wedding, party, funeral)" 7 "Infrequently" 8 "Never" 9 "Dont know"
label define q4c_fishtime_ 1 "Daily" 2 "2-3 times per week" 3 "Weekly (once per week)" 4 "Fortnightly (once every two weeks)" 5 "Monthly" 6 "Special Occasions  (e.g. wedding, party, funeral)" 7 "Infrequently" 8 "Never" 9 "Dont know"
label define q4c_insecttime_ 1 "Daily" 2 "2-3 times per week" 3 "Weekly (once per week)" 4 "Fortnightly (once every two weeks)" 5 "Monthly" 6 "Special Occasions  (e.g. wedding, party, funeral)" 7 "Infrequently" 8 "Never" 9 "Dont know"
label define q4c_pulsestime_ 1 "Daily" 2 "2-3 times per week" 3 "Weekly (once per week)" 4 "Fortnightly (once every two weeks)" 5 "Monthly" 6 "Special Occasions  (e.g. wedding, party, funeral)" 7 "Infrequently" 8 "Never" 9 "Dont know"
label define q4c_nutstime_ 1 "Daily" 2 "2-3 times per week" 3 "Weekly (once per week)" 4 "Fortnightly (once every two weeks)" 5 "Monthly" 6 "Special Occasions  (e.g. wedding, party, funeral)" 7 "Infrequently" 8 "Never" 9 "Dont know"
label define q4c_milktime_ 1 "Daily" 2 "2-3 times per week" 3 "Weekly (once per week)" 4 "Fortnightly (once every two weeks)" 5 "Monthly" 6 "Special Occasions  (e.g. wedding, party, funeral)" 7 "Infrequently" 8 "Never" 9 "Dont know"
label define q4c_oilstime_ 1 "Daily" 2 "2-3 times per week" 3 "Weekly (once per week)" 4 "Fortnightly (once every two weeks)" 5 "Monthly" 6 "Special Occasions  (e.g. wedding, party, funeral)" 7 "Infrequently" 8 "Never" 9 "Dont know"
label define q4c_sweetstime_ 1 "Daily" 2 "2-3 times per week" 3 "Weekly (once per week)" 4 "Fortnightly (once every two weeks)" 5 "Monthly" 6 "Special Occasions  (e.g. wedding, party, funeral)" 7 "Infrequently" 8 "Never" 9 "Dont know"
label define q4c_snackstime_ 1 "Daily" 2 "2-3 times per week" 3 "Weekly (once per week)" 4 "Fortnightly (once every two weeks)" 5 "Monthly" 6 "Special Occasions  (e.g. wedding, party, funeral)" 7 "Infrequently" 8 "Never" 9 "Dont know"
label define q4c_ssbtime_ 1 "Daily" 2 "2-3 times per week" 3 "Weekly (once per week)" 4 "Fortnightly (once every two weeks)" 5 "Monthly" 6 "Special Occasions  (e.g. wedding, party, funeral)" 7 "Infrequently" 8 "Never" 9 "Dont know"
label define q4c_nalctime_ 1 "Daily" 2 "2-3 times per week" 3 "Weekly (once per week)" 4 "Fortnightly (once every two weeks)" 5 "Monthly" 6 "Special Occasions  (e.g. wedding, party, funeral)" 7 "Infrequently" 8 "Never" 9 "Dont know"
label define q4c_alctime_ 1 "Daily" 2 "2-3 times per week" 3 "Weekly (once per week)" 4 "Fortnightly (once every two weeks)" 5 "Monthly" 6 "Special Occasions  (e.g. wedding, party, funeral)" 7 "Infrequently" 8 "Never" 9 "Dont know"
label define q4c_condtime_ 1 "Daily" 2 "2-3 times per week" 3 "Weekly (once per week)" 4 "Fortnightly (once every two weeks)" 5 "Monthly" 6 "Special Occasions  (e.g. wedding, party, funeral)" 7 "Infrequently" 8 "Never" 9 "Dont know"
label define q4c_mealstime_ 1 "Daily" 2 "2-3 times per week" 3 "Weekly (once per week)" 4 "Fortnightly (once every two weeks)" 5 "Monthly" 6 "Special Occasions  (e.g. wedding, party, funeral)" 7 "Infrequently" 8 "Never" 9 "Dont know"
label define q4c_done_ 1 "Yes, move on to SECTION 4d - FOOD SOURCE: AID" 2 "No,  will not move on"
label define section_4c_food_sour_v_0_ 0 "Incomplete" 1 "Unverified" 2 "Complete"



** ----------------------------------------------------------------------
** PART 3: VARIABLE CATEGORY LABEL ATTACHMENTS
** ----------------------------------------------------------------------
label values q4c_borrow q4c_borrow_
label values q4c_borrowtype___1 q4c_borrowtype___1_
label values q4c_borrowtype___2 q4c_borrowtype___2_
label values q4c_borrowtype___3 q4c_borrowtype___3_
label values q4c_borrowtype___4 q4c_borrowtype___4_
label values q4c_borrowtype___5 q4c_borrowtype___5_
label values q4c_borrowtype___6 q4c_borrowtype___6_
label values q4c_borrowtype___7 q4c_borrowtype___7_
label values q4c_borrowtype___8 q4c_borrowtype___8_
label values q4c_borrowtype___9 q4c_borrowtype___9_
label values q4c_borrowtype___10 q4c_borrowtype___10_
label values q4c_borrowtype___11 q4c_borrowtype___11_
label values q4c_borrowtype___12 q4c_borrowtype___12_
label values q4c_borrowtype___13 q4c_borrowtype___13_
label values q4c_borrowtype___14 q4c_borrowtype___14_
label values q4c_borrowtype___15 q4c_borrowtype___15_
label values q4c_borrowtype___16 q4c_borrowtype___16_
label values q4c_borrowtype___17 q4c_borrowtype___17_
label values q4c_borrowtype___18 q4c_borrowtype___18_
label values q4c_borrowtype___19 q4c_borrowtype___19_
label values q4c_borrowtype___20 q4c_borrowtype___20_
label values q4c_borrowtype___21 q4c_borrowtype___21_
label values q4c_borrowtype___22 q4c_borrowtype___22_
label values q4c_cerealtime q4c_cerealtime_
label values q4c_rootstime q4c_rootstime_
label values q4c_vegtime q4c_vegtime_
label values q4c_fruittime q4c_fruittime_
label values q4c_pmeattime q4c_pmeattime_
label values q4c_upmeattime q4c_upmeattime_
label values q4c_eggstime q4c_eggstime_
label values q4c_fishtime q4c_fishtime_
label values q4c_insecttime q4c_insecttime_
label values q4c_pulsestime q4c_pulsestime_
label values q4c_nutstime q4c_nutstime_
label values q4c_milktime q4c_milktime_
label values q4c_oilstime q4c_oilstime_
label values q4c_sweetstime q4c_sweetstime_
label values q4c_snackstime q4c_snackstime_
label values q4c_ssbtime q4c_ssbtime_
label values q4c_nalctime q4c_nalctime_
label values q4c_alctime q4c_alctime_
label values q4c_condtime q4c_condtime_
label values q4c_mealstime q4c_mealstime_
label values q4c_done q4c_done_
label values section_4c_food_sour_v_0 section_4c_food_sour_v_0_




** ----------------------------------------------------------------------
** PART 4: VARIABLE METADATA
** ----------------------------------------------------------------------
label variable record_id "Record ID"
label variable q4c_borrow "(Q1) Do you get any of your food and drink from borrowing etc?"

label variable q4c_borrowtype___1 "(Q2) Which food from borrowing etc. (choice=Cereals)"
label variable q4c_borrowtype___2 "(Q2) Which food from borrowing etc. (choice=White roots, tubers and plantains)"
label variable q4c_borrowtype___3 "(Q2) Which food from borrowing etc. (choice=Vegetables)"
label variable q4c_borrowtype___4 "(Q2) Which food from borrowing etc. (choice=Fruit)"
label variable q4c_borrowtype___5 "(Q2) Which food from borrowing etc. (choice=Unprocessed meat)"
label variable q4c_borrowtype___6 "(Q2) Which food from borrowing etc. (choice=Processed meat)"
label variable q4c_borrowtype___7 "(Q2) Which food from borrowing etc. (choice=Eggs)"
label variable q4c_borrowtype___8 "(Q2) Which food from borrowing etc. (choice=Fish and seafood)"
label variable q4c_borrowtype___9 "(Q2) Which food from borrowing etc. (choice=Insects etc)"
label variable q4c_borrowtype___10 "(Q2) Which food from borrowing etc. (choice=Pulses)"
label variable q4c_borrowtype___11 "(Q2) Which food from borrowing etc. (choice=Nuts and seeds)"
label variable q4c_borrowtype___12 "(Q2) Which food from borrowing etc. (choice=Dairy (milk and milk products))"
label variable q4c_borrowtype___13 "(Q2) Which food from borrowing etc. (choice=Oils and fats)"
label variable q4c_borrowtype___14 "(Q2) Which food from borrowing etc. (choice=Sweets)"
label variable q4c_borrowtype___15 "(Q2) Which food from borrowing etc. (choice=Savoury and fried snacks)"
label variable q4c_borrowtype___16 "(Q2) Which food from borrowing etc. (choice=SSBs)"
label variable q4c_borrowtype___17 "(Q2) Which food from borrowing etc. (choice=Non-alc beverages)"
label variable q4c_borrowtype___18 "(Q2) Which food from borrowing etc. (choice=Alcoholic beverages)"
label variable q4c_borrowtype___19 "(Q2) Which food from borrowing etc. (choice=Condiments and seasonings)"
label variable q4c_borrowtype___20 "(Q2) Which food from borrowing etc. (choice=Ready-to-eat meals)"
label variable q4c_borrowtype___21 "(Q2) Which food from borrowing etc. (choice=Other)"
label variable q4c_borrowtype___22 "(Q2) Which food from borrowing etc. (choice=Dont know)"

label variable q4c_cerealtime "(Q2a) How often do you consume cereals from borrowing"
label variable q4c_rootstime "(Q2b) How often do you consume white roots from borrowing"
label variable q4c_vegtime "(Q2c) How often do you consume vegetables from borrowing"
label variable q4c_fruittime "(Q2d) How often do you consume fruits from borrowing"
label variable q4c_pmeattime "(Q2e) How often do you consume processed red meat from borrowing"
label variable q4c_upmeattime "(Q2f) How often do you consume unprocessed red meat from borrowing"
label variable q4c_eggstime "(Q2g) How often do you consume eggs from borrowing"
label variable q4c_fishtime "(Q2h) How often do you consume fish and seafood from borrowing"
label variable q4c_insecttime "(Q2i) How often do you consume insects from borrowing"
label variable q4c_pulsestime "(Q2j) How often do you consume pulses from borrowing"
label variable q4c_nutstime "(Q2k) How often do you consume nuts and seeds from borrowing"
label variable q4c_milktime "(Q2l) How often do you consume dairy from borrowing"
label variable q4c_oilstime "(Q2m) How often do you consume oils and fats that from borrowing"
label variable q4c_sweetstime "(Q2n) How often do you consume sweets from borrowing"
label variable q4c_snackstime "(Q2o) How often do you consume savoury / fried snacks from borrowing"
label variable q4c_ssbtime "(Q2p) How often do you consume SSBs from borrowing"
label variable q4c_nalctime "(Q2q) How often do you consume non-alc beverages from borrowing"
label variable q4c_alctime "(Q2r) How often do you consume alcoholic beverages from borrowing"
label variable q4c_condtime "(Q2s) How often do you consume condiments and seasonings from borrowing"
label variable q4c_mealstime "(Q2t) How often do you consume ready-to-eat meals from borrowing"
label variable q4c_done "Have you covered all relevant questions?"
label variable q4c_donereason "What is your reason to not move on to the next survey?"
label variable section_4c_food_sour_v_0 "Complete?"


** ----------------------------------------------------------------------
** PART 5: ORDER AND SAVE THE FILE
** ----------------------------------------------------------------------
order pid record_id q4c_borrow q4c_borrowtype___1 q4c_borrowtype___2 q4c_borrowtype___3 q4c_borrowtype___4 q4c_borrowtype___5 q4c_borrowtype___6 q4c_borrowtype___7 q4c_borrowtype___8 q4c_borrowtype___9 q4c_borrowtype___10 q4c_borrowtype___11 q4c_borrowtype___12 q4c_borrowtype___13 q4c_borrowtype___14 q4c_borrowtype___15 q4c_borrowtype___16 q4c_borrowtype___17 q4c_borrowtype___18 q4c_borrowtype___19 q4c_borrowtype___20 q4c_borrowtype___21 q4c_borrowtype___22 q4c_cerealtime q4c_rootstime q4c_vegtime q4c_fruittime q4c_pmeattime q4c_upmeattime q4c_eggstime q4c_fishtime q4c_insecttime q4c_pulsestime q4c_nutstime q4c_milktime q4c_oilstime q4c_sweetstime q4c_snackstime q4c_ssbtime q4c_nalctime q4c_alctime q4c_condtime q4c_mealstime q4c_done q4c_donereason section_4c_food_sour_v_0

label data "CFaH Survey. Section4C-DietScreener. Pre-release3. 11Dec2018"
drop record_id q4c_done q4c_donereason section_4c_food_sour_v_0  _merge
sort pid
save "`datapath'/version01/2-working/section4c_pre-release3.dta", replace

set linesize 180
describe, full
