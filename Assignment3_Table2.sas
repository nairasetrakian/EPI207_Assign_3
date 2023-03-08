/********TABLE 2*********/
/**Unadjusted logistic regression modeling effect of Age at Menarche on Any non-gestational Diabetes**/
Proc Surveylogistic Data=CHIS2009.adult_clean Varmethod=Jackknife;
Weight rakedw0;
Repweight rakedw1-rakedw80/Jkcoefs=1;
Class AD1_c (Ref="12-13 years") dm (Ref="No");
MODEL dm = AD1_c;
FORMAT AD1_c AD1_cfmt. dm yesnofmt.;
Title 'Unadjusted Model: Effect of Age at Menarche on Any Non-gestational Diabetes';
Run;

/**Unadjusted logistic regression modeling effect of Age at Menarche on Type 2 Diabetes**/
Proc Surveylogistic Data=CHIS2009.adult_clean Varmethod=Jackknife;
Weight rakedw0;
Repweight rakedw1-rakedw80/Jkcoefs=1;
Class AD1_c (Ref="12-13 years") dm2 (Ref="No");
Model dm2 = AD1_c;
Format AD1_c AD1_cfmt. dm2 yesnofmt.;
Title 'Unadjusted Model: Effect of Age at Menarche on Type 2 Diabetes';
Run;

/**Unadjusted logistic regression modeling effect of Age at Menarche on Gestational Diabetes**/
Proc Surveylogistic Data=CHIS2009.adult_clean Varmethod=Jackknife;
Weight rakedw0;
Repweight rakedw1-rakedw80/Jkcoefs=1;
Class AD1_c (Ref="12-13 years") gdm (Ref="No");
Model gdm = AD1_c;
Format AD1_c AD1_cfmt. gdm yesnofmt.;
Title 'Unadjusted Model: Effect of Age at Menarche on Gestational Diabetes';
Run;

/**Adjusted logistic regression modeling effect of Age at Menarche on Any non-gestational Diabetes
controlling for race and age**/
Proc Surveylogistic Data=CHIS2009.adult_clean Varmethod=Jackknife;
Weight rakedw0;
Repweight rakedw1-rakedw80/Jkcoefs=1;
Class AD1_c (Ref="12-13 years") age_c (Ref="18-34 years") race_c (Ref="White, NH") dm (Ref="No");
Model dm = AD1_c age_c race_c;
Format AD1_c AD1_cfmt. age_c age_cfmt. race_c race_cfmt. dm yesnofmt.;
Title 'Adjusted Model: Effect of Age at Menarche on Any Non-gestational Diabetes';
Run;

/**Adjusted logistic regression modeling effect of Age at Menarche on Any Type 2 Diabetes
controlling for race and age**/
Proc Surveylogistic Data=CHIS2009.adult_clean Varmethod=Jackknife;
Weight rakedw0;
Repweight rakedw1-rakedw80/Jkcoefs=1;
Class AD1_c (Ref="12-13 years") age_c (Ref="18-34 years") race_c (Ref="White, NH") dm2 (Ref="No");
Model dm2 = AD1_c age_c race_c;
Format AD1_c AD1_cfmt. age_c age_cfmt. race_c race_cfmt. dm2 yesnofmt.;
Title 'Adjusted Model: Effect of Age at Menarche on Type 2 Diabetes';
Run;

/**Adjusted logistic regression modeling effect of Age at Menarche on Gestational Diabetes
controlling for race and age**/
Proc Surveylogistic Data=CHIS2009.adult_clean Varmethod=Jackknife;
Weight rakedw0;
Repweight rakedw1-rakedw80/Jkcoefs=1;
Class AD1_c (Ref="12-13 years") age_c (Ref="18-34 years") race_c (Ref="White, NH") gdm (Ref="No");
Model gdm = AD1_c age_c race_c;
Format AD1_c AD1_cfmt. age_c age_cfmt. race_c race_cfmt. gdm yesnofmt.;
Title 'Adjusted Model: Effect of Age at Menarche on Gestational Diabetes';
Run;
