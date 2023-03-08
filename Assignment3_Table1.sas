/********************************
Table 1: Discriptive Statistics
*********************************/
PROC SURVEYFREQ DATA =CHIS2009.adult_clean VARMETHOD=JACKKNIFE VARHEADER=LABEL; 
WEIGHT rakedw0;
REPWEIGHT rakedw1-rakedw80/JKCOEFS=1;
TABLE AD1_C age_c*AD1_C race_c*AD1_C dm*AD1_C dm2*AD1_C gdm*AD1_c/col;
Format AD1_c AD1_cfmt. age_c age_cfmt. race_c race_cfmt.
       dm dm2 gdm yesnofmt.;
Label AD1_C  = 'Age When Period Started, Categorical (8-11, 12-13, 14-18)'
	  age_c  = 'Categorical Age'
      race_c = 'Race/Ethnicity'
      dm     = 'Had Any Type Diabetes or not'
      dm2    = 'Had Type2 Diabetes or not'
      gdm    = 'Had Gestational Diabetes or not';
RUN;
