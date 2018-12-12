** HEADER -----------------------------------------------------
**  DO-FILE METADATA
   //  algorithm name			      section4b_CFaHHouseholdSurvey.do
   //  project:				          Community Food and Health
   //  analysts:				 	        Ian HAMBLETON
   // 	date last modified	      11-DEC-2018
   //  algorithm task			      Preparing DATA: SECTION 4B

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
   log using "`logpath'\section4b_CFaHHouseholdSurvey", replace
** HEADER -----------------------------------------------------


** IMPORT the REDCap EXPORT (11-DEC-2018)
import delimited record_id q4b_buy q4b_buytype___1 q4b_buytype___2 q4b_buytype___3 q4b_buytype___4 q4b_buytype___5 q4b_buytype___6 q4b_buytype___7 q4b_buytype___8 q4b_buytype___9 q4b_buytype___10 q4b_buytype___11 q4b_buytype___12 q4b_buytype___13 q4b_buytype___14 q4b_buytype___15 q4b_buytype___16 q4b_buytype___17 q4b_buytype___18 q4b_buytype___19 q4b_buytype___20 q4b_buytype___21 q4b_buytype___22 q4b_retailtype___1 q4b_retailtype___2 q4b_retailtype___3 q4b_retailtype___4 q4b_retailtype___5 q4b_retailtype___6 q4b_retailtype___7 q4b_retailtype___8 q4b_retailtype___9 q4b_retailtype___10 q4b_retailtype___11 q4b_retailtype___12 q4b_retailtype___13 q4b_wholetime q4b_wholetype___1 q4b_wholetype___2 q4b_wholetype___3 q4b_wholetype___4 q4b_wholetype___5 q4b_wholetype___6 q4b_wholetype___7 q4b_wholetype___8 q4b_wholetype___9 q4b_wholetype___10 q4b_wholetype___11 q4b_wholetype___12 q4b_wholetype___13 q4b_wholetype___14 q4b_wholetype___15 q4b_wholetype___16 q4b_wholetype___17 q4b_wholetype___18 q4b_wholetype___19 q4b_wholetype___20 q4b_wholetype___21 q4b_wholetype___22 q4b_smarkettime q4b_smarkettype___1 q4b_smarkettype___2 q4b_smarkettype___3 q4b_smarkettype___4 q4b_smarkettype___5 q4b_smarkettype___6 q4b_smarkettype___7 q4b_smarkettype___8 q4b_smarkettype___9 q4b_smarkettype___10 q4b_smarkettype___11 q4b_smarkettype___12 q4b_smarkettype___13 q4b_smarkettype___14 q4b_smarkettype___15 q4b_smarkettype___16 q4b_smarkettype___17 q4b_smarkettype___18 q4b_smarkettype___19 q4b_smarkettype___20 q4b_smarkettype___21 q4b_smarkettype___22 q4b_shoptime q4b_shoptype___1 q4b_shoptype___2 q4b_shoptype___3 q4b_shoptype___4 q4b_shoptype___5 q4b_shoptype___6 q4b_shoptype___7 q4b_shoptype___8 q4b_shoptype___9 q4b_shoptype___10 q4b_shoptype___11 q4b_shoptype___12 q4b_shoptype___13 q4b_shoptype___14 q4b_shoptype___15 q4b_shoptype___16 q4b_shoptype___17 q4b_shoptype___18 q4b_shoptype___19 q4b_shoptype___20 q4b_shoptype___21 q4b_shoptype___22 q4b_dealertime q4b_dealertype___1 q4b_dealertype___2 q4b_dealertype___3 q4b_dealertype___4 q4b_dealertype___5 q4b_dealertype___6 q4b_dealertype___7 q4b_dealertype___8 q4b_dealertype___9 q4b_dealertype___10 q4b_dealertype___11 q4b_dealertype___12 q4b_dealertype___13 q4b_dealertype___14 q4b_dealertype___15 q4b_dealertype___16 q4b_dealertype___17 q4b_dealertype___18 q4b_dealertype___19 q4b_dealertype___20 q4b_dealertype___21 q4b_dealertype___22 q4b_infshoptime q4b_infshoptype___1 q4b_infshoptype___2 q4b_infshoptype___3 q4b_infshoptype___4 q4b_infshoptype___5 q4b_infshoptype___6 q4b_infshoptype___7 q4b_infshoptype___8 q4b_infshoptype___9 q4b_infshoptype___10 q4b_infshoptype___11 q4b_infshoptype___12 q4b_infshoptype___13 q4b_infshoptype___14 q4b_infshoptype___15 q4b_infshoptype___16 q4b_infshoptype___17 q4b_infshoptype___18 q4b_infshoptype___19 q4b_infshoptype___20 q4b_infshoptype___21 q4b_infshoptype___22 q4b_stalltime q4b_stalltype___1 q4b_stalltype___2 q4b_stalltype___3 q4b_stalltype___4 q4b_stalltype___5 q4b_stalltype___6 q4b_stalltype___7 q4b_stalltype___8 q4b_stalltype___9 q4b_stalltype___10 q4b_stalltype___11 q4b_stalltype___12 q4b_stalltype___13 q4b_stalltype___14 q4b_stalltype___15 q4b_stalltype___16 q4b_stalltype___17 q4b_stalltype___18 q4b_stalltype___19 q4b_stalltype___20 q4b_stalltype___21 q4b_stalltype___22 q4b_tradertime q4b_tradertype___1 q4b_tradertype___2 q4b_tradertype___3 q4b_tradertype___4 q4b_tradertype___5 q4b_tradertype___6 q4b_tradertype___7 q4b_tradertype___8 q4b_tradertype___9 q4b_tradertype___10 q4b_tradertype___11 q4b_tradertype___12 q4b_tradertype___13 q4b_tradertype___14 q4b_tradertype___15 q4b_tradertype___16 q4b_tradertype___17 q4b_tradertype___18 q4b_tradertype___19 q4b_tradertype___20 q4b_tradertype___21 q4b_tradertype___22 q4b_abatime q4b_abatype___1 q4b_abatype___2 q4b_abatype___3 q4b_abatype___4 q4b_abatype___5 q4b_abatype___6 q4b_abatype___7 q4b_abatype___8 q4b_abatype___9 q4b_abatype___10 q4b_abatype___11 q4b_abatype___12 q4b_abatype___13 q4b_abatype___14 q4b_abatype___15 q4b_abatype___16 q4b_abatype___17 q4b_abatype___18 q4b_abatype___19 q4b_abatype___20 q4b_abatype___21 q4b_abatype___22 q4b_trucktime q4b_trucktype___1 q4b_trucktype___2 q4b_trucktype___3 q4b_trucktype___4 q4b_trucktype___5 q4b_trucktype___6 q4b_trucktype___7 q4b_trucktype___8 q4b_trucktype___9 q4b_trucktype___10 q4b_trucktype___11 q4b_trucktype___12 q4b_trucktype___13 q4b_trucktype___14 q4b_trucktype___15 q4b_trucktype___16 q4b_trucktype___17 q4b_trucktype___18 q4b_trucktype___19 q4b_trucktype___20 q4b_trucktype___21 q4b_trucktype___22 q4b_schooltime q4b_schooltype___1 q4b_schooltype___2 q4b_schooltype___3 q4b_schooltype___4 q4b_schooltype___5 q4b_schooltype___6 q4b_schooltype___7 q4b_schooltype___8 q4b_schooltype___9 q4b_schooltype___10 q4b_schooltype___11 q4b_schooltype___12 q4b_schooltype___13 q4b_schooltype___14 q4b_schooltype___15 q4b_schooltype___16 q4b_schooltype___17 q4b_schooltype___18 q4b_schooltype___19 q4b_schooltype___20 q4b_schooltype___21 q4b_schooltype___22 q4b_friendtime q4b_friendtype___1 q4b_friendtype___2 q4b_friendtype___3 q4b_friendtype___4 q4b_friendtype___5 q4b_friendtype___6 q4b_friendtype___7 q4b_friendtype___8 q4b_friendtype___9 q4b_friendtype___10 q4b_friendtype___11 q4b_friendtype___12 q4b_friendtype___13 q4b_friendtype___14 q4b_friendtype___15 q4b_friendtype___16 q4b_friendtype___17 q4b_friendtype___18 q4b_friendtype___19 q4b_friendtype___20 q4b_friendtype___21 q4b_friendtype___22 q4b_foodbus___1 q4b_foodbus___2 q4b_foodbus___3 q4b_foodbus___4 q4b_foodbus___5 q4b_foodbus___6 q4b_foodbus___7 q4b_resttime q4b_fftime q4b_tatime q4b_mobiletime q4b_bartime q4b_done q4b_donereason section_4b_food_sour_v_0 using "`datapath'/version01/1-input/section4b_CFaHHouseholdSurvey_11dec2018.csv", varnames(nonames)
label data "CFaH Household Survey: SECTION 4B"

** Merge with de-identified ID numbers
sort record_id
merge 1:1 record_id using "`datapath'/version01/2-working/section1_idlinkage.dta"
order pid, before(record_id)

** ----------------------------------------------------------------------
** PART 2: VARIABLE CATEGORY DEFINITIONS
** ----------------------------------------------------------------------
label define q4b_buy_ 1 "Yes" 2 "No"
label define q4b_buytype___1_ 0 "Unchecked" 1 "Checked"
label define q4b_buytype___2_ 0 "Unchecked" 1 "Checked"
label define q4b_buytype___3_ 0 "Unchecked" 1 "Checked"
label define q4b_buytype___4_ 0 "Unchecked" 1 "Checked"
label define q4b_buytype___5_ 0 "Unchecked" 1 "Checked"
label define q4b_buytype___6_ 0 "Unchecked" 1 "Checked"
label define q4b_buytype___7_ 0 "Unchecked" 1 "Checked"
label define q4b_buytype___8_ 0 "Unchecked" 1 "Checked"
label define q4b_buytype___9_ 0 "Unchecked" 1 "Checked"
label define q4b_buytype___10_ 0 "Unchecked" 1 "Checked"
label define q4b_buytype___11_ 0 "Unchecked" 1 "Checked"
label define q4b_buytype___12_ 0 "Unchecked" 1 "Checked"
label define q4b_buytype___13_ 0 "Unchecked" 1 "Checked"
label define q4b_buytype___14_ 0 "Unchecked" 1 "Checked"
label define q4b_buytype___15_ 0 "Unchecked" 1 "Checked"
label define q4b_buytype___16_ 0 "Unchecked" 1 "Checked"
label define q4b_buytype___17_ 0 "Unchecked" 1 "Checked"
label define q4b_buytype___18_ 0 "Unchecked" 1 "Checked"
label define q4b_buytype___19_ 0 "Unchecked" 1 "Checked"
label define q4b_buytype___20_ 0 "Unchecked" 1 "Checked"
label define q4b_buytype___21_ 0 "Unchecked" 1 "Checked"
label define q4b_buytype___22_ 0 "Unchecked" 1 "Checked"
label define q4b_retailtype___1_ 0 "Unchecked" 1 "Checked"
label define q4b_retailtype___2_ 0 "Unchecked" 1 "Checked"
label define q4b_retailtype___3_ 0 "Unchecked" 1 "Checked"
label define q4b_retailtype___4_ 0 "Unchecked" 1 "Checked"
label define q4b_retailtype___5_ 0 "Unchecked" 1 "Checked"
label define q4b_retailtype___6_ 0 "Unchecked" 1 "Checked"
label define q4b_retailtype___7_ 0 "Unchecked" 1 "Checked"
label define q4b_retailtype___8_ 0 "Unchecked" 1 "Checked"
label define q4b_retailtype___9_ 0 "Unchecked" 1 "Checked"
label define q4b_retailtype___10_ 0 "Unchecked" 1 "Checked"
label define q4b_retailtype___11_ 0 "Unchecked" 1 "Checked"
label define q4b_retailtype___12_ 0 "Unchecked" 1 "Checked"
label define q4b_retailtype___13_ 0 "Unchecked" 1 "Checked"
label define q4b_wholetime_ 1 "Daily" 2 "2-3 times per week" 3 "Weekly (once per week)" 4 "Fortnightly (once every two weeks)" 5 "Monthly" 6 "Special Occasions  (e.g. wedding, party, funeral)" 7 "Infrequently" 8 "Dont know"
label define q4b_wholetype___1_ 0 "Unchecked" 1 "Checked"
label define q4b_wholetype___2_ 0 "Unchecked" 1 "Checked"
label define q4b_wholetype___3_ 0 "Unchecked" 1 "Checked"
label define q4b_wholetype___4_ 0 "Unchecked" 1 "Checked"
label define q4b_wholetype___5_ 0 "Unchecked" 1 "Checked"
label define q4b_wholetype___6_ 0 "Unchecked" 1 "Checked"
label define q4b_wholetype___7_ 0 "Unchecked" 1 "Checked"
label define q4b_wholetype___8_ 0 "Unchecked" 1 "Checked"
label define q4b_wholetype___9_ 0 "Unchecked" 1 "Checked"
label define q4b_wholetype___10_ 0 "Unchecked" 1 "Checked"
label define q4b_wholetype___11_ 0 "Unchecked" 1 "Checked"
label define q4b_wholetype___12_ 0 "Unchecked" 1 "Checked"
label define q4b_wholetype___13_ 0 "Unchecked" 1 "Checked"
label define q4b_wholetype___14_ 0 "Unchecked" 1 "Checked"
label define q4b_wholetype___15_ 0 "Unchecked" 1 "Checked"
label define q4b_wholetype___16_ 0 "Unchecked" 1 "Checked"
label define q4b_wholetype___17_ 0 "Unchecked" 1 "Checked"
label define q4b_wholetype___18_ 0 "Unchecked" 1 "Checked"
label define q4b_wholetype___19_ 0 "Unchecked" 1 "Checked"
label define q4b_wholetype___20_ 0 "Unchecked" 1 "Checked"
label define q4b_wholetype___21_ 0 "Unchecked" 1 "Checked"
label define q4b_wholetype___22_ 0 "Unchecked" 1 "Checked"
label define q4b_smarkettime_ 1 "Daily" 2 "2-3 times per week" 3 "Weekly (once per week)" 4 "Fortnightly (once every two weeks)" 5 "Monthly" 6 "Special Occasions  (e.g. wedding, party, funeral)" 7 "Infrequently" 8 "Dont know"
label define q4b_smarkettype___1_ 0 "Unchecked" 1 "Checked"
label define q4b_smarkettype___2_ 0 "Unchecked" 1 "Checked"
label define q4b_smarkettype___3_ 0 "Unchecked" 1 "Checked"
label define q4b_smarkettype___4_ 0 "Unchecked" 1 "Checked"
label define q4b_smarkettype___5_ 0 "Unchecked" 1 "Checked"
label define q4b_smarkettype___6_ 0 "Unchecked" 1 "Checked"
label define q4b_smarkettype___7_ 0 "Unchecked" 1 "Checked"
label define q4b_smarkettype___8_ 0 "Unchecked" 1 "Checked"
label define q4b_smarkettype___9_ 0 "Unchecked" 1 "Checked"
label define q4b_smarkettype___10_ 0 "Unchecked" 1 "Checked"
label define q4b_smarkettype___11_ 0 "Unchecked" 1 "Checked"
label define q4b_smarkettype___12_ 0 "Unchecked" 1 "Checked"
label define q4b_smarkettype___13_ 0 "Unchecked" 1 "Checked"
label define q4b_smarkettype___14_ 0 "Unchecked" 1 "Checked"
label define q4b_smarkettype___15_ 0 "Unchecked" 1 "Checked"
label define q4b_smarkettype___16_ 0 "Unchecked" 1 "Checked"
label define q4b_smarkettype___17_ 0 "Unchecked" 1 "Checked"
label define q4b_smarkettype___18_ 0 "Unchecked" 1 "Checked"
label define q4b_smarkettype___19_ 0 "Unchecked" 1 "Checked"
label define q4b_smarkettype___20_ 0 "Unchecked" 1 "Checked"
label define q4b_smarkettype___21_ 0 "Unchecked" 1 "Checked"
label define q4b_smarkettype___22_ 0 "Unchecked" 1 "Checked"
label define q4b_shoptime_ 1 "Daily" 2 "2-3 times per week" 3 "Weekly (once per week)" 4 "Fortnightly (once every two weeks)" 5 "Monthly" 6 "Special Occasions  (e.g. wedding, party, funeral)" 7 "Infrequently" 8 "Dont know"
label define q4b_shoptype___1_ 0 "Unchecked" 1 "Checked"
label define q4b_shoptype___2_ 0 "Unchecked" 1 "Checked"
label define q4b_shoptype___3_ 0 "Unchecked" 1 "Checked"
label define q4b_shoptype___4_ 0 "Unchecked" 1 "Checked"
label define q4b_shoptype___5_ 0 "Unchecked" 1 "Checked"
label define q4b_shoptype___6_ 0 "Unchecked" 1 "Checked"
label define q4b_shoptype___7_ 0 "Unchecked" 1 "Checked"
label define q4b_shoptype___8_ 0 "Unchecked" 1 "Checked"
label define q4b_shoptype___9_ 0 "Unchecked" 1 "Checked"
label define q4b_shoptype___10_ 0 "Unchecked" 1 "Checked"
label define q4b_shoptype___11_ 0 "Unchecked" 1 "Checked"
label define q4b_shoptype___12_ 0 "Unchecked" 1 "Checked"
label define q4b_shoptype___13_ 0 "Unchecked" 1 "Checked"
label define q4b_shoptype___14_ 0 "Unchecked" 1 "Checked"
label define q4b_shoptype___15_ 0 "Unchecked" 1 "Checked"
label define q4b_shoptype___16_ 0 "Unchecked" 1 "Checked"
label define q4b_shoptype___17_ 0 "Unchecked" 1 "Checked"
label define q4b_shoptype___18_ 0 "Unchecked" 1 "Checked"
label define q4b_shoptype___19_ 0 "Unchecked" 1 "Checked"
label define q4b_shoptype___20_ 0 "Unchecked" 1 "Checked"
label define q4b_shoptype___21_ 0 "Unchecked" 1 "Checked"
label define q4b_shoptype___22_ 0 "Unchecked" 1 "Checked"
label define q4b_dealertime_ 1 "Daily" 2 "2-3 times per week" 3 "Weekly (once per week)" 4 "Fortnightly (once every two weeks)" 5 "Monthly" 6 "Special Occasions  (e.g. wedding, party, funeral)" 7 "Infrequently" 8 "Dont know"
label define q4b_dealertype___1_ 0 "Unchecked" 1 "Checked"
label define q4b_dealertype___2_ 0 "Unchecked" 1 "Checked"
label define q4b_dealertype___3_ 0 "Unchecked" 1 "Checked"
label define q4b_dealertype___4_ 0 "Unchecked" 1 "Checked"
label define q4b_dealertype___5_ 0 "Unchecked" 1 "Checked"
label define q4b_dealertype___6_ 0 "Unchecked" 1 "Checked"
label define q4b_dealertype___7_ 0 "Unchecked" 1 "Checked"
label define q4b_dealertype___8_ 0 "Unchecked" 1 "Checked"
label define q4b_dealertype___9_ 0 "Unchecked" 1 "Checked"
label define q4b_dealertype___10_ 0 "Unchecked" 1 "Checked"
label define q4b_dealertype___11_ 0 "Unchecked" 1 "Checked"
label define q4b_dealertype___12_ 0 "Unchecked" 1 "Checked"
label define q4b_dealertype___13_ 0 "Unchecked" 1 "Checked"
label define q4b_dealertype___14_ 0 "Unchecked" 1 "Checked"
label define q4b_dealertype___15_ 0 "Unchecked" 1 "Checked"
label define q4b_dealertype___16_ 0 "Unchecked" 1 "Checked"
label define q4b_dealertype___17_ 0 "Unchecked" 1 "Checked"
label define q4b_dealertype___18_ 0 "Unchecked" 1 "Checked"
label define q4b_dealertype___19_ 0 "Unchecked" 1 "Checked"
label define q4b_dealertype___20_ 0 "Unchecked" 1 "Checked"
label define q4b_dealertype___21_ 0 "Unchecked" 1 "Checked"
label define q4b_dealertype___22_ 0 "Unchecked" 1 "Checked"
label define q4b_infshoptime_ 1 "Daily" 2 "2-3 times per week" 3 "Weekly (once per week)" 4 "Fortnightly (once every two weeks)" 5 "Monthly" 6 "Special Occasions  (e.g. wedding, party, funeral)" 7 "Infrequently" 8 "Dont know"
label define q4b_infshoptype___1_ 0 "Unchecked" 1 "Checked"
label define q4b_infshoptype___2_ 0 "Unchecked" 1 "Checked"
label define q4b_infshoptype___3_ 0 "Unchecked" 1 "Checked"
label define q4b_infshoptype___4_ 0 "Unchecked" 1 "Checked"
label define q4b_infshoptype___5_ 0 "Unchecked" 1 "Checked"
label define q4b_infshoptype___6_ 0 "Unchecked" 1 "Checked"
label define q4b_infshoptype___7_ 0 "Unchecked" 1 "Checked"
label define q4b_infshoptype___8_ 0 "Unchecked" 1 "Checked"
label define q4b_infshoptype___9_ 0 "Unchecked" 1 "Checked"
label define q4b_infshoptype___10_ 0 "Unchecked" 1 "Checked"
label define q4b_infshoptype___11_ 0 "Unchecked" 1 "Checked"
label define q4b_infshoptype___12_ 0 "Unchecked" 1 "Checked"
label define q4b_infshoptype___13_ 0 "Unchecked" 1 "Checked"
label define q4b_infshoptype___14_ 0 "Unchecked" 1 "Checked"
label define q4b_infshoptype___15_ 0 "Unchecked" 1 "Checked"
label define q4b_infshoptype___16_ 0 "Unchecked" 1 "Checked"
label define q4b_infshoptype___17_ 0 "Unchecked" 1 "Checked"
label define q4b_infshoptype___18_ 0 "Unchecked" 1 "Checked"
label define q4b_infshoptype___19_ 0 "Unchecked" 1 "Checked"
label define q4b_infshoptype___20_ 0 "Unchecked" 1 "Checked"
label define q4b_infshoptype___21_ 0 "Unchecked" 1 "Checked"
label define q4b_infshoptype___22_ 0 "Unchecked" 1 "Checked"
label define q4b_stalltime_ 1 "Daily" 2 "2-3 times per week" 3 "Weekly (once per week)" 4 "Fortnightly (once every two weeks)" 5 "Monthly" 6 "Special Occasions  (e.g. wedding, party, funeral)" 7 "Infrequently" 8 "Dont know"
label define q4b_stalltype___1_ 0 "Unchecked" 1 "Checked"
label define q4b_stalltype___2_ 0 "Unchecked" 1 "Checked"
label define q4b_stalltype___3_ 0 "Unchecked" 1 "Checked"
label define q4b_stalltype___4_ 0 "Unchecked" 1 "Checked"
label define q4b_stalltype___5_ 0 "Unchecked" 1 "Checked"
label define q4b_stalltype___6_ 0 "Unchecked" 1 "Checked"
label define q4b_stalltype___7_ 0 "Unchecked" 1 "Checked"
label define q4b_stalltype___8_ 0 "Unchecked" 1 "Checked"
label define q4b_stalltype___9_ 0 "Unchecked" 1 "Checked"
label define q4b_stalltype___10_ 0 "Unchecked" 1 "Checked"
label define q4b_stalltype___11_ 0 "Unchecked" 1 "Checked"
label define q4b_stalltype___12_ 0 "Unchecked" 1 "Checked"
label define q4b_stalltype___13_ 0 "Unchecked" 1 "Checked"
label define q4b_stalltype___14_ 0 "Unchecked" 1 "Checked"
label define q4b_stalltype___15_ 0 "Unchecked" 1 "Checked"
label define q4b_stalltype___16_ 0 "Unchecked" 1 "Checked"
label define q4b_stalltype___17_ 0 "Unchecked" 1 "Checked"
label define q4b_stalltype___18_ 0 "Unchecked" 1 "Checked"
label define q4b_stalltype___19_ 0 "Unchecked" 1 "Checked"
label define q4b_stalltype___20_ 0 "Unchecked" 1 "Checked"
label define q4b_stalltype___21_ 0 "Unchecked" 1 "Checked"
label define q4b_stalltype___22_ 0 "Unchecked" 1 "Checked"
label define q4b_tradertime_ 1 "Daily" 2 "2-3 times per week" 3 "Weekly (once per week)" 4 "Fortnightly (once every two weeks)" 5 "Monthly" 6 "Special Occasions  (e.g. wedding, party, funeral)" 7 "Infrequently" 8 "Dont know"
label define q4b_tradertype___1_ 0 "Unchecked" 1 "Checked"
label define q4b_tradertype___2_ 0 "Unchecked" 1 "Checked"
label define q4b_tradertype___3_ 0 "Unchecked" 1 "Checked"
label define q4b_tradertype___4_ 0 "Unchecked" 1 "Checked"
label define q4b_tradertype___5_ 0 "Unchecked" 1 "Checked"
label define q4b_tradertype___6_ 0 "Unchecked" 1 "Checked"
label define q4b_tradertype___7_ 0 "Unchecked" 1 "Checked"
label define q4b_tradertype___8_ 0 "Unchecked" 1 "Checked"
label define q4b_tradertype___9_ 0 "Unchecked" 1 "Checked"
label define q4b_tradertype___10_ 0 "Unchecked" 1 "Checked"
label define q4b_tradertype___11_ 0 "Unchecked" 1 "Checked"
label define q4b_tradertype___12_ 0 "Unchecked" 1 "Checked"
label define q4b_tradertype___13_ 0 "Unchecked" 1 "Checked"
label define q4b_tradertype___14_ 0 "Unchecked" 1 "Checked"
label define q4b_tradertype___15_ 0 "Unchecked" 1 "Checked"
label define q4b_tradertype___16_ 0 "Unchecked" 1 "Checked"
label define q4b_tradertype___17_ 0 "Unchecked" 1 "Checked"
label define q4b_tradertype___18_ 0 "Unchecked" 1 "Checked"
label define q4b_tradertype___19_ 0 "Unchecked" 1 "Checked"
label define q4b_tradertype___20_ 0 "Unchecked" 1 "Checked"
label define q4b_tradertype___21_ 0 "Unchecked" 1 "Checked"
label define q4b_tradertype___22_ 0 "Unchecked" 1 "Checked"
label define q4b_abatime_ 1 "Daily" 2 "2-3 times per week" 3 "Weekly (once per week)" 4 "Fortnightly (once every two weeks)" 5 "Monthly" 6 "Special Occasions  (e.g. wedding, party, funeral)" 7 "Infrequently" 8 "Dont know"
label define q4b_abatype___1_ 0 "Unchecked" 1 "Checked"
label define q4b_abatype___2_ 0 "Unchecked" 1 "Checked"
label define q4b_abatype___3_ 0 "Unchecked" 1 "Checked"
label define q4b_abatype___4_ 0 "Unchecked" 1 "Checked"
label define q4b_abatype___5_ 0 "Unchecked" 1 "Checked"
label define q4b_abatype___6_ 0 "Unchecked" 1 "Checked"
label define q4b_abatype___7_ 0 "Unchecked" 1 "Checked"
label define q4b_abatype___8_ 0 "Unchecked" 1 "Checked"
label define q4b_abatype___9_ 0 "Unchecked" 1 "Checked"
label define q4b_abatype___10_ 0 "Unchecked" 1 "Checked"
label define q4b_abatype___11_ 0 "Unchecked" 1 "Checked"
label define q4b_abatype___12_ 0 "Unchecked" 1 "Checked"
label define q4b_abatype___13_ 0 "Unchecked" 1 "Checked"
label define q4b_abatype___14_ 0 "Unchecked" 1 "Checked"
label define q4b_abatype___15_ 0 "Unchecked" 1 "Checked"
label define q4b_abatype___16_ 0 "Unchecked" 1 "Checked"
label define q4b_abatype___17_ 0 "Unchecked" 1 "Checked"
label define q4b_abatype___18_ 0 "Unchecked" 1 "Checked"
label define q4b_abatype___19_ 0 "Unchecked" 1 "Checked"
label define q4b_abatype___20_ 0 "Unchecked" 1 "Checked"
label define q4b_abatype___21_ 0 "Unchecked" 1 "Checked"
label define q4b_abatype___22_ 0 "Unchecked" 1 "Checked"
label define q4b_trucktime_ 1 "Daily" 2 "2-3 times per week" 3 "Weekly (once per week)" 4 "Fortnightly (once every two weeks)" 5 "Monthly" 6 "Special Occasions  (e.g. wedding, party, funeral)" 7 "Infrequently" 8 "Dont know"
label define q4b_trucktype___1_ 0 "Unchecked" 1 "Checked"
label define q4b_trucktype___2_ 0 "Unchecked" 1 "Checked"
label define q4b_trucktype___3_ 0 "Unchecked" 1 "Checked"
label define q4b_trucktype___4_ 0 "Unchecked" 1 "Checked"
label define q4b_trucktype___5_ 0 "Unchecked" 1 "Checked"
label define q4b_trucktype___6_ 0 "Unchecked" 1 "Checked"
label define q4b_trucktype___7_ 0 "Unchecked" 1 "Checked"
label define q4b_trucktype___8_ 0 "Unchecked" 1 "Checked"
label define q4b_trucktype___9_ 0 "Unchecked" 1 "Checked"
label define q4b_trucktype___10_ 0 "Unchecked" 1 "Checked"
label define q4b_trucktype___11_ 0 "Unchecked" 1 "Checked"
label define q4b_trucktype___12_ 0 "Unchecked" 1 "Checked"
label define q4b_trucktype___13_ 0 "Unchecked" 1 "Checked"
label define q4b_trucktype___14_ 0 "Unchecked" 1 "Checked"
label define q4b_trucktype___15_ 0 "Unchecked" 1 "Checked"
label define q4b_trucktype___16_ 0 "Unchecked" 1 "Checked"
label define q4b_trucktype___17_ 0 "Unchecked" 1 "Checked"
label define q4b_trucktype___18_ 0 "Unchecked" 1 "Checked"
label define q4b_trucktype___19_ 0 "Unchecked" 1 "Checked"
label define q4b_trucktype___20_ 0 "Unchecked" 1 "Checked"
label define q4b_trucktype___21_ 0 "Unchecked" 1 "Checked"
label define q4b_trucktype___22_ 0 "Unchecked" 1 "Checked"
label define q4b_schooltime_ 1 "Daily" 2 "2-3 times per week" 3 "Weekly (once per week)" 4 "Fortnightly (once every two weeks)" 5 "Monthly" 6 "Special Occasions  (e.g. wedding, party, funeral)" 7 "Infrequently" 8 "Dont know"
label define q4b_schooltype___1_ 0 "Unchecked" 1 "Checked"
label define q4b_schooltype___2_ 0 "Unchecked" 1 "Checked"
label define q4b_schooltype___3_ 0 "Unchecked" 1 "Checked"
label define q4b_schooltype___4_ 0 "Unchecked" 1 "Checked"
label define q4b_schooltype___5_ 0 "Unchecked" 1 "Checked"
label define q4b_schooltype___6_ 0 "Unchecked" 1 "Checked"
label define q4b_schooltype___7_ 0 "Unchecked" 1 "Checked"
label define q4b_schooltype___8_ 0 "Unchecked" 1 "Checked"
label define q4b_schooltype___9_ 0 "Unchecked" 1 "Checked"
label define q4b_schooltype___10_ 0 "Unchecked" 1 "Checked"
label define q4b_schooltype___11_ 0 "Unchecked" 1 "Checked"
label define q4b_schooltype___12_ 0 "Unchecked" 1 "Checked"
label define q4b_schooltype___13_ 0 "Unchecked" 1 "Checked"
label define q4b_schooltype___14_ 0 "Unchecked" 1 "Checked"
label define q4b_schooltype___15_ 0 "Unchecked" 1 "Checked"
label define q4b_schooltype___16_ 0 "Unchecked" 1 "Checked"
label define q4b_schooltype___17_ 0 "Unchecked" 1 "Checked"
label define q4b_schooltype___18_ 0 "Unchecked" 1 "Checked"
label define q4b_schooltype___19_ 0 "Unchecked" 1 "Checked"
label define q4b_schooltype___20_ 0 "Unchecked" 1 "Checked"
label define q4b_schooltype___21_ 0 "Unchecked" 1 "Checked"
label define q4b_schooltype___22_ 0 "Unchecked" 1 "Checked"
label define q4b_friendtime_ 1 "Daily" 2 "2-3 times per week" 3 "Weekly (once per week)" 4 "Fortnightly (once every two weeks)" 5 "Monthly" 6 "Special Occasions  (e.g. wedding, party, funeral)" 7 "Infrequently" 8 "Dont know"
label define q4b_friendtype___1_ 0 "Unchecked" 1 "Checked"
label define q4b_friendtype___2_ 0 "Unchecked" 1 "Checked"
label define q4b_friendtype___3_ 0 "Unchecked" 1 "Checked"
label define q4b_friendtype___4_ 0 "Unchecked" 1 "Checked"
label define q4b_friendtype___5_ 0 "Unchecked" 1 "Checked"
label define q4b_friendtype___6_ 0 "Unchecked" 1 "Checked"
label define q4b_friendtype___7_ 0 "Unchecked" 1 "Checked"
label define q4b_friendtype___8_ 0 "Unchecked" 1 "Checked"
label define q4b_friendtype___9_ 0 "Unchecked" 1 "Checked"
label define q4b_friendtype___10_ 0 "Unchecked" 1 "Checked"
label define q4b_friendtype___11_ 0 "Unchecked" 1 "Checked"
label define q4b_friendtype___12_ 0 "Unchecked" 1 "Checked"
label define q4b_friendtype___13_ 0 "Unchecked" 1 "Checked"
label define q4b_friendtype___14_ 0 "Unchecked" 1 "Checked"
label define q4b_friendtype___15_ 0 "Unchecked" 1 "Checked"
label define q4b_friendtype___16_ 0 "Unchecked" 1 "Checked"
label define q4b_friendtype___17_ 0 "Unchecked" 1 "Checked"
label define q4b_friendtype___18_ 0 "Unchecked" 1 "Checked"
label define q4b_friendtype___19_ 0 "Unchecked" 1 "Checked"
label define q4b_friendtype___20_ 0 "Unchecked" 1 "Checked"
label define q4b_friendtype___21_ 0 "Unchecked" 1 "Checked"
label define q4b_friendtype___22_ 0 "Unchecked" 1 "Checked"
label define q4b_foodbus___1_ 0 "Unchecked" 1 "Checked"
label define q4b_foodbus___2_ 0 "Unchecked" 1 "Checked"
label define q4b_foodbus___3_ 0 "Unchecked" 1 "Checked"
label define q4b_foodbus___4_ 0 "Unchecked" 1 "Checked"
label define q4b_foodbus___5_ 0 "Unchecked" 1 "Checked"
label define q4b_foodbus___6_ 0 "Unchecked" 1 "Checked"
label define q4b_foodbus___7_ 0 "Unchecked" 1 "Checked"
label define q4b_resttime_ 1 "Daily" 2 "2-3 times per week" 3 "Weekly (once per week)" 4 "Fortnightly (once every two weeks)" 5 "Monthly" 6 "Special Occasions  (e.g. wedding, party, funeral)" 7 "Infrequently" 8 "Never" 9 "Dont know"
label define q4b_fftime_ 1 "Daily" 2 "2-3 times per week" 3 "Weekly (once per week)" 4 "Fortnightly (once every two weeks)" 5 "Monthly" 6 "Special Occasions  (e.g. wedding, party, funeral)" 7 "Infrequently" 8 "Never" 9 "Dont know"
label define q4b_tatime_ 1 "Daily" 2 "2-3 times per week" 3 "Weekly (once per week)" 4 "Fortnightly (once every two weeks)" 5 "Monthly" 6 "Special Occasions  (e.g. wedding, party, funeral)" 7 "Infrequently" 8 "Never" 9 "Dont know"
label define q4b_mobiletime_ 1 "Daily" 2 "2-3 times per week" 3 "Weekly (once per week)" 4 "Fortnightly (once every two weeks)" 5 "Monthly" 6 "Special Occasions  (e.g. wedding, party, funeral)" 7 "Infrequently" 8 "Never" 9 "Dont know"
label define q4b_bartime_ 1 "Daily" 2 "2-3 times per week" 3 "Weekly (once per week)" 4 "Fortnightly (once every two weeks)" 5 "Monthly" 6 "Special Occasions  (e.g. wedding, party, funeral)" 7 "Infrequently" 8 "Never" 9 "Dont know"
label define q4b_done_ 1 "Yes, move on to SECTION 4c - FOOD SOURCE: BORROW" 2 "No,  will not move on"
label define section_4b_food_sour_v_0_ 0 "Incomplete" 1 "Unverified" 2 "Complete"


** ----------------------------------------------------------------------
** PART 3: VARIABLE CATEGORY LABEL ATTACHMENTS
** ----------------------------------------------------------------------
label values q4b_buy q4b_buy_
label values q4b_buytype___1 q4b_buytype___1_
label values q4b_buytype___2 q4b_buytype___2_
label values q4b_buytype___3 q4b_buytype___3_
label values q4b_buytype___4 q4b_buytype___4_
label values q4b_buytype___5 q4b_buytype___5_
label values q4b_buytype___6 q4b_buytype___6_
label values q4b_buytype___7 q4b_buytype___7_
label values q4b_buytype___8 q4b_buytype___8_
label values q4b_buytype___9 q4b_buytype___9_
label values q4b_buytype___10 q4b_buytype___10_
label values q4b_buytype___11 q4b_buytype___11_
label values q4b_buytype___12 q4b_buytype___12_
label values q4b_buytype___13 q4b_buytype___13_
label values q4b_buytype___14 q4b_buytype___14_
label values q4b_buytype___15 q4b_buytype___15_
label values q4b_buytype___16 q4b_buytype___16_
label values q4b_buytype___17 q4b_buytype___17_
label values q4b_buytype___18 q4b_buytype___18_
label values q4b_buytype___19 q4b_buytype___19_
label values q4b_buytype___20 q4b_buytype___20_
label values q4b_buytype___21 q4b_buytype___21_
label values q4b_buytype___22 q4b_buytype___22_
label values q4b_retailtype___1 q4b_retailtype___1_
label values q4b_retailtype___2 q4b_retailtype___2_
label values q4b_retailtype___3 q4b_retailtype___3_
label values q4b_retailtype___4 q4b_retailtype___4_
label values q4b_retailtype___5 q4b_retailtype___5_
label values q4b_retailtype___6 q4b_retailtype___6_
label values q4b_retailtype___7 q4b_retailtype___7_
label values q4b_retailtype___8 q4b_retailtype___8_
label values q4b_retailtype___9 q4b_retailtype___9_
label values q4b_retailtype___10 q4b_retailtype___10_
label values q4b_retailtype___11 q4b_retailtype___11_
label values q4b_retailtype___12 q4b_retailtype___12_
label values q4b_retailtype___13 q4b_retailtype___13_
label values q4b_wholetime q4b_wholetime_
label values q4b_wholetype___1 q4b_wholetype___1_
label values q4b_wholetype___2 q4b_wholetype___2_
label values q4b_wholetype___3 q4b_wholetype___3_
label values q4b_wholetype___4 q4b_wholetype___4_
label values q4b_wholetype___5 q4b_wholetype___5_
label values q4b_wholetype___6 q4b_wholetype___6_
label values q4b_wholetype___7 q4b_wholetype___7_
label values q4b_wholetype___8 q4b_wholetype___8_
label values q4b_wholetype___9 q4b_wholetype___9_
label values q4b_wholetype___10 q4b_wholetype___10_
label values q4b_wholetype___11 q4b_wholetype___11_
label values q4b_wholetype___12 q4b_wholetype___12_
label values q4b_wholetype___13 q4b_wholetype___13_
label values q4b_wholetype___14 q4b_wholetype___14_
label values q4b_wholetype___15 q4b_wholetype___15_
label values q4b_wholetype___16 q4b_wholetype___16_
label values q4b_wholetype___17 q4b_wholetype___17_
label values q4b_wholetype___18 q4b_wholetype___18_
label values q4b_wholetype___19 q4b_wholetype___19_
label values q4b_wholetype___20 q4b_wholetype___20_
label values q4b_wholetype___21 q4b_wholetype___21_
label values q4b_wholetype___22 q4b_wholetype___22_
label values q4b_smarkettime q4b_smarkettime_
label values q4b_smarkettype___1 q4b_smarkettype___1_
label values q4b_smarkettype___2 q4b_smarkettype___2_
label values q4b_smarkettype___3 q4b_smarkettype___3_
label values q4b_smarkettype___4 q4b_smarkettype___4_
label values q4b_smarkettype___5 q4b_smarkettype___5_
label values q4b_smarkettype___6 q4b_smarkettype___6_
label values q4b_smarkettype___7 q4b_smarkettype___7_
label values q4b_smarkettype___8 q4b_smarkettype___8_
label values q4b_smarkettype___9 q4b_smarkettype___9_
label values q4b_smarkettype___10 q4b_smarkettype___10_
label values q4b_smarkettype___11 q4b_smarkettype___11_
label values q4b_smarkettype___12 q4b_smarkettype___12_
label values q4b_smarkettype___13 q4b_smarkettype___13_
label values q4b_smarkettype___14 q4b_smarkettype___14_
label values q4b_smarkettype___15 q4b_smarkettype___15_
label values q4b_smarkettype___16 q4b_smarkettype___16_
label values q4b_smarkettype___17 q4b_smarkettype___17_
label values q4b_smarkettype___18 q4b_smarkettype___18_
label values q4b_smarkettype___19 q4b_smarkettype___19_
label values q4b_smarkettype___20 q4b_smarkettype___20_
label values q4b_smarkettype___21 q4b_smarkettype___21_
label values q4b_smarkettype___22 q4b_smarkettype___22_
label values q4b_shoptime q4b_shoptime_
label values q4b_shoptype___1 q4b_shoptype___1_
label values q4b_shoptype___2 q4b_shoptype___2_
label values q4b_shoptype___3 q4b_shoptype___3_
label values q4b_shoptype___4 q4b_shoptype___4_
label values q4b_shoptype___5 q4b_shoptype___5_
label values q4b_shoptype___6 q4b_shoptype___6_
label values q4b_shoptype___7 q4b_shoptype___7_
label values q4b_shoptype___8 q4b_shoptype___8_
label values q4b_shoptype___9 q4b_shoptype___9_
label values q4b_shoptype___10 q4b_shoptype___10_
label values q4b_shoptype___11 q4b_shoptype___11_
label values q4b_shoptype___12 q4b_shoptype___12_
label values q4b_shoptype___13 q4b_shoptype___13_
label values q4b_shoptype___14 q4b_shoptype___14_
label values q4b_shoptype___15 q4b_shoptype___15_
label values q4b_shoptype___16 q4b_shoptype___16_
label values q4b_shoptype___17 q4b_shoptype___17_
label values q4b_shoptype___18 q4b_shoptype___18_
label values q4b_shoptype___19 q4b_shoptype___19_
label values q4b_shoptype___20 q4b_shoptype___20_
label values q4b_shoptype___21 q4b_shoptype___21_
label values q4b_shoptype___22 q4b_shoptype___22_
label values q4b_dealertime q4b_dealertime_
label values q4b_dealertype___1 q4b_dealertype___1_
label values q4b_dealertype___2 q4b_dealertype___2_
label values q4b_dealertype___3 q4b_dealertype___3_
label values q4b_dealertype___4 q4b_dealertype___4_
label values q4b_dealertype___5 q4b_dealertype___5_
label values q4b_dealertype___6 q4b_dealertype___6_
label values q4b_dealertype___7 q4b_dealertype___7_
label values q4b_dealertype___8 q4b_dealertype___8_
label values q4b_dealertype___9 q4b_dealertype___9_
label values q4b_dealertype___10 q4b_dealertype___10_
label values q4b_dealertype___11 q4b_dealertype___11_
label values q4b_dealertype___12 q4b_dealertype___12_
label values q4b_dealertype___13 q4b_dealertype___13_
label values q4b_dealertype___14 q4b_dealertype___14_
label values q4b_dealertype___15 q4b_dealertype___15_
label values q4b_dealertype___16 q4b_dealertype___16_
label values q4b_dealertype___17 q4b_dealertype___17_
label values q4b_dealertype___18 q4b_dealertype___18_
label values q4b_dealertype___19 q4b_dealertype___19_
label values q4b_dealertype___20 q4b_dealertype___20_
label values q4b_dealertype___21 q4b_dealertype___21_
label values q4b_dealertype___22 q4b_dealertype___22_
label values q4b_infshoptime q4b_infshoptime_
label values q4b_infshoptype___1 q4b_infshoptype___1_
label values q4b_infshoptype___2 q4b_infshoptype___2_
label values q4b_infshoptype___3 q4b_infshoptype___3_
label values q4b_infshoptype___4 q4b_infshoptype___4_
label values q4b_infshoptype___5 q4b_infshoptype___5_
label values q4b_infshoptype___6 q4b_infshoptype___6_
label values q4b_infshoptype___7 q4b_infshoptype___7_
label values q4b_infshoptype___8 q4b_infshoptype___8_
label values q4b_infshoptype___9 q4b_infshoptype___9_
label values q4b_infshoptype___10 q4b_infshoptype___10_
label values q4b_infshoptype___11 q4b_infshoptype___11_
label values q4b_infshoptype___12 q4b_infshoptype___12_
label values q4b_infshoptype___13 q4b_infshoptype___13_
label values q4b_infshoptype___14 q4b_infshoptype___14_
label values q4b_infshoptype___15 q4b_infshoptype___15_
label values q4b_infshoptype___16 q4b_infshoptype___16_
label values q4b_infshoptype___17 q4b_infshoptype___17_
label values q4b_infshoptype___18 q4b_infshoptype___18_
label values q4b_infshoptype___19 q4b_infshoptype___19_
label values q4b_infshoptype___20 q4b_infshoptype___20_
label values q4b_infshoptype___21 q4b_infshoptype___21_
label values q4b_infshoptype___22 q4b_infshoptype___22_
label values q4b_stalltime q4b_stalltime_
label values q4b_stalltype___1 q4b_stalltype___1_
label values q4b_stalltype___2 q4b_stalltype___2_
label values q4b_stalltype___3 q4b_stalltype___3_
label values q4b_stalltype___4 q4b_stalltype___4_
label values q4b_stalltype___5 q4b_stalltype___5_
label values q4b_stalltype___6 q4b_stalltype___6_
label values q4b_stalltype___7 q4b_stalltype___7_
label values q4b_stalltype___8 q4b_stalltype___8_
label values q4b_stalltype___9 q4b_stalltype___9_
label values q4b_stalltype___10 q4b_stalltype___10_
label values q4b_stalltype___11 q4b_stalltype___11_
label values q4b_stalltype___12 q4b_stalltype___12_
label values q4b_stalltype___13 q4b_stalltype___13_
label values q4b_stalltype___14 q4b_stalltype___14_
label values q4b_stalltype___15 q4b_stalltype___15_
label values q4b_stalltype___16 q4b_stalltype___16_
label values q4b_stalltype___17 q4b_stalltype___17_
label values q4b_stalltype___18 q4b_stalltype___18_
label values q4b_stalltype___19 q4b_stalltype___19_
label values q4b_stalltype___20 q4b_stalltype___20_
label values q4b_stalltype___21 q4b_stalltype___21_
label values q4b_stalltype___22 q4b_stalltype___22_
label values q4b_tradertime q4b_tradertime_
label values q4b_tradertype___1 q4b_tradertype___1_
label values q4b_tradertype___2 q4b_tradertype___2_
label values q4b_tradertype___3 q4b_tradertype___3_
label values q4b_tradertype___4 q4b_tradertype___4_
label values q4b_tradertype___5 q4b_tradertype___5_
label values q4b_tradertype___6 q4b_tradertype___6_
label values q4b_tradertype___7 q4b_tradertype___7_
label values q4b_tradertype___8 q4b_tradertype___8_
label values q4b_tradertype___9 q4b_tradertype___9_
label values q4b_tradertype___10 q4b_tradertype___10_
label values q4b_tradertype___11 q4b_tradertype___11_
label values q4b_tradertype___12 q4b_tradertype___12_
label values q4b_tradertype___13 q4b_tradertype___13_
label values q4b_tradertype___14 q4b_tradertype___14_
label values q4b_tradertype___15 q4b_tradertype___15_
label values q4b_tradertype___16 q4b_tradertype___16_
label values q4b_tradertype___17 q4b_tradertype___17_
label values q4b_tradertype___18 q4b_tradertype___18_
label values q4b_tradertype___19 q4b_tradertype___19_
label values q4b_tradertype___20 q4b_tradertype___20_
label values q4b_tradertype___21 q4b_tradertype___21_
label values q4b_tradertype___22 q4b_tradertype___22_
label values q4b_abatime q4b_abatime_
label values q4b_abatype___1 q4b_abatype___1_
label values q4b_abatype___2 q4b_abatype___2_
label values q4b_abatype___3 q4b_abatype___3_
label values q4b_abatype___4 q4b_abatype___4_
label values q4b_abatype___5 q4b_abatype___5_
label values q4b_abatype___6 q4b_abatype___6_
label values q4b_abatype___7 q4b_abatype___7_
label values q4b_abatype___8 q4b_abatype___8_
label values q4b_abatype___9 q4b_abatype___9_
label values q4b_abatype___10 q4b_abatype___10_
label values q4b_abatype___11 q4b_abatype___11_
label values q4b_abatype___12 q4b_abatype___12_
label values q4b_abatype___13 q4b_abatype___13_
label values q4b_abatype___14 q4b_abatype___14_
label values q4b_abatype___15 q4b_abatype___15_
label values q4b_abatype___16 q4b_abatype___16_
label values q4b_abatype___17 q4b_abatype___17_
label values q4b_abatype___18 q4b_abatype___18_
label values q4b_abatype___19 q4b_abatype___19_
label values q4b_abatype___20 q4b_abatype___20_
label values q4b_abatype___21 q4b_abatype___21_
label values q4b_abatype___22 q4b_abatype___22_
label values q4b_trucktime q4b_trucktime_
label values q4b_trucktype___1 q4b_trucktype___1_
label values q4b_trucktype___2 q4b_trucktype___2_
label values q4b_trucktype___3 q4b_trucktype___3_
label values q4b_trucktype___4 q4b_trucktype___4_
label values q4b_trucktype___5 q4b_trucktype___5_
label values q4b_trucktype___6 q4b_trucktype___6_
label values q4b_trucktype___7 q4b_trucktype___7_
label values q4b_trucktype___8 q4b_trucktype___8_
label values q4b_trucktype___9 q4b_trucktype___9_
label values q4b_trucktype___10 q4b_trucktype___10_
label values q4b_trucktype___11 q4b_trucktype___11_
label values q4b_trucktype___12 q4b_trucktype___12_
label values q4b_trucktype___13 q4b_trucktype___13_
label values q4b_trucktype___14 q4b_trucktype___14_
label values q4b_trucktype___15 q4b_trucktype___15_
label values q4b_trucktype___16 q4b_trucktype___16_
label values q4b_trucktype___17 q4b_trucktype___17_
label values q4b_trucktype___18 q4b_trucktype___18_
label values q4b_trucktype___19 q4b_trucktype___19_
label values q4b_trucktype___20 q4b_trucktype___20_
label values q4b_trucktype___21 q4b_trucktype___21_
label values q4b_trucktype___22 q4b_trucktype___22_
label values q4b_schooltime q4b_schooltime_
label values q4b_schooltype___1 q4b_schooltype___1_
label values q4b_schooltype___2 q4b_schooltype___2_
label values q4b_schooltype___3 q4b_schooltype___3_
label values q4b_schooltype___4 q4b_schooltype___4_
label values q4b_schooltype___5 q4b_schooltype___5_
label values q4b_schooltype___6 q4b_schooltype___6_
label values q4b_schooltype___7 q4b_schooltype___7_
label values q4b_schooltype___8 q4b_schooltype___8_
label values q4b_schooltype___9 q4b_schooltype___9_
label values q4b_schooltype___10 q4b_schooltype___10_
label values q4b_schooltype___11 q4b_schooltype___11_
label values q4b_schooltype___12 q4b_schooltype___12_
label values q4b_schooltype___13 q4b_schooltype___13_
label values q4b_schooltype___14 q4b_schooltype___14_
label values q4b_schooltype___15 q4b_schooltype___15_
label values q4b_schooltype___16 q4b_schooltype___16_
label values q4b_schooltype___17 q4b_schooltype___17_
label values q4b_schooltype___18 q4b_schooltype___18_
label values q4b_schooltype___19 q4b_schooltype___19_
label values q4b_schooltype___20 q4b_schooltype___20_
label values q4b_schooltype___21 q4b_schooltype___21_
label values q4b_schooltype___22 q4b_schooltype___22_
label values q4b_friendtime q4b_friendtime_
label values q4b_friendtype___1 q4b_friendtype___1_
label values q4b_friendtype___2 q4b_friendtype___2_
label values q4b_friendtype___3 q4b_friendtype___3_
label values q4b_friendtype___4 q4b_friendtype___4_
label values q4b_friendtype___5 q4b_friendtype___5_
label values q4b_friendtype___6 q4b_friendtype___6_
label values q4b_friendtype___7 q4b_friendtype___7_
label values q4b_friendtype___8 q4b_friendtype___8_
label values q4b_friendtype___9 q4b_friendtype___9_
label values q4b_friendtype___10 q4b_friendtype___10_
label values q4b_friendtype___11 q4b_friendtype___11_
label values q4b_friendtype___12 q4b_friendtype___12_
label values q4b_friendtype___13 q4b_friendtype___13_
label values q4b_friendtype___14 q4b_friendtype___14_
label values q4b_friendtype___15 q4b_friendtype___15_
label values q4b_friendtype___16 q4b_friendtype___16_
label values q4b_friendtype___17 q4b_friendtype___17_
label values q4b_friendtype___18 q4b_friendtype___18_
label values q4b_friendtype___19 q4b_friendtype___19_
label values q4b_friendtype___20 q4b_friendtype___20_
label values q4b_friendtype___21 q4b_friendtype___21_
label values q4b_friendtype___22 q4b_friendtype___22_
label values q4b_foodbus___1 q4b_foodbus___1_
label values q4b_foodbus___2 q4b_foodbus___2_
label values q4b_foodbus___3 q4b_foodbus___3_
label values q4b_foodbus___4 q4b_foodbus___4_
label values q4b_foodbus___5 q4b_foodbus___5_
label values q4b_foodbus___6 q4b_foodbus___6_
label values q4b_foodbus___7 q4b_foodbus___7_
label values q4b_resttime q4b_resttime_
label values q4b_fftime q4b_fftime_
label values q4b_tatime q4b_tatime_
label values q4b_mobiletime q4b_mobiletime_
label values q4b_bartime q4b_bartime_
label values q4b_done q4b_done_
label values section_4b_food_sour_v_0 section_4b_food_sour_v_0_



** ----------------------------------------------------------------------
** PART 4: VARIABLE METADATA
** ----------------------------------------------------------------------
label variable record_id "Record ID"
label variable q4b_buy "(Q1) Do you get any of your food and drink from purchasing or buying?"
label variable q4b_buytype___1 "(Q2) Buy? (choice=Cereals)"
label variable q4b_buytype___2 "(Q2) Buy? (choice=White roots, tubers and plantains)"
label variable q4b_buytype___3 "(Q2) Buy? (choice=Vegetables)"
label variable q4b_buytype___4 "(Q2) Buy? (choice=Fruit)"
label variable q4b_buytype___5 "(Q2) Buy? (choice=Unprocessed meat)"
label variable q4b_buytype___6 "(Q2) Buy? (choice=Processed meat)"
label variable q4b_buytype___7 "(Q2) Buy? (choice=Eggs)"
label variable q4b_buytype___8 "(Q2) Buy? (choice=Fish and seafood)"
label variable q4b_buytype___9 "(Q2) Buy? (choice=Insects and other small protein foods)"
label variable q4b_buytype___10 "(Q2) Buy? (choice=Pulses)"
label variable q4b_buytype___11 "(Q2) Buy? (choice=Nuts and seeds)"
label variable q4b_buytype___12 "(Q2) Buy? (choice=Dairy (milk and milk products))"
label variable q4b_buytype___13 "(Q2) Buy? (choice=Oils and fats)"
label variable q4b_buytype___14 "(Q2) Buy? (choice=Sweets)"
label variable q4b_buytype___15 "(Q2) Buy? (choice=Savoury and fried snacks)"
label variable q4b_buytype___16 "(Q2) Buy? (choice=Sugar-sweetened beverages)"
label variable q4b_buytype___17 "(Q2) Buy? (choice=Non-alcoholic beverages )"
label variable q4b_buytype___18 "(Q2) Buy? (choice=Alcoholic beverages)"
label variable q4b_buytype___19 "(Q2) Buy? (choice=Condiments and seasonings)"
label variable q4b_buytype___20 "(Q2) Buy? (choice=Ready-to-eat meals)"
label variable q4b_buytype___21 "(Q2) Buy? (choice=Other)"
label variable q4b_buytype___22 "(Q2) Buy? (choice=Dont know)"

label variable q4b_retailtype___1 "(Q3) Bought from? (choice=Wholesaler/Distributor)"
label variable q4b_retailtype___2 "(Q3) Bought from? (choice=Supermarket)"
label variable q4b_retailtype___3 "(Q3) Bought from? (choice=Small shop/Convenience store)"
label variable q4b_retailtype___4 "(Q3) Bought from? (choice=General dealer)"
label variable q4b_retailtype___5 "(Q3) Bought from? (choice=Informal small shop)"
label variable q4b_retailtype___6 "(Q3) Bought from? (choice=Stall/Roadside stall)"
label variable q4b_retailtype___7 "(Q3) Bought from? (choice=Mobile trader)"
label variable q4b_retailtype___8 "(Q3) Bought from? (choice=Informal abattoir or slaughterhouse)"
label variable q4b_retailtype___9 "(Q3) Bought from? (choice=Food trucks/vans, pick-up truck or trike)"
label variable q4b_retailtype___10 "(Q3) Bought from? (choice=School/College tuck shop)"
label variable q4b_retailtype___11 "(Q3) Bought from? (choice=Buy from friends or neighbours)"
label variable q4b_retailtype___12 "(Q3) Bought from? (choice=Other)"
label variable q4b_retailtype___13 "(Q3) Bought from? (choice=Dont know)"

label variable q4b_wholetime "(Q3a1) How often from wholesaler/distributor."
label variable q4b_wholetype___1 "(Q3a2) wholesaler/distributor? Bought (choice=Cereals)"
label variable q4b_wholetype___2 "(Q3a2) wholesaler/distributor? Bought (choice=White roots, tubers and plantains)"
label variable q4b_wholetype___3 "(Q3a2) wholesaler/distributor? Bought (choice=Vegetables)"
label variable q4b_wholetype___4 "(Q3a2) wholesaler/distributor? Bought (choice=Fruit)"
label variable q4b_wholetype___5 "(Q3a2) wholesaler/distributor? Bought (choice=Unprocessed meat)"
label variable q4b_wholetype___6 "(Q3a2) wholesaler/distributor? Bought (choice=Processed meat)"
label variable q4b_wholetype___7 "(Q3a2) wholesaler/distributor? Bought (choice=Eggs)"
label variable q4b_wholetype___8 "(Q3a2) wholesaler/distributor? Bought (choice=Fish and seafood)"
label variable q4b_wholetype___9 "(Q3a2) wholesaler/distributor? Bought (choice=small protein foods)"
label variable q4b_wholetype___10 "(Q3a2) wholesaler/distributor? Bought (choice=Pulses)"
label variable q4b_wholetype___11 "(Q3a2) wholesaler/distributor? Bought (choice=Nuts and seeds)"
label variable q4b_wholetype___12 "(Q3a2) wholesaler/distributor? Bought (choice=Dairy (milk and milk products))"
label variable q4b_wholetype___13 "(Q3a2) wholesaler/distributor? Bought (choice=Oils and fats)"
label variable q4b_wholetype___14 "(Q3a2) wholesaler/distributor? Bought (choice=Sweets)"
label variable q4b_wholetype___15 "(Q3a2) wholesaler/distributor? Bought (choice=Savoury and fried snacks)"
label variable q4b_wholetype___16 "(Q3a2) wholesaler/distributor? Bought (choice=Sugar-sweetened beverages)"
label variable q4b_wholetype___17 "(Q3a2) Wholesaler/distributor? Bought (choice=Non-alcoholic beverages)"
label variable q4b_wholetype___18 "(Q3a2) Wholesaler/distributor? Bought (choice=Alcoholic beverages)"
label variable q4b_wholetype___19 "(Q3a2) Wholesaler/distributor? Bought (choice=Condiments and seasonings)"
label variable q4b_wholetype___20 "(Q3a2) Wholesaler/distributor? Bought (choice=Ready-to-eat meals)"
label variable q4b_wholetype___21 "(Q3a2) Wholesaler/distributor? Bought (choice=Other)"
label variable q4b_wholetype___22 "(Q3a2) Wholesaler/distributor? Bought (choice=Dont know)"

label variable q4b_smarkettime "(Q3b1) How often from a supermarket."
label variable q4b_smarkettype___1 "(Q3b2) supermarket? Bought (choice=Cereals)"
label variable q4b_smarkettype___2 "(Q3b2) supermarket? Bought (choice=White roots, tubers and plantains)"
label variable q4b_smarkettype___3 "(Q3b2) supermarket? Bought (choice=Vegetables)"
label variable q4b_smarkettype___4 "(Q3b2) supermarket? Bought (choice=Fruit)"
label variable q4b_smarkettype___5 "(Q3b2) supermarket? Bought (choice=Unprocessed meat)"
label variable q4b_smarkettype___6 "(Q3b2) supermarket? Bought (choice=Processed meat)"
label variable q4b_smarkettype___7 "(Q3b2) supermarket? Bought (choice=Eggs)"
label variable q4b_smarkettype___8 "(Q3b2) supermarket? Bought (choice=Fish and seafood)"
label variable q4b_smarkettype___9 "(Q3b2) supermarket? Bought (choice=Insects and other small protein foods)"
label variable q4b_smarkettype___10 "(Q3b2) supermarket? Bought  (choice=Pulses)"
label variable q4b_smarkettype___11 "(Q3b2) supermarket? Bought  (choice=Nuts and seeds)"
label variable q4b_smarkettype___12 "(Q3b2) supermarket? Bought  (choice=Dairy (milk and milk products))"
label variable q4b_smarkettype___13 "(Q3b2) supermarket? Bought  (choice=Oils and fats)"
label variable q4b_smarkettype___14 "(Q3b2) supermarket? Bought  (choice=Sweets)"
label variable q4b_smarkettype___15 "(Q3b2) supermarket? Bought  (choice=Savoury and fried snacks)"
label variable q4b_smarkettype___16 "(Q3b2) supermarket? Bought  (choice=Sugar-sweetened beverages)"
label variable q4b_smarkettype___17 "(Q3b2) supermarket? Bought  (choice=Non-alcoholic beverages )"
label variable q4b_smarkettype___18 "(Q3b2) supermarket? Bought  (choice=Alcoholic beverages)"
label variable q4b_smarkettype___19 "(Q3b2) supermarket? Bought  (choice=Condiments and seasonings)"
label variable q4b_smarkettype___20 "(Q3b2) supermarket? Bought  (choice=Ready-to-eat meals )"
label variable q4b_smarkettype___21 "(Q3b2) supermarket? Bought  (choice=Other)"
label variable q4b_smarkettype___22 "(Q3b2) supermarket? Bought  (choice=Dont know)"

label variable q4b_shoptime "(Q3c1) How often from a small shop/convenience store."
label variable q4b_shoptype___1 "(Q3c2) small shop. Bought? (choice=Cereals)"
label variable q4b_shoptype___2 "(Q3c2) small shop. Bought? (choice=White roots, tubers and plantains)"
label variable q4b_shoptype___3 "(Q3c2) small shop. Bought? (choice=Vegetables)"
label variable q4b_shoptype___4 "(Q3c2) small shop. Bought? (choice=Fruit)"
label variable q4b_shoptype___5 "(Q3c2) small shop. Bought? (choice=Unprocessed meat)"
label variable q4b_shoptype___6 "(Q3c2) small shop. Bought? (choice=Processed meat)"
label variable q4b_shoptype___7 "(Q3c2) small shop. Bought? (choice=Eggs)"
label variable q4b_shoptype___8 "(Q3c2) small shop. Bought? (choice=Fish and seafood)"
label variable q4b_shoptype___9 "(Q3c2) small shop. Bought? (choice=Insects and other small protein foods)"
label variable q4b_shoptype___10 "(Q3c2) small shop. Bought?  (choice=Pulses)"
label variable q4b_shoptype___11 "(Q3c2) small shop. Bought?  (choice=Nuts and seeds)"
label variable q4b_shoptype___12 "(Q3c2) small shop. Bought?  (choice=Dairy (milk and milk products))"
label variable q4b_shoptype___13 "(Q3c2) small shop. Bought?  (choice=Oils and fats)"
label variable q4b_shoptype___14 "(Q3c2) small shop. Bought?  (choice=Sweets)"
label variable q4b_shoptype___15 "(Q3c2) small shop. Bought?  (choice=Savoury and fried snacks)"
label variable q4b_shoptype___16 "(Q3c2) small shop. Bought?  (choice=Sugar-sweetened beverages )"
label variable q4b_shoptype___17 "(Q3c2) small shop. Bought?  (choice=Non-alcoholic beverages)"
label variable q4b_shoptype___18 "(Q3c2) small shop. Bought?  (choice=Alcoholic beverages)"
label variable q4b_shoptype___19 "(Q3c2) small shop. Bought?  (choice=Condiments and seasonings)"
label variable q4b_shoptype___20 "(Q3c2) small shop. Bought?  (choice=Ready-to-eat meals )"
label variable q4b_shoptype___21 "(Q3c2) small shop. Bought?  (choice=Other)"
label variable q4b_shoptype___22 "(Q3c2) small shop. Bought?  (choice=Dont know)"

label variable q4b_dealertime "(Q3d1) How often from a general dealer"
label variable q4b_dealertype___1 "(Q3d2) general dealer. Bought? (choice=Cereals)"
label variable q4b_dealertype___2 "(Q3d2)  general dealer. Bought? (choice=White roots, tubers and plantains)"
label variable q4b_dealertype___3 "(Q3d2)  general dealer. Bought? (choice=Vegetables)"
label variable q4b_dealertype___4 "(Q3d2)  general dealer. Bought? (choice=Fruit)"
label variable q4b_dealertype___5 "(Q3d2)  general dealer. Bought? (choice=Unprocessed meat)"
label variable q4b_dealertype___6 "(Q3d2)  general dealer. Bought? (choice=Processed meat)"
label variable q4b_dealertype___7 "(Q3d2)  general dealer. Bought? (choice=Eggs)"
label variable q4b_dealertype___8 "(Q3d2)  general dealer. Bought? (choice=Fish and seafood)"
label variable q4b_dealertype___9 "(Q3d2)  general dealer. Bought? (choice=Insects and other small protein foods)"
label variable q4b_dealertype___10 "(Q3d2) general dealer. Bought?  (choice=Pulses)"
label variable q4b_dealertype___11 "(Q3d2) general dealer. Bought?  (choice=Nuts and seeds)"
label variable q4b_dealertype___12 "(Q3d2) general dealer. Bought?  (choice=Dairy (milk and milk products))"
label variable q4b_dealertype___13 "(Q3d2) general dealer. Bought?  (choice=Oils and fats)"
label variable q4b_dealertype___14 "(Q3d2) general dealer. Bought?  (choice=Sweets)"
label variable q4b_dealertype___15 "(Q3d2) general dealer. Bought?  (choice=Savoury and fried snacks)"
label variable q4b_dealertype___16 "(Q3d2) general dealer. Bought?  (choice=Sugar-sweetened beverages )"
label variable q4b_dealertype___17 "(Q3d2) general dealer. Bought?  (choice=Non-alcoholic beverages )"
label variable q4b_dealertype___18 "(Q3d2) general dealer. Bought?  (choice=Alcoholic beverages)"
label variable q4b_dealertype___19 "(Q3d2) general dealer. Bought?  (choice=Condiments and seasonings)"
label variable q4b_dealertype___20 "(Q3d2) general dealer. Bought?  (choice=Ready-to-eat meals)"
label variable q4b_dealertype___21 "(Q3d2) general dealer. Bought?  (choice=Other)"
label variable q4b_dealertype___22 "(Q3d2) general dealer. Bought?  (choice=Dont know)"

label variable q4b_infshoptime "(Q3e1) How often from an informal small shop."
label variable q4b_infshoptype___1 "(Q3e2) informal small shop. Bought? (choice=Cereals)"
label variable q4b_infshoptype___2 "(Q3e2)  informal small shop. Bought? (choice=White roots, tubers and plantains)"
label variable q4b_infshoptype___3 "(Q3e2)  informal small shop. Bought? (choice=Vegetables)"
label variable q4b_infshoptype___4 "(Q3e2)  informal small shop. Bought? (choice=Fruit)"
label variable q4b_infshoptype___5 "(Q3e2)  informal small shop. Bought? (choice=Unprocessed meat)"
label variable q4b_infshoptype___6 "(Q3e2)  informal small shop. Bought? (choice=Processed meat)"
label variable q4b_infshoptype___7 "(Q3e2)  informal small shop. Bought? (choice=Eggs)"
label variable q4b_infshoptype___8 "(Q3e2)  informal small shop. Bought? (choice=Fish and seafood)"
label variable q4b_infshoptype___9 "(Q3e2)  informal small shop. Bought? (choice=small protein foods)"
label variable q4b_infshoptype___10 "(Q3e2) informal small shop. Bought?  (choice=Pulses)"
label variable q4b_infshoptype___11 "(Q3e2) informal small shop. Bought?  (choice=Nuts and seeds)"
label variable q4b_infshoptype___12 "(Q3e2) informal small shop. Bought?  (choice=Dairy (milk and milk products))"
label variable q4b_infshoptype___13 "(Q3e2) informal small shop. Bought?  (choice=Oils and fats)"
label variable q4b_infshoptype___14 "(Q3e2) informal small shop. Bought?  (choice=Sweets)"
label variable q4b_infshoptype___15 "(Q3e2) informal small shop. Bought?  (choice=Savoury and fried snacks)"
label variable q4b_infshoptype___16 "(Q3e2) informal small shop. Bought?  (choice=Sugar-sweetened beverages )"
label variable q4b_infshoptype___17 "(Q3e2) informal small shop. Bought?  (choice=Non-alcoholic beverages )"
label variable q4b_infshoptype___18 "(Q3e2) informal small shop. Bought?  (choice=Alcoholic beverages)"
label variable q4b_infshoptype___19 "(Q3e2) informal small shop. Bought?  (choice=Condiments and seasonings)"
label variable q4b_infshoptype___20 "(Q3e2) informal small shop. Bought?  (choice=Ready-to-eat meals )"
label variable q4b_infshoptype___21 "(Q3e2) informal small shop. Bought?  (choice=Other)"
label variable q4b_infshoptype___22 "(Q3e2) informal small shop. Bought?  (choice=Dont know)"

label variable q4b_stalltime "(Q3f1) How often from a stall"
label variable q4b_stalltype___1 "(Q3f2) stall. Bought? (choice=Cereals)"
label variable q4b_stalltype___2 "(Q3f2)  stall. Bought? (choice=White roots, tubers and plantains)"
label variable q4b_stalltype___3 "(Q3f2)  stall. Bought? (choice=Vegetables)"
label variable q4b_stalltype___4 "(Q3f2)  stall. Bought? (choice=Fruit)"
label variable q4b_stalltype___5 "(Q3f2)  stall. Bought? (choice=Unprocessed meat)"
label variable q4b_stalltype___6 "(Q3f2)  stall. Bought? (choice=Processed meat)"
label variable q4b_stalltype___7 "(Q3f2)  stall. Bought? (choice=Eggs)"
label variable q4b_stalltype___8 "(Q3f2)  stall. Bought? (choice=Fish and seafood)"
label variable q4b_stalltype___9 "(Q3f2)  stall. Bought? (choice=Insects and other small protein foods)"
label variable q4b_stalltype___10 "(Q3f2) stall. Bought?  (choice=Pulses)"
label variable q4b_stalltype___11 "(Q3f2) stall. Bought?  (choice=Nuts and seeds)"
label variable q4b_stalltype___12 "(Q3f2) stall. Bought?  (choice=Dairy (milk and milk products))"
label variable q4b_stalltype___13 "(Q3f2) stall. Bought?  (choice=Oils and fats)"
label variable q4b_stalltype___14 "(Q3f2) stall. Bought?  (choice=Sweets)"
label variable q4b_stalltype___15 "(Q3f2) stall. Bought?  (choice=Savoury and fried snacks)"
label variable q4b_stalltype___16 "(Q3f2) stall. Bought?  (choice=Sugar-sweetened beverages )"
label variable q4b_stalltype___17 "(Q3f2) stall. Bought?  (choice=Non-alcoholic beverages )"
label variable q4b_stalltype___18 "(Q3f2) stall. Bought?  (choice=Alcoholic beverages)"
label variable q4b_stalltype___19 "(Q3f2) stall. Bought?  (choice=Condiments and seasonings)"
label variable q4b_stalltype___20 "(Q3f2) stall. Bought?  (choice=Ready-to-eat meals)"
label variable q4b_stalltype___21 "(Q3f2) stall. Bought?  (choice=Other)"
label variable q4b_stalltype___22 "(Q3f2) stall. Bought?  (choice=Dont know)"

label variable q4b_tradertime "(Q3g1) How often from a mobile trader"
label variable q4b_tradertype___1 "(Q3g2) mobile trader. Bought? (choice=Cereals)"
label variable q4b_tradertype___2 "(Q3g2)  mobile trader. Bought? (choice=White roots, tubers and plantains)"
label variable q4b_tradertype___3 "(Q3g2)  mobile trader. Bought? (choice=Vegetables)"
label variable q4b_tradertype___4 "(Q3g2)  mobile trader. Bought? (choice=Fruit)"
label variable q4b_tradertype___5 "(Q3g2)  mobile trader. Bought? (choice=Unprocessed meat)"
label variable q4b_tradertype___6 "(Q3g2)  mobile trader. Bought? (choice=Processed meat)"
label variable q4b_tradertype___7 "(Q3g2)  mobile trader. Bought? (choice=Eggs)"
label variable q4b_tradertype___8 "(Q3g2)  mobile trader. Bought? (choice=Fish and seafood)"
label variable q4b_tradertype___9 "(Q3g2)  mobile trader. Bought? (choice=Insects and other small protein foods)"
label variable q4b_tradertype___10 "(Q3g2) mobile trader. Bought?  (choice=Pulses)"
label variable q4b_tradertype___11 "(Q3g2) mobile trader. Bought?  (choice=Nuts and seeds)"
label variable q4b_tradertype___12 "(Q3g2) mobile trader. Bought?  (choice=Dairy (milk and milk products))"
label variable q4b_tradertype___13 "(Q3g2) mobile trader. Bought?  (choice=Oils and fats)"
label variable q4b_tradertype___14 "(Q3g2) mobile trader. Bought?  (choice=Sweets)"
label variable q4b_tradertype___15 "(Q3g2) mobile trader. Bought?  (choice=Savoury and fried snacks)"
label variable q4b_tradertype___16 "(Q3g2) mobile trader. Bought?  (choice=Sugar-sweetened beverages )"
label variable q4b_tradertype___17 "(Q3g2) mobile trader. Bought?  (choice=Non-alcoholic beverages )"
label variable q4b_tradertype___18 "(Q3g2) mobile trader. Bought?  (choice=Alcoholic beverages)"
label variable q4b_tradertype___19 "(Q3g2) mobile trader. Bought?  (choice=Condiments and seasonings)"
label variable q4b_tradertype___20 "(Q3g2) mobile trader. Bought?  (choice=Ready-to-eat meals )"
label variable q4b_tradertype___21 "(Q3g2) mobile trader. Bought?  (choice=Other)"
label variable q4b_tradertype___22 "(Q3g2) mobile trader. Bought?  (choice=Dont know)"

label variable q4b_abatime "(Q3h1) How often from an abattoir"
label variable q4b_abatype___1 "(Q3h2) abattoir. Bought? (choice=Cereals)"
label variable q4b_abatype___2 "(Q3h2)  abattoir. Bought? (choice=White roots, tubers and plantains)"
label variable q4b_abatype___3 "(Q3h2)  abattoir. Bought? (choice=Vegetables)"
label variable q4b_abatype___4 "(Q3h2)  abattoir. Bought? (choice=Fruit)"
label variable q4b_abatype___5 "(Q3h2)  abattoir. Bought? (choice=Unprocessed meat)"
label variable q4b_abatype___6 "(Q3h2)  abattoir. Bought? (choice=Processed meat)"
label variable q4b_abatype___7 "(Q3h2)  abattoir. Bought? (choice=Eggs)"
label variable q4b_abatype___8 "(Q3h2)  abattoir. Bought? (choice=Fish and seafood)"
label variable q4b_abatype___9 "(Q3h2)  abattoir. Bought? (choice=Insects and other small protein foods)"
label variable q4b_abatype___10 "(Q3h2) abattoir. Bought?  (choice=Pulses)"
label variable q4b_abatype___11 "(Q3h2) abattoir. Bought?  (choice=Nuts and seeds)"
label variable q4b_abatype___12 "(Q3h2) abattoir. Bought?  (choice=Dairy (milk and milk products))"
label variable q4b_abatype___13 "(Q3h2) abattoir. Bought?  (choice=Oils and fats)"
label variable q4b_abatype___14 "(Q3h2) abattoir. Bought?  (choice=Sweets)"
label variable q4b_abatype___15 "(Q3h2) abattoir. Bought?  (choice=Savoury and fried snacks)"
label variable q4b_abatype___16 "(Q3h2) abattoir. Bought?  (choice=Sugar-sweetened beverages )"
label variable q4b_abatype___17 "(Q3h2) abattoir. Bought?  (choice=Non-alcoholic beverages )"
label variable q4b_abatype___18 "(Q3h2) abattoir. Bought?  (choice=Alcoholic beverages)"
label variable q4b_abatype___19 "(Q3h2) abattoir. Bought?  (choice=Condiments and seasonings)"
label variable q4b_abatype___20 "(Q3h2) abattoir. Bought?  (choice=Ready-to-eat meals )"
label variable q4b_abatype___21 "(Q3h2) abattoir. Bought?  (choice=Other)"
label variable q4b_abatype___22 "(Q3h2) abattoir. Bought?  (choice=Dont know)"

label variable q4b_trucktime "(Q3i1) HOw often from a food truck?"
label variable q4b_trucktype___1 "(Q3i2) food truck. Bought? (choice=Cereals)"
label variable q4b_trucktype___2 "(Q3i2)  food truck. Bought? (choice=White roots, tubers and plantains)"
label variable q4b_trucktype___3 "(Q3i2)  food truck. Bought? (choice=Vegetables)"
label variable q4b_trucktype___4 "(Q3i2)  food truck. Bought? (choice=Fruit)"
label variable q4b_trucktype___5 "(Q3i2)  food truck. Bought? (choice=Unprocessed meat)"
label variable q4b_trucktype___6 "(Q3i2)  food truck. Bought? (choice=Processed meat)"
label variable q4b_trucktype___7 "(Q3i2)  food truck. Bought? (choice=Eggs)"
label variable q4b_trucktype___8 "(Q3i2)  food truck. Bought? (choice=Fish and seafood)"
label variable q4b_trucktype___9 "(Q3i2)  food truck. Bought? (choice=Insects and other small protein foods)"
label variable q4b_trucktype___10 "(Q3i2) food truck. Bought?  (choice=Pulses)"
label variable q4b_trucktype___11 "(Q3i2) food truck. Bought?  (choice=Nuts and seeds)"
label variable q4b_trucktype___12 "(Q3i2) food truck. Bought?  (choice=Dairy (milk and milk products))"
label variable q4b_trucktype___13 "(Q3i2) food truck. Bought?  (choice=Oils and fats)"
label variable q4b_trucktype___14 "(Q3i2) food truck. Bought?  (choice=Sweets)"
label variable q4b_trucktype___15 "(Q3i2) food truck. Bought?  (choice=Savoury and fried snacks)"
label variable q4b_trucktype___16 "(Q3i2) food truck. Bought?  (choice=Sugar-sweetened beverages )"
label variable q4b_trucktype___17 "(Q3i2) food truck. Bought?  (choice=Non-alcoholic beverages )"
label variable q4b_trucktype___18 "(Q3i2) food truck. Bought?  (choice=Alcoholic beverages)"
label variable q4b_trucktype___19 "(Q3i2) food truck. Bought?  (choice=Condiments and seasonings)"
label variable q4b_trucktype___20 "(Q3i2) food truck. Bought?  (choice=Ready-to-eat meals )"
label variable q4b_trucktype___21 "(Q3i2) food truck. Bought?  (choice=Other)"
label variable q4b_trucktype___22 "(Q3i2) food truck. Bought?  (choice=Dont know)"


label variable q4b_schooltime "(Q3j1) How often from a school tuck shop."
label variable q4b_schooltype___1 "(Q3j2) school tuck shop. Bought? (choice=Cereals)"
label variable q4b_schooltype___2 "(Q3j2)  school tuck shop. Bought? (choice=White roots, tubers and plantains)"
label variable q4b_schooltype___3 "(Q3j2)  school tuck shop. Bought? (choice=Vegetables)"
label variable q4b_schooltype___4 "(Q3j2)  school tuck shop. Bought? (choice=Fruit)"
label variable q4b_schooltype___5 "(Q3j2)  school tuck shop. Bought? (choice=Unprocessed meat)"
label variable q4b_schooltype___6 "(Q3j2)  school tuck shop. Bought? (choice=Processed meat)"
label variable q4b_schooltype___7 "(Q3j2)  school tuck shop. Bought? (choice=Eggs)"
label variable q4b_schooltype___8 "(Q3j2)  school tuck shop. Bought? (choice=Fish and seafood)"
label variable q4b_schooltype___9 "(Q3j2)  school tuck shop. Bought? (choice=Insects and other small protein foods)"
label variable q4b_schooltype___10 "(Q3j2) school tuck shop. Bought?  (choice=Pulses)"
label variable q4b_schooltype___11 "(Q3j2) school tuck shop. Bought?  (choice=Nuts and seeds)"
label variable q4b_schooltype___12 "(Q3j2) school tuck shop. Bought?  (choice=Dairy (milk and milk products))"
label variable q4b_schooltype___13 "(Q3j2) school tuck shop. Bought?  (choice=Oils and fats)"
label variable q4b_schooltype___14 "(Q3j2) school tuck shop. Bought?  (choice=Sweets)"
label variable q4b_schooltype___15 "(Q3j2) school tuck shop. Bought?  (choice=Savoury and fried snacks)"
label variable q4b_schooltype___16 "(Q3j2) school tuck shop. Bought?  (choice=Sugar-sweetened beverages )"
label variable q4b_schooltype___17 "(Q3j2) school tuck shop. Bought?  (choice=Non-alcoholic beverages )"
label variable q4b_schooltype___18 "(Q3j2) school tuck shop. Bought?  (choice=Alcoholic beverages)"
label variable q4b_schooltype___19 "(Q3j2) school tuck shop. Bought?  (choice=Condiments and seasonings)"
label variable q4b_schooltype___20 "(Q3j2) school tuck shop. Bought?  (choice=Ready-to-eat meals )"
label variable q4b_schooltype___21 "(Q3j2) school tuck shop. Bought?  (choice=Other)"
label variable q4b_schooltype___22 "(Q3j2) school tuck shop. Bought?  (choice=Dont know)"


label variable q4b_friendtime "(Q3k1) How often from friends"
label variable q4b_friendtype___1 "(Q3k2) friends. Bought? (choice=Cereals)"
label variable q4b_friendtype___2 "(Q3k2)  friends. Bought? (choice=White roots, tubers and plantains)"
label variable q4b_friendtype___3 "(Q3k2)  friends. Bought? (choice=Vegetables)"
label variable q4b_friendtype___4 "(Q3k2)  friends. Bought? (choice=Fruit)"
label variable q4b_friendtype___5 "(Q3k2)  friends. Bought? (choice=Unprocessed meat)"
label variable q4b_friendtype___6 "(Q3k2)  friends. Bought? (choice=Processed meat)"
label variable q4b_friendtype___7 "(Q3k2)  friends. Bought? (choice=Eggs)"
label variable q4b_friendtype___8 "(Q3k2)  friends. Bought? (choice=Fish and seafood)"
label variable q4b_friendtype___9 "(Q3k2)  friends. Bought? (choice=Insects and other small protein foods)"
label variable q4b_friendtype___10 "(Q3k2) friends. Bought?  (choice=Pulses)"
label variable q4b_friendtype___11 "(Q3k2) friends. Bought?  (choice=Nuts and seeds)"
label variable q4b_friendtype___12 "(Q3k2) friends. Bought?  (choice=Dairy (milk and milk products))"
label variable q4b_friendtype___13 "(Q3k2) friends. Bought?  (choice=Oils and fats)"
label variable q4b_friendtype___14 "(Q3k2) friends. Bought?  (choice=Sweets)"
label variable q4b_friendtype___15 "(Q3k2) friends. Bought?  (choice=Savoury and fried snacks)"
label variable q4b_friendtype___16 "(Q3k2) friends. Bought?  (choice=Sugar-sweetened beverages )"
label variable q4b_friendtype___17 "(Q3k2) friends. Bought?  (choice=Non-alcoholic beverages )"
label variable q4b_friendtype___18 "(Q3k2) friends. Bought?  (choice=Alcoholic beverages)"
label variable q4b_friendtype___19 "(Q3k2) friends. Bought?  (choice=Condiments and seasonings)"
label variable q4b_friendtype___20 "(Q3k2) friends. Bought?  (choice=Ready-to-eat meals )"
label variable q4b_friendtype___21 "(Q3k2) friends. Bought?  (choice=Other)"
label variable q4b_friendtype___22 "(Q3k2) friends. Bought?  (choice=Dont know)"

label variable q4b_foodbus___1 "(Q4) Bought from food service business (choice=Formal restaurant)"
label variable q4b_foodbus___2 "(Q4) Bought from food service business (choice=Corporate fast food shop)"
label variable q4b_foodbus___3 "(Q4) Bought from food service business (choice=Informal restaurant)"
label variable q4b_foodbus___4 "(Q4) Bought from food service business (choice=Mobile food stall)"
label variable q4b_foodbus___5 "(Q4) Bought from food service business (choice=Roadside bar)"
label variable q4b_foodbus___6 "(Q4) Bought from food service business (choice=Other)"
label variable q4b_foodbus___7 "(Q4) Bought from food service business (choice=Dont know)"

label variable q4b_resttime "(Q4a) formal restaurant. How often?"
label variable q4b_fftime "(Q4b) corporate fast food shop. How often?"
label variable q4b_tatime "(Q4c) informal restaurant. How often?"
label variable q4b_mobiletime "(Q4d) mobile food stall. How often?"
label variable q4b_bartime "(Q4e) roadside bar. How often?"
label variable q4b_done "Have you covered all relevant questions?"
label variable q4b_donereason "What is your reason to not move on to the next survey?"
label variable section_4b_food_sour_v_0 "Complete?"


** ----------------------------------------------------------------------
** PART 5: ORDER AND SAVE THE FILE
** ----------------------------------------------------------------------
order pid record_id q4b_buy q4b_buytype___1 q4b_buytype___2 q4b_buytype___3 q4b_buytype___4 q4b_buytype___5 q4b_buytype___6 q4b_buytype___7 q4b_buytype___8 q4b_buytype___9 q4b_buytype___10 q4b_buytype___11 q4b_buytype___12 q4b_buytype___13 q4b_buytype___14 q4b_buytype___15 q4b_buytype___16 q4b_buytype___17 q4b_buytype___18 q4b_buytype___19 q4b_buytype___20 q4b_buytype___21 q4b_buytype___22 q4b_retailtype___1 q4b_retailtype___2 q4b_retailtype___3 q4b_retailtype___4 q4b_retailtype___5 q4b_retailtype___6 q4b_retailtype___7 q4b_retailtype___8 q4b_retailtype___9 q4b_retailtype___10 q4b_retailtype___11 q4b_retailtype___12 q4b_retailtype___13 q4b_wholetime q4b_wholetype___1 q4b_wholetype___2 q4b_wholetype___3 q4b_wholetype___4 q4b_wholetype___5 q4b_wholetype___6 q4b_wholetype___7 q4b_wholetype___8 q4b_wholetype___9 q4b_wholetype___10 q4b_wholetype___11 q4b_wholetype___12 q4b_wholetype___13 q4b_wholetype___14 q4b_wholetype___15 q4b_wholetype___16 q4b_wholetype___17 q4b_wholetype___18 q4b_wholetype___19 q4b_wholetype___20 q4b_wholetype___21 q4b_wholetype___22 q4b_smarkettime q4b_smarkettype___1 q4b_smarkettype___2 q4b_smarkettype___3 q4b_smarkettype___4 q4b_smarkettype___5 q4b_smarkettype___6 q4b_smarkettype___7 q4b_smarkettype___8 q4b_smarkettype___9 q4b_smarkettype___10 q4b_smarkettype___11 q4b_smarkettype___12 q4b_smarkettype___13 q4b_smarkettype___14 q4b_smarkettype___15 q4b_smarkettype___16 q4b_smarkettype___17 q4b_smarkettype___18 q4b_smarkettype___19 q4b_smarkettype___20 q4b_smarkettype___21 q4b_smarkettype___22 q4b_shoptime q4b_shoptype___1 q4b_shoptype___2 q4b_shoptype___3 q4b_shoptype___4 q4b_shoptype___5 q4b_shoptype___6 q4b_shoptype___7 q4b_shoptype___8 q4b_shoptype___9 q4b_shoptype___10 q4b_shoptype___11 q4b_shoptype___12 q4b_shoptype___13 q4b_shoptype___14 q4b_shoptype___15 q4b_shoptype___16 q4b_shoptype___17 q4b_shoptype___18 q4b_shoptype___19 q4b_shoptype___20 q4b_shoptype___21 q4b_shoptype___22 q4b_dealertime q4b_dealertype___1 q4b_dealertype___2 q4b_dealertype___3 q4b_dealertype___4 q4b_dealertype___5 q4b_dealertype___6 q4b_dealertype___7 q4b_dealertype___8 q4b_dealertype___9 q4b_dealertype___10 q4b_dealertype___11 q4b_dealertype___12 q4b_dealertype___13 q4b_dealertype___14 q4b_dealertype___15 q4b_dealertype___16 q4b_dealertype___17 q4b_dealertype___18 q4b_dealertype___19 q4b_dealertype___20 q4b_dealertype___21 q4b_dealertype___22 q4b_infshoptime q4b_infshoptype___1 q4b_infshoptype___2 q4b_infshoptype___3 q4b_infshoptype___4 q4b_infshoptype___5 q4b_infshoptype___6 q4b_infshoptype___7 q4b_infshoptype___8 q4b_infshoptype___9 q4b_infshoptype___10 q4b_infshoptype___11 q4b_infshoptype___12 q4b_infshoptype___13 q4b_infshoptype___14 q4b_infshoptype___15 q4b_infshoptype___16 q4b_infshoptype___17 q4b_infshoptype___18 q4b_infshoptype___19 q4b_infshoptype___20 q4b_infshoptype___21 q4b_infshoptype___22 q4b_stalltime q4b_stalltype___1 q4b_stalltype___2 q4b_stalltype___3 q4b_stalltype___4 q4b_stalltype___5 q4b_stalltype___6 q4b_stalltype___7 q4b_stalltype___8 q4b_stalltype___9 q4b_stalltype___10 q4b_stalltype___11 q4b_stalltype___12 q4b_stalltype___13 q4b_stalltype___14 q4b_stalltype___15 q4b_stalltype___16 q4b_stalltype___17 q4b_stalltype___18 q4b_stalltype___19 q4b_stalltype___20 q4b_stalltype___21 q4b_stalltype___22 q4b_tradertime q4b_tradertype___1 q4b_tradertype___2 q4b_tradertype___3 q4b_tradertype___4 q4b_tradertype___5 q4b_tradertype___6 q4b_tradertype___7 q4b_tradertype___8 q4b_tradertype___9 q4b_tradertype___10 q4b_tradertype___11 q4b_tradertype___12 q4b_tradertype___13 q4b_tradertype___14 q4b_tradertype___15 q4b_tradertype___16 q4b_tradertype___17 q4b_tradertype___18 q4b_tradertype___19 q4b_tradertype___20 q4b_tradertype___21 q4b_tradertype___22 q4b_abatime q4b_abatype___1 q4b_abatype___2 q4b_abatype___3 q4b_abatype___4 q4b_abatype___5 q4b_abatype___6 q4b_abatype___7 q4b_abatype___8 q4b_abatype___9 q4b_abatype___10 q4b_abatype___11 q4b_abatype___12 q4b_abatype___13 q4b_abatype___14 q4b_abatype___15 q4b_abatype___16 q4b_abatype___17 q4b_abatype___18 q4b_abatype___19 q4b_abatype___20 q4b_abatype___21 q4b_abatype___22 q4b_trucktime q4b_trucktype___1 q4b_trucktype___2 q4b_trucktype___3 q4b_trucktype___4 q4b_trucktype___5 q4b_trucktype___6 q4b_trucktype___7 q4b_trucktype___8 q4b_trucktype___9 q4b_trucktype___10 q4b_trucktype___11 q4b_trucktype___12 q4b_trucktype___13 q4b_trucktype___14 q4b_trucktype___15 q4b_trucktype___16 q4b_trucktype___17 q4b_trucktype___18 q4b_trucktype___19 q4b_trucktype___20 q4b_trucktype___21 q4b_trucktype___22 q4b_schooltime q4b_schooltype___1 q4b_schooltype___2 q4b_schooltype___3 q4b_schooltype___4 q4b_schooltype___5 q4b_schooltype___6 q4b_schooltype___7 q4b_schooltype___8 q4b_schooltype___9 q4b_schooltype___10 q4b_schooltype___11 q4b_schooltype___12 q4b_schooltype___13 q4b_schooltype___14 q4b_schooltype___15 q4b_schooltype___16 q4b_schooltype___17 q4b_schooltype___18 q4b_schooltype___19 q4b_schooltype___20 q4b_schooltype___21 q4b_schooltype___22 q4b_friendtime q4b_friendtype___1 q4b_friendtype___2 q4b_friendtype___3 q4b_friendtype___4 q4b_friendtype___5 q4b_friendtype___6 q4b_friendtype___7 q4b_friendtype___8 q4b_friendtype___9 q4b_friendtype___10 q4b_friendtype___11 q4b_friendtype___12 q4b_friendtype___13 q4b_friendtype___14 q4b_friendtype___15 q4b_friendtype___16 q4b_friendtype___17 q4b_friendtype___18 q4b_friendtype___19 q4b_friendtype___20 q4b_friendtype___21 q4b_friendtype___22 q4b_foodbus___1 q4b_foodbus___2 q4b_foodbus___3 q4b_foodbus___4 q4b_foodbus___5 q4b_foodbus___6 q4b_foodbus___7 q4b_resttime q4b_fftime q4b_tatime q4b_mobiletime q4b_bartime q4b_done q4b_donereason section_4b_food_sour_v_0


label data "CFaH Survey. Section4B-DietScreener. Pre-release3. 11Dec2018"
drop record_id q4b_done q4b_donereason section_4b_food_sour_v_0   _merge
sort pid
save "`datapath'/version01/2-working/section4b_pre-release3.dta", replace

set linesize 180
describe, full
