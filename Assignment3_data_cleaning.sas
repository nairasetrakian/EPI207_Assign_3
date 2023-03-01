LIBNAME CHIS2009 "/home/u59641456/EPI207";
/***Data cleaning***/
/*Formatting variables to be included in analysis*/
Proc Format;
VALUE  SRSEX		/*GENDER*/
       1            = "MALE"
       2            = "FEMALE";
Value  AD1_cfmt  	/*Age When Period Started, Categorical*/
       1            = "8-11 years"
       2            = "12-13 years"
       3            = "14-18 years";
Value  age_cfmt  	/*Categorical age*/
       1            = "18-34 years"
       2            = "35-49 years"
       3            = "50-64 years"
       4            = ">=65 years";
Value  race_cfmt    /*Race/Ethnicity*/
       1            = "White, NH"
       2            = "AA, NH"
       3            = "Hispanic"
       4            = "Asian, NH"
       5            = "Other";
Value  yesnofmt     /*Had Diabetes or not/Had Type2 Diabetes or not/Had Gestational Diabetes or not*/
       1            = "Yes"
       0            = "No";
Run;

/***Create new dataset using variables required for analysis from CHIS2009***/
Data CHIS2009.adult_clean;
Set CHIS2009.adult (Keep = PUF_ID SRSEX AD1 AB22 AB51 AB81 AB23_P
     						SRAGE_P OMBSRREO rakedw0 rakedw1-rakedw80);
/***Inclusion criteria/Exclusion criteria***/

If SRSEX=1 then delete; /*only include female adults*/

If AD1=96 then delete;  /*Exclude women who never started menstrual cycle*/
If AD1=-2 then delete;  /*Exclude women with no period info*/
									
If 8>AD1 then delete;
If AD1>18 then delete; /*Exclude women with age at menarche younger <8 or >18*/

If 0<AB23_P<AD1 then delete; /*Exclude women with diabetes diagnosis prior to first period*/

AD1_C=.; /*****age at menarche*****/
If AD1<12      Then AD1_c=1;
If 12<=AD1<=13 Then AD1_c=2;
If AD1>13      Then AD1_c=3;

Age_c=.; /*****age*****/
If 18<=SRAGE_P<=34 Then age_c=1;
If 35<=SRAGE_P<=49 Then age_c=2;
If 50<=SRAGE_P<=64 Then age_c=3;
If SRAGE_P>=65     Then age_c=4;

Race_c=.; /*****race*****/
If OMBSRREO=1 Then race_c=3;
If OMBSRREO=2 Then race_c=1;
If OMBSRREO=3 Then race_c=2;
If OMBSRREO=5 Then race_c=4;
If OMBSRREO=4 or OMBSRREO=6 or OMBSRREO=7 Then race_c=5;

dm=.; /*any type non-gestational diabetes*/
If AB22=1 Then dm=1;
If AB22=2 or AB22=3 Then dm=0;
dm2=.; /*type 2 diabetes*/
If AB51=2 Then dm2=1;
If AB51=-1 or AB51=1 or AB51=3 Then dm2=0;
gdm=.; /*gestational diabetes*/
If AB81=1 Then gdm=1;
If AB81=-1 or AB81=2 or AB81=3 Then gdm=0;

FORMAT
SRSEX SRSEX.
AD1_c AD1_cfmt.
age_c age_cfmt. 
race_c race_cfmt.
dm dm2 gdm yesnofmt.;
RUN;

/*proc freq of final variables included in analysis - sample size = 27,906*/
Proc Freq Data=CHIS2009.adult_clean;
Table  AD1_C Age_C Race_C dm dm2 gdm;
Format AD1_c AD1_cfmt. age_c age_cfmt. race_c race_cfmt.
       dm dm2 gdm yesnofmt.;
Label AD1_C  = 'Age When Period Started, Categorical (8-11, 12-13, 14-18)'
	  age_c  = 'Categorical Age'
      race_c = 'Race/Ethnicity'
      dm     = 'Had Any Type Diabetes or not'
      dm2    = 'Had Type2 Diabetes or not'
      gdm    = 'Had Gestational Diabetes or not';
Run;
