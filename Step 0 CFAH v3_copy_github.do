************************************************************************************
* CFAH datacleaning : Step 0  -- Basic cleaning  | VERSION: 3.0 (17/12/2018)       *
************************************************************************************
* Purpose of cleaning step: to merge and check CFAH data (from a third extract) in preparation for analysis
*
* VERSION TRACKING:
* Version 1.0: First version of this cleaning step with initial data extract
* Version 2.0: Second version of this cleaning step with data extract from 22/10/2018
* Version 3.0: final version of this cleaning step with data extract from 12/12/2018
*
* SUMMARY OF SCRIPT:
* SUBSTEP a: Loading data
* SUBSTEP b. Merge datasets
* SUBSTEP c. Explore data and flag participants
* SUBSTEP d. Generating new variables  
* 
*
* REQUIRES: 
* Do-files: section1_CFaHHouseholdSurvey.do, section2_CFaHHouseholdSurvey.do, section3_CFaHHouseholdSurvey.do, section4a_CFaHHouseholdSurvey.do, section4b_CFaHHouseholdSurvey.do, section4c_CFaHHouseholdSurvey.do, section4d_CFaHHouseholdSurvey.do section5_CFaHHouseholdSurvey.do, section6_CFaHHouseholdSurvey.do
*
* Databases (see section descriptions below): section1_pre-release3.dta, section2_pre-release3.dta, section3_pre-release3.dta, section4a_pre-release3.dta ,section4b_pre-release3.dta, section4c_pre-release3.dta, section4d_pre-release3.dta ,section5_pre-release3.dta, section6_pre-release3.dta
*
* Section 1: Participant and household information
* Section 2: Dietary diversity (questionnaire 1)
* Section 3: Diet screener (questionnaire 2)
* Section 4: Food source/procurement (questionnaire 3)
* Section 4a: Food source_own production 
* Section 4b: Food source_purchase/buy
* Section 4c: Food source_borrow
* Section 4d: Food source_food aid
* Section 5: Food insecurity (questionnaire 4)
* Sectino 6: Demographics and medical data (questionnaire 5)
* 
*
* REQUIRED BY:
* Do-files: Step 1 CFAH v3.do (for analysis)
*
*
* SPECIFIC STATA ADD ONS REQUIRED:
* None
* Written in Stata14.2
* Written by Anna Brugulat, Divya Bhagtani and Lou Foley

************************************************************************************

************************************************************************************
* Substep a. Loading data 							     						   *
************************************************************************************

global inputdir "V:\StrategicProjects\NIHR_GDAR\Global Public Health\CFaH\Data\CFaH Quant Analysis\Raw data 3\"     //the inputdirectory - the directory containing all inputfiles (i.e. the database, files to merge) 
global outputdir "V:\StrategicProjects\NIHR_GDAR\Global Public Health\CFaH\Data\CFaH Quant Analysis\Cleaning 3\"   	//the outputdirectoy - the directory where all output is stored (i.e. logs and end products). If you would like to save graphs or whatever just put ${outputdir} in front of the file name and they will be stored in that directory as well
global inputfile "section1_pre-release3.dta"                                 	//the inputfile to start the cleaning at this step with. If it is auto, it will automatically load the release (step-1) of the prior step. The program automatically determines how to load this file and can handle csv files and stata files

cd "$inputdir"																	//change the working directory to the inputdir

//in these three lines the input data will be opened, depending on the type of file
use "$inputfile", clear 

************************************************************************************
* GLOBALS AND LOCALS															   *
************************************************************************************
//you can define your globals and locals in this part


************************************************************************************
* SUBSTEP b. Merge datasets						        				           *
************************************************************************************
* Short summary: CFAH data was supplied as six discrete datasets, these are merged *
* using the unique id (pid) prior to further cleaning  							   *
************************************************************************************

//merge all datasets together

merge 1:1 pid using section2_pre-release3.dta //to merge data for participants with the same pid 


drop _merge
merge 1:1 pid using section3_pre-release3.dta


drop _merge
merge 1:1 pid using section4a_pre-release3.dta



drop _merge
merge 1:1 pid using section4b_pre-release3.dta


drop _merge
merge 1:1 pid using section4c_pre-release3.dta



drop _merge
merge 1:1 pid using section4d_pre-release3.dta


drop _merge
merge 1:1 pid using section5_pre-release3.dta



drop _merge
merge 1:1 pid using section6_pre-release3.dta



drop _merge


//save the merged data to a new cleaning file
save "${outputdir}CFAH_section1-6_pre-release3.dta", replace
use "${outputdir}CFAH_section1-6_pre-release3", clear

// At this point, the data set contains 335 observations and 734 variables


************************************************************************************
* SUBSTEP c. Explore data       				        				           *
************************************************************************************
* Short summary: First look at the data to identify missing or potential problems  *
************************************************************************************
//cid corresponds to the ID given in REdcap and pid to the unique internal ID in the dta.file
//If to double check data is needed, use cid to find original data from participants in REDcap. e.g. see below
list q1_country cid pid if pid >180 & pid <194


//Section 1* Participant and household identification

//look at ranges, missing, to identify
codebook q1_country q1_region q1_hh hid cid pid q1_sex q1_agecalc q1_cook q1_housetotal q1_p1sex q1_p1age q1_p2sex q1_p2age ///
q1_p3sex q1_p3age q1_p4sex q1_p4age q1_p5sex q1_p5age q1_p6sex q1_p6age q1_p7sex q1_p7age q1_p8sex q1_p8age q1_p9sex q1_p9age ///
q1_p10sex q1_p10age q1_p11sex q1_p11age q1_p12sex q1_p12age

//DB : Cid (country id) is missing for two participants with pid 187 and pid 335
//DB: participant pid 335 and pid 187 are missing all data in all sections.

* DB: Need to confirm these for data extract 3* 
//Labels for regions confirmed by Catherine and same than in data extract 1: 
//1, Molituva, Kuku, Tailevu District (rural formal) | 2, Vusuya Settlement (rural informal) | 3, Kalabu Village (urban formal) | 4, Manikoso Settlement (urban informal) --> Fiji
//5, Cane Garden (urban, high SES) | 6, Fair Hall and Glen (urban, low SES) | 7, New Grounds (rural, high SES) | 8, Overland and Big Level (rural, low SES) --> SVG

//DB: suggested from Ian's do file to drop q1_region==5 Cane Garden (SVG; urban, high SES) as it has only 2 participants 
browse pid cid q1_country if q1_region==5
//The 2 participants from SVG are cid 66 with pid 252 and cid 88 with pid 274
//drop if q1_region==5

**In the meeting with Lou and Anna on 9-0-19 it was decided to not drop these 2 participants but also that these i.e. Cane Garden will not be compared as a group with another group eg. New Grounds 

//DB: q1_p1age q1_p2age q1_p3age q1_p4age q1_p5age q1_p6age have a range from 0-999, where 999 means "not applicable, unsure or refuse to answer".  Remeber to treat 999 values as missing data during Data Cleaning

//DB: q1_hh is missing for 7 participants from Fiji 
// It appeared from Ian's do file that q1_hh was generated using q1_country q1_region q1_house but Cathrine confirmed on 8-1-19 that these were assigned by field supervisors i.e. Jioje for Fiji.
//although only 7 participants were missing this info , it would be useful to have this when accounting for clustering within households. 
//- Jioje was emailed on 8-1-19 for info on the same  // All participants missing variable q1_hh were missing information on q1_region except one which was also missing q1_house. 
//We could try and generate q1_hh if we had the data for q1_region and q1_house for those missing.

list cid pid q1_sex q1_country  q1_region q1_housetotal q1_hh if q1_hh==.



//// Confirming that all participants who reported cohabiting partner as the main cook, also reported other people living in the HH
browse if q1_cook ==3 & q1_housetotal==0
// Confirming that there are participants who reported a relative as a main cook but the relative does not live in the HH
browse if q1_cook ==2 & q1_housetotal==0

//DB: In the data extract 2, participant pid 276 had no data for all sections. (pid 276 does not have a cid)
//In data extract 3, pid 276 has all the data completed and has a cid 90 (SVG).

//L&A&D: In data extract 1, participant pid 71 (cid 71, fiji) had few demographic data. According to Joije, it was updated. 
// In data extract 2 and 3, pid 71 (cid 71) has all the demographics 

//Section 2* Diet diversity 

codebook q2_usualday q2_unusualhow___1 q2_unusualhow___2 q2_unusualhow___3 q2_unusualhow___4 ///
 q2_unusualhow___5 q2_recall1 q2_recall2 q2_recall3 q2_recall4 q2_grains q2_roots q2_pulses ///
 q2_nuts q2_milk q2_ormeat q2_pmeat q2_ppoul q2_upmeat q2_uppoul q2_fish q2_eggs q2_gveg q2_vitaveg ///
 q2_vitafruit q2_vegoth q2_fruitoth q2_insects q2_palmoil q2_oils q2_snacks q2_sweets q2_ssb q2_cond ///
 q2_drinkoth q2_grains2 q2_roots2 q2_pulses2 q2_nuts2 q2_milk2 q2_ormeat2 q2_pmeat2 q2_ppoul2 q2_upmeat2 ///
 q2_uppoul2 q2_fish2 q2_eggs2 q2_gveg2 q2_vitaveg2 q2_vitafruit2 q2_vegoth2 q2_fruitoth2 q2_insects2 ///
 q2_palmoil2 q2_oils2 q2_snacks2 q2_sweets2 q2_ssb2 q2_cond2 q2_eatout
 
 
 ** The dietary diversity recall was taken in two ways 1. uninterupted free recall (q2_variable) 2. Asking specific probe questions for food groups that were not reported in the uninterupted recall(q2_variable2).
 // which means that it would be better to consider the second recall (specific food group probe enteries) for those participants who may be missing the first recall but have data for the second. 
 //Thus checking below for q2_variable2 entries
 
 order q2_drinkoth , after(q2_cond2) 
 
 foreach x in q2_grains q2_roots q2_pulses q2_nuts q2_milk q2_ormeat q2_pmeat q2_ppoul q2_upmeat q2_uppoul q2_fish q2_eggs q2_gveg q2_vitaveg q2_vitafruit q2_vegoth q2_fruitoth q2_insects q2_palmoil q2_oils q2_snacks q2_sweets q2_ssb q2_cond {
 tab1 `x' if `x' ==3 & (`x'2 ==1 | `x'2 ==2)
 }
 
 
//For each food group the number of second recalls (after specific probing)- look below;
*grains - 1
*White roots, tubers and plantains - 2 
*pulses - 0
*nuts and seeds - 1
*milk and milk products - 1
*organ meat - 0
*processsed red meat - 0 ; unprocessed red meat - 6
*processed poultry - 3 ; unprocessed poultry - 16 
*fish and seafood - 3
*eggs - 0
*DGLV - 2 
*vit a rich vegetables and tubers - 10 ; vit a rich fruits - 6                 
* other vegetables - 12 ; other fruits - 2
* insects and small protein foods - 1 
* red palm oil - 2
* oils and fats - 3
* fried snacks - 3 ; sweets - 1 ; ssbs - 4
* condiments and seasonings - 3 
/// In total over a 100 (aprox 106)participants were identified with no data for food groups in recall 1 but had reported data for the second/ probed recall 

**Just to check that there are no food groups with missing values in recall 1 but have values in recall 2. *(there were no such observations)
// foreach x in q2_grains q2_roots q2_pulses q2_nuts q2_milk q2_ormeat q2_pmeat q2_ppoul q2_upmeat q2_uppoul q2_fish q2_eggs q2_gveg q2_vitaveg q2_vitafruit q2_vegoth q2_fruitoth q2_insects q2_palmoil q2_oils q2_snacks q2_sweets q2_ssb q2_cond {
 //tab1 `x' if `x' ==. & `x'2 !=.
 //}
 
 foreach x in q2_grains q2_roots q2_pulses q2_nuts q2_milk q2_ormeat q2_pmeat q2_ppoul q2_upmeat q2_uppoul q2_fish q2_eggs q2_gveg q2_vitaveg q2_vitafruit q2_vegoth q2_fruitoth q2_insects q2_palmoil q2_oils q2_snacks q2_sweets q2_ssb q2_cond {                                                                                        
 replace `x' = `x'2 if `x' ==3 & (`x'2 ==1 | `x'2 ==2)                                                                                                
 }

* //Section 3* Diet screener  

 codebook q3_eatoutnum q3_diets___1 q3_diets___2 q3_diets___3 q3_diets___4 q3_diets___5 ///
 q3_diets___6 q3_diets___7 q3_diets___8 q3_diets___9 q3_diets___10 q3_diets___11 q3_diets___12 ///
 q3_diets___13 q3_diets___14 q3_diets___15 q3_dietreason___1 q3_dietreason___2 q3_dietreason___3 ///
 q3_dietreason___4 q3_dietreason___5 q3_dietreason___6 q3_dietreason___7 q3_dietreason___8 q3_dietreason___9 ///
 q3_dietreason___10 q3_dietreason___11 q3_fruitnum q3_fruitserv q3_vegnum q3_vegserv q3_fishnum q3_fishserv ///
 q3_oilfishnum q3_oilfishserv q3_upmeatnum q3_upmeatserv q3_pmeatnum q3_pmeatserv q3_upfoodnum q3_pfoodnum ///
 q3_tinfoodnum q3_ultpfoodnum q3_ssbnum q3_ssbserv q3_ddrinknum q3_ddrinkserv q3_drinkdaily___1 q3_drinkdaily___2 ///
 q3_drinkdaily___3 q3_drinkdaily___4 q3_drinkdaily___5 q3_drinkdaily___6 q3_drinkdaily___7 q3_drinkdaily___8 ///
 q3_drinkdaily___9 q3_drinkdaily___10 q3_drinkdaily___11 q3_fjuiceserv q3_mjuiceserv q3_twatserv q3_bwatserv ///
 q3_tea q3_teamilksug q3_teasug q3_teamilk q3_milkserv q3_milktype___1 q3_milktype___2 q3_milktype___3 q3_milktype___4 ///
 q3_milktype___5 q3_milktype___6 q3_milktype___7 q3_milktype___8 q3_milktype___9 q3_milktype___10 q3_milktype___11 ///
 q3_addnacook q3_addnabf q3_addnawhile q3_addsugcook q3_addsugbf q3_addsugwhile q3_oiltype___1 q3_oiltype___2 q3_oiltype___2 ///
 q3_oiltype___3 q3_oiltype___4 q3_oiltype___5 q3_oiltype___6 q3_oiltype___7 q3_oiltype___8 q3_oiltype___9 q3_oiltype___10 ///
 q3_oiltype___11 q3_oiltype___12 q3_oiltype___12 q3_oiltype___13 q3_suppmv q3_suppva q3_suppvb q3_suppvc q3_suppvd q3_suppcod ///
 q3_suppca q3_suppo3 q3_suppfe q3_suppzn
 
 //DB: variable q3_eatoutnum is a string variable "1 day"- for pid 241
 //DB: variable q3_eatoutnum has 999 values. Remeber to treat 999 values as missing data during Data Cleaning
 //DB: variable q3_eatoutnum also has some embeded blanks- these on redcap were with value 0. Remember to treat those also as missing data
 
 //DB: variables q3_Xnum have the label 9 "don't know". Remember to treat 9 values as missing values during the Data Cleaning.   
 //DB: variables q3_Xserv have the label 6 "don't know". Remember to treat 6 values as missing values during the Data Cleaning.   
 
 //DB: variable q3_fjuiceserv q3_mjuiceserv q3_twatserv q3_bwatserv had a range of 0-999. Treat 999 as missing data. 
 //DB: variable q3_teamilksug has a range of [1,500], servings of tea with milk and sugar per day  
 
 //
 //section 4a* Food production 
 *It has been split into shorter sections to make the exploring easier
 
 codebook  q4a_prod q4a_prodtype___1 q4a_prodtype___2 q4a_prodtype___3 q4a_prodtype___4 q4a_prodtype___5 q4a_prodtype___6 ///
 q4a_prodtype___7 q4a_prodtype___8 q4a_prodtype___9 q4a_prodtype___10 q4a_prodtype___11 q4a_prodtype___12 q4a_prodtype___13 q4a_prodtype___14 ///
 q4a_prodtype___15 q4a_prodtype___16 q4a_prodtype___17 q4a_prodtype___18 q4a_prodtype___19 q4a_prodtype___20 q4a_prodtype___21 q4a_prodtype___22
 
 codebook q4a_cerealtime q4a_cerealsell q4a_rootstime q4a_rootssell q4a_vegavail q4a_vegtime q4a_vegsell q4a_fruitavail q4a_fruittime q4a_fruitsell ///
 q4a_pmeattime q4a_pmeatsell q4a_upmeattime q4a_upmeatsell q4a_eggstime q4a_eggssell q4a_fishtime q4a_fishsell q4a_insecttime q4a_insectsell ///
 q4a_pulsestime q4a_pulsessell q4a_nutstime q4a_nutssell q4a_milktime q4a_milksell q4a_oilstime q4a_oilssell q4a_sweetstime q4a_sweetssell ///
 q4a_snackstime q4a_snackssell q4a_ssbtime q4a_ssbsell q4a_nalctime q4a_nalcsell q4a_alctime q4a_alcsell q4a_condtime q4a_condsell q4a_mealstime ///
 q4a_mealssell
 
 //Section 4b* Food purchase  
 *It has been split into shorter sections to make the exploring easier

  codebook q4b_bartime q4b_mobiletime q4b_tatime q4b_fftime q4b_resttime q4b_foodbus___7 ///
  q4b_foodbus___6 q4b_foodbus___5 q4b_foodbus___4 q4b_foodbus___3 q4b_foodbus___2 q4b_foodbus___1 ///
  q4b_friendtype___22 q4b_friendtype___21 q4b_friendtype___20 q4b_friendtype___19 q4b_friendtype___18 ///
  q4b_friendtype___17 q4b_friendtype___16 q4b_friendtype___15 q4b_friendtype___14 q4b_friendtype___13 ///
  q4b_friendtype___12 q4b_friendtype___11 q4b_friendtype___10 q4b_friendtype___9 q4b_friendtype___8 
  
  codebook q4b_friendtype___7 q4b_friendtype___6 q4b_friendtype___5 q4b_friendtype___4 q4b_friendtype___3 q4b_friendtype___2 ///
  q4b_friendtype___1 q4b_friendtime q4b_schooltype___22 q4b_schooltype___21 q4b_schooltype___20 q4b_schooltype___19 ///
  q4b_schooltype___18 q4b_schooltype___17 q4b_schooltype___16 q4b_schooltype___15 q4b_schooltype___14 q4b_schooltype___13 ///
  q4b_schooltype___12 q4b_schooltype___11 q4b_schooltype___10 q4b_schooltype___9 q4b_schooltype___8 q4b_schooltype___7 ///
  q4b_schooltype___6 q4b_schooltype___5 q4b_schooltype___4 q4b_schooltype___3 q4b_schooltype___2 q4b_schooltype___1 ///
  q4b_schooltime q4b_trucktype___22 q4b_trucktype___21 q4b_trucktype___20 q4b_trucktype___19 q4b_trucktype___18 ///
  q4b_trucktype___17 q4b_trucktype___16 q4b_trucktype___15 q4b_trucktype___14 q4b_trucktype___13 q4b_trucktype___12 ///
  q4b_trucktype___11 q4b_trucktype___10 q4b_trucktype___9 q4b_trucktype___8 q4b_trucktype___7 q4b_trucktype___6 ///
  q4b_trucktype___5 q4b_trucktype___4 q4b_trucktype___3 q4b_trucktype___2 q4b_trucktype___1 q4b_trucktime q4b_abatype___22 
  
  codebook q4b_abatype___21 q4b_abatype___20 q4b_abatype___19 q4b_abatype___18 q4b_abatype___17 q4b_abatype___16 q4b_abatype___15 ///
  q4b_abatype___14 q4b_abatype___13 q4b_abatype___12 q4b_abatype___11 q4b_abatype___10 q4b_abatype___9 q4b_abatype___8 ///
  q4b_abatype___7 q4b_abatype___6 q4b_abatype___5 q4b_abatype___4 q4b_abatype___3 q4b_abatype___2 q4b_abatype___1 ///
  q4b_abatime q4b_tradertype___22 q4b_tradertype___21 q4b_tradertype___20 q4b_tradertype___19 q4b_tradertype___18 ///
  q4b_tradertype___17 q4b_tradertype___16 q4b_tradertype___15 q4b_tradertype___14 q4b_tradertype___13 q4b_tradertype___12 ///
  q4b_tradertype___11 q4b_tradertype___10 q4b_tradertype___9 q4b_tradertype___8 q4b_tradertype___7 q4b_tradertype___6 ///
  q4b_tradertype___5 q4b_tradertype___4 q4b_tradertype___3 q4b_tradertype___2 q4b_tradertype___1 q4b_tradertime q4b_stalltype___22 ///
  q4b_stalltype___21 q4b_stalltype___20 q4b_stalltype___19 q4b_stalltype___18 q4b_stalltype___17 q4b_stalltype___16 ///
  q4b_stalltype___15 q4b_stalltype___14 q4b_stalltype___13 q4b_stalltype___12 q4b_stalltype___11 q4b_stalltype___10 ///
  q4b_stalltype___9 q4b_stalltype___8 q4b_stalltype___7 q4b_stalltype___6 q4b_stalltype___5 q4b_stalltype___4 q4b_stalltype___3 ///
  q4b_stalltype___2 q4b_stalltype___1 q4b_stalltime q4b_infshoptype___22 q4b_infshoptype___21 q4b_infshoptype___20 ///
  q4b_infshoptype___19 q4b_infshoptype___18 q4b_infshoptype___17 q4b_infshoptype___16 q4b_infshoptype___15 q4b_infshoptype___14 ///
  q4b_infshoptype___13 q4b_infshoptype___12 q4b_infshoptype___11 q4b_infshoptype___10 q4b_infshoptype___9 q4b_infshoptype___8 ///
  q4b_infshoptype___7 q4b_infshoptype___6 q4b_infshoptype___5 q4b_infshoptype___4 q4b_infshoptype___3 q4b_infshoptype___2 ///
  q4b_infshoptype___1 q4b_infshoptime q4b_dealertype___22 q4b_dealertype___21 q4b_dealertype___20 q4b_dealertype___19 ///
  q4b_dealertype___18 q4b_dealertype___17 q4b_dealertype___16 q4b_dealertype___15 q4b_dealertype___14 q4b_dealertype___13 ///
  q4b_dealertype___12 q4b_dealertype___11 q4b_dealertype___10 q4b_dealertype___9 q4b_dealertype___8 q4b_dealertype___7 ///
  q4b_dealertype___6 q4b_dealertype___5 q4b_dealertype___4 q4b_dealertype___3 q4b_dealertype___2 q4b_dealertype___1 
  
  codebook q4b_dealertime q4b_shoptype___22 q4b_shoptype___21 q4b_shoptype___20 q4b_shoptype___19 q4b_shoptype___18 q4b_shoptype___17 ///
  q4b_shoptype___16 q4b_shoptype___15 q4b_shoptype___14 q4b_shoptype___13 q4b_shoptype___12 q4b_shoptype___11 q4b_shoptype___10 ///
  q4b_shoptype___9 q4b_shoptype___8 q4b_shoptype___7 q4b_shoptype___6 q4b_shoptype___5 q4b_shoptype___4 q4b_shoptype___3 ///
  q4b_shoptype___2 q4b_shoptype___1 q4b_shoptime q4b_smarkettype___22 q4b_smarkettype___21 q4b_smarkettype___20 q4b_smarkettype___19 ///
  q4b_smarkettype___18 q4b_smarkettype___17 q4b_smarkettype___16 q4b_smarkettype___15 q4b_smarkettype___14 q4b_smarkettype___13 ///
  q4b_smarkettype___12 q4b_smarkettype___11 q4b_smarkettype___10 q4b_smarkettype___9 q4b_smarkettype___8 q4b_smarkettype___7 ///
  q4b_smarkettype___6 q4b_smarkettype___5 q4b_smarkettype___4 q4b_smarkettype___3 q4b_smarkettype___2 q4b_smarkettype___1 ///
  q4b_wholetype___22 q4b_wholetype___21 q4b_wholetype___20 q4b_wholetype___19 q4b_wholetype___18 q4b_wholetype___17 q4b_wholetype___16 ///
  q4b_wholetype___15 q4b_wholetype___14 q4b_wholetype___13 q4b_wholetype___12 q4b_wholetype___11 q4b_wholetype___10 q4b_wholetype___9 ///
  q4b_wholetype___8 q4b_wholetype___7 q4b_wholetype___6 q4b_wholetype___5 q4b_wholetype___4 q4b_wholetype___3 q4b_wholetype___2 ///
  q4b_wholetype___1 q4b_wholetime q4b_retailtype___13 q4b_retailtype___12 q4b_retailtype___11 q4b_retailtype___10 q4b_retailtype___9 ///
  q4b_retailtype___8 q4b_retailtype___7 q4b_retailtype___6 q4b_retailtype___5 q4b_retailtype___4 q4b_retailtype___3 q4b_retailtype___2 ///
  q4b_retailtype___1 q4b_buytype___22 q4b_buytype___21 q4b_buytype___20 q4b_buytype___19 q4b_buytype___18 q4b_buytype___17 ///
  q4b_buytype___16 q4b_buytype___15 q4b_buytype___14 q4b_buytype___13 q4b_buytype___12 q4b_buytype___11 q4b_buytype___10 ///
  q4b_buytype___9 q4b_buytype___8 q4b_buytype___7 q4b_buytype___6 q4b_buytype___5 q4b_buytype___4 q4b_buytype___3 q4b_buytype___2 ///
  q4b_buytype___1 q4b_buy

  
//Section 4c* Food borrow  
*It has been split into shorter sections to make the exploring easier 

codebook q4c_borrow q4c_borrowtype___1 q4c_borrowtype___2 q4c_borrowtype___3 q4c_borrowtype___4 q4c_borrowtype___5 q4c_borrowtype___6 ///
q4c_borrowtype___7 q4c_borrowtype___8 q4c_borrowtype___9 q4c_borrowtype___10 q4c_borrowtype___11 q4c_borrowtype___12 q4c_borrowtype___13 ///
q4c_borrowtype___14 q4c_borrowtype___15 q4c_borrowtype___16 q4c_borrowtype___17 q4c_borrowtype___18 q4c_borrowtype___19 ///
q4c_borrowtype___20 q4c_borrowtype___21 q4c_borrowtype___22

codebook q4c_cerealtime q4c_rootstime q4c_vegtime q4c_fruittime q4c_pmeattime q4c_upmeattime q4c_eggstime q4c_fishtime q4c_insecttime ///
q4c_pulsestime q4c_nutstime q4c_milktime q4c_oilstime q4c_sweetstime q4c_snackstime q4c_ssbtime q4c_nalctime q4c_alctime q4c_condtime q4c_mealstime

//Section 4d* Food aid 
*It has been split into shorter sections to make the exploring easier 

codebook q4d_aid q4d_aidtype___1 q4d_aidtype___2 q4d_aidtype___3 q4d_aidtype___4 q4d_aidtype___5
codebook q4d_schooltype___22 q4d_schooltype___21 q4d_schooltype___20 q4d_schooltype___19 q4d_schooltype___18 q4d_schooltype___17 q4d_schooltype___16 ///
q4d_schooltype___15 q4d_schooltype___14 q4d_schooltype___13 q4d_schooltype___12 q4d_schooltype___11 q4d_schooltype___10 q4d_schooltype___9 /// 
q4d_schooltype___8 q4d_schooltype___7 q4d_schooltype___6 q4d_schooltype___5 q4d_schooltype___4 q4d_schooltype___3 q4d_schooltype___2 q4d_schooltype___1 q4d_schooltime 
codebook q4d_kitchentime q4d_kitchentype___1 q4d_kitchentype___2 q4d_kitchentype___3 q4d_kitchentype___4 q4d_kitchentype___5 q4d_kitchentype___6 /// 
q4d_kitchentype___7 q4d_kitchentype___8 q4d_kitchentype___9 q4d_kitchentype___10 q4d_kitchentype___11 q4d_kitchentype___12 q4d_kitchentype___13 /// 
q4d_kitchentype___14 q4d_kitchentype___15 q4d_kitchentype___16 q4d_kitchentype___17 q4d_kitchentype___18 q4d_kitchentype___19 q4d_kitchentype___20 /// 
q4d_kitchentype___21 q4d_kitchentype___22
codebook q4d_parceltime q4d_parceltype___1 q4d_parceltype___2 q4d_parceltype___3 q4d_parceltype___4 q4d_parceltype___5 q4d_parceltype___6 q4d_parceltype___7 ///
 q4d_parceltype___8 q4d_parceltype___9 q4d_parceltype___10 q4d_parceltype___11 q4d_parceltype___12 q4d_parceltype___13 q4d_parceltype___14 q4d_parceltype___15 ///
 q4d_parceltype___16 q4d_parceltype___17 q4d_parceltype___18 q4d_parceltype___19 q4d_parceltype___20 q4d_parceltype___21 q4d_parceltype___22


//Section 5* Food insecurity
		
codebook q5_worry q5_unable q5_few q5_skip q5_less q5_ranout q5_noteat q5_noteatday 		
		
// Section 6* Additional demographic and medicat information 

codebook q6_htn q6_dm q6_chol q6_hd q6_stk q6_cancer q6_htnrx q6_dmrx q6_edu q6_eth ///
 q6_ethoth q6_mar q6_occ q6_occoth q6_bpallow q6_intidbp q6_bpid q6_arm q6_sys1 q6_dias1 ///
 q6_sys2 q6_dias2 q6_sys3 q6_dias3 q6_htallow q6_intidheight q6_stadid q6_height q6_height ///
 q6_wtallow q6_intidweight q6_scaleid q6_weight q6_bmi q6_wcallow q6_intidwaist q6_tapeid ///
 q6_wc1 q6_wc2 q6_wc3	
 
//DB: variable q6_occoth is a string variable "fisherman" "fishermen" "Employ"

//DB: q6_dias1 has a range of 48-151  q6_dias2 also has a range from 45-125 q6_dias3 range 46-124. 
//DB: q6_sys1 has a range of 82-232  q6_sys2 also has a range from 81-251 q6_sys3 range 81-220. 
//DB: q6_height has a range of 133.5-197cm. 
//DB: q6_weight has a range of 23.5-191.4 
//DB: q6_bmi has a range of 9.7-64 
//DB: q6_wc1 has a range of 45-157 
//DB: q6_wc2 has a range of 43-155.5 
//DB: q6_wc3 has a range of 94.5-115.8 

// DB: NOTE- only 5 participants out of 335 have a third wc measurement taken.

// L&A: In data extract 1, participants pid 81 & 84 had no data for section 6 --> pid 81 corresponded to ID 2 (SVG) in REdcap. pid 84 corresponded to ID 5 (SVG) in Redcap.
// L&A: In data extract 2, the same participants have been identified and have no data for section 6. They have new pid in this file. --> Id 2 in Redcap (SVG) is pid 189. Id 5 in Redcap (SVG) has pid 192 
// DB: In data extract 3, the same participants have been identified and have no data for section 6. They have same pid as extract 2. --> Id 2 in Redcap (SVG) is pid 189. Id 5 in Redcap (SVG) has pid 192 

//DB: In data extract 3, Pid 289 Cid 103 (SVG)has no data for anthro measures (height,weight,bmi,blood pressure and waist circumference)as he refused those measurements
//DB: similarly pid 195 cid 8 (SVG)and pid=cid=82 (Fiji) has no data for height, weight and bmi but does have data on blood pressure and waist circumference.  

//DB: The following do not have any data on waist circumference for any of the three wc measurements (q6_wc1 q6_wc2 q6_wc3)as they refused measurement
  ** pid=cid=12 Fiji 
  ** pid=cid=61 Fiji 
  ** pid= 289 cid=103 SVG
  ** pid 204 to 208 with corresponding cid 18 to 22 SVG also dont have any data on waist circumference
  
// DB: Variable q6_bmi has a range value of:  [9.7, 64]
   
 list q1_p1sex q1_p1age q6_height q6_weight q6_bmi q6_wc1 q6_wc2 q6_wc3 if q6_bmi  <18
 browse  pid cid q1_country q6_height q6_weight q6_bmi q6_wc1 q6_wc2 q6_wc3 if q6_bmi  <18
 
// L&A: In data extract 1, pid 86 (ID 7 (SVG) in REDcap) & 89 (ID 10 (SVG) in REDcap) had potential data errors in BMI values. 
// L&A: In data extract 2, these participants still have the same errors. Pid has changed --> pid 194 (ID 7 (SVG) in REDcap). pid 197 (ID 10 (SVG) in REDcap)
//DB: In data extract 3, these participants still have the same errors. Pid same as extract 2 --> pid 194 has BMI 9.7(ID 7 (SVG) in REDcap). pid 197 has BMI 14.2 (ID 10 (SVG) in REDcap) 
//In addition to this pid=cid=13 (Fiji) has a bmi of 15. however the participant is very tall height=175 and weighs less weight =46 which may be resulting in a low bmi.
//Email confirming source data not availabe for checking - therefore spurious BMI values should not be included in analysis for ID 7 and ID 10 (waist circumference values to be used)

 
list q1_country cid pid q1_p1sex q1_p1age q6_height q6_weight q6_bmi q6_wc1 q6_wc2 if q6_bmi  >50 & q6_bmi !=.
// DB: participants pid 298 cid 112 has bmi 64 and pid 299 cid 113 has bmi 63.4 .....chcek with cathrine!

browse pid cid q1_country q1_sex q6_height q6_weight q6_bmi q6_wc1 q6_wc2 q6_wc3 q6_dias1 q6_sys1 q6_sys2 q6_dias2 q6_sys3 q6_dias3 if cid==112
// DB: participants pid 298 cid 112 has a weight of 171.3....Check! this participant also has a high wc and blood pressure values

browse pid cid q1_country q1_sex q6_height q6_weight q6_bmi q6_wc1 q6_wc2 q6_wc3 q6_dias1 q6_sys1 q6_sys2 q6_dias2 q6_sys3 q6_dias3 if cid==113
// DB: participants pid 299 cid 113 has a weight of 191.4....Check!

 
//L&A: In data extract 1, participant pid 87 ( ID 8 (SVG) in REDcap) had an error in q6_wc2 ==4 
//L&A&D: In data extract 2, this participant has been already updated with the correct value --> it has the pid 195 (SVG). the same is true for extract 3 

//****** On 8/1/2019 Catherine responded to a query on the weight and BMI values for pid 298 with cid 112 and pid 299 with cid 113 saying that both these participants had their weight incorrectly recorded in pounds insted of Kgs resulting in also incorrect BMI
**Catherine provided the values for weight and bmi now in Kgs which were replaced - see below

replace q6_bmi =29 if pid==298
replace q6_weight =77.7 if pid==298

replace q6_bmi =28.7 if pid==299
replace q6_weight =86.8 if pid==299

****************************************
*   Generating flags for participants  *
*      with invalid data values		   *
****************************************

//*1. NOTE: In extract 3, pid 187 and pid 335 do not have a cid and have no data in all sections except that pid 187 has data for country which is fiji. since there is no data drop both pid's
drop if pid==187
drop if pid==335
//So now total sample size is 333 and not 335. 

*2. Participant pid 194 and 197 --> Unreasonable BMI values. Disregard BMI, height and weight values and only consider waist circumference values for these participants.

gen flag_heightweightBMI =. 
replace flag_heightweightBMI =0 if pid!=194 | pid != 197
replace flag_heightweightBMI =1 if pid==194 | pid == 197 
label variable flag_heightweightBMI "Identifying data issues with height, weight and BMI"
label define flag_heightweightBMI_ 0 "Without any issues" 1 "With issues"
label values flag_heightweightBMI flag_heightweightBMI_
order flag_heightweightBMI, after (pid)

 
//Clean out 999 codes

//First destring one variable that is incorrectly coded as a string when it should be numeric
replace q3_eatoutnum = "999" if q3_eatoutnum == "1 day"
destring q3_eatoutnum, replace

//q6_occoth is also a string variable -->  (Q5a) What is your other main work status?
replace q6_occoth = "999" if q6_occoth == "Fisherman" | q6_occoth == "Fishermen" | q6_occoth == "Employ"
destring q6_occoth, replace

foreach var of varlist q1_country-q6_wc3 {
list pid if `var' == 999
replace `var' = . if `var' == 999
}

//Clean out 500 codes

foreach var of varlist q1_country-q6_wc3 {
list pid if `var' == 500
replace `var' = . if `var' == 500
}

* Other codes have been cleaned in Section 3. Diet screener. (see further below).

************************************************************************************
* SUBSTEP d. Generating new variables       				                       *
************************************************************************************
* Short summary: New variables are generated which will be used in subsequent
* analysis                                                                         *
************************************************************************************

//Section 1

//Age groups
gen q1_agecalc_cat3 = .
replace q1_agecalc_cat3 = 1 if q1_agecalc < 40
replace q1_agecalc_cat3 = 2 if q1_agecalc >= 40 & q1_agecalc < 65
replace q1_agecalc_cat3 = 3 if q1_agecalc >= 65 & q1_agecalc != .
label variable q1_agecalc_cat3 "Age category based on q1_agecalc"
label define q1_agecalc_cat3_ 1 "15 to < 40 years" 2 "40 to < 65 years" 3 "65 years or older"
label values q1_agecalc_cat3 q1_agecalc_cat3_
order q1_agecalc_cat3, after (q1_agecalc)

gen q1_agecalc_cat2WHO = .
replace q1_agecalc_cat2WHO = 1 if q1_agecalc < 20
replace q1_agecalc_cat2WHO = 2 if q1_agecalc >= 20 & q1_agecalc != .
label variable q1_agecalc_cat2WHO "Age category based on q1_agecalc and WHO definition of adolescent/adult"
label define q1_agecalc_cat2WHO_ 1 "Adolescent" 2 "Adult"
label values q1_agecalc_cat2WHO q1_agecalc_cat2WHO_
order q1_agecalc_cat2WHO, after (q1_agecalc_cat3)

gen q1_agecalc_cat2FAO = .
replace q1_agecalc_cat2FAO = 1 if q1_agecalc < 19
replace q1_agecalc_cat2FAO = 2 if q1_agecalc >= 19 & q1_agecalc != .
label variable q1_agecalc_cat2FAO "Age category based on q1_agecalc and FAO definition of adolescent/adult"
label define q1_agecalc_cat2FAO_ 1 "Adolescent" 2 "Adult"
label values q1_agecalc_cat2FAO q1_agecalc_cat2FAO_
order q1_agecalc_cat2FAO, after (q1_agecalc_cat2WHO)

//Region
gen q1_region_cat2a = .
replace q1_region_cat2a = 1 if q1_region == 1 | q1_region == 2 | q1_region == 7 | q1_region == 8
replace q1_region_cat2a = 2 if q1_region == 3 | q1_region == 4 | q1_region == 5 | q1_region == 6 
label variable q1_region_cat2a "Urban or rural based on q1_region"
label define q1_region_cat2a_ 1 "Rural" 2 "Urban"
label values q1_region_cat2a q1_region_cat2a_
order q1_region_cat2a, after (q1_region)

gen q1_region_cat2b = .
replace q1_region_cat2b = 1 if q1_region == 1 | q1_region == 3 | q1_region == 5 | q1_region == 7 
replace q1_region_cat2b = 2 if q1_region == 2 | q1_region == 4 | q1_region == 6 | q1_region == 8 
label variable q1_region_cat2b "High or low SES based on q1_region"
label define q1_region_cat2b_ 1 "High SES" 2 "Low SES"
label values q1_region_cat2b q1_region_cat2b_
order q1_region_cat2b, after(q1_region_cat2a)

gen q1_region_cat4 = .
replace q1_region_cat4 = 1 if q1_region == 1 | q1_region == 7
replace q1_region_cat4 = 2 if q1_region == 2 | q1_region == 8
replace q1_region_cat4 = 3 if q1_region == 3 | q1_region == 5
replace q1_region_cat4 = 4 if q1_region == 4 | q1_region == 6
label variable q1_region_cat4 "Urban/rural and high/low socioeconomic status (SES) based on q1_region"
label define q1_region_cat4_ 1 "Rural, high SES" 2 "Rural, low SES" 3 "Urban, high SES" 4 "Urban, low SES" 
label values q1_region_cat4 q1_region_cat4_
order q1_region_cat4, after (q1_region_cat2b)

//Education

gen q6_edu_cat3 = .
replace q6_edu_cat3 = 1 if q6_edu == 1 | q6_edu == 2|q6_edu == 3
replace q6_edu_cat3 = 2 if q6_edu == 4
replace q6_edu_cat3 = 3 if q6_edu == 5 |q6_edu == 6 & q6_edu != .
label variable q6_edu_cat3 "Education category based on q6_edu"
label define q6_edu_cat3_ 1 "Primary education or lower" 2 "Secondary school completed" 3 " Higher education completed" 
label values q6_edu_cat3 q6_edu_cat3_
order q6_edu_cat3, after (q1_agecalc_cat2FAO)

// BMI
gen q6_bmi_cat3 = .
replace q6_bmi_cat3 = 1 if q6_bmi <18.50 & flag_heightweightBMI==0
replace q6_bmi_cat3 = 2 if q6_bmi >= 18.50 & q6_bmi != . & q6_bmi < 25 & flag_heightweightBMI==0
replace q6_bmi_cat3 = 3 if q6_bmi >=25 & q6_bmi != . & q6_bmi <30 & flag_heightweightBMI==0
replace q6_bmi_cat3 = 4 if q6_bmi >= 30 & q6_bmi != . & flag_heightweightBMI==0
label variable q6_bmi_cat3 "BMi classification based on q6_bmi"
label define q6_bmi_cat3_ 1 "Underweight "2 "Normal" 3 "Overweight" 4 " Obese" 
label values q6_bmi_cat3 q6_bmi_cat3_
order q6_bmi_cat3, after (q6_bmi)



//Section 2
*L&A&D: If any of the base food groups consumed, the composite variable will show consumed (even if missing in some base food groups)
*If the reported base food groups are not consumed, but some are missing, the composite variable will show missing (as it cannot be definitely said that all of the food groups were not consumed)

gen q2_grainsroots = .
replace q2_grainsroots = 0 if q2_grains == 3 & q2_roots == 3
replace q2_grainsroots = 1 if q2_grains < 3 | q2_roots < 3
label variable q2_grainsroots "Consumed any grains or roots based on q2_grains & q2_roots"
label define q2_grainsroots_ 0 "Not consumed" 1 "Consumed"
label values q2_grainsroots q2_grainsroots_
order q2_grainsroots, after (q2_eatout)

gen q2_meatpoultyfish = .
replace q2_meatpoultyfish = 0 if q2_ormeat == 3 & q2_pmeat == 3 & q2_ppoul == 3 & q2_upmeat == 3 & q2_uppoul == 3 & q2_fish == 3 
replace q2_meatpoultyfish = 1 if q2_ormeat < 3 | q2_pmeat < 3 | q2_ppoul < 3 | q2_upmeat < 3 | q2_uppoul < 3 | q2_fish < 3 
label variable q2_meatpoultyfish "Consumed any meat, poultry or fish based on q2_ormeat q2_pmeat q2_ppoul q2_upmeat q2_uppoul q2_fish"
label define q2_meatpoultyfish_ 0 "Not consumed" 1 "Consumed"
label values q2_meatpoultyfish q2_meatpoultyfish_
order q2_meatpoultyfish, after (q2_grainsroots)

gen q2_vitafruitveg = .
replace q2_vitafruitveg = 0 if q2_vitaveg == 3 & q2_vitafruit == 3 & q2_palmoil == 3
replace q2_vitafruitveg = 1 if q2_vitaveg < 3 | q2_vitafruit < 3 | q2_palmoil < 3
label variable q2_vitafruitveg "Consumed any vitamin A rich fruit and veg based on q2_vitaveg q2_vitafruit q2_palmoil"
label define q2_vitafruitveg_ 0 "Not consumed" 1 "Consumed"
label values q2_vitafruitveg q2_vitafruitveg_
order q2_vitafruitveg, after (q2_meatpoultyfish)

egen q2_miss = rowmiss(q2_grainsroots q2_pulses q2_nuts q2_milk q2_meatpoultyfish q2_eggs q2_gveg q2_vitafruitveg q2_vegoth q2_fruitoth)
label variable q2_miss "Number of missing values across 10 food groups used to generate MDDW score (range 0-10)"
order q2_miss, after (q2_vitafruitveg)

***The above 3 variables q2_grainsroots, q2_meatpoultyfish and q2_vitafruitveg take into account consumption irrespective of quantity consumed. 
//Now we also need these variables for analysis when consumption was above 15g (as per FAO-MDDW guidelines)

gen q2_grainsroots_15g = .
replace q2_grainsroots_15g = 0 if (q2_grains > 1 & q2_grains !=.) & (q2_roots > 1 & q2_roots!=.)
replace q2_grainsroots_15g = 1 if q2_grains == 1 | q2_roots == 1
label variable q2_grainsroots_15g "Consumed any grains or roots in amounts >15g based on q2_grains & q2_roots"
label define q2_grainsroots_15g_ 0 "Not consumed in amounts >15g" 1 "Consumed in amounts >15g"
label values q2_grainsroots_15g q2_grainsroots_15g_
order q2_grainsroots_15g, after (q2_grainsroots)

gen q2_meatpoultyfish_15g = .
replace q2_meatpoultyfish_15g = 0 if (q2_ormeat > 1 & q2_ormeat !=.)  & (q2_pmeat > 1 & q2_pmeat !=.) & (q2_ppoul > 1 & q2_ppoul !=.) & (q2_upmeat > 1 & q2_upmeat !=.) & (q2_uppoul > 1 & q2_uppoul !=.)& (q2_fish > 1 & q2_fish !=.)
replace q2_meatpoultyfish_15g = 1 if q2_ormeat ==1 | q2_pmeat ==1 | q2_ppoul ==1 | q2_upmeat ==1 | q2_uppoul ==1 | q2_fish ==1 
label variable q2_meatpoultyfish_15g "Consumed any meat, poultry or fish in amounts >15g based on q2_ormeat q2_pmeat q2_ppoul q2_upmeat q2_uppoul q2_fish"
label define q2_meatpoultyfish_15g_ 0 "Not consumed in amounts >15g" 1 "Consumed in amounts >15g"
label values q2_meatpoultyfish_15g q2_meatpoultyfish_15g_
order q2_meatpoultyfish_15g, after (q2_meatpoultyfish)

gen q2_vitafruitveg_15g = .
replace q2_vitafruitveg_15g = 0 if (q2_vitaveg > 1 & q2_vitaveg !=.) & (q2_vitafruit > 1 & q2_vitafruit !=.) & (q2_palmoil > 1 & q2_palmoil !=.)
replace q2_vitafruitveg_15g = 1 if q2_vitaveg == 1 | q2_vitafruit == 1 | q2_palmoil == 1
label variable q2_vitafruitveg_15g "Consumed any vitamin A rich fruit and veg in amounts >15g based on q2_vitaveg q2_vitafruit q2_palmoil"
label define q2_vitafruitveg_15g_ 0 "Not consumed in amounts >15g" 1 "Consumed in amounts >15g"
label values q2_vitafruitveg_15g q2_vitafruitveg_15g_
order q2_vitafruitveg_15g, after (q2_vitafruitveg)


//Recode food groups as 0/1 corresponds to did not consume/consumed (irrespective of quantity of consumption)
foreach var of varlist q2_pulses q2_nuts q2_milk q2_eggs q2_gveg q2_vegoth q2_fruitoth {
generate `var'_2cat = .
replace `var'_2cat = 0 if `var' == 3
replace `var'_2cat = 1 if `var' < 3
label variable `var'_2cat "Consumed food group based on `var'"
label define `var'_2cat_ 0 "Not consumed" 1 "Consumed"
label values `var'_2cat `var'_2cat_
order `var'_2cat, after (q3_eatoutnum)
}

**//Recoding here only for consumption reported >15g

//Recode food groups as 0/1 corresponds to did not consume >15g/consumed >15g
foreach var of varlist q2_pulses q2_nuts q2_milk q2_eggs q2_gveg q2_vegoth q2_fruitoth {
generate `var'_15g = .
replace `var'_15g = 0 if `var' >1 & `var'!=.
replace `var'_15g = 1 if `var' == 1
label variable `var'_15g "Consumed food group in amounts >15g  based on `var'"
label define `var'_15g_ 0 "Not consumed in amounts >15g" 1 "Consumed in amounts >15g"
label values `var'_15g `var'_15g_
order `var'_15g, after (q2_miss)
}
		
* As a conservative approach, only participants with no missing data across all 10 food groups have been included in the variable generating MDDW score.

**// Generating MDDWscore irrespective of quantity of consumption 
egen q2_MDDWscore = rowtotal(q2_grainsroots q2_pulses_2cat q2_nuts_2cat q2_milk_2cat q2_meatpoultyfish q2_eggs_2cat q2_gveg_2cat q2_vitafruitveg q2_vegoth_2cat q2_fruitoth_2cat) if q2_miss == 0
label variable q2_MDDWscore "MDDW score (dietary diversity) possible range 0-10"
order q2_MDDWscore, after (q2_pulses_2cat)

// Generating a categorical vatiable for achieved/not achieved dietary diversity
gen q2_MDDWscore_2cat =.
replace q2_MDDWscore_2cat = 0 if q2_MDDWscore < 5 
replace q2_MDDWscore_2cat = 1 if q2_MDDWscore >= 5 & q2_MDDWscore !=.
label variable q2_MDDWscore_2cat "MDDW clasification (dietary diversity) based on q2_MDDWscore"
label define q2_MDDWscore_2cat_ 0 "Not achieved minimum dietary diversity" 1 "Achieved minimum dietary diversity"
label values q2_MDDWscore_2cat q2_MDDWscore_2cat_
order q2_MDDWscore_2cat, after (q2_MDDWscore)

**// Generating MDDWscore only for consumption >15g
egen q2_MDDWscore_15g = rowtotal(q2_grainsroots_15g q2_meatpoultyfish_15g q2_vitafruitveg_15g q2_fruitoth_15g q2_vegoth_15g q2_gveg_15g q2_eggs_15g q2_milk_15g q2_nuts_15g q2_pulses_15g ) if q2_miss == 0
label variable q2_MDDWscore_15g "MDDW score if consumption >15g (dietary diversity) possible range 0-10"
order q2_MDDWscore_15g, after (q2_MDDWscore_2cat)

// Generating a categorical vatiable for achieved/not achieved dietary diversity (when consumption >15g)
gen q2_MDDWscore_15g_2cat =.
replace q2_MDDWscore_15g_2cat = 0 if q2_MDDWscore_15g < 5 
replace q2_MDDWscore_15g_2cat = 1 if q2_MDDWscore_15g >= 5 & q2_MDDWscore_15g !=.
label variable q2_MDDWscore_15g_2cat "MDDW clasification if consumption >15g(dietary diversity) based on q2_MDDWscore_15g"
label define q2_MDDWscore_15g_2cat_ 0 "Not achieved minimum dietary diversity" 1 "Achieved minimum dietary diversity"
label values q2_MDDWscore_15g_2cat q2_MDDWscore_15g_2cat_
order q2_MDDWscore_15g_2cat, after (q2_MDDWscore_15g)



*************************************************************************************************************************************
*L&A: Create a new variable to group all tyes of fruits and vegetables from 0-4, as indicated in the FAO guidelines. 
*L&A: The commands to generate this variable with a range from 0-5 have been deleted since they are not needed anymore. Check Step 0 CFAH v1 to know how to do it, if necessary. 
gen q2_anyfruitveg =.
replace q2_anyfruitveg = 0 if q2_gveg == 3 & q2_vitafruitveg == 0 & q2_vegoth == 3 & q2_fruitoth == 3    
replace q2_anyfruitveg = 1 if q2_gveg < 3 | q2_vitafruitveg == 1| q2_vegoth < 3 | q2_fruitoth < 3  
label variable q2_anyfruitveg "Consumed any fruit and veg based on q2_gveg q2_vitafruitveg q2_vegoth q2_fruitoth"
label define q2_anyfruitveg_ 0 "Not consumed" 1 "Consumed"
label values q2_anyfruitveg q2_anyfruitveg_
order q2_anyfruitveg, after (q2_vitafruitveg)

egen q2_miss2 = rowmiss(q2_gveg q2_vitafruitveg q2_vegoth q2_fruitoth)
label variable q2_miss2 "Number of missing values across 4 food groups used to generate total fruit and veg score (range 0-4)"
order q2_miss2, after (q2_miss)

//L&A: Out of 333 participants, x have missing data on at least one of the food groups that is used to generate total fruit and veg score. This could lead to misclassifcation of the number of fruits and vegetables consumed by 
//a person. As a conservative approach, only participants with no missing data across all 4 food groups have been included in the variable generating total fruit and vegetable score.
egen q2_totalFVscore = rowtotal(q2_gveg_2cat q2_vegoth_2cat q2_fruitoth_2cat q2_vitafruitveg) if q2_miss2 == 0
label variable q2_totalFVscore "Total fruits and veg score (dietary diversity) possible range 0-4"
order q2_totalFVscore, after (q2_MDDWscore_2cat)


*Generating new variables to study consumption patterns:

*1. Animal Source Food
gen q2_animal = .
replace q2_animal = 0 if q2_ormeat==3 & q2_pmeat==3 & q2_ppoul==3 & q2_upmeat==3 & q2_uppoul==3 & q2_fish==3 & q2_eggs==3 & q2_milk==3    
replace q2_animal = 1 if q2_ormeat < 3 | q2_pmeat < 3 | q2_ppoul < 3| q2_upmeat < 3 | q2_uppoul < 3 | q2_fish < 3 | q2_eggs < 3 | q2_milk < 3 
label variable q2_animal "Consumed any type of animal source food based on q2_ormeat q2_pmeat q2_ppoul q2_upmeat q2_uppoul q2_fish q2_eggs q2_milk"
label define q2_animal_ 0 "Not consumed" 1 "Consumed"
label values q2_animal q2_animal_
order q2_animal, after (q2_totalFVscore)

*2. Pulses, Nuts and Seeds 
gen q2_pulsesnuts = .
replace q2_pulsesnuts = 0 if q2_pulses==3 & q2_nuts==3 
replace q2_pulsesnuts = 1 if q2_pulses < 3 | q2_nuts < 3 
label variable q2_pulsesnuts "Consumed any pulses, nuts and seeds based on q2_pulses q2_nuts"
label define q2_pulsesnuts_ 0 "Not consumed" 1 "Consumed"
label values q2_pulsesnuts q2_pulsesnuts_
order q2_pulsesnuts, after (q2_animal)

*3. Flesh meat: based on q2_meatpoultyfish q2_pmeat q2_ppoul q2_upmeat q2_uppoul q2_insects
* According to the FAO definition, this group includes flesh meats and any processed/cured products made from the meats. 
gen q2_flesh = .
replace q2_flesh = 0 if q2_pmeat ==3 & q2_ppoul==3 & q2_upmeat==3 & q2_uppoul==3 & q2_insects==3 
replace q2_flesh = 1 if q2_pmeat < 3 | q2_ppoul < 3 | q2_upmeat < 3| q2_uppoul < 3 | q2_insects < 3 
label variable q2_flesh "Consumed flesh meat based on q2_pmeat q2_ppoul q2_upmeat q2_uppoul q2_insects"
label define q2_flesh_ 0 "Not consumed" 1 "Consumed"
label values q2_flesh q2_flesh_
order q2_flesh, after (q2_pulsesnuts)

*4. Generate a 2 categories variable (consumed or nor consumed) for each food group comprised in the low nutrient density foods ("fats and oils" "snacks", "sweets" and "ssbv")
gen q2_oils_2cat = .
replace q2_oils_2cat = 0 if q2_oils==3 
replace q2_oils_2cat= 1 if q2_oils ==1 | q2_oils ==2 
label variable q2_oils_2cat "Fats and oils consumption based on q2_oils, regardless amount"
label define q2_oils_2cat_ 0 "Not consumed" 1 "Consumed"
label values q2_oils_2cat q2_oils_2cat_
order q2_oils_2cat, after (q2_flesh)

gen  q2_snacks_2cat = .
replace q2_snacks_2cat = 0 if q2_snacks==3 
replace q2_snacks_2cat= 1 if q2_snacks ==1 | q2_snacks ==2 
label variable q2_snacks_2cat "Snacks consumption based on q2_snacks, regardless amount"
label define q2_snacks_2cat_ 0 "Not consumed" 1 "Consumed"
label values q2_snacks_2cat  q2_snacks_2cat_
order  q2_snacks_2cat, after (q2_oils_2cat)

gen q2_sweets_2cat = .
replace q2_sweets_2cat = 0 if q2_sweets==3 
replace q2_sweets_2cat= 1 if q2_sweets ==1 | q2_sweets ==2 
label variable q2_sweets_2cat "Sweets consumption based on q2_sweets, regardless amount"
label define q2_sweets_2cat_ 0 "Not consumed" 1 "Consumed"
label values q2_sweets_2cat q2_sweets_2cat_
order q2_sweets_2cat, after (q2_snacks_2cat)

gen q2_ssb_2cat = .
replace q2_ssb_2cat = 0 if q2_ssb==3 
replace q2_ssb_2cat= 1 if q2_ssb ==1 | q2_ssb ==2 
label variable q2_ssb_2cat "Ssbv consumption based on  q2_ssb, regardless amount"
label define  q2_ssb_2cat_ 0 "Not consumed" 1 "Consumed"
label values  q2_ssb_2cat  q2_ssb_2cat_
order  q2_ssb_2cat, after (q2_sweets_2cat)

gen q2_ormeat_2cat  = .
replace q2_ormeat_2cat = 0 if q2_ormeat==3 
replace q2_ormeat_2cat = 1 if q2_ormeat ==1 | q2_ormeat ==2 
label variable q2_ormeat_2cat "Organ meat consumption based on q2_ormeat, regardless amount"
label define q2_ormeat_2cat_ 0 "Not consumed" 1 "Consumed"
label values q2_ormeat_2cat  q2_ormeat_2cat_
order q2_ormeat_2cat, after (q2_fruitoth_2cat)

gen q2_fish_2cat = .
replace q2_fish_2cat = 0 if q2_fish ==3 
replace q2_fish_2cat = 1 if q2_fish ==1 | q2_fish ==2 
label variable q2_fish_2cat "Fish and seafood consumption based on q2_fish, regardless amount"
label define q2_fish_2cat_ 0 "Not consumed" 1 "Consumed"
label values q2_fish_2cat  q2_fish_2cat_
order  q2_fish_2cat, after (q2_ormeat_2cat)

gen q2_vitaveg_2cat = .
replace q2_vitaveg_2cat  = 0 if q2_vitaveg==3 
replace q2_vitaveg_2cat  = 1 if q2_vitaveg ==1 | q2_vitaveg ==2 
label variable q2_vitaveg_2cat  "Vit.A-rich vegetables consumption based on q2_vitaveg, regardless amount"
label define q2_vitaveg_2cat_ 0 "Not consumed" 1 "Consumed"
label values q2_vitaveg_2cat q2_vitaveg_2cat_
order q2_vitaveg_2cat , after (q2_fish_2cat )

gen q2_vitafruit_2cat = .
replace q2_vitafruit_2cat = 0 if q2_vitafruit==3 
replace q2_vitafruit_2cat = 1 if q2_vitafruit ==1 | q2_vitafruit ==2 
label variable q2_vitafruit_2cat "FVit.A-rich fruit consumption based on q2_vitafruit, regardless amount"
label define q2_vitafruit_2cat_ 0 "Not consumed" 1 "Consumed"
label values q2_vitafruit_2cat  q2_vitafruit_2cat_
order  q2_vitafruit_2cat, after (q2_vitaveg_2cat)


//Section 3

* Clean out other codes in diet screener
*L&A&D: replace using the code above
//The following variables: q3_fruitnum q3_vegnum q3_fishnum q3_oilfishnum q3_upmeatnum q3_pmeatnum q3_upfoodnum q3_pfoodnum q3_tinfoodnum q3_ultpfoodnum q3_ssbnum q3_ddrinknum
//Answer the question: "In a typical week, how many days do you eat (food group)?
//and have the code:  1, 0 | 2, 1 | 3, 2 | 4, 3 | 5, 4 | 6, 5 | 7, 6 | 8, 7 | 9, Don't know
// The code 9=Don't know, needs to be cleaned out for further calculations.

 foreach var of varlist q3_fruitnum q3_vegnum q3_fishnum q3_oilfishnum q3_upmeatnum q3_pmeatnum q3_upfoodnum q3_pfoodnum q3_tinfoodnum q3_ultpfoodnum q3_ssbnum q3_ddrinknum {
list pid if `var' == 9
replace `var' = . if `var' == 9
}

*The following variables: q3_fruitserv q3_vegserv q3_fishserv q3_oilfishserv q3_upmeatserv q3_pmeatserv q3_ssbnum q3_ssbserv q3_ddrinkserv
//Answer the question:" How many servings of (food group) do you usually eat on one of those days?
//and have the code: 1, 1 | 2, 2 | 3, 3 | 4, 4 | 5, 5+ | 6, Don't know
//The code 6=don't know, needs to be cleaned out for further calculations. BUT:
//If a participant reported zero for number of times consumed per week of food group (e.g. fruitnum), they do not proceed to report number of servings per day (e.g. fruitserv).
// However, we know this value should be zero (not missing) because if they didn't report consuming, they can't have consumed any serves

 foreach x in q3_fruit q3_veg q3_fish q3_oilfish q3_upmeat q3_pmeat q3_ssb q3_ddrink {
list pid if `x'serv == 6
replace `x'serv = . if `x'serv == 6
replace `x'serv = 0 if `x'num == 1 //num=1 means not consumed
}

recode q3_fruitnum q3_vegnum q3_fishnum q3_oilfishnum q3_upmeatnum q3_pmeatnum q3_upfoodnum q3_tinfoodnum q3_pfoodnum q3_ultpfoodnum q3_ssbnum q3_ddrinknum (1=0) (2=1) (3=2) (4=3) (5=4) (6=5) (7=6) (8=7)
label drop q3_fruitnum_ q3_vegnum_ q3_fishnum_ q3_oilfishnum_ q3_upmeatnum_ q3_pmeatnum_ q3_upfoodnum_ q3_tinfoodnum_ q3_pfoodnum_ q3_ultpfoodnum_ q3_ssbnum_ q3_ddrinknum_

//FRUITS AND VEGETABLES SERVINGS CONSUMPTION:
*Generate a new variable containing the total number of fruit and veg servings eaten per day. 

//Approach 0: Only considering servings/day without reference to days eaten per week
egen q3_FVapproach0 = rowtotal(q3_fruitserv q3_vegserv) if (q3_fruitserv != . & q3_vegserv != .) | (q3_fruitserv == . & q3_vegserv >= 5 & q3_vegserv != .) | (q3_fruitserv >= 5 & q3_fruitserv != . & q3_vegserv == .)
label variable q3_FVapproach0 "Number of F&V servings per day (possible range 0-10), regardless days per week"
order q3_FVapproach0, after (q3_ddrinkserv)
* Classify participants based on WHO recommendations on fruit and vegetables consumption. 
gen q3_FVapproach0_2cat = .
replace q3_FVapproach0_2cat = 0 if q3_FVapproach0 < 5
replace q3_FVapproach0_2cat = 1 if q3_FVapproach0 >=5 & q3_FVapproach0 !=.
label variable q3_FVapproach0_2cat "Mininum F&V servings according to WHO based on q3_fruitserv q3_vegserv, regardless days per week"
label define q3_FVapproach0_2cat_ 0 "WHO recommendation not achieved" 1 "WHO recommendation achieved"
label values q3_FVapproach0_2cat q3_FVapproach0_2cat_
order q3_FVapproach0_2cat, after (q3_FVapproach0)

//Approach 1: Only participants who eat fruit OR vegetables on ALL seven days can be considered as meeting guidelines - and in these people, only if they eat >= 5 servings/day
// This approach is described in the Discussion Document (CFAH _discussion document_1stNov18) as "Approach 1"
egen q3_FVapproach1 = rowtotal(q3_fruitserv q3_vegserv) if (q3_fruitnum==7 | q3_vegnum==7) & (q3_fruitserv != . & q3_vegserv != .) | (q3_fruitserv == . & q3_vegserv >= 5 & q3_vegserv != .) | (q3_fruitserv >= 5 & q3_fruitserv != . & q3_vegserv == .)
label variable q3_FVapproach1 "Number of F&V servings per day (possible range 0-10), only participants consuming on all 7 days (OR)"
order q3_FVapproach1, after (q3_FVapproach0_2cat)
* Classify participants based on WHO recommendations on fruit and vegetables consumption. 
gen q3_FVapproach1_2cat = .
replace q3_FVapproach1_2cat = 0 if  q3_FVapproach1 < 5
replace q3_FVapproach1_2cat = 1 if q3_FVapproach1 >=5 & q3_FVapproach1 !=.
replace q3_FVapproach1_2cat = 0 if q3_fruitnum!=. & q3_fruitnum < 7 & q3_vegnum!=. & q3_vegnum < 7
label variable q3_FVapproach1_2cat "Minimum F&V servings according to WHO based on q3_fruitserv q3_vegserv and 7 days consumption"
label define q3_FVapproach1_2cat_ 0 "WHO recommendation not achieved" 1 "WHO recommendation achieved"
label values q3_FVapproach1_2cat q3_FVapproach1_2cat_
order q3_FVapproach1_2cat, after (q3_FVapproach1)

 // When looking at the Fiji sample, for example, if the approach 1 was used (only participants reporting consumption in all seven days a week of fruit OR vegetables), we find that 
// around 8% of the sample achieved the WHO recommendation. When approach 3 is used (total fruit and vegetable servings per week) we see that around 6% of the Fiji sample
// achieved the WHOrecommendation. These values make us to revisit the syntaxis made for approach 1, since approach 3 should be less restrictive than approach 1 and therefore give a 
// greater percentage of participants achieving the recommendation.  

 //tab q3_FVapproach1_2cat if q1_country==1 & flag ==0

 
// If we browse participants with different meeting recommendation outcomes, we realise that approach 1 is classifying as "achieved" participants who stricty did not achieve the recommendation. 
// browse pid q3_fruitnum q3_fruitserv q3_fruitweekserv q3_vegnum q3_vegserv q3_vegweekserv q3_FVapproach1 q3_FVapproach1_2cat q3_FVapproach3 q3_FVapproach3_2cat if q3_FVapproach1_2cat != q3_FVapproach3_2cat 
// E.g. pid 68 reported veg consumption 7 days per week with 4 veg servings on each day. It also reported fruit consumption 2 days per week with 2 fruit servings per day. According to Approach 1 syntaxis, 
// this participant meets the recommendation since 4+2=6 and 6 is >=5 servings/day but we know that on those days were fruit and veg are not both consumed, the participants won't meet the recommendation. 
// That brings us to propose another syntaxis for Approach 1 which would be more accurate and restrictive. This has been called Approach 2 (also in the Disucssion Report "CFAH _discussion document_1stNov18")

//Approach 2: Only participants who eat fruit AND vegetables on ALL seven days can be considered as meeting guidelines - and in these people, only if they eat >= 5 servings/day
//This approach is described in the Discussion Document (CFAH _discussion document_1stNov18) as "Approach 2"
gen q3_sampleFVapproach2 =.
replace q3_sampleFVapproach2 = 0 if (q3_fruitnum <7 & q3_vegnum <7) | (q3_fruitnum ==7 & q3_fruitserv <5 & q3_fruitserv !=. & q3_vegnum <7 & q3_vegnum !=.) | (q3_vegnum ==7 & q3_vegserv <5 & q3_vegnum !=. & q3_fruitnum <7 & q3_fruitserv !=.)
replace q3_sampleFVapproach2 = 1 if (q3_fruitnum==7 & q3_vegnum==7) | (q3_fruitnum ==7 & q3_fruitserv >=5 & q3_fruitserv!=. & (q3_vegnum <7 | q3_vegnum==.)) | (q3_vegnum ==7 & q3_vegserv >=5 & q3_vegserv!=. & (q3_fruitnum <7 | q3_fruitnum==.))
label variable q3_sampleFVapproach2 " Only participants considered for Approach 2 F&V" 
order q3_sampleFVapproach2, after (q3_FVapproach1_2cat)

egen q3_FVapproach2 = rowtotal(q3_fruitserv q3_vegserv) if q3_sampleFVapproach2 ==1 & (q3_fruitserv != . & q3_vegserv != .) | (q3_fruitserv == . & q3_vegserv >= 5 & q3_vegserv != .) | (q3_fruitserv >= 5 & q3_fruitserv != . & q3_vegserv == .)
label variable q3_FVapproach2 "Number of F&V servings per day (possible range 0-10), only participants consuming on all 7 days(AND)"
order q3_FVapproach2, after (q3_sampleFVapproach2)
// WHO classification
gen q3_FVapproach2_2cat = .
replace q3_FVapproach2_2cat = 0 if q3_FVapproach2 < 5 
replace q3_FVapproach2_2cat = 1 if q3_FVapproach2 >=5 & q3_FVapproach2 !=.
replace q3_FVapproach2_2cat = 0 if q3_sampleFVapproach2 ==0 
label variable q3_FVapproach2_2cat "Minimum F&V serving according to WHO based on q3_fruitserv q3_vegserv and 7 days consumption. Approach 2b"
label define q3_FVapproach2_2cat_ 0 "WHO recommendation not achieved" 1 "WHO recommendation achieved"
label values q3_FVapproach2_2cat q3_FVapproach2_2cat_
order q3_FVapproach2_2cat, after (q3_FVapproach2)
 
// Approach 3: Servings eaten per week (min. 5 servings/day --> min. 35 servings per week
//Total fruit servings per week.  This approach is described in the Discussion Document (CFAH _discussion document_1stNov18) as "Approach 3"
gen q3_fruitweekserv = q3_fruitnum*q3_fruitserv if q3_fruitnum !=. & q3_fruitserv !=. & flag==0 
label variable q3_fruitweekserv "Number of total fruit servings per week"
order q3_fruitweekserv, after (q3_FVapproach2_2cat)
// Total vegetable servings per week
gen q3_vegweekserv = q3_vegnum*q3_vegserv if q3_vegnum !=. & q3_vegserv !=. & flag==0 
label variable q3_vegweekserv "Number of total vegetable servings per week"
order q3_vegweekserv, after (q3_fruitweekserv)
//Total number of fruit and vegetable servings per week
egen q3_FVapproach3 = rowtotal (q3_fruitweekserv q3_vegweekserv) if (q3_fruitweekserv!=. & q3_vegweekserv!=.) | (q3_fruitweekserv==. & q3_vegweekserv >=35 & q3_vegweekserv!=.) | (q3_fruitweekserv >=35 & q3_fruitweekserv !=. & q3_vegweekserv==.)
label variable q3_FVapproach3 "Number of total F&V servings per week (App.3)"
order q3_FVapproach3, after (q3_vegweekserv)
//Generate a categorical variable from the numerical variable to classify participants according WHO recommendation
gen q3_FVapproach3_2cat =. 
replace q3_FVapproach3_2cat = 0 if q3_FVapproach3 < 35
replace q3_FVapproach3_2cat = 1 if q3_FVapproach3 >= 35 & q3_FVapproach3 !=.
label variable q3_FVapproach3_2cat " Minimum F&V servings per week based on q3_fruitweekserv q3_vegweekserv"
label define q3_FVapproach3_2cat_ 0 "WHO recommendation not achieved" 1 "WHO recommendation achieved" 
label values q3_FVapproach3_2cat q3_FVapproach3_2cat_
order q3_FVapproach3_2cat, after (q3_FVapproach3)


// tabulation of q3_FVapproach1_2cat if q1_country==1 & flag ==0 

 

//The following approaches were found in the STEPS Operational Protocol and were suggested to analyse "Fruit and Vegetable Consumption Risk Eating". 
//All these approaches have been included in the Disucssion Report under the same approach name. 

//Approach 4: Fruit OR vegetables eaten on fewer than 4 days/week
// This approach is described in the Discussion Document (CFAH _discussion document_1stNov18) as "Approach 4"
gen q3_FVapproach4_2cat = .
replace q3_FVapproach4_2cat = 0 if  q3_fruitnum < 4 | q3_vegnum < 4
replace q3_FVapproach4_2cat = 1 if q3_fruitnum >=4 & q3_fruitnum !=. | q3_vegnum >=4 & q3_vegnum !=.
label variable q3_FVapproach4_2cat "F&V consumption risk eating (App.4) based on q3_fruitnum q3_vegnum"
label define q3_FVapproach4_2cat_ 0 "F&V Consumption risk" 1 "F&V not consumption risk"
label values q3_FVapproach4_2cat q3_FVapproach4_2cat_
order q3_FVapproach4_2cat, after (q3_FVapproach3_2cat)

//Approach 5: Under 2 servings of fruit OR vegetables per day, when eaten. 
// This approach is described in the Discussion Document (CFAH _discussion document_1stNov18) as "Approach 5"
gen q3_FVapproach5_2cat = .
replace q3_FVapproach5_2cat = 0 if q3_fruitserv < 2 | q3_vegserv < 2
replace q3_FVapproach5_2cat = 1 if q3_fruitserv >=2 & q3_fruitserv !=. | q3_vegserv >=2 & q3_vegserv !=.
label variable q3_FVapproach5_2cat "F&V consumption risk eating (App.5) based on q3_fruitnum q3_vegnum"
label define q3_FVapproach5_2cat_ 0 "F&V Consumption risk" 1 "F&V not consumption risk"
label values q3_FVapproach5_2cat q3_FVapproach5_2cat_
order q3_FVapproach5_2cat, after (q3_FVapproach4_2cat)

//Approach 6: Under 14 servings of fruit OR vegetables per week
// This approach is described in the Discussion Document (CFAH _discussion document_1stNov18) as "Approach 6"
egen q3_FVapproach6 = rowtotal (q3_fruitweekserv q3_vegweekserv) if (q3_fruitweekserv!=. & q3_vegweekserv!=.) | (q3_fruitweekserv==. & q3_vegweekserv >=14 & q3_vegweekserv!=.) | (q3_fruitweekserv >=14 & q3_fruitweekserv !=. & q3_vegweekserv==.)
label variable q3_FVapproach6 "Number of total F&V servings per week (App.6)"
order q3_FVapproach6, after (q3_FVapproach5_2cat)

gen q3_FVapproach6_2cat = .
replace q3_FVapproach6_2cat = 0 if q3_FVapproach6 < 14 
replace q3_FVapproach6_2cat = 1 if q3_FVapproach6 >=14 & q3_FVapproach6 !=. 
label variable q3_FVapproach6_2cat "F&V consumption risk eating (App.6) based on q3_fruitweekserv q3_vegweekserv"
label define q3_FVapproach6_2cat_ 0 "F&V Consumption risk" 1 "F&V not consumption risk"
label values q3_FVapproach6_2cat q3_FVapproach6_2cat_
order q3_FVapproach6_2cat, after (q3_FVapproach6)

//ALTERNATIVE STEP. Run this option if you want to allow participants to be missing on one or other variable. 
//egen q3_totalFVserv = rowtotal(q3_fruitserv q3_vegserv) if q3_fruitserv != . | q3_vegserv != . 

//MEAT SERVINGS EATEN PER DAY:
*Generate a new variable containing the total number of red meat (processed and unprocessed) servings eaten per day. 
//Approach 1: 
//Based on WHO - consumption of red meat and processed meat and NCD risk. This is the criteria followed after confirming with Nigel, NIta and Ian by email on 16Oct18
egen q3_riskmeatserv = rowtotal(q3_upmeatserv q3_pmeatserv) if q3_upmeatserv != . & q3_pmeatserv != . | (q3_upmeatserv >= 2 & q3_upmeatserv != . & q3_pmeatserv == . ) | (q3_upmeatserv == . & q3_pmeatserv >= 2 & q3_pmeatserv != . ) 
label variable q3_riskmeatserv "Number of red meat servings eaten per day (possible range 0-10)"
order q3_riskmeatserv, after (q3_FVapproach6_2cat)
*Classify participants based on WHO recommendations on red & processed meat consumption: 70g/day = 1 serving/day. 
gen q3_riskmeatserv_2cat = .
replace q3_riskmeatserv_2cat = 0 if  q3_riskmeatserv < 2
replace q3_riskmeatserv_2cat = 1 if q3_riskmeatserv >=2 & q3_riskmeatserv !=.
label variable q3_riskmeatserv_2cat "Red and processed meat consumption according to WHO based on q3_upmeatserv q3_pmeatserv"
label define q3_riskmeatserv_2cat_ 0 "WHO Not risk intake" 1 "WHO risk intake"
label values q3_riskmeatserv_2cat q3_riskmeatserv_2cat_
order q3_riskmeatserv_2cat, after (q3_riskmeatserv)

//Approach 2: Only with participants reporting consumption in all 7 days/week. 
// This is the most conservative AND accurate command.
egen q3_riskmeatserv7 = rowtotal(q3_upmeatserv q3_pmeatserv) if (q3_upmeatnum==7 | q3_pmeatnum==7) & ((q3_upmeatserv != . & q3_pmeatserv != .) | (q3_upmeatserv >= 2 & q3_upmeatserv != . & q3_pmeatserv == . ) | (q3_upmeatserv == . & q3_pmeatserv >= 2 & q3_pmeatserv !=.))
label variable q3_riskmeatserv7 "Number of red meat servings eaten per day (possible range 0-10), only participants consuming all days"
order q3_riskmeatserv7, after (q3_riskmeatserv_2cat)
*Classify participants based on WHO recommendations on red & processed meat consumption: 70g/day = 1 serving/day. 
gen q3_riskmeatserv7_2cat = .
replace q3_riskmeatserv7_2cat = 0 if q3_riskmeatserv7 < 2
replace q3_riskmeatserv7_2cat = 1 if q3_riskmeatserv7 >=2 & q3_riskmeatserv7 !=.
replace q3_riskmeatserv7_2cat = 0 if q3_upmeatnum < 7 & q3_upmeatnum !=. & q3_pmeatnum < 7 & q3_pmeatnum !=.
label variable q3_riskmeatserv7_2cat "Red and processed meat consumption according to WHO based on q3_upmeatserv q3_pmeatserv, only participants consuming all days"
label define q3_riskmeatserv7_2cat_ 0 "WHO Not risk intake" 1 "WHO risk intake"
label values q3_riskmeatserv7_2cat q3_riskmeatserv7_2cat_
order q3_riskmeatserv7_2cat, after (q3_riskmeatserv7)

//Approach 2b: More restrictive
gen q3_partMEATserv7 =.
replace q3_partMEATserv7 =1 if (q3_upmeatnum==7 & q3_pmeatnum==7) | (q3_upmeatnum ==7 & q3_upmeatserv >=2 & q3_pmeatnum <7 | q3_pmeatnum==.) | (q3_pmeatnum ==7 & q3_pmeatserv >=2 & q3_upmeatnum <7 | q3_upmeatnum==.)
label variable q3_partMEATserv7 " Only participants considered for Approach 2b MEAT" 
egen q3_riskmeatserv7b = rowtotal(q3_upmeatserv q3_pmeatserv) if q3_partMEATserv7 ==1 & (q3_upmeatserv != . & q3_pmeatserv != .) | (q3_upmeatserv == . & q3_pmeatserv >= 2 & q3_pmeatserv != .) | (q3_upmeatserv >= 2 & q3_upmeatserv != . & q3_pmeatserv == .)
label variable q3_riskmeatserv7b "Number of MEAT servings per day. only participants consuming on all 7 days. Approach 2b"
order q3_partMEATserv7, after (q3_riskmeatserv7_2cat)
// WHO classification
gen q3_riskmeatserv7b_2cat = .
replace q3_riskmeatserv7b_2cat = 0 if  q3_riskmeatserv7b < 2 | q3_riskmeatserv7b ==.
replace q3_riskmeatserv7b_2cat = 1 if q3_riskmeatserv7b >=2 & q3_riskmeatserv7b !=.
label variable q3_riskmeatserv7b_2cat "Minimum F&V serving according to WHO based on q3_fruitserv q3_vegserv and 7 days consumption. Approach 2b"
label define q3_riskmeatserv7b_2cat_ 0 "WHO Not risk intake" 1 "WHO risk intake"
label values q3_riskmeatserv7b_2cat q3_riskmeatserv7b_2cat_
order q3_riskmeatserv7b_2cat, after (q3_riskmeatserv7b)

//PROCESSED & ULTRA-PROCESSED FOODS: 
*1. Processed and ultra-processed foods: based on q3_pmeatnum q3_pfoodnum q3_tinfoodnum q3_ultpfoodnum
gen q3_allprocessednum = .
replace q3_allprocessednum = 0 if q3_pmeatnum ==0 & q3_pfoodnum==0 & q3_tinfoodnum==0 & q3_ultpfoodnum==0 
replace q3_allprocessednum = 1 if q3_pmeatnum > 0 & q3_pmeatnum !=.  | q3_pfoodnum > 0 & q3_pfoodnum !=.| q3_tinfoodnum > 0 & q3_tinfoodnum !=.| q3_ultpfoodnum > 0 & q3_ultpfoodnum !=.
label variable q3_allprocessednum "Consumed processed and ultra-processed foods based on q3_pmeatnum q3_pfoodnum q3_tinfoodnum q3_ultpfoodnum"
label define q3_allprocessednum_ 0 "Not consumed" 1 "Consumed"
label values q3_allprocessednum q3_allprocessednum_
order q3_allprocessednum, after (q3_riskmeatserv7b_2cat)


*SUPLEMENTATION:
//Generate a new variable to group all types of supplementation.  
//The code is: 1, Yes, daily | 2, Yes, weekly | 3, Yes, monthly | 4, Yes, yearly | 5, No, never
gen q3_anysup =.
replace q3_anysup = 0 if q3_suppmv==5 & q3_suppva==5 & q3_suppvb==5 & q3_suppvc==5 & q3_suppvd==5 & q3_suppcod==5 & q3_suppca==5 & q3_suppo3==5 & q3_suppfe==5 & q3_suppzn==5  
replace q3_anysup = 1 if q3_suppmv<=4 | q3_suppva<=4 | q3_suppvb<=4 | q3_suppvc<=4 | q3_suppvd<=4 | q3_suppcod<=4 | q3_suppca<=4 | q3_suppo3<=4 | q3_suppfe<=4 | q3_suppzn<=4   
label variable q3_anysup "Any supplementation taken based on q3_suppzn q3_suppfe q3_suppo3 q3_suppca q3_suppcod q3_suppvd q3_suppvc q3_suppvb q3_suppva q3_suppmv "
label define q3_anysup_ 0 "Any supplementation not taken" 1 "Any supplementation taken"
label values q3_anysup q3_anysup_
order q3_anysup, after (q3_suppzn)

egen q3_miss3 = rowmiss(q3_suppmv q3_suppva q3_suppvb q3_suppvc q3_suppvd q3_suppcod q3_suppca q3_suppo3 q3_suppfe q3_suppzn)
label variable q3_miss3 "Number of missing values across 10 supplementation groups used to generate total supplementation (range 0-10)"
order q3_miss3, after (q3_anysup)


//Recode supplementation as 0/1 corresponds to not taken/taken. The code is: 1, Yes, daily | 2, Yes, weekly | 3, Yes, monthly | 4, Yes, yearly | 5, No, never
foreach var of varlist q3_suppmv q3_suppva q3_suppvb q3_suppvc q3_suppvd q3_suppcod q3_suppca q3_suppo3 q3_suppfe q3_suppzn {
generate `var'_2cat = .
replace `var'_2cat = 0 if `var' > 4 & `var' !=.
replace `var'_2cat = 1 if `var' <= 4 
label variable `var'_2cat "Supplementation taken based on `var'"
label define `var'_2cat_ 0 "Supplementation not taken" 1 "Supplementation taken"
label values `var'_2cat `var'_2cat_
order `var'_2cat, after (q3_miss3)
}

egen q3_totalsup = rowtotal(q3_suppzn_2cat q3_suppfe_2cat q3_suppo3_2cat q3_suppca_2cat q3_suppcod_2cat q3_suppvd_2cat q3_suppvc_2cat q3_suppvb_2cat q3_suppva_2cat q3_suppmv_2cat) if q3_miss3 == 0
label variable q3_totalsup "Total supplementation taken (range 0-10) based on q3_suppmv q3_suppva q3_suppvb q3_suppvc q3_suppvd q3_suppcod q3_suppca q3_suppo3 q3_suppfe q3_suppzn "
order q3_totalsup, after (q3_anysup)


*Generate a new variable for "non-alcoholic drinks" containing sugar-sweetened beverages AND sugar-free soft drinks (diet drinks)servings per day: q3_ssbserv q3_ddrinkserv
// The variables have been coded as 1, 1 | 2, 2 | 3, 3 | 4, 4 | 5, 5+ | 6, Don't know

egen q3_nonalcserv = rowtotal(q3_ssbserv q3_ddrinkserv) if q3_ssbserv != . | q3_ddrinkserv != . //We have allowed participants to be missing on one or other variable
label variable q3_nonalcserv "Number of servings per day of non-alcoholic drinks drunken (possible range 0-10) based on q3_ssbserv q3_ddrinkserv"
order q3_nonalcserv, after (q3_ddrinkserv)

list pid q3_ddrinkserv q3_ssbserv q3_nonalcserv if q3_ddrinkserv ==. | q3_ssbserv==.

	
* Classify participants according the number of ssbv servings per day based on q3_ssbserv:

// At least 1 ssbv serving a day. Only with participants reporting consumption in all 7 days/week. Otherwise, they were classified as less than 1 ssbv serving per day
gen q3_ssbserv_2catA = .
replace q3_ssbserv_2catA = 0 if q3_ssbnum!=. & q3_ssbnum < 7 
replace q3_ssbserv_2catA = 1 if q3_ssbnum ==7 & q3_ssbnum !=. & q3_ssbserv >=1 & q3_ssbserv !=. 
label variable q3_ssbserv_2catA "Proportion of at least 1 ssbv servings a day based on q3_ssbserv. Only participants consuming on all 7 days"
label define q3_ssbserv_2catA_ 0 "Less than one serving a day" 1 "At least one serving a day"
label values q3_ssbserv_2catA q3_ssbserv_2catA_
order q3_ssbserv_2catA, after (q3_ssbserv)
// 2 or more ssbv servings a day. Only with participants reporting consumption in all 7 days/week. Otherwise, they were classified as less than 1 ssbv serving per day
gen q3_ssbserv_2catB = .
replace q3_ssbserv_2catB = 0 if  q3_ssbnum!=. & q3_ssbnum < 7 
replace q3_ssbserv_2catB = 1 if  q3_ssbnum ==7 & q3_ssbnum !=. & q3_ssbserv ==1
replace q3_ssbserv_2catB = 2 if  q3_ssbnum ==7 & q3_ssbnum !=. & q3_ssbserv >=2 & q3_ssbserv !=.
label variable q3_ssbserv_2catB "Proportion of 2 or more ssbv servings a day based on q3_ssbserv. Only participants consuming on all 7 days"
label define q3_ssbserv_2catB_ 0 "Less than one serving a day" 1 "1 serving a day" 2 "2 or more servings a day"
label values q3_ssbserv_2catB q3_ssbserv_2catB_
order q3_ssbserv_2catB, after (q3_ssbserv_2catA)

//Generate a new variable for ssbv servings per week
//Total ssbv servings per week
gen q3_ssbweekserv = q3_ssbnum*q3_ssbserv if q3_ssbnum !=. & q3_ssbserv !=. & flag==0 
label variable q3_ssbweekserv "Number of total ssbv servings per week"
order q3_ssbweekserv, after (q3_ssbserv_2catB)
// At least 7 servings per week, which would be equivalent to 1 ssbv serving a day
gen q3_ssbweekserv_2catA =. 
replace q3_ssbweekserv_2catA = 0 if q3_ssbweekserv < 7
replace q3_ssbweekserv_2catA = 1 if q3_ssbweekserv >= 7 & q3_ssbweekserv !=.
label variable q3_ssbweekserv_2catA "At least 7 ssbv servings per week based on q3_ssbweekserv"
label define q3_ssbweekserv_2catA_ 0 "Less than 7 servings a week" 1 "At least 7 servings a week" 
label values q3_ssbweekserv_2catA q3_ssbweekserv_2catA_
order q3_ssbweekserv_2catA, after (q3_ssbweekserv)
//14 or more ssbv servings a day, which would be equivalent to 2 or more servings a day. 
gen q3_ssbweekserv_2catB = .
replace q3_ssbweekserv_2catB = 0 if  q3_ssbweekserv < 7 
replace q3_ssbweekserv_2catB = 1 if  q3_ssbweekserv ==7 | q3_ssbweekserv >7 & q3_ssbweekserv !=. & q3_ssbweekserv < 14
replace q3_ssbweekserv_2catB = 2 if  q3_ssbweekserv > 14 & q3_ssbweekserv !=. 
label variable q3_ssbweekserv_2catB "14 or more ssbv servings per week based on q3_ssbweekserv"
label define q3_ssbweekserv_2catB_ 0 "Less than 7 serving a week" 1 " At least 7 servings a week" 2 "14 or more servings a week"
label values q3_ssbweekserv_2catB q3_ssbweekserv_2catB_
order q3_ssbweekserv_2catB, after (q3_ssbweekserv_2catA)

//generating new variables for salt consumption based on those reporting to add salt to food either before or while eating irrespective of frequency 
//these variables were created to look at excess salt consumption. i.e. most participants reported to add salt during cooking so here only salt added before or while consumption were considered.
//variable for added salt to food before eating
gen q3_anynabf_2cat = .
replace q3_anynabf_2cat = 0 if q3_addnabf ==5
replace q3_anynabf_2cat = 1 if q3_addnabf == 1 | q3_addnabf == 2| q3_addnabf == 3 | q3_addnabf == 4
label variable q3_anynabf_2cat "Added any salt before eating"
label define q3_anynabf_2cat_ 0 "Not added salt before eating" 1 "Added salt before eating"
label values q3_anynabf_2cat q3_anynabf_2cat_
order q3_anynabf_2cat, after (q3_addnabf)

//variable for added salt to food while eating
gen q3_anynawhile_2cat = .
replace q3_anynawhile_2cat = 0 if q3_addnawhile ==5
replace q3_anynawhile_2cat = 1 if q3_addnawhile == 1 | q3_addnawhile == 2| q3_addnawhile == 3 | q3_addnawhile == 4
label variable q3_anynawhile_2cat "Added any salt while eating"
label define q3_anynawhile_2cat_ 0 "Not added salt while eating" 1 "Added salt while eating"
label values q3_anynawhile_2cat q3_anynawhile_2cat_
order q3_anynawhile_2cat, after (q3_addnawhile)

//Section 4b Food purchase

* Generate a new variable for all food retailer types. 
//Include the variables q4b_retailtype___1 q4b_retailtype___2 q4b_retailtype___3 q4b_retailtype___4 q4b_retailtype___5 q4b_retailtype___6 q4b_retailtype___7 q4b_retailtype___8 q4b_retailtype___9 q4b_retailtype___10 q4b_retailtype___11 q4b_retailtype___12 q4b_retailtype___13
//The code is 0 "Unckecked" 1 "Checked"
//L&A: q4b_retailtype___12 codes for "Other" types of food retailers and q4b_retailtype___13 codes for "don't know". 
*Therefore, q4b_retailtype___13 has been removed from the label "purchased in retailers"
gen q4b_allretail= .
replace q4b_allretail= 0 if q4b_retailtype___1==0 & q4b_retailtype___2==0 & q4b_retailtype___3==0 & q4b_retailtype___4==0 & q4b_retailtype___5==0 & q4b_retailtype___6==0 & q4b_retailtype___7==0 & q4b_retailtype___8==0 & q4b_retailtype___9==0 & q4b_retailtype___10==0 & q4b_retailtype___11==0 & q4b_retailtype___12==0 & q4b_retailtype___13==0 
replace q4b_allretail=1 if q4b_retailtype___1 !=0 | q4b_retailtype___2 !=0 | q4b_retailtype___3 !=0 | q4b_retailtype___4 !=0 | q4b_retailtype___5!=0 | q4b_retailtype___6!=0 | q4b_retailtype___7!=0 | q4b_retailtype___8!=0 | q4b_retailtype___9!=0 | q4b_retailtype___10!=0 | q4b_retailtype___11!=0 | q4b_retailtype___12!=0 
replace q4b_allretail=2 if q4b_retailtype___13!=0
label variable q4b_allretail "food purchased in food retailers or not based on all types of food retailers"
label define q4b_allretail_ 0 "Not purchased in retailers" 1 "Purcased in retailers " 2 "Don't know" 
label values q4b_allretail q4b_allretail_
order q4b_allretail, after (q4b_retailtype___13)


* Generate a new variable for all food service business.  
//Include the variables q4b_foodbus___1 q4b_foodbus___2 q4b_foodbus___3 q4b_foodbus___4 q4b_foodbus___5 q4b_foodbus___6 q4b_foodbus___7
//The code is 0 "Unckecked" 1 "Checked"
//L&A: q4b_foodbus___6 codes for "Other" types of food service business and q4b_foodbus___7 codes for "don't know". 
*Therefore, q4b_foodbus___7 has been removed from the label "purchased in service business"
* Participants who don't know will be missing.
gen q4b_allservice= .
replace q4b_allservice=0 if q4b_foodbus___1==0 & q4b_foodbus___2==0 & q4b_foodbus___3==0 & q4b_foodbus___4==0 & q4b_foodbus___5==0 & q4b_foodbus___6==0 & q4b_foodbus___7==0 
replace q4b_allservice=1 if q4b_foodbus___1 !=0 | q4b_foodbus___2 !=0 |  q4b_foodbus___3!=0 | q4b_foodbus___4 !=0 | q4b_foodbus___5!=0 | q4b_foodbus___6!=0 
replace q4b_allservice=2 if q4b_foodbus___7!=0
label variable q4b_allservice "food purchased in food service business or not based on all types of food service business"
label define q4b_allservice_ 0 "Not purchased in service business" 1 "Purchased in service business" 2 "Don't know" 
label values q4b_allservice q4b_allservice_
order q4b_allservice, after (q4b_foodbus___7)


//Section 6

* L&A: Generate a new variable for the average of blood pressure measurements: discard Measurement 1 and make average of the second and the third.
//Systolic: cut-off point 140. Above 140 mmHg --> high blood pressure.
egen q6_sys_av = rowmean (q6_sys2 q6_sys3)  
label variable q6_sys_av "Mean systolic pressure based on q6_sys2 q6_sys3"
order q6_sys_av, after (q6_dias3)      

gen q6_sys_av_2cat= .
replace q6_sys_av_2cat=0 if q6_sys_av <140 
replace q6_sys_av_2cat=1 if q6_sys_av >=140 & q6_sys_av !=. 
label variable q6_sys_av_2cat "Systolic pressure risk value based on q6_sys2 q6_sys3"
label define q6_sys_av_2cat_ 0 "No risk high systolic" 1 "Risk high systolic" 
label values q6_sys_av_2cat q6_sys_av_2cat_
order q6_sys_av_2cat, after (q6_sys_av)             

// Diastolic: Cut-off point 90 mmHg. Above that --> high blood pressure
egen q6_dias_av = rowmean (q6_dias2 q6_dias3)  
label variable q6_dias_av "Mean diastolic pressure based on q6_dias2 q6_dias3"
order q6_dias_av, after (q6_sys_av_2cat)      

gen q6_dias_av_2cat= .
replace q6_dias_av_2cat=0 if q6_dias_av <90 
replace q6_dias_av_2cat=1 if q6_dias_av >=90 & q6_dias_av !=. 
label variable q6_dias_av_2cat "Diastolic pressure risk value based on q6_dias2 q6_dias3"
label define q6_dias_av_2cat_ 0 "No risk high diastolic" 1 "Risk high diastolic" 
label values q6_dias_av_2cat q6_dias_av_2cat_
label values q6_dias_av_2cat q6_dias_av_2cat_
order q6_dias_av_2cat, after (q6_dias_av)             

// Classify participants whether they had high blood pressure or not based on either high systolic pressure or high diastolic pressure 
gen q6_bloodp_2cat= .
replace q6_bloodp_2cat=0 if q6_sys_av_2cat ==0 & q6_dias_av_2cat==0
replace q6_bloodp_2cat=1 if q6_sys_av_2cat ==1 | q6_dias_av_2cat==1
label variable q6_bloodp_2cat "Diastolic pressure risk value based on q6_sys2 q6_sys3 q6_dias2 q6_dias3"
label define q6_bloodp_2cat_ 0 "No risk high blood pressure" 1 "Risk high blood pressure" 
label values q6_bloodp_2cat q6_bloodp_2cat_
label values q6_bloodp_2cat q6_bloodp_2cat_
order q6_bloodp_2cat, after (q6_dias_av_2cat) 	  

* Generate variable Cereals + White roots, tubers and plantains for food purchase: 
gen q4b_buytype__1and2= .
replace q4b_buytype__1and2=0 if q4b_buytype___1 ==0 & q4b_buytype___2==0 
replace q4b_buytype__1and2=1 if q4b_buytype___1 !=0 | q4b_buytype___2 !=0 
label variable q4b_buytype__1and2 "Cereals and roots food group purchased based on q4b_buytype___1 q4b_buytype___2"
label define q4b_buytype__1and2_ 0 "Not purchased" 1 "Purchased "
label values q4b_buytype__1and2 q4b_buytype__1and2_
order q4b_buytype__1and2, after (q4b_buytype___22)

* Generate variable Meat + Poultry + Fish: 
gen q4b_buytype__568= .
replace q4b_buytype__568=0 if q4b_buytype___5 ==0 & q4b_buytype___6==0 & q4b_buytype___8==0
replace q4b_buytype__568=1 if q4b_buytype___5 !=0 | q4b_buytype___6 !=0 |  q4b_buytype___8!=0
label variable q4b_buytype__568 "Meat, poultry and fish food group purchased based on q4b_buytype___5 q4b_buytype___6 q4b_buytype___8"
label define q4b_buytype__568_ 0 "Not purchased" 1 "Purchased "
label values q4b_buytype__568 q4b_buytype__568_
order q4b_buytype__568, after (q4b_buytype__1and2)


// Generate a new variable for wc according to the International Diabetes Federation cut-off points (male >=90cm and female >=80cm) and the American NCEP (male >=102cm and female >=88cm)
//International Diabetes Federation
egen q6_wc_av = rowmean (q6_wc1 q6_wc2)  
label variable q6_wc_av "Mean waist circumference based on q6_wc1 q6_wc2"
order q6_wc_av, after (q6_wc3)      

gen q6_wc_av_2catIDF= .
replace q6_wc_av_2catIDF = 0 if q6_wc_av <80 &  q1_sex==2 |  q6_wc_av <90 & q1_sex==1
replace q6_wc_av_2catIDF = 1 if q6_wc_av >=80 & q6_wc_av !=. &  q1_sex==2 |  q6_wc_av >=90 & q6_wc_av !=. &  q1_sex==1 
label variable q6_wc_av_2catIDF "IDF Waist circumference risk value based on q6_wc1 q6_wc2"
label define q6_wc_av_2catIDF_ 0 "No risk high wc" 1 "Risk high wc" 
label values q6_wc_av_2catIDF q6_wc_av_2catIDF_
order q6_wc_av_2catIDF, after (q6_wc_av)             


// Generate a new variable for wc according to the American NCEP (male >=102cm and female >=88cm)

gen q6_wc_av_2catNCEP= .
replace q6_wc_av_2catNCEP = 0 if q6_wc_av <88 &  q1_sex==2 |  q6_wc_av <102 & q1_sex==1
replace q6_wc_av_2catNCEP = 1 if q6_wc_av >=88 & q6_wc_av !=. &  q1_sex==2 |  q6_wc_av >=102 & q6_wc_av !=. &  q1_sex==1 
label variable q6_wc_av_2catNCEP "NCEP Waist circumference risk value based on q6_wc1 q6_wc2"
label define q6_wc_av_2catNCEP_ 0 "No risk high wc" 1 "Risk high wc" 
label values q6_wc_av_2catNCEP q6_wc_av_2catNCEP_
order q6_wc_av_2catNCEP, after (q6_wc_av_2catIDF)      

//Notes for finishing


save "${outputdir}CFAH_section1-6_analysis3.dta", replace
use "${outputdir}CFAH_section1-6_analysis3.dta", clear
