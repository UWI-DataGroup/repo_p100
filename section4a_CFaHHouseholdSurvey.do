** HEADER -----------------------------------------------------
**  DO-FILE METADATA
   //  algorithm name			         section4a_CFaHHouseholdSurvey.do
   //  project:				             Community Food and Health
   //  analysts:				 	         Ian HAMBLETON
   // 	date last modified	       11-DEC-2018
   //  algorithm task			         Preparing DATA: SECTION 4A

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
   log using "`logpath'\section4a_CFaHHouseholdSurvey", replace
** HEADER -----------------------------------------------------

** IMPORT the REDCap EXPORT (11-DEC-2018)
import delimited record_id q4a_prodsvg q4a_prodfiji q4a_prod q4a_prodtype___1 q4a_prodtype___2 q4a_prodtype___3 q4a_prodtype___4 q4a_prodtype___5 q4a_prodtype___6 q4a_prodtype___7 q4a_prodtype___8 q4a_prodtype___9 q4a_prodtype___10 q4a_prodtype___11 q4a_prodtype___12 q4a_prodtype___13 q4a_prodtype___14 q4a_prodtype___15 q4a_prodtype___16 q4a_prodtype___17 q4a_prodtype___18 q4a_prodtype___19 q4a_prodtype___20 q4a_prodtype___21 q4a_prodtype___22 q4a_cerealtime q4a_cerealsell q4a_rootstime q4a_rootssell q4a_vegavail q4a_vegtime q4a_vegsell q4a_fruitavail q4a_fruittime q4a_fruitsell q4a_pmeattime q4a_pmeatsell q4a_upmeattime q4a_upmeatsell q4a_eggstime q4a_eggssell q4a_fishtime q4a_fishsell q4a_insecttime q4a_insectsell q4a_pulsestime q4a_pulsessell q4a_nutstime q4a_nutssell q4a_milktime q4a_milksell q4a_oilstime q4a_oilssell q4a_sweetstime q4a_sweetssell q4a_snackstime q4a_snackssell q4a_ssbtime q4a_ssbsell q4a_nalctime q4a_nalcsell q4a_alctime q4a_alcsell q4a_condtime q4a_condsell q4a_mealstime q4a_mealssell q4a_done q4a_donereason section_4a_food_sour_v_0 using "`datapath'/version01/1-input/section4a_CFaHHouseholdSurvey_11dec2018.csv", varnames(nonames)
label data "CFaH Household Survey: SECTION 4A"

** Merge with de-identified ID numbers
sort record_id
merge 1:1 record_id using "`datapath'/version01/2-working/section1_idlinkage.dta"
order pid, before(record_id)

** ----------------------------------------------------------------------
** PART 2: VARIABLE CATEGORY DEFINITIONS
** ----------------------------------------------------------------------
label define q4a_prodsvg_ 1 "St. Vincent and the Grenadines" 2 "Caribbean region" 3 "Internationally (imported)" 4 "Dont know"
label define q4a_prodfiji_ 1 "Fiji" 2 "South Pacific region" 3 "Internationally (imported)" 4 "Dont know"
label define q4a_prod_ 1 "Yes" 2 "No"
label define q4a_prodtype___1_ 0 "Unchecked" 1 "Checked"
label define q4a_prodtype___2_ 0 "Unchecked" 1 "Checked"
label define q4a_prodtype___3_ 0 "Unchecked" 1 "Checked"
label define q4a_prodtype___4_ 0 "Unchecked" 1 "Checked"
label define q4a_prodtype___5_ 0 "Unchecked" 1 "Checked"
label define q4a_prodtype___6_ 0 "Unchecked" 1 "Checked"
label define q4a_prodtype___7_ 0 "Unchecked" 1 "Checked"
label define q4a_prodtype___8_ 0 "Unchecked" 1 "Checked"
label define q4a_prodtype___9_ 0 "Unchecked" 1 "Checked"
label define q4a_prodtype___10_ 0 "Unchecked" 1 "Checked"
label define q4a_prodtype___11_ 0 "Unchecked" 1 "Checked"
label define q4a_prodtype___12_ 0 "Unchecked" 1 "Checked"
label define q4a_prodtype___13_ 0 "Unchecked" 1 "Checked"
label define q4a_prodtype___14_ 0 "Unchecked" 1 "Checked"
label define q4a_prodtype___15_ 0 "Unchecked" 1 "Checked"
label define q4a_prodtype___16_ 0 "Unchecked" 1 "Checked"
label define q4a_prodtype___17_ 0 "Unchecked" 1 "Checked"
label define q4a_prodtype___18_ 0 "Unchecked" 1 "Checked"
label define q4a_prodtype___19_ 0 "Unchecked" 1 "Checked"
label define q4a_prodtype___20_ 0 "Unchecked" 1 "Checked"
label define q4a_prodtype___21_ 0 "Unchecked" 1 "Checked"
label define q4a_prodtype___22_ 0 "Unchecked" 1 "Checked"
label define q4a_cerealtime_ 1 "Daily" 2 "2-3 times per week" 3 "Weekly (once per week)" 4 "Fortnightly (once every two weeks)" 5 "Monthly" 6 "Special Occasions  (e.g. wedding, party, funeral)" 7 "Infrequently" 8 "Never" 9 "Dont know"
label define q4a_cerealsell_ 1 "Yes" 2 "No" 3 "Dont know"
label define q4a_rootstime_ 1 "Daily" 2 "2-3 times per week" 3 "Weekly (once per week)" 4 "Fortnightly (once every two weeks)" 5 "Monthly" 6 "Special Occasions  (e.g. wedding, party, funeral)" 7 "Infrequently" 8 "Never" 9 "Dont know"
label define q4a_rootssell_ 1 "Yes" 2 "No" 3 "Dont know"
label define q4a_vegavail_ 1 "Less than 4 months" 2 "4-6 months" 3 "7-9 months" 4 "Most or all of the year"
label define q4a_vegtime_ 1 "Daily" 2 "2-3 times per week" 3 "Weekly (once per week)" 4 "Fortnightly (once every two weeks)" 5 "Monthly" 6 "Special Occasions  (e.g. wedding, party, funeral)" 7 "Infrequently" 8 "Never" 9 "Dont know"
label define q4a_vegsell_ 1 "Yes" 2 "No" 3 "Dont know"
label define q4a_fruitavail_ 1 "Less than 4 months" 2 "4-6 months" 3 "7-9 months" 4 "Most or all of the year"
label define q4a_fruittime_ 1 "Daily" 2 "2-3 times per week" 3 "Weekly (once per week)" 4 "Fortnightly (once every two weeks)" 5 "Monthly" 6 "Special Occasions  (e.g. wedding, party, funeral)" 7 "Infrequently" 8 "Never" 9 "Dont know"
label define q4a_fruitsell_ 1 "Yes" 2 "No" 3 "Dont know"
label define q4a_pmeattime_ 1 "Daily" 2 "2-3 times per week" 3 "Weekly (once per week)" 4 "Fortnightly (once every two weeks)" 5 "Monthly" 6 "Special Occasions  (e.g. wedding, party, funeral)" 7 "Infrequently" 8 "Never" 9 "Dont know"
label define q4a_pmeatsell_ 1 "Yes" 2 "No" 3 "Dont know"
label define q4a_upmeattime_ 1 "Daily" 2 "2-3 times per week" 3 "Weekly (once per week)" 4 "Fortnightly (once every two weeks)" 5 "Monthly" 6 "Special Occasions  (e.g. wedding, party, funeral)" 7 "Infrequently" 8 "Never" 9 "Dont know"
label define q4a_upmeatsell_ 1 "Yes" 2 "No" 3 "Dont know"
label define q4a_eggstime_ 1 "Daily" 2 "2-3 times per week" 3 "Weekly (once per week)" 4 "Fortnightly (once every two weeks)" 5 "Monthly" 6 "Special Occasions  (e.g. wedding, party, funeral)" 7 "Infrequently" 8 "Never" 9 "Dont know"
label define q4a_eggssell_ 1 "Yes" 2 "No" 3 "Dont know"
label define q4a_fishtime_ 1 "Daily" 2 "2-3 times per week" 3 "Weekly (once per week)" 4 "Fortnightly (once every two weeks)" 5 "Monthly" 6 "Special Occasions  (e.g. wedding, party, funeral)" 7 "Infrequently" 8 "Never" 9 "Dont know"
label define q4a_fishsell_ 1 "Yes" 2 "No" 3 "Dont know"
label define q4a_insecttime_ 1 "Daily" 2 "2-3 times per week" 3 "Weekly (once per week)" 4 "Fortnightly (once every two weeks)" 5 "Monthly" 6 "Special Occasions  (e.g. wedding, party, funeral)" 7 "Infrequently" 8 "Never" 9 "Dont know"
label define q4a_insectsell_ 1 "Yes" 2 "No" 3 "Dont know"
label define q4a_pulsestime_ 1 "Daily" 2 "2-3 times per week" 3 "Weekly (once per week)" 4 "Fortnightly (once every two weeks)" 5 "Monthly" 6 "Special Occasions  (e.g. wedding, party, funeral)" 7 "Infrequently" 8 "Never" 9 "Dont know"
label define q4a_pulsessell_ 1 "Yes" 2 "No" 3 "Dont know"
label define q4a_nutstime_ 1 "Daily" 2 "2-3 times per week" 3 "Weekly (once per week)" 4 "Fortnightly (once every two weeks)" 5 "Monthly" 6 "Special Occasions  (e.g. wedding, party, funeral)" 7 "Infrequently" 8 "Never" 9 "Dont know"
label define q4a_nutssell_ 1 "Yes" 2 "No" 3 "Dont know"
label define q4a_milktime_ 1 "Daily" 2 "2-3 times per week" 3 "Weekly (once per week)" 4 "Fortnightly (once every two weeks)" 5 "Monthly" 6 "Special Occasions  (e.g. wedding, party, funeral)" 7 "Infrequently" 8 "Never" 9 "Dont know"
label define q4a_milksell_ 1 "Yes" 2 "No" 3 "Dont know"
label define q4a_oilstime_ 1 "Daily" 2 "2-3 times per week" 3 "Weekly (once per week)" 4 "Fortnightly (once every two weeks)" 5 "Monthly" 6 "Special Occasions  (e.g. wedding, party, funeral)" 7 "Infrequently" 8 "Never" 9 "Dont know"
label define q4a_oilssell_ 1 "Yes" 2 "No" 3 "Dont know"
label define q4a_sweetstime_ 1 "Daily" 2 "2-3 times per week" 3 "Weekly (once per week)" 4 "Fortnightly (once every two weeks)" 5 "Monthly" 6 "Special Occasions  (e.g. wedding, party, funeral)" 7 "Infrequently" 8 "Never" 9 "Dont know"
label define q4a_sweetssell_ 1 "Yes" 2 "No" 3 "Dont know"
label define q4a_snackstime_ 1 "Daily" 2 "2-3 times per week" 3 "Weekly (once per week)" 4 "Fortnightly (once every two weeks)" 5 "Monthly" 6 "Special Occasions  (e.g. wedding, party, funeral)" 7 "Infrequently" 8 "Never" 9 "Dont know"
label define q4a_snackssell_ 1 "Yes" 2 "No" 3 "Dont know"
label define q4a_ssbtime_ 1 "Daily" 2 "2-3 times per week" 3 "Weekly (once per week)" 4 "Fortnightly (once every two weeks)" 5 "Monthly" 6 "Special Occasions  (e.g. wedding, party, funeral)" 7 "Infrequently" 8 "Never" 9 "Dont know"
label define q4a_ssbsell_ 1 "Yes" 2 "No" 3 "Dont know"
label define q4a_nalctime_ 1 "Daily" 2 "2-3 times per week" 3 "Weekly (once per week)" 4 "Fortnightly (once every two weeks)" 5 "Monthly" 6 "Special Occasions  (e.g. wedding, party, funeral)" 7 "Infrequently" 8 "Never" 9 "Dont know"
label define q4a_nalcsell_ 1 "Yes" 2 "No" 3 "Dont know"
label define q4a_alctime_ 1 "Daily" 2 "2-3 times per week" 3 "Weekly (once per week)" 4 "Fortnightly (once every two weeks)" 5 "Monthly" 6 "Special Occasions  (e.g. wedding, party, funeral)" 7 "Infrequently" 8 "Never" 9 "Dont know"
label define q4a_alcsell_ 1 "Yes" 2 "No" 3 "Dont know"
label define q4a_condtime_ 1 "Daily" 2 "2-3 times per week" 3 "Weekly (once per week)" 4 "Fortnightly (once every two weeks)" 5 "Monthly" 6 "Special Occasions  (e.g. wedding, party, funeral)" 7 "Infrequently" 8 "Never" 9 "Dont know"
label define q4a_condsell_ 1 "Yes" 2 "No" 3 "Dont know"
label define q4a_mealstime_ 1 "Daily" 2 "2-3 times per week" 3 "Weekly (once per week)" 4 "Fortnightly (once every two weeks)" 5 "Monthly" 6 "Special Occasions  (e.g. wedding, party, funeral)" 7 "Infrequently" 8 "Never" 9 "Dont know"
label define q4a_mealssell_ 1 "Yes" 2 "No" 3 "Dont know"
label define q4a_done_ 1 "Yes, move on to Section 4b - FOOD SOURCE: BUY" 2 "No,  will not move on"
label define section_4a_food_sour_v_0_ 0 "Incomplete" 1 "Unverified" 2 "Complete"


** ----------------------------------------------------------------------
** PART 3: VARIABLE CATEGORY LABEL ATTACHMENTS
** ----------------------------------------------------------------------
label values q4a_prodsvg q4a_prodsvg_
label values q4a_prodfiji q4a_prodfiji_
label values q4a_prod q4a_prod_
label values q4a_prodtype___1 q4a_prodtype___1_
label values q4a_prodtype___2 q4a_prodtype___2_
label values q4a_prodtype___3 q4a_prodtype___3_
label values q4a_prodtype___4 q4a_prodtype___4_
label values q4a_prodtype___5 q4a_prodtype___5_
label values q4a_prodtype___6 q4a_prodtype___6_
label values q4a_prodtype___7 q4a_prodtype___7_
label values q4a_prodtype___8 q4a_prodtype___8_
label values q4a_prodtype___9 q4a_prodtype___9_
label values q4a_prodtype___10 q4a_prodtype___10_
label values q4a_prodtype___11 q4a_prodtype___11_
label values q4a_prodtype___12 q4a_prodtype___12_
label values q4a_prodtype___13 q4a_prodtype___13_
label values q4a_prodtype___14 q4a_prodtype___14_
label values q4a_prodtype___15 q4a_prodtype___15_
label values q4a_prodtype___16 q4a_prodtype___16_
label values q4a_prodtype___17 q4a_prodtype___17_
label values q4a_prodtype___18 q4a_prodtype___18_
label values q4a_prodtype___19 q4a_prodtype___19_
label values q4a_prodtype___20 q4a_prodtype___20_
label values q4a_prodtype___21 q4a_prodtype___21_
label values q4a_prodtype___22 q4a_prodtype___22_
label values q4a_cerealtime q4a_cerealtime_
label values q4a_cerealsell q4a_cerealsell_
label values q4a_rootstime q4a_rootstime_
label values q4a_rootssell q4a_rootssell_
label values q4a_vegavail q4a_vegavail_
label values q4a_vegtime q4a_vegtime_
label values q4a_vegsell q4a_vegsell_
label values q4a_fruitavail q4a_fruitavail_
label values q4a_fruittime q4a_fruittime_
label values q4a_fruitsell q4a_fruitsell_
label values q4a_pmeattime q4a_pmeattime_
label values q4a_pmeatsell q4a_pmeatsell_
label values q4a_upmeattime q4a_upmeattime_
label values q4a_upmeatsell q4a_upmeatsell_
label values q4a_eggstime q4a_eggstime_
label values q4a_eggssell q4a_eggssell_
label values q4a_fishtime q4a_fishtime_
label values q4a_fishsell q4a_fishsell_
label values q4a_insecttime q4a_insecttime_
label values q4a_insectsell q4a_insectsell_
label values q4a_pulsestime q4a_pulsestime_
label values q4a_pulsessell q4a_pulsessell_
label values q4a_nutstime q4a_nutstime_
label values q4a_nutssell q4a_nutssell_
label values q4a_milktime q4a_milktime_
label values q4a_milksell q4a_milksell_
label values q4a_oilstime q4a_oilstime_
label values q4a_oilssell q4a_oilssell_
label values q4a_sweetstime q4a_sweetstime_
label values q4a_sweetssell q4a_sweetssell_
label values q4a_snackstime q4a_snackstime_
label values q4a_snackssell q4a_snackssell_
label values q4a_ssbtime q4a_ssbtime_
label values q4a_ssbsell q4a_ssbsell_
label values q4a_nalctime q4a_nalctime_
label values q4a_nalcsell q4a_nalcsell_
label values q4a_alctime q4a_alctime_
label values q4a_alcsell q4a_alcsell_
label values q4a_condtime q4a_condtime_
label values q4a_condsell q4a_condsell_
label values q4a_mealstime q4a_mealstime_
label values q4a_mealssell q4a_mealssell_
label values q4a_done q4a_done_
label values section_4a_food_sour_v_0 section_4a_food_sour_v_0_



** ----------------------------------------------------------------------
** PART 4: VARIABLE METADATA
** ----------------------------------------------------------------------
label variable record_id "Record ID"
label variable q4a_prodsvg "(Q1) Where do you think that most of the food and drink you consume is produced?"
label variable q4a_prodfiji "(Q1) Where do you think that most of the food and drink you consume is produced?"
label variable q4a_prod "(Q2) Do you get any of your food and drink from your own production?"
label variable q4a_prodtype___1 "(Q3) Produce yourself? (choice=Cereals)"
label variable q4a_prodtype___2 "(Q3) Produce yourself? (choice=White roots, tubers and plantains)"
label variable q4a_prodtype___3 "(Q3) Produce yourself?  (choice=Vegetables)"
label variable q4a_prodtype___4 "(Q3) Produce yourself? (choice=Fruit)"
label variable q4a_prodtype___5 "(Q3) Produce yourself? (choice=Unprocessed meat)"
label variable q4a_prodtype___6 "(Q3) Produce yourself?  (choice=Processed meat)"
label variable q4a_prodtype___7 "(Q3) Produce yourself? (choice=Eggs)"
label variable q4a_prodtype___8 "(Q3) Produce yourself? (choice=Fish and seafood)"
label variable q4a_prodtype___9 "(Q3) Produce yourself? (choice=Insects and other small protein foods)"
label variable q4a_prodtype___10 "(Q3) Produce yourself?  (choice=Pulses)"
label variable q4a_prodtype___11 "(Q3) Produce yourself?  (choice=Nuts and seeds)"
label variable q4a_prodtype___12 "(Q3) Produce yourself?  (choice=Dairy (milk and milk products))"
label variable q4a_prodtype___13 "(Q3) Produce yourself?  (choice=Oils and fats)"
label variable q4a_prodtype___14 "(Q3) Produce yourself?  (choice=Sweets)"
label variable q4a_prodtype___15 "(Q3) Produce yourself?  (choice=Savoury and fried snacks)"
label variable q4a_prodtype___16 "(Q3) Produce yourself?  (choice=SSB)"
label variable q4a_prodtype___17 "(Q3) Produce yourself?  (choice=Non-alcoholic beverages)"
label variable q4a_prodtype___18 "(Q3) Produce yourself?  (choice=Alcoholic beverages)"
label variable q4a_prodtype___19 "(Q3) Produce yourself?  (choice=Condiments and seasonings)"
label variable q4a_prodtype___20 "(Q3) Produce yourself?  (choice=Ready-to-eat meals)"
label variable q4a_prodtype___21 "(Q3) Produce yourself?  (choice=Other)"
label variable q4a_prodtype___22 "(Q3) Produce yourself?  (choice=Dont know)"
label variable q4a_cerealtime "(Q3a1) How often do you consume the cereals that you produce?"
label variable q4a_cerealsell "(Q3a2) Do you sell any of the cereals you produce for money?"
label variable q4a_rootstime "(Q3b1) How often do you consume the white roots that you produce?"
label variable q4a_rootssell "(Q3b2) Do you sell any of the white roots you produce for money?"
label variable q4a_vegavail "(Q3c1) During a year how many months are your vegetables available?"
label variable q4a_vegtime "(Q3c2) During that time how often to you consume them?"
label variable q4a_vegsell "(Q3c3) Do you sell any of the vegetables you produce for money?"
label variable q4a_fruitavail "(Q3d1) During a year how many months are your fruits available?"
label variable q4a_fruittime "(Q3d2) During that time how often to you consume them?"
label variable q4a_fruitsell "(Q3d3) Do you sell any of the fruits you produce for money?"
label variable q4a_pmeattime "(Q3e1) How often do you consume the processed meat that you produce?"
label variable q4a_pmeatsell "(Q3e2) Do you sell any of the processed meat you produce for money?"
label variable q4a_upmeattime "(Q3f1) How often do you consume the unprocessed meat that you produce?"
label variable q4a_upmeatsell "(Q3f2) Do you sell any of the unprocessed meat you produce for money?"
label variable q4a_eggstime "(Q3g1) How often do you consume the eggs that you produce?"
label variable q4a_eggssell "(Q3g2) Do you sell any of the eggs you produce for money?"
label variable q4a_fishtime "(Q3h1) How often do you consume the fish and seafood that you produce?"
label variable q4a_fishsell "(Q3h2) Do you sell any of the fish and seafood you produce for money?"
label variable q4a_insecttime "(Q3i1) How often do you consume the insects etc that you produce?"
label variable q4a_insectsell "(Q3i2) Do you sell any of the insects etc you produce for money?"
label variable q4a_pulsestime "(Q3j1)How often do you consume the pulses that you produce?"
label variable q4a_pulsessell "(Q3j2) Do you sell any of the pulses you produce for money?"
label variable q4a_nutstime "(Q3k1) How often do you consume the nuts and seeds that you produce?"
label variable q4a_nutssell "(Q3k2) Do you sell any of the nuts and seeds you produce for money?"
label variable q4a_milktime "(Q3l1) How often do you consume the dairy that you produce?"
label variable q4a_milksell "(Q3l2) Do you sell any of the dairy you produce for money?"
label variable q4a_oilstime "(Q3m1) How often do you consume the oils and fats that you produce?"
label variable q4a_oilssell "(Q3m2) Do you sell any of the oils and fats you produce for money?"
label variable q4a_sweetstime "(Q3n1) How often do you consume the sweets that you produce?"
label variable q4a_sweetssell "(Q3n2) Do you sell any of the sweets you produce for money?"
label variable q4a_snackstime "(Q3o1) How often do you consume the savoury and fried snacks that you produce?"
label variable q4a_snackssell "(Q3o2) Do you sell any of the savoury and fried snacks you produce for money?"
label variable q4a_ssbtime "(Q3p1) How often do you consume the sugar-sweetened beverages that you produce?"
label variable q4a_ssbsell "(Q3p2) Do you sell any of the sugar-sweetened beverages you produce for money?"
label variable q4a_nalctime "(Q3q1) How often do you consume the non-alcoholic beverages that you produce?"
label variable q4a_nalcsell "(Q3q2) Do you sell any of the non-alcoholic beverages you produce for money?"
label variable q4a_alctime "(Q3r1) How often do you consume the alcoholic beverages that you produce"
label variable q4a_alcsell "(Q3r2) Do you sell any of the alcoholic beverages you produce for money?"
label variable q4a_condtime "(Q3s1) How often do you consume the condimentsetc that you produce?"
label variable q4a_condsell "(Q3s2) Do you sell any of the condiments and seasonings you produce for money?"
label variable q4a_mealstime "(Q3t1) How often do you consume the ready-to-eat meals that you produce?"
label variable q4a_mealssell "(Q3t2) Do you sell any of the ready-to-eat meals you produce for money?"
label variable q4a_done "Have you covered all relevant questions?"
label variable q4a_donereason "What is your reason to not move on to the next survey?"
label variable section_4a_food_sour_v_0 "Complete?"

** ----------------------------------------------------------------------
** PART 5: ORDER AND SAVE THE FILE
** ----------------------------------------------------------------------
order pid record_id q4a_prodsvg q4a_prodfiji q4a_prod q4a_prodtype___1 q4a_prodtype___2 q4a_prodtype___3 q4a_prodtype___4 q4a_prodtype___5 q4a_prodtype___6 q4a_prodtype___7 q4a_prodtype___8 q4a_prodtype___9 q4a_prodtype___10 q4a_prodtype___11 q4a_prodtype___12 q4a_prodtype___13 q4a_prodtype___14 q4a_prodtype___15 q4a_prodtype___16 q4a_prodtype___17 q4a_prodtype___18 q4a_prodtype___19 q4a_prodtype___20 q4a_prodtype___21 q4a_prodtype___22 q4a_cerealtime q4a_cerealsell q4a_rootstime q4a_rootssell q4a_vegavail q4a_vegtime q4a_vegsell q4a_fruitavail q4a_fruittime q4a_fruitsell q4a_pmeattime q4a_pmeatsell q4a_upmeattime q4a_upmeatsell q4a_eggstime q4a_eggssell q4a_fishtime q4a_fishsell q4a_insecttime q4a_insectsell q4a_pulsestime q4a_pulsessell q4a_nutstime q4a_nutssell q4a_milktime q4a_milksell q4a_oilstime q4a_oilssell q4a_sweetstime q4a_sweetssell q4a_snackstime q4a_snackssell q4a_ssbtime q4a_ssbsell q4a_nalctime q4a_nalcsell q4a_alctime q4a_alcsell q4a_condtime q4a_condsell q4a_mealstime q4a_mealssell q4a_done q4a_donereason section_4a_food_sour_v_0

label data "CFaH Survey. Section4B-DietScreener. Pre-release3. 11Dec2018"
drop record_id  q4a_done q4a_donereason section_4a_food_sour_v_0 _merge
sort pid
save "`datapath'/version01/2-working/section4a_pre-release3.dta", replace

set linesize 180
describe, full
