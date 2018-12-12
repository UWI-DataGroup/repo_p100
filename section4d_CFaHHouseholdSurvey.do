** HEADER -----------------------------------------------------
**  DO-FILE METADATA
   //  algorithm name			      section4d_CFaHHouseholdSurvey.do
   //  project:				          Community Food and Health
   //  analysts:				 	        Ian HAMBLETON
   // 	date last modified	      11-DEC-2018
   //  algorithm task			      Preparing DATA: SECTION 4D

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
   log using "`logpath'\section4d_CFaHHouseholdSurvey", replace
** HEADER -----------------------------------------------------


** IMPORT the REDCap EXPORT (11-DEC-2018)
import delimited record_id q4d_aid q4d_aidtype___1 q4d_aidtype___2 q4d_aidtype___3 q4d_aidtype___4 q4d_aidtype___5 q4d_schooltime q4d_schooltype___1 q4d_schooltype___2 q4d_schooltype___3 q4d_schooltype___4 q4d_schooltype___5 q4d_schooltype___6 q4d_schooltype___7 q4d_schooltype___8 q4d_schooltype___9 q4d_schooltype___10 q4d_schooltype___11 q4d_schooltype___12 q4d_schooltype___13 q4d_schooltype___14 q4d_schooltype___15 q4d_schooltype___16 q4d_schooltype___17 q4d_schooltype___18 q4d_schooltype___19 q4d_schooltype___20 q4d_schooltype___21 q4d_schooltype___22 q4d_kitchentime q4d_kitchentype___1 q4d_kitchentype___2 q4d_kitchentype___3 q4d_kitchentype___4 q4d_kitchentype___5 q4d_kitchentype___6 q4d_kitchentype___7 q4d_kitchentype___8 q4d_kitchentype___9 q4d_kitchentype___10 q4d_kitchentype___11 q4d_kitchentype___12 q4d_kitchentype___13 q4d_kitchentype___14 q4d_kitchentype___15 q4d_kitchentype___16 q4d_kitchentype___17 q4d_kitchentype___18 q4d_kitchentype___19 q4d_kitchentype___20 q4d_kitchentype___21 q4d_kitchentype___22 q4d_parceltime q4d_parceltype___1 q4d_parceltype___2 q4d_parceltype___3 q4d_parceltype___4 q4d_parceltype___5 q4d_parceltype___6 q4d_parceltype___7 q4d_parceltype___8 q4d_parceltype___9 q4d_parceltype___10 q4d_parceltype___11 q4d_parceltype___12 q4d_parceltype___13 q4d_parceltype___14 q4d_parceltype___15 q4d_parceltype___16 q4d_parceltype___17 q4d_parceltype___18 q4d_parceltype___19 q4d_parceltype___20 q4d_parceltype___21 q4d_parceltype___22 q4d_done q4d_donereason section_4d_food_sour_v_0 using "`datapath'/version01/1-input/section4d_CFaHHouseholdSurvey_11dec2018.csv", varnames(nonames)
label data "CFaH Household Survey: SECTION 4D"

** Merge with de-identified ID numbers
sort record_id
merge 1:1 record_id using "`datapath'/version01/2-working/section1_idlinkage.dta"
order pid, before(record_id)

** ----------------------------------------------------------------------
** PART 2: VARIABLE CATEGORY DEFINITIONS
** ----------------------------------------------------------------------
label define q4d_aid_ 1 "Yes" 2 "No"
label define q4d_aidtype___1_ 0 "Unchecked" 1 "Checked"
label define q4d_aidtype___2_ 0 "Unchecked" 1 "Checked"
label define q4d_aidtype___3_ 0 "Unchecked" 1 "Checked"
label define q4d_aidtype___4_ 0 "Unchecked" 1 "Checked"
label define q4d_aidtype___5_ 0 "Unchecked" 1 "Checked"
label define q4d_schooltime_ 1 "Daily" 2 "2-3 times per week" 3 "Weekly (once per week)" 4 "Fortnightly (once every two weeks)" 5 "Monthly" 6 "Special Occasions  (e.g. wedding, party, funeral)" 7 "Infrequently" 8 "Never" 9 "Dont know"
label define q4d_schooltype___1_ 0 "Unchecked" 1 "Checked"
label define q4d_schooltype___2_ 0 "Unchecked" 1 "Checked"
label define q4d_schooltype___3_ 0 "Unchecked" 1 "Checked"
label define q4d_schooltype___4_ 0 "Unchecked" 1 "Checked"
label define q4d_schooltype___5_ 0 "Unchecked" 1 "Checked"
label define q4d_schooltype___6_ 0 "Unchecked" 1 "Checked"
label define q4d_schooltype___7_ 0 "Unchecked" 1 "Checked"
label define q4d_schooltype___8_ 0 "Unchecked" 1 "Checked"
label define q4d_schooltype___9_ 0 "Unchecked" 1 "Checked"
label define q4d_schooltype___10_ 0 "Unchecked" 1 "Checked"
label define q4d_schooltype___11_ 0 "Unchecked" 1 "Checked"
label define q4d_schooltype___12_ 0 "Unchecked" 1 "Checked"
label define q4d_schooltype___13_ 0 "Unchecked" 1 "Checked"
label define q4d_schooltype___14_ 0 "Unchecked" 1 "Checked"
label define q4d_schooltype___15_ 0 "Unchecked" 1 "Checked"
label define q4d_schooltype___16_ 0 "Unchecked" 1 "Checked"
label define q4d_schooltype___17_ 0 "Unchecked" 1 "Checked"
label define q4d_schooltype___18_ 0 "Unchecked" 1 "Checked"
label define q4d_schooltype___19_ 0 "Unchecked" 1 "Checked"
label define q4d_schooltype___20_ 0 "Unchecked" 1 "Checked"
label define q4d_schooltype___21_ 0 "Unchecked" 1 "Checked"
label define q4d_schooltype___22_ 0 "Unchecked" 1 "Checked"
label define q4d_kitchentime_ 1 "Daily" 2 "2-3 times per week" 3 "Weekly (once per week)" 4 "Fortnightly (once every two weeks)" 5 "Monthly" 6 "Special Occasions  (e.g. wedding, party, funeral)" 7 "Infrequently" 8 "Never" 9 "Dont know"
label define q4d_kitchentype___1_ 0 "Unchecked" 1 "Checked"
label define q4d_kitchentype___2_ 0 "Unchecked" 1 "Checked"
label define q4d_kitchentype___3_ 0 "Unchecked" 1 "Checked"
label define q4d_kitchentype___4_ 0 "Unchecked" 1 "Checked"
label define q4d_kitchentype___5_ 0 "Unchecked" 1 "Checked"
label define q4d_kitchentype___6_ 0 "Unchecked" 1 "Checked"
label define q4d_kitchentype___7_ 0 "Unchecked" 1 "Checked"
label define q4d_kitchentype___8_ 0 "Unchecked" 1 "Checked"
label define q4d_kitchentype___9_ 0 "Unchecked" 1 "Checked"
label define q4d_kitchentype___10_ 0 "Unchecked" 1 "Checked"
label define q4d_kitchentype___11_ 0 "Unchecked" 1 "Checked"
label define q4d_kitchentype___12_ 0 "Unchecked" 1 "Checked"
label define q4d_kitchentype___13_ 0 "Unchecked" 1 "Checked"
label define q4d_kitchentype___14_ 0 "Unchecked" 1 "Checked"
label define q4d_kitchentype___15_ 0 "Unchecked" 1 "Checked"
label define q4d_kitchentype___16_ 0 "Unchecked" 1 "Checked"
label define q4d_kitchentype___17_ 0 "Unchecked" 1 "Checked"
label define q4d_kitchentype___18_ 0 "Unchecked" 1 "Checked"
label define q4d_kitchentype___19_ 0 "Unchecked" 1 "Checked"
label define q4d_kitchentype___20_ 0 "Unchecked" 1 "Checked"
label define q4d_kitchentype___21_ 0 "Unchecked" 1 "Checked"
label define q4d_kitchentype___22_ 0 "Unchecked" 1 "Checked"
label define q4d_parceltime_ 1 "Daily" 2 "2-3 times per week" 3 "Weekly (once per week)" 4 "Fortnightly (once every two weeks)" 5 "Monthly" 6 "Special Occasions  (e.g. wedding, party, funeral)" 7 "Infrequently" 8 "Never" 9 "Dont know"
label define q4d_parceltype___1_ 0 "Unchecked" 1 "Checked"
label define q4d_parceltype___2_ 0 "Unchecked" 1 "Checked"
label define q4d_parceltype___3_ 0 "Unchecked" 1 "Checked"
label define q4d_parceltype___4_ 0 "Unchecked" 1 "Checked"
label define q4d_parceltype___5_ 0 "Unchecked" 1 "Checked"
label define q4d_parceltype___6_ 0 "Unchecked" 1 "Checked"
label define q4d_parceltype___7_ 0 "Unchecked" 1 "Checked"
label define q4d_parceltype___8_ 0 "Unchecked" 1 "Checked"
label define q4d_parceltype___9_ 0 "Unchecked" 1 "Checked"
label define q4d_parceltype___10_ 0 "Unchecked" 1 "Checked"
label define q4d_parceltype___11_ 0 "Unchecked" 1 "Checked"
label define q4d_parceltype___12_ 0 "Unchecked" 1 "Checked"
label define q4d_parceltype___13_ 0 "Unchecked" 1 "Checked"
label define q4d_parceltype___14_ 0 "Unchecked" 1 "Checked"
label define q4d_parceltype___15_ 0 "Unchecked" 1 "Checked"
label define q4d_parceltype___16_ 0 "Unchecked" 1 "Checked"
label define q4d_parceltype___17_ 0 "Unchecked" 1 "Checked"
label define q4d_parceltype___18_ 0 "Unchecked" 1 "Checked"
label define q4d_parceltype___19_ 0 "Unchecked" 1 "Checked"
label define q4d_parceltype___20_ 0 "Unchecked" 1 "Checked"
label define q4d_parceltype___21_ 0 "Unchecked" 1 "Checked"
label define q4d_parceltype___22_ 0 "Unchecked" 1 "Checked"
label define q4d_done_ 1 "Yes, move on to SECTION 5 - FOOD INSECURITY" 2 "No,  will not move on"
label define section_4d_food_sour_v_0_ 0 "Incomplete" 1 "Unverified" 2 "Complete"



** ----------------------------------------------------------------------
** PART 3: VARIABLE CATEGORY LABEL ATTACHMENTS
** ----------------------------------------------------------------------
label values q4d_aid q4d_aid_
label values q4d_aidtype___1 q4d_aidtype___1_
label values q4d_aidtype___2 q4d_aidtype___2_
label values q4d_aidtype___3 q4d_aidtype___3_
label values q4d_aidtype___4 q4d_aidtype___4_
label values q4d_aidtype___5 q4d_aidtype___5_
label values q4d_schooltime q4d_schooltime_
label values q4d_schooltype___1 q4d_schooltype___1_
label values q4d_schooltype___2 q4d_schooltype___2_
label values q4d_schooltype___3 q4d_schooltype___3_
label values q4d_schooltype___4 q4d_schooltype___4_
label values q4d_schooltype___5 q4d_schooltype___5_
label values q4d_schooltype___6 q4d_schooltype___6_
label values q4d_schooltype___7 q4d_schooltype___7_
label values q4d_schooltype___8 q4d_schooltype___8_
label values q4d_schooltype___9 q4d_schooltype___9_
label values q4d_schooltype___10 q4d_schooltype___10_
label values q4d_schooltype___11 q4d_schooltype___11_
label values q4d_schooltype___12 q4d_schooltype___12_
label values q4d_schooltype___13 q4d_schooltype___13_
label values q4d_schooltype___14 q4d_schooltype___14_
label values q4d_schooltype___15 q4d_schooltype___15_
label values q4d_schooltype___16 q4d_schooltype___16_
label values q4d_schooltype___17 q4d_schooltype___17_
label values q4d_schooltype___18 q4d_schooltype___18_
label values q4d_schooltype___19 q4d_schooltype___19_
label values q4d_schooltype___20 q4d_schooltype___20_
label values q4d_schooltype___21 q4d_schooltype___21_
label values q4d_schooltype___22 q4d_schooltype___22_
label values q4d_kitchentime q4d_kitchentime_
label values q4d_kitchentype___1 q4d_kitchentype___1_
label values q4d_kitchentype___2 q4d_kitchentype___2_
label values q4d_kitchentype___3 q4d_kitchentype___3_
label values q4d_kitchentype___4 q4d_kitchentype___4_
label values q4d_kitchentype___5 q4d_kitchentype___5_
label values q4d_kitchentype___6 q4d_kitchentype___6_
label values q4d_kitchentype___7 q4d_kitchentype___7_
label values q4d_kitchentype___8 q4d_kitchentype___8_
label values q4d_kitchentype___9 q4d_kitchentype___9_
label values q4d_kitchentype___10 q4d_kitchentype___10_
label values q4d_kitchentype___11 q4d_kitchentype___11_
label values q4d_kitchentype___12 q4d_kitchentype___12_
label values q4d_kitchentype___13 q4d_kitchentype___13_
label values q4d_kitchentype___14 q4d_kitchentype___14_
label values q4d_kitchentype___15 q4d_kitchentype___15_
label values q4d_kitchentype___16 q4d_kitchentype___16_
label values q4d_kitchentype___17 q4d_kitchentype___17_
label values q4d_kitchentype___18 q4d_kitchentype___18_
label values q4d_kitchentype___19 q4d_kitchentype___19_
label values q4d_kitchentype___20 q4d_kitchentype___20_
label values q4d_kitchentype___21 q4d_kitchentype___21_
label values q4d_kitchentype___22 q4d_kitchentype___22_
label values q4d_parceltime q4d_parceltime_
label values q4d_parceltype___1 q4d_parceltype___1_
label values q4d_parceltype___2 q4d_parceltype___2_
label values q4d_parceltype___3 q4d_parceltype___3_
label values q4d_parceltype___4 q4d_parceltype___4_
label values q4d_parceltype___5 q4d_parceltype___5_
label values q4d_parceltype___6 q4d_parceltype___6_
label values q4d_parceltype___7 q4d_parceltype___7_
label values q4d_parceltype___8 q4d_parceltype___8_
label values q4d_parceltype___9 q4d_parceltype___9_
label values q4d_parceltype___10 q4d_parceltype___10_
label values q4d_parceltype___11 q4d_parceltype___11_
label values q4d_parceltype___12 q4d_parceltype___12_
label values q4d_parceltype___13 q4d_parceltype___13_
label values q4d_parceltype___14 q4d_parceltype___14_
label values q4d_parceltype___15 q4d_parceltype___15_
label values q4d_parceltype___16 q4d_parceltype___16_
label values q4d_parceltype___17 q4d_parceltype___17_
label values q4d_parceltype___18 q4d_parceltype___18_
label values q4d_parceltype___19 q4d_parceltype___19_
label values q4d_parceltype___20 q4d_parceltype___20_
label values q4d_parceltype___21 q4d_parceltype___21_
label values q4d_parceltype___22 q4d_parceltype___22_
label values q4d_done q4d_done_
label values section_4d_food_sour_v_0 section_4d_food_sour_v_0_




** ----------------------------------------------------------------------
** PART 4: VARIABLE METADATA
** ----------------------------------------------------------------------
label variable record_id "Record ID"
label variable q4d_aid "(Q1) Do you get any of your food and drink from food aid?"
label variable q4d_aidtype___1 "(Q2) Which types of food aid do you get (choice=School feeding progamme)"
label variable q4d_aidtype___2 "(Q2) Which types of food aid do you get (choice=Food kitchen)"
label variable q4d_aidtype___3 "(Q2) Which types of food aid do you get (choice=Food parcel)"
label variable q4d_aidtype___4 "(Q2) Which types of food aid do you get (choice=Other)"
label variable q4d_aidtype___5 "(Q2) Which types of food aid do you get (choice=Dont know)"

label variable q4d_schooltime "(Q2a1) How often do you consume the food from the school feeding programme?"
label variable q4d_schooltype___1 "(Q2a2) What food from a school feeding programme? (choice=Cereals)"
label variable q4d_schooltype___2 "(Q2a2) What food from a school feeding programme? (choice=White roots)"
label variable q4d_schooltype___3 "(Q2a2) What food from a school feeding programme?(choice=Vegetables)"
label variable q4d_schooltype___4 "(Q2a2) What food from a school feeding programme?(choice=Fruit)"
label variable q4d_schooltype___5 "(Q2a2) What food from a school feeding programme?(choice=Unprocessed meat)"
label variable q4d_schooltype___6 "(Q2a2) What food from a school feeding programme?(choice=Processed meat)"
label variable q4d_schooltype___7 "(Q2a2) What food from a school feeding programme?(choice=Eggs)"
label variable q4d_schooltype___8 "(Q2a2) What food from a school feeding programme?(choice=Fish and seafood)"
label variable q4d_schooltype___9 "(Q2a2) What food from a school feeding programme?(choice=Insects etc)"
label variable q4d_schooltype___10 "(Q2a2) What food from a school feeding programme? (choice=Pulses)"
label variable q4d_schooltype___11 "(Q2a2) What food from a school feeding programme? (choice=Nuts and seeds)"
label variable q4d_schooltype___12 "(Q2a2) What food from a school feeding programme? (choice=Dairy)"
label variable q4d_schooltype___13 "(Q2a2) What food from a school feeding programme? (choice=Oils and fats)"
label variable q4d_schooltype___14 "(Q2a2) What food from a school feeding programme? (choice=Sweets)"
label variable q4d_schooltype___15 "(Q2a2) What food from a school feeding programme? (choice=Snacks)"
label variable q4d_schooltype___16 "(Q2a2) What food from a school feeding programme? (choice=SSBs)"
label variable q4d_schooltype___17 "(Q2a2) What food from a school feeding programme? (choice=Non-alc beverages)"
label variable q4d_schooltype___18 "(Q2a2) What food from a school feeding programme? (choice=Alcoholic beverages)"
label variable q4d_schooltype___19 "(Q2a2) What food from a school feeding programme? (choice=Condiments)"
label variable q4d_schooltype___20 "(Q2a2) What food from a school feeding programme? (choice=Ready-to-eat meals)"
label variable q4d_schooltype___21 "(Q2a2) What food from a school feeding programme? (choice=Other)"
label variable q4d_schooltype___22 "(Q2a2) What food from a school feeding programme? (choice=Dont know)"

label variable q4d_kitchentime "(Q2b1) How often do you consume the food that you get from the food kitchen"
label variable q4d_kitchentype___1 "(Q2b2) What food from a food kitchen? (choice=Cereals)"
label variable q4d_kitchentype___2 "(Q2b2) What food from a food kitchen? (choice=White roots, tubers and plantains)"
label variable q4d_kitchentype___3 "(Q2b2) What food from a food kitchen? (choice=Vegetables)"
label variable q4d_kitchentype___4 "(Q2b2) What food from a food kitchen? (choice=Fruit)"
label variable q4d_kitchentype___5 "(Q2b2) What food from a food kitchen? (choice=Unprocessed meat)"
label variable q4d_kitchentype___6 "(Q2b2) What food from a food kitchen? (choice=Processed meat)"
label variable q4d_kitchentype___7 "(Q2b2) What food from a food kitchen? (choice=Eggs)"
label variable q4d_kitchentype___8 "(Q2b2) What food from a food kitchen? (choice=Fish and seafood)"
label variable q4d_kitchentype___9 "(Q2b2) What food from a food kitchen? (choice=Insects etc)"
label variable q4d_kitchentype___10 "(Q2b2) What food from a food kitchen? (choice=Pulses)"
label variable q4d_kitchentype___11 "(Q2b2) What food from a food kitchen? (choice=Nuts and seeds)"
label variable q4d_kitchentype___12 "(Q2b2) What food from a food kitchen? (choice=Dairy (milk and milk products))"
label variable q4d_kitchentype___13 "(Q2b2) What food from a food kitchen? (choice=Oils and fats)"
label variable q4d_kitchentype___14 "(Q2b2) What food from a food kitchen? (choice=Sweets)"
label variable q4d_kitchentype___15 "(Q2b2) What food from a food kitchen? (choice=Savoury and fried snacks)"
label variable q4d_kitchentype___16 "(Q2b2) What food from a food kitchen? (choice=SSBs)"
label variable q4d_kitchentype___17 "(Q2b2) What food from a food kitchen? (choice=Non-alc beverages)"
label variable q4d_kitchentype___18 "(Q2b2) What food from a food kitchen? (choice=Alcoholic beverages)"
label variable q4d_kitchentype___19 "(Q2b2) What food from a food kitchen? (choice=Condiments and seasonings)"
label variable q4d_kitchentype___20 "(Q2b2) What food from a food kitchen? (choice=Ready-to-eat meals)"
label variable q4d_kitchentype___21 "(Q2b2) What food from a food kitchen? (choice=Other)"
label variable q4d_kitchentype___22 "(Q2b2) What food from a food kitchen? (choice=Dont know)"

label variable q4d_parceltime "(Q2c1) How often do you consume the food that you get from the food parcel"
label variable q4d_parceltype___1 "(Q2c2) What food from a food parcel? (choice=Cereals)"
label variable q4d_parceltype___2 "(Q2c2) What food from a food parcel? (choice=White roots, tubers and plantains)"
label variable q4d_parceltype___3 "(Q2c2) What food from a food parcel? (choice=Vegetables)"
label variable q4d_parceltype___4 "(Q2c2) What food from a food parcel? (choice=Fruit)"
label variable q4d_parceltype___5 "(Q2c2) What food from a food parcel? (choice=Unprocessed meat)"
label variable q4d_parceltype___6 "(Q2c2) What food from a food parcel? (choice=Processed meat)"
label variable q4d_parceltype___7 "(Q2c2) What food from a food parcel? (choice=Eggs)"
label variable q4d_parceltype___8 "(Q2c2) What food from a food parcel? (choice=Fish and seafood)"
label variable q4d_parceltype___9 "(Q2c2) What food from a food parcel? (choice=Insects etc)"
label variable q4d_parceltype___10 "(Q2c2)What food from a food parcel?  (choice=Pulses)"
label variable q4d_parceltype___11 "(Q2c2)What food from a food parcel?  (choice=Nuts and seeds)"
label variable q4d_parceltype___12 "(Q2c2)What food from a food parcel?  (choice=Dairy (milk and milk products))"
label variable q4d_parceltype___13 "(Q2c2)What food from a food parcel?  (choice=Oils and fats)"
label variable q4d_parceltype___14 "(Q2c2)What food from a food parcel?  (choice=Sweets)"
label variable q4d_parceltype___15 "(Q2c2)What food from a food parcel?  (choice=Savoury and fried snacks)"
label variable q4d_parceltype___16 "(Q2c2)What food from a food parcel?  (choice=SSBs)"
label variable q4d_parceltype___17 "(Q2c2)What food from a food parcel?  (choice=Non-alc beverages)"
label variable q4d_parceltype___18 "(Q2c2)What food from a food parcel?  (choice=Alcoholic beverages)"
label variable q4d_parceltype___19 "(Q2c2)What food from a food parcel?  (choice=Condiments and seasonings)"
label variable q4d_parceltype___20 "(Q2c2)What food from a food parcel?  (choice=Ready-to-eat meals)"
label variable q4d_parceltype___21 "(Q2c2)What food from a food parcel?  (choice=Other)"
label variable q4d_parceltype___22 "(Q2c2)What food from a food parcel?  (choice=Dont know)"
label variable q4d_done "Have you covered all relevant questions?"
label variable q4d_donereason "What is your reason to not move on to the next survey?"
label variable section_4d_food_sour_v_0 "Complete?"


** ----------------------------------------------------------------------
** PART 5: ORDER AND SAVE THE FILE
** ----------------------------------------------------------------------
order pid record_id q4d_aid q4d_aidtype___1 q4d_aidtype___2 q4d_aidtype___3 q4d_aidtype___4 q4d_aidtype___5 q4d_schooltime q4d_schooltype___1 q4d_schooltype___2 q4d_schooltype___3 q4d_schooltype___4 q4d_schooltype___5 q4d_schooltype___6 q4d_schooltype___7 q4d_schooltype___8 q4d_schooltype___9 q4d_schooltype___10 q4d_schooltype___11 q4d_schooltype___12 q4d_schooltype___13 q4d_schooltype___14 q4d_schooltype___15 q4d_schooltype___16 q4d_schooltype___17 q4d_schooltype___18 q4d_schooltype___19 q4d_schooltype___20 q4d_schooltype___21 q4d_schooltype___22 q4d_kitchentime q4d_kitchentype___1 q4d_kitchentype___2 q4d_kitchentype___3 q4d_kitchentype___4 q4d_kitchentype___5 q4d_kitchentype___6 q4d_kitchentype___7 q4d_kitchentype___8 q4d_kitchentype___9 q4d_kitchentype___10 q4d_kitchentype___11 q4d_kitchentype___12 q4d_kitchentype___13 q4d_kitchentype___14 q4d_kitchentype___15 q4d_kitchentype___16 q4d_kitchentype___17 q4d_kitchentype___18 q4d_kitchentype___19 q4d_kitchentype___20 q4d_kitchentype___21 q4d_kitchentype___22 q4d_parceltime q4d_parceltype___1 q4d_parceltype___2 q4d_parceltype___3 q4d_parceltype___4 q4d_parceltype___5 q4d_parceltype___6 q4d_parceltype___7 q4d_parceltype___8 q4d_parceltype___9 q4d_parceltype___10 q4d_parceltype___11 q4d_parceltype___12 q4d_parceltype___13 q4d_parceltype___14 q4d_parceltype___15 q4d_parceltype___16 q4d_parceltype___17 q4d_parceltype___18 q4d_parceltype___19 q4d_parceltype___20 q4d_parceltype___21 q4d_parceltype___22 q4d_done q4d_donereason section_4d_food_sour_v_0


label data "CFaH Survey. Section4D-DietScreener. Pre-release3. 11Dec2018"
drop record_id q4d_done q4d_donereason section_4d_food_sour_v_0  _merge
sort pid
save "`datapath'/version01/2-working/section4d_pre-release3.dta", replace

set linesize 180
describe, full
