** HEADER -----------------------------------------------------
**  DO-FILE METADATA
    //  algorithm name			      section6_CFaHHouseholdSurvey.do
    //  project:				          Community Food and Health
    //  analysts:				 	        Ian HAMBLETON
    // 	date last modified	      22-OCT-2018
    //  algorithm task			      Preparing DATA: SECTION 6

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
    log using "`logpath'\section6_CFaHHouseholdSurvey", replace
** HEADER -----------------------------------------------------



** IMPORT the REDCap EXPORT (6-OCT-2018)
import delimited record_id q6_htn q6_dm q6_chol q6_hd q6_stk q6_cancer q6_htnrx q6_dmrx q6_edu q6_eth q6_ethoth q6_mar q6_occ q6_occoth q6_bpallow q6_intidbp q6_bpid q6_arm q6_sys1 q6_dias1 q6_sys2 q6_dias2 q6_sys3 q6_dias3 q6_htallow q6_intidheight q6_stadid q6_height q6_wtallow q6_intidweight q6_scaleid q6_weight q6_bmi q6_wcallow q6_intidwaist q6_tapeid q6_wc1 q6_wc2 q6_wc3 q6_done section_6_additional_v_0 using "`datapath'/version01/1-input/section6_CFaHHouseholdSurvey_22oct2018.csv", varnames(nonames)
label data "CFaH Household Survey: SECTION 6"

** Merge with de-identified ID numbers
sort record_id
merge 1:1 record_id using "`datapath'/version01/2-working/section1_idlinkage.dta"
order pid, before(record_id)



** ----------------------------------------------------------------------
** PART 2: VARIABLE CATEGORY DEFINITIONS
** ----------------------------------------------------------------------
label define q6_htn_ 1 "Yes" 2 "No" 3 "Dont know" 4 "Refuse to answer"
label define q6_dm_ 1 "Yes" 2 "No" 3 "Dont know" 4 "Refuse to answer"
label define q6_chol_ 1 "Yes" 2 "No" 3 "Dont know" 4 "Refuse to answer"
label define q6_hd_ 1 "Yes" 2 "No" 3 "Dont know" 4 "Refuse to answer"
label define q6_stk_ 1 "Yes" 2 "No" 3 "Dont know" 4 "Refuse to answer"
label define q6_cancer_ 1 "Yes" 2 "No" 3 "Dont know" 4 "Refuse to answer"
label define q6_htnrx_ 1 "Yes" 2 "No" 3 "Dont know" 4 "Refused to answer"
label define q6_dmrx_ 1 "Yes" 2 "No" 3 "Dont know" 4 "Refused to answer"
label define q6_edu_ 1 "No formal schooling" 2 "Less than primary  school" 3 "Primary school completed" 4 "Secondary school completed" 5 "Technical training/vocational completed" 6 "College/University completed" 7 "Post graduate degree" 8 "Refuse to answer"
label define q6_eth_ 1 "African/Black" 2 "Taukei" 3 "Fijian of Indian Descent" 4 "Fijian of Other Descent" 5 "Indigenous Carib/Amerindian" 6 "White/Caucasian" 7 "Chinese" 8 "East Indian/Indian" 9 "Hispanic/Spanish" 10 "Mixed" 11 "Portuguese" 12 "Syrian/Lebanese" 13 "Other" 14 "Refuse to answer"
label define q6_mar_ 1 "Never married" 2 "Currently married" 3 "Separated" 4 "Divorced" 5 "Widowed" 6 "Cohabiting" 7 "Visiting partner" 8 "Refuse to answer"
label define q6_occ_ 1 "Government employee" 2 "Non-government employee" 3 "Self-employed/own business without paid employees" 4 "Self-employed/own business with paid employees" 5 "Unpaid" 6 "Student" 7 "Homemaker" 8 "Retired" 9 "Unemployed (able to work)" 10 "Unemployed (unable to work)" 11 "Other" 12 "Refuse to answer"
label define q6_bpallow_ 1 "Yes" 2 "No"
label define q6_intidbp_ 1 "1" 2 "2" 3 "3" 4 "4" 5 "5" 6 "6" 7 "7" 8 "8" 9 "9" 10 "10" 11 "11" 12 "12" 13 "13" 14 "14" 15 "15"
label define q6_bpid_ 1 "1" 2 "2" 3 "3" 4 "4" 5 "5" 6 "6" 7 "7" 8 "8"
label define q6_arm_ 1 "Dominant" 2 "Non-dominant"
label define q6_htallow_ 1 "Yes" 2 "No"
label define q6_intidheight_ 1 "1" 2 "2" 3 "3" 4 "4" 5 "5" 6 "6" 7 "7" 8 "8" 9 "9" 10 "10" 11 "11" 12 "12" 13 "13" 14 "14" 15 "15"
label define q6_stadid_ 1 "1" 2 "2" 3 "3" 4 "4" 5 "5" 6 "6" 7 "7" 8 "8"
label define q6_wtallow_ 1 "Yes" 2 "No"
label define q6_intidweight_ 1 "1" 2 "2" 3 "3" 4 "4" 5 "5" 6 "6" 7 "7" 8 "8" 9 "9" 10 "10" 11 "11" 12 "12" 13 "13" 14 "14" 15 "15"
label define q6_scaleid_ 1 "1" 2 "2" 3 "3" 4 "4" 5 "5" 6 "6" 7 "7" 8 "8"
label define q6_wcallow_ 1 "Yes" 2 "No"
label define q6_intidwaist_ 1 "1" 2 "2" 3 "3" 4 "4" 5 "5" 6 "6" 7 "7" 8 "8" 9 "9" 10 "10" 11 "11" 12 "12" 13 "13" 14 "14" 15 "15"
label define q6_tapeid_ 1 "1" 2 "2" 3 "3" 4 "4" 5 "5" 6 "6" 7 "7" 8 "8"
label define q6_done_ 1 "Yes" 2 "No"
label define section_6_additional_v_0_ 0 "Incomplete" 1 "Unverified" 2 "Complete"

** ----------------------------------------------------------------------
** PART 3: VARIABLE CATEGORY LABEL ATTACHMENTS
** ----------------------------------------------------------------------
label values q6_htn q6_htn_
label values q6_dm q6_dm_
label values q6_chol q6_chol_
label values q6_hd q6_hd_
label values q6_stk q6_stk_
label values q6_cancer q6_cancer_
label values q6_htnrx q6_htnrx_
label values q6_dmrx q6_dmrx_
label values q6_edu q6_edu_
label values q6_eth q6_eth_
label values q6_mar q6_mar_
label values q6_occ q6_occ_
label values q6_bpallow q6_bpallow_
label values q6_intidbp q6_intidbp_
label values q6_bpid q6_bpid_
label values q6_arm q6_arm_
label values q6_htallow q6_htallow_
label values q6_intidheight q6_intidheight_
label values q6_stadid q6_stadid_
label values q6_wtallow q6_wtallow_
label values q6_intidweight q6_intidweight_
label values q6_scaleid q6_scaleid_
label values q6_wcallow q6_wcallow_
label values q6_intidwaist q6_intidwaist_
label values q6_tapeid q6_tapeid_
label values q6_done q6_done_
label values section_6_additional_v_0 section_6_additional_v_0_



** ----------------------------------------------------------------------
** PART 4: VARIABLE METADATA
** ----------------------------------------------------------------------
label variable record_id "Record ID"
label variable q6_htn "hbp? Excluding hypertension during pregnancy"
label variable q6_dm "Diabetes. Excluding diabetes during pregnancy"
label variable q6_chol "Raised blood cholesterol"
label variable q6_hd "Heart disease"
label variable q6_stk "Stroke"
label variable q6_cancer "Cancer"
label variable q6_htnrx "(Q1a) History of hbp - currently prescribed medication?"
label variable q6_dmrx "(Q1b) History of diabetes - currently prescribed medication?"
label variable q6_edu "(Q2) Highest level of education?"
label variable q6_eth "(Q3) What is your ethnic background?  USE SHOWCARD 6_P"
label variable q6_ethoth "(Q3a) What is your other background?"
label variable q6_mar "(Q4) Current marital status?"
label variable q6_occ "(Q5) Main work status over the past 12 months?"
label variable q6_occoth "(Q5a) What is your other main work status?"
label variable q6_bpallow "(Q6) Can I measure your blood pressure? "
label variable q6_intidbp "(Q6a) Select interviewer ID of person measuring blood pressure"
label variable q6_bpid "(Q6b) Select blood pressure monitor ID"
label variable q6_arm "(Q6c) Select arm"
label variable q6_sys1 "(Q6d) State reading 1: systolic pressure"
label variable q6_dias1 "(Q6e) State reading 1: diastolic pressure"
label variable q6_sys2 "(Q6f) State reading 2: systolic pressure"
label variable q6_dias2 "(Q6g) State reading 2: diastolic pressure"
label variable q6_sys3 "(Q6h) State reading 3: systolic pressure"
label variable q6_dias3 "(Q6i) State reading 3: diastolic pressure"
label variable q6_htallow "(Q7) Can I measure your height? "
label variable q6_intidheight "(Q7a) Select interviewer ID of person measuring height"
label variable q6_stadid "(Q7b) Select stadiometer ID"
label variable q6_height "(Q7c) State height"
label variable q6_wtallow "(Q8) Can I measure your weight?"
label variable q6_intidweight "(Q8a) Select interviewer ID of person measuring weight"
label variable q6_scaleid "(Q8b) Select scale ID"
label variable q6_weight "(Q8c) State weight"
label variable q6_bmi "(Q9) BMI (auto-calculates)"
label variable q6_wcallow "(Q10) Can I measure your waist circumference?"
label variable q6_intidwaist "(Q10a) Select interviewer ID of person measuring waist circumference"
label variable q6_tapeid "(Q10b) Select measuring tape ID"
label variable q6_wc1 "(Q10c) State reading 1: waist circumference "
label variable q6_wc2 "(Q10d) State reading 2: waist circumference "
label variable q6_wc3 "(Q10e) State reading 3: waist circumference "
label variable q6_done "Have you covered all relevant questions?"
label variable section_6_additional_v_0 "Complete?"


** ----------------------------------------------------------------------
** PART 5: ORDER AND SAVE THE FILE
** ----------------------------------------------------------------------

order pid record_id q6_htn q6_dm q6_chol q6_hd q6_stk q6_cancer q6_htnrx q6_dmrx q6_edu q6_eth q6_ethoth q6_mar q6_occ q6_occoth q6_bpallow q6_intidbp q6_bpid q6_arm q6_sys1 q6_dias1 q6_sys2 q6_dias2 q6_sys3 q6_dias3 q6_htallow q6_intidheight q6_stadid q6_height q6_wtallow q6_intidweight q6_scaleid q6_weight q6_bmi q6_wcallow q6_intidwaist q6_tapeid q6_wc1 q6_wc2 q6_wc3 q6_done section_6_additional_v_0

label data "CFaH Survey. Section6-DietScreener. Pre-release2. 22Oct2018"
drop record_id q6_done section_6_additional_v_0 _merge
sort pid
save "`datapath'/version01/2-working/section6_pre-release2.dta", replace

set linesize 180
describe, full
