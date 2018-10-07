* HEADER -----------------------------------------------------
**  DO-FILE METADATA
    //  algorithm name			      section3_CFaHHouseholdSurvey.do
    //  project:				          Community Food and Health
    //  analysts:				 	        Ian HAMBLETON
    // 	date last modified	      06-OCT-2018
    //  algorithm task			      Preparing DATA: SECTION 3

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
    log using "`logpath'\section3_CFaHHouseholdSurvey", replace
** HEADER -----------------------------------------------------


** IMPORT the REDCap EXPORT (6-OCT-2018)
import delimited record_id q3_eatoutnum q3_diets___1 q3_diets___2 q3_diets___3 q3_diets___4 q3_diets___5 q3_diets___6 q3_diets___7 q3_diets___8 q3_diets___9 q3_diets___10 q3_diets___11 q3_diets___12 q3_diets___13 q3_diets___14 q3_diets___15 q3_dietreason___1 q3_dietreason___2 q3_dietreason___3 q3_dietreason___4 q3_dietreason___5 q3_dietreason___6 q3_dietreason___7 q3_dietreason___8 q3_dietreason___9 q3_dietreason___10 q3_dietreason___11 q3_fruitnum q3_fruitserv q3_vegnum q3_vegserv q3_fishnum q3_fishserv q3_oilfishnum q3_oilfishserv q3_upmeatnum q3_upmeatserv q3_pmeatnum q3_pmeatserv q3_upfoodnum q3_pfoodnum q3_tinfoodnum q3_ultpfoodnum q3_ssbnum q3_ssbserv q3_ddrinknum q3_ddrinkserv q3_drinkdaily___1 q3_drinkdaily___2 q3_drinkdaily___3 q3_drinkdaily___4 q3_drinkdaily___5 q3_drinkdaily___6 q3_drinkdaily___7 q3_drinkdaily___8 q3_drinkdaily___9 q3_drinkdaily___10 q3_drinkdaily___11 q3_fjuiceserv q3_mjuiceserv q3_twatserv q3_bwatserv q3_tea q3_teamilksug q3_teasug q3_teamilk q3_milkserv q3_milktype___1 q3_milktype___2 q3_milktype___3 q3_milktype___4 q3_milktype___5 q3_milktype___6 q3_milktype___7 q3_milktype___8 q3_milktype___9 q3_milktype___10 q3_milktype___11 q3_addnacook q3_addnabf q3_addnawhile q3_addsugcook q3_addsugbf q3_addsugwhile q3_oiltype___1 q3_oiltype___2 q3_oiltype___3 q3_oiltype___4 q3_oiltype___5 q3_oiltype___6 q3_oiltype___7 q3_oiltype___8 q3_oiltype___9 q3_oiltype___10 q3_oiltype___11 q3_oiltype___12 q3_oiltype___13 q3_suppmv q3_suppva q3_suppvb q3_suppvc q3_suppvd q3_suppcod q3_suppca q3_suppo3 q3_suppfe q3_suppzn q3_done q3_donereason section_3_diet_scree_v_0 using "`datapath'/version01/1-input/section3_CFaHHouseholdSurvey.csv", varnames(nonames)
label data "CFaH Household Survey: SECTION 3"

** Merge with de-identified ID numbers
sort record_id
merge 1:1 record_id using "`datapath'/version01/2-working/section1_idlinkage.dta"
order pid, before(record_id)

** ----------------------------------------------------------------------
** PART 2: VARIABLE CATEGORY DEFINITIONS
** ----------------------------------------------------------------------
label define q3_diets___1_ 0 "Unchecked" 1 "Checked"
label define q3_diets___2_ 0 "Unchecked" 1 "Checked"
label define q3_diets___3_ 0 "Unchecked" 1 "Checked"
label define q3_diets___4_ 0 "Unchecked" 1 "Checked"
label define q3_diets___5_ 0 "Unchecked" 1 "Checked"
label define q3_diets___6_ 0 "Unchecked" 1 "Checked"
label define q3_diets___7_ 0 "Unchecked" 1 "Checked"
label define q3_diets___8_ 0 "Unchecked" 1 "Checked"
label define q3_diets___9_ 0 "Unchecked" 1 "Checked"
label define q3_diets___10_ 0 "Unchecked" 1 "Checked"
label define q3_diets___11_ 0 "Unchecked" 1 "Checked"
label define q3_diets___12_ 0 "Unchecked" 1 "Checked"
label define q3_diets___13_ 0 "Unchecked" 1 "Checked"
label define q3_diets___14_ 0 "Unchecked" 1 "Checked"
label define q3_diets___15_ 0 "Unchecked" 1 "Checked"
label define q3_dietreason___1_ 0 "Unchecked" 1 "Checked"
label define q3_dietreason___2_ 0 "Unchecked" 1 "Checked"
label define q3_dietreason___3_ 0 "Unchecked" 1 "Checked"
label define q3_dietreason___4_ 0 "Unchecked" 1 "Checked"
label define q3_dietreason___5_ 0 "Unchecked" 1 "Checked"
label define q3_dietreason___6_ 0 "Unchecked" 1 "Checked"
label define q3_dietreason___7_ 0 "Unchecked" 1 "Checked"
label define q3_dietreason___8_ 0 "Unchecked" 1 "Checked"
label define q3_dietreason___9_ 0 "Unchecked" 1 "Checked"
label define q3_dietreason___10_ 0 "Unchecked" 1 "Checked"
label define q3_dietreason___11_ 0 "Unchecked" 1 "Checked"
label define q3_fruitnum_ 1 "0" 2 "1" 3 "2" 4 "3" 5 "4" 6 "5" 7 "6" 8 "7" 9 "Dont know"
label define q3_fruitserv_ 1 "1" 2 "2" 3 "3" 4 "4" 5 "5+" 6 "Dont know"
label define q3_vegnum_ 1 "0" 2 "1" 3 "2" 4 "3" 5 "4" 6 "5" 7 "6" 8 "7" 9 "Dont know"
label define q3_vegserv_ 1 "1" 2 "2" 3 "3" 4 "4" 5 "5+" 6 "Dont know"
label define q3_fishnum_ 1 "0" 2 "1" 3 "2" 4 "3" 5 "4" 6 "5" 7 "6" 8 "7" 9 "Dont know"
label define q3_fishserv_ 1 "1" 2 "2" 3 "3" 4 "4" 5 "5+" 6 "Dont know"
label define q3_oilfishnum_ 1 "0" 2 "1" 3 "2" 4 "3" 5 "4" 6 "5" 7 "6" 8 "7" 9 "Dont know"
label define q3_oilfishserv_ 1 "1" 2 "2" 3 "3" 4 "4" 5 "5+" 6 "Dont know"
label define q3_upmeatnum_ 1 "0" 2 "1" 3 "2" 4 "3" 5 "4" 6 "5" 7 "6" 8 "7" 9 "Dont know"
label define q3_upmeatserv_ 1 "1" 2 "2" 3 "3" 4 "4" 5 "5+" 6 "Dont know"
label define q3_pmeatnum_ 1 "0" 2 "1" 3 "2" 4 "3" 5 "4" 6 "5" 7 "6" 8 "7" 9 "Dont know"
label define q3_pmeatserv_ 1 "1" 2 "2" 3 "3" 4 "4" 5 "5+" 6 "Dont know"
label define q3_upfoodnum_ 1 "0" 2 "1" 3 "2" 4 "3" 5 "4" 6 "5" 7 "6" 8 "7" 9 "Dont know"
label define q3_pfoodnum_ 1 "0" 2 "1" 3 "2" 4 "3" 5 "4" 6 "5" 7 "6" 8 "7" 9 "Dont know"
label define q3_tinfoodnum_ 1 "0" 2 "1" 3 "2" 4 "3" 5 "4" 6 "5" 7 "6" 8 "7" 9 "Dont know"
label define q3_ultpfoodnum_ 1 "0" 2 "1" 3 "2" 4 "3" 5 "4" 6 "5" 7 "6" 8 "7" 9 "Dont know"
label define q3_ssbnum_ 1 "0" 2 "1" 3 "2" 4 "3" 5 "4" 6 "5" 7 "6" 8 "7" 9 "Dont know"
label define q3_ssbserv_ 1 "1" 2 "2" 3 "3" 4 "4" 5 "5+" 6 "Dont know"
label define q3_ddrinknum_ 1 "0" 2 "1" 3 "2" 4 "3" 5 "4" 6 "5" 7 "6" 8 "7" 9 "Dont know"
label define q3_ddrinkserv_ 1 "1" 2 "2" 3 "3" 4 "4" 5 "5+" 6 "Dont know"
label define q3_drinkdaily___1_ 0 "Unchecked" 1 "Checked"
label define q3_drinkdaily___2_ 0 "Unchecked" 1 "Checked"
label define q3_drinkdaily___3_ 0 "Unchecked" 1 "Checked"
label define q3_drinkdaily___4_ 0 "Unchecked" 1 "Checked"
label define q3_drinkdaily___5_ 0 "Unchecked" 1 "Checked"
label define q3_drinkdaily___6_ 0 "Unchecked" 1 "Checked"
label define q3_drinkdaily___7_ 0 "Unchecked" 1 "Checked"
label define q3_drinkdaily___8_ 0 "Unchecked" 1 "Checked"
label define q3_drinkdaily___9_ 0 "Unchecked" 1 "Checked"
label define q3_drinkdaily___10_ 0 "Unchecked" 1 "Checked"
label define q3_drinkdaily___11_ 0 "Unchecked" 1 "Checked"
label define q3_milktype___1_ 0 "Unchecked" 1 "Checked"
label define q3_milktype___2_ 0 "Unchecked" 1 "Checked"
label define q3_milktype___3_ 0 "Unchecked" 1 "Checked"
label define q3_milktype___4_ 0 "Unchecked" 1 "Checked"
label define q3_milktype___5_ 0 "Unchecked" 1 "Checked"
label define q3_milktype___6_ 0 "Unchecked" 1 "Checked"
label define q3_milktype___7_ 0 "Unchecked" 1 "Checked"
label define q3_milktype___8_ 0 "Unchecked" 1 "Checked"
label define q3_milktype___9_ 0 "Unchecked" 1 "Checked"
label define q3_milktype___10_ 0 "Unchecked" 1 "Checked"
label define q3_milktype___11_ 0 "Unchecked" 1 "Checked"
label define q3_addnacook_ 1 "Always" 2 "Often" 3 "Sometimes" 4 "Rarely" 5 "Never" 6 "Dont know"
label define q3_addnabf_ 1 "Always" 2 "Often" 3 "Sometimes" 4 "Rarely" 5 "Never" 6 "Dont know"
label define q3_addnawhile_ 1 "Always" 2 "Often" 3 "Sometimes" 4 "Rarely" 5 "Never" 6 "Dont know"
label define q3_addsugcook_ 1 "Always" 2 "Often" 3 "Sometimes" 4 "Rarely" 5 "Never" 6 "Dont know"
label define q3_addsugbf_ 1 "Always" 2 "Often" 3 "Sometimes" 4 "Rarely" 5 "Never" 6 "Dont know"
label define q3_addsugwhile_ 1 "Always" 2 "Often" 3 "Sometimes" 4 "Rarely" 5 "Never" 6 "Dont know"
label define q3_oiltype___1_ 0 "Unchecked" 1 "Checked"
label define q3_oiltype___2_ 0 "Unchecked" 1 "Checked"
label define q3_oiltype___3_ 0 "Unchecked" 1 "Checked"
label define q3_oiltype___4_ 0 "Unchecked" 1 "Checked"
label define q3_oiltype___5_ 0 "Unchecked" 1 "Checked"
label define q3_oiltype___6_ 0 "Unchecked" 1 "Checked"
label define q3_oiltype___7_ 0 "Unchecked" 1 "Checked"
label define q3_oiltype___8_ 0 "Unchecked" 1 "Checked"
label define q3_oiltype___9_ 0 "Unchecked" 1 "Checked"
label define q3_oiltype___10_ 0 "Unchecked" 1 "Checked"
label define q3_oiltype___11_ 0 "Unchecked" 1 "Checked"
label define q3_oiltype___12_ 0 "Unchecked" 1 "Checked"
label define q3_oiltype___13_ 0 "Unchecked" 1 "Checked"
label define q3_suppmv_ 1 "Yes, daily" 2 "Yes, weekly" 3 "Yes, monthly" 4 "Yes, yearly" 5 "No, never"
label define q3_suppva_ 1 "Yes, daily" 2 "Yes, weekly" 3 "Yes, monthly" 4 "Yes, yearly" 5 "No, never"
label define q3_suppvb_ 1 "Yes, daily" 2 "Yes, weekly" 3 "Yes, monthly" 4 "Yes, yearly" 5 "No, never"
label define q3_suppvc_ 1 "Yes, daily" 2 "Yes, weekly" 3 "Yes, monthly" 4 "Yes, yearly" 5 "No, never"
label define q3_suppvd_ 1 "Yes, daily" 2 "Yes, weekly" 3 "Yes, monthly" 4 "Yes, yearly" 5 "No, never"
label define q3_suppcod_ 1 "Yes, daily" 2 "Yes, weekly" 3 "Yes, monthly" 4 "Yes, yearly" 5 "No, never"
label define q3_suppca_ 1 "Yes, daily" 2 "Yes, weekly" 3 "Yes, monthly" 4 "Yes, yearly" 5 "No, never"
label define q3_suppo3_ 1 "Yes, daily" 2 "Yes, weekly" 3 "Yes, monthly" 4 "Yes, yearly" 5 "No, never"
label define q3_suppfe_ 1 "Yes, daily" 2 "Yes, weekly" 3 "Yes, monthly" 4 "Yes, yearly" 5 "No, never"
label define q3_suppzn_ 1 "Yes, daily" 2 "Yes, weekly" 3 "Yes, monthly" 4 "Yes, yearly" 5 "No, never"
label define q3_done_ 1 "Yes, move on to Section 4 - FOOD SOURCE: PRODUCE" 2 "No,  will not move on"
label define section_3_diet_scree_v_0_ 0 "Incomplete" 1 "Unverified" 2 "Complete"

** ----------------------------------------------------------------------
** PART 3: VARIABLE CATEGORY LABEL ATTACHMENTS
** ----------------------------------------------------------------------
label values q3_diets___1 q3_diets___1_
label values q3_diets___2 q3_diets___2_
label values q3_diets___3 q3_diets___3_
label values q3_diets___4 q3_diets___4_
label values q3_diets___5 q3_diets___5_
label values q3_diets___6 q3_diets___6_
label values q3_diets___7 q3_diets___7_
label values q3_diets___8 q3_diets___8_
label values q3_diets___9 q3_diets___9_
label values q3_diets___10 q3_diets___10_
label values q3_diets___11 q3_diets___11_
label values q3_diets___12 q3_diets___12_
label values q3_diets___13 q3_diets___13_
label values q3_diets___14 q3_diets___14_
label values q3_diets___15 q3_diets___15_
label values q3_dietreason___1 q3_dietreason___1_
label values q3_dietreason___2 q3_dietreason___2_
label values q3_dietreason___3 q3_dietreason___3_
label values q3_dietreason___4 q3_dietreason___4_
label values q3_dietreason___5 q3_dietreason___5_
label values q3_dietreason___6 q3_dietreason___6_
label values q3_dietreason___7 q3_dietreason___7_
label values q3_dietreason___8 q3_dietreason___8_
label values q3_dietreason___9 q3_dietreason___9_
label values q3_dietreason___10 q3_dietreason___10_
label values q3_dietreason___11 q3_dietreason___11_
label values q3_fruitnum q3_fruitnum_
label values q3_fruitserv q3_fruitserv_
label values q3_vegnum q3_vegnum_
label values q3_vegserv q3_vegserv_
label values q3_fishnum q3_fishnum_
label values q3_fishserv q3_fishserv_
label values q3_oilfishnum q3_oilfishnum_
label values q3_oilfishserv q3_oilfishserv_
label values q3_upmeatnum q3_upmeatnum_
label values q3_upmeatserv q3_upmeatserv_
label values q3_pmeatnum q3_pmeatnum_
label values q3_pmeatserv q3_pmeatserv_
label values q3_upfoodnum q3_upfoodnum_
label values q3_pfoodnum q3_pfoodnum_
label values q3_tinfoodnum q3_tinfoodnum_
label values q3_ultpfoodnum q3_ultpfoodnum_
label values q3_ssbnum q3_ssbnum_
label values q3_ssbserv q3_ssbserv_
label values q3_ddrinknum q3_ddrinknum_
label values q3_ddrinkserv q3_ddrinkserv_
label values q3_drinkdaily___1 q3_drinkdaily___1_
label values q3_drinkdaily___2 q3_drinkdaily___2_
label values q3_drinkdaily___3 q3_drinkdaily___3_
label values q3_drinkdaily___4 q3_drinkdaily___4_
label values q3_drinkdaily___5 q3_drinkdaily___5_
label values q3_drinkdaily___6 q3_drinkdaily___6_
label values q3_drinkdaily___7 q3_drinkdaily___7_
label values q3_drinkdaily___8 q3_drinkdaily___8_
label values q3_drinkdaily___9 q3_drinkdaily___9_
label values q3_drinkdaily___10 q3_drinkdaily___10_
label values q3_drinkdaily___11 q3_drinkdaily___11_
label values q3_milktype___1 q3_milktype___1_
label values q3_milktype___2 q3_milktype___2_
label values q3_milktype___3 q3_milktype___3_
label values q3_milktype___4 q3_milktype___4_
label values q3_milktype___5 q3_milktype___5_
label values q3_milktype___6 q3_milktype___6_
label values q3_milktype___7 q3_milktype___7_
label values q3_milktype___8 q3_milktype___8_
label values q3_milktype___9 q3_milktype___9_
label values q3_milktype___10 q3_milktype___10_
label values q3_milktype___11 q3_milktype___11_
label values q3_addnacook q3_addnacook_
label values q3_addnabf q3_addnabf_
label values q3_addnawhile q3_addnawhile_
label values q3_addsugcook q3_addsugcook_
label values q3_addsugbf q3_addsugbf_
label values q3_addsugwhile q3_addsugwhile_
label values q3_oiltype___1 q3_oiltype___1_
label values q3_oiltype___2 q3_oiltype___2_
label values q3_oiltype___3 q3_oiltype___3_
label values q3_oiltype___4 q3_oiltype___4_
label values q3_oiltype___5 q3_oiltype___5_
label values q3_oiltype___6 q3_oiltype___6_
label values q3_oiltype___7 q3_oiltype___7_
label values q3_oiltype___8 q3_oiltype___8_
label values q3_oiltype___9 q3_oiltype___9_
label values q3_oiltype___10 q3_oiltype___10_
label values q3_oiltype___11 q3_oiltype___11_
label values q3_oiltype___12 q3_oiltype___12_
label values q3_oiltype___13 q3_oiltype___13_
label values q3_suppmv q3_suppmv_
label values q3_suppva q3_suppva_
label values q3_suppvb q3_suppvb_
label values q3_suppvc q3_suppvc_
label values q3_suppvd q3_suppvd_
label values q3_suppcod q3_suppcod_
label values q3_suppca q3_suppca_
label values q3_suppo3 q3_suppo3_
label values q3_suppfe q3_suppfe_
label values q3_suppzn q3_suppzn_
label values q3_done q3_done_
label values section_3_diet_scree_v_0 section_3_diet_scree_v_0_



** ----------------------------------------------------------------------
** PART 4: VARIABLE METADATA
** ----------------------------------------------------------------------
label variable record_id "Record ID"
label variable q3_eatoutnum "(Q1) Meals per week not prepared at home?"
label variable q3_diets___1 "(Q2) Do you follow any particular diets?  USE SHOWCARD 3c_P (choice=No)"
label variable q3_diets___2 "(Q2) Do you follow any particular diets?  USE SHOWCARD 3c_P (choice=Pescatarian)"
label variable q3_diets___3 "(Q2) Do you follow any particular diets?  USE SHOWCARD 3c_P (choice=Vegetarian)"
label variable q3_diets___4 "(Q2) Do you follow any particular diets?  USE SHOWCARD 3c_P (choice=Vegan)"
label variable q3_diets___5 "(Q2) Do you follow any particular diets?  USE SHOWCARD 3c_P (choice=Low fat)"
label variable q3_diets___6 "(Q2) Low carbohydrate diet"
label variable q3_diets___7 "(Q2) Low glycemic index diet?"
label variable q3_diets___8 "(Q2) Diabetic diet?"
label variable q3_diets___9 "(Q2) Low salt diet"
label variable q3_diets___10 "(Q2) Weight reduction diet"
label variable q3_diets___11 "(Q2) Gluten free diet"
label variable q3_diets___12 "(Q2) Lactose free diet"
label variable q3_diets___13 "(Q2) High fibre diet"
label variable q3_diets___14 "(Q2) Other diet"
label variable q3_diets___15 "(Q2) Dont know"
label variable q3_dietreason___1 "(Q3) Changed your diet in the past year (choice=No)"
label variable q3_dietreason___2 "(Q3) Changed your diet in the past year (choice=Overweight or obesity)"
label variable q3_dietreason___3 "(Q3) Changed your diet in the past year (choice=Diabetes)"
label variable q3_dietreason___5 "(Q3) Changed your diet in the past year (choice=High blood cholesterol)"
label variable q3_dietreason___4 "(Q3) Changed your diet in the past year (choice=High blood pressure)"
label variable q3_dietreason___6 "(Q3) Changed your diet in the past year (choice=Cancer)"
label variable q3_dietreason___7 "(Q3) Changed your diet in the past year (choice=Concerns over family history)"
label variable q3_dietreason___8 "(Q3) Changed your diet in the past year (choice=Concerns over healthy eating)"
label variable q3_dietreason___9 "(Q3) Changed your diet in the past year (choice=Stomach/bowel problems)"
label variable q3_dietreason___10 "(Q3) Changed your diet in the past year (choice=family member changed diet)"
label variable q3_dietreason___11 "(Q3) Changed your diet in the past year (choice=Other)"
label variable q3_fruitnum "(Q4) Days fruit?"
label variable q3_fruitserv "(Q5) Servngs fruit"
label variable q3_vegnum "(Q6) Days Vegetables "
label variable q3_vegserv "(Q7) Servings vegetables"
label variable q3_fishnum "(Q8) Days Fish"
label variable q3_fishserv "(Q9) Servings of fish "
label variable q3_oilfishnum "(Q10) Days Oily fish"
label variable q3_oilfishserv "(Q11) Servings of oily fish"
label variable q3_upmeatnum "(Q12) Days unprocessed red meat"
label variable q3_upmeatserv "(Q13) Servings unprocessed red meat"
label variable q3_pmeatnum "(Q14) Days processed red meat?"
label variable q3_pmeatserv "(Q15) Servings processed meat"
label variable q3_upfoodnum "(Q16) Days unprocessed or minimally processed foods?"
label variable q3_pfoodnum "(Q17) Days processed culinary ingredients?"
label variable q3_tinfoodnum "(Q18) Days processed foods"
label variable q3_ultpfoodnum "(Q19) Days ultra-processed foods?"
label variable q3_ssbnum "(Q20) Days sugar-sweetened beverages?"
label variable q3_ssbserv "(Q21) Servings sugar-sweetened beverages"
label variable q3_ddrinknum "(Q22) Days sugar-free soft drinks?"
label variable q3_ddrinkserv "(Q23) Servings sugar-free soft drinks"
label variable q3_drinkdaily___1 "(Q24) Beverages (choice=Fresh juices)"
label variable q3_drinkdaily___2 "(Q24) Beverages (choice=Manufactured juices)"
label variable q3_drinkdaily___3 "(Q24) Beverages (choice=Drinking water from tap)"
label variable q3_drinkdaily___4 "(Q24) Beverages (choice=Bottled drinking water)"
label variable q3_drinkdaily___5 "(Q24) Beverages (choice=Tea or coffee (-milk, -sugar))"
label variable q3_drinkdaily___6 "(Q24) Beverages (choice=Tea or coffee (+milk, +sugar))"
label variable q3_drinkdaily___7 "(Q24) Beverages (choice=Tea or coffee (-milk, +sugar))"
label variable q3_drinkdaily___8 "(Q24) Beverages (choice=Tea or coffee (+milk, -sugar))"
label variable q3_drinkdaily___9 "(Q24) Beverages (choice=Milk)"
label variable q3_drinkdaily___10 "(Q24) Beverages (choice=Other)"
label variable q3_drinkdaily___11 "(Q24) Beverages (choice=Dont know)"
label variable q3_fjuiceserv "(Q25) How many servings of fresh juices do you consume daily?  USE SHOWCARD"
label variable q3_mjuiceserv "(Q26) Servings juices"
label variable q3_twatserv "(Q27) Servings water"
label variable q3_bwatserv "(Q28) Servings bottled water"
label variable q3_tea "(Q29) Servings tea or coffee (no milk/sugar)"
label variable q3_teamilksug "(Q30) Servings tea or coffee (with milk+sugar)"
label variable q3_teasug "(Q31) Servings tea or coffee (no milk, +sugar)"
label variable q3_teamilk "(Q32) Servings tea or coffee (+milk, no sugar)"
label variable q3_milkserv "(Q33) Servings milk"
label variable q3_milktype___1 "(Q34) Milk (choice=Cows milk (full fat))"
label variable q3_milktype___2 "(Q34) Milk (choice=Cows milk (skimmed/low fat))"
label variable q3_milktype___3 "(Q34) Milk (choice=Cows milk (semi-skimmed))"
label variable q3_milktype___4 "(Q34) Milk (choice=Powdered cows milk (full fat))"
label variable q3_milktype___5 "(Q34) Milk (choice=Powdered cows milk (skimmed))"
label variable q3_milktype___6 "(Q34) Milk (choice=Goats milk)"
label variable q3_milktype___7 "(Q34) Milk (choice=Soy milk)"
label variable q3_milktype___8 "(Q34) Milk (choice=Almond milk)"
label variable q3_milktype___9 "(Q34) Milk (choice=Other nut milk)"
label variable q3_milktype___10 "(Q34) Milk (choice=Other)"
label variable q3_milktype___11 "(Q34) Milk (choice=Not consumed)"
label variable q3_addnacook "during cooking or preparing?"
label variable q3_addnabf "right before eating?"
label variable q3_addnawhile "while you are eating?"
label variable q3_addsugcook "during cooking or preparing?"
label variable q3_addsugbf "right before eating?"
label variable q3_addsugwhile "while you are eating?"
label variable q3_oiltype___1 "(Q37) Oil or fat (choice=Vegetable oil)"
label variable q3_oiltype___2 "(Q37) Oil or fat (choice=Palm oil)"
label variable q3_oiltype___3 "(Q37) Oil or fat (choice=Coconut oil)"
label variable q3_oiltype___4 "(Q37) Oil or fat (choice=Canola/rapeseed oil)"
label variable q3_oiltype___5 "(Q37) Oil or fat (choice=Olive oil)"
label variable q3_oiltype___6 "(Q37) Oil or fat (choice=Sunflower oil)"
label variable q3_oiltype___7 "(Q37) Oil or fat (choice=Soybean oil)"
label variable q3_oiltype___8 "(Q37) Oil or fat (choice=Lard or suet)"
label variable q3_oiltype___9 "(Q37) Oil or fat (choice=Butter or ghee)"
label variable q3_oiltype___10 "(Q37) Oil or fat (choice=Margarine)"
label variable q3_oiltype___11 "(Q37) Oil or fat (choice=Other)"
label variable q3_oiltype___12 "(Q37) Oil or fat (choice=None)"
label variable q3_oiltype___13 "(Q37) Oil or fat (choice=Dont know)"
label variable q3_suppmv "Multivitamins"
label variable q3_suppva "Vitamin A (eg: beta-carotene)"
label variable q3_suppvb "B vitamins"
label variable q3_suppvc "Vitamin C"
label variable q3_suppvd "Vitamin D"
label variable q3_suppcod "Cod liver oil"
label variable q3_suppca "Calcium"
label variable q3_suppo3 "Fish oils/omega-3 oils"
label variable q3_suppfe "Iron"
label variable q3_suppzn "Zinc"
label variable q3_done "Have you covered all relevant questions?"
label variable q3_donereason "What is your reason to not move on to the next survey?"
label variable section_3_diet_scree_v_0 "Complete?"

** ----------------------------------------------------------------------
** PART 5: ORDER AND SAVE THE FILE
** ----------------------------------------------------------------------
order pid record_id q3_eatoutnum q3_diets___1 q3_diets___2 q3_diets___3 q3_diets___4 q3_diets___5 q3_diets___6 q3_diets___7 q3_diets___8 q3_diets___9 q3_diets___10 q3_diets___11 q3_diets___12 q3_diets___13 q3_diets___14 q3_diets___15 q3_dietreason___1 q3_dietreason___2 q3_dietreason___3 q3_dietreason___4 q3_dietreason___5 q3_dietreason___6 q3_dietreason___7 q3_dietreason___8 q3_dietreason___9 q3_dietreason___10 q3_dietreason___11 q3_fruitnum q3_fruitserv q3_vegnum q3_vegserv q3_fishnum q3_fishserv q3_oilfishnum q3_oilfishserv q3_upmeatnum q3_upmeatserv q3_pmeatnum q3_pmeatserv q3_upfoodnum q3_pfoodnum q3_tinfoodnum q3_ultpfoodnum q3_ssbnum q3_ssbserv q3_ddrinknum q3_ddrinkserv q3_drinkdaily___1 q3_drinkdaily___2 q3_drinkdaily___3 q3_drinkdaily___4 q3_drinkdaily___5 q3_drinkdaily___6 q3_drinkdaily___7 q3_drinkdaily___8 q3_drinkdaily___9 q3_drinkdaily___10 q3_drinkdaily___11 q3_fjuiceserv q3_mjuiceserv q3_twatserv q3_bwatserv q3_tea q3_teamilksug q3_teasug q3_teamilk q3_milkserv q3_milktype___1 q3_milktype___2 q3_milktype___3 q3_milktype___4 q3_milktype___5 q3_milktype___6 q3_milktype___7 q3_milktype___8 q3_milktype___9 q3_milktype___10 q3_milktype___11 q3_addnacook q3_addnabf q3_addnawhile q3_addsugcook q3_addsugbf q3_addsugwhile q3_oiltype___1 q3_oiltype___2 q3_oiltype___3 q3_oiltype___4 q3_oiltype___5 q3_oiltype___6 q3_oiltype___7 q3_oiltype___8 q3_oiltype___9 q3_oiltype___10 q3_oiltype___11 q3_oiltype___12 q3_oiltype___13 q3_suppmv q3_suppva q3_suppvb q3_suppvc q3_suppvd q3_suppcod q3_suppca q3_suppo3 q3_suppfe q3_suppzn q3_done q3_donereason section_3_diet_scree_v_0


label data "CFaH Survey. Dataset01-DietScreener. Pre-release1. 07Oct2018"
drop record_id q3_done q3_donereason section_3_diet_scree_v_0 _merge
sort pid
datasignature set, saving(cfah3_pr1, replace) reset
save "`datapath'/version01/2-working/section3_pre-release1.dta", replace

set linesize 180
describe, full
