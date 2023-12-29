cd "C:\Aalto\BSc Thesis\Stata_Thesis\Data_checked"

import delimited "karaoke_room_checked.csv", clear

***Check for duplicate in panel data
duplicates list venueid year

**Without covariates (parallel trend assumptions)

*Never as control group
csdid roa, ivar(venueid) time(year) gvar(treat_year)
*Never as conrol group - Uncodnitional parallel trend assumptions
estat simple
estat group
*Save output table as an estimation equation
estimates store m1, title("Never/ Unconditional Parallel Trend")


*Not yet as control group
csdid roa, ivar(venueid) time(year) gvar(treat_year) notyet
*Not yet as control group - Uncodnitional parallel trend assumptions
estat simple
estat group

//Plot group ATT dynamic effects Unconditional parallel trend
estat attgt

csdid_plot, group(2019) title("Average Treatment effects on the Treated for group 2019") ytitle("ATT (percentage change)")

graph export un2019.png, replace

csdid_plot, group(2020) title("Average Treatment effects on the Treated for group 2020") ytitle("ATT (percentage change)") 

graph export un2020.png, replace

csdid_plot, group(2021) title("Average Treatment effects on the Treated for group 2021") ytitle("ATT (percentage change)")

graph export un2021.png, replace

csdid_plot, group(2022) title("Average Treatment effects on the Treated for group 2022") ytitle("ATT (percentage change)") 

graph export un2022.png, replace

**With covariates (conditional parallel trend assumptions)

*Never treated as control group  - conditional parallel trend
csdid roa years_incorporation, ivar(venueid) time(year) gvar(treat_year)
*Never treated as control group  - conditional parallel trend
estat simple
estat group


*Not yet as control group  - conditional parallel trend
csdid  roa years_incorporation , ivar(venueid) time(year) gvar(treat_year) notyet
*Not yet as control group - conditional parallel trend
estat simple
estat group


**Plot average treatment effects across periods 
estat calendar
csdid_plot, title("Average Treatment effects on the treated across periods") ytitle("ATT (percentage change)") 


//Tableau all the estimation
estout *, cells(b(star fmt(3)) se(par fmt(2))) legend label stats(r2, fmt(3 0 1) label(R-squared))

//Plot group ATT dynamic effects Conditional parallel trend
estat attgt

csdid_plot, group(2019) title("Average Treatment effects on the Treated for group 2019") ytitle("ATT (percentage change)")

graph export 2019.png, replace

csdid_plot, group(2020) title("Average Treatment effects on the Treated for group 2020") ytitle("ATT (percentage change)") 

graph export 2020.png, replace

csdid_plot, group(2021)  title("Average Treatment effects on the Treated for group 2021") ytitle("ATT (percentage change)") 

graph export 2021.png, replace

csdid_plot, group(2022) title("Average Treatment effects on the Treated for group 2022") ytitle("ATT (percentage change)")

graph export 2022.png, replace

***Visualization for parallel trend assumpion test
**Generate average ROA group by treat year
gen never_treated = roa if treat_year == 0
egen avg_never_treated = mean(never_treated), by(year)

gen g2019 = roa if treat_year == 2019
egen avg_g2019 = mean(g2019), by(year)

gen g2020 = roa if treat_year == 2020
egen avg_g2020 = mean(g2020), by(year)

gen g2021 = roa if treat_year == 2021
egen avg_g2021 = mean(g2021), by(year)

gen g2022 = roa if treat_year == 2022
egen avg_g2022 = mean(g2022), by(year)

gen not_yet = roa if treat_year > year | treat_year == 0
egen avg_not_yet = mean(not_yet), by(year)


***Plot cohort g2020 vs Not-yet and Never Treated 
twoway (connected avg_g2020 year, sort) (connected avg_never_treated year, sort) (connected avg_not_yet year, sort), ytitle("Return on assets (%)") xtitle("End of year") title("Parallel trends in hospitality venues' ROA in UK (2018-2022)") tlabel(2018(1)2022) legend(order(1 "g2020" 2 "Never Treated" 3 "Not Yet")) ysize(2) xsize(3) tline(2019, lpattern(dash))

graph export para20.png, replace

***Plot cohort g2021 vs Not-yet and Never Treated 
twoway (connected avg_g2021 year, sort) (connected avg_never_treated year, sort) (connected avg_not_yet year, sort), ytitle("Return on assets (%)") xtitle("End of year") title("Parallel trends in hospitality venues ROA in UK (2018-2022)") tlabel(2018(1)2022) legend(order(1 "g2021" 2 "Never Treated" 3 "Not Yet")) ysize(2) xsize(3) tline(2020, lpattern(dash))

graph export para21.png, replace

***Plot cohort g2022 vs Not-yet and Never Treated 
twoway (connected avg_g2022 year, sort) (connected avg_never_treated year, sort) (connected avg_not_yet year, sort), ytitle("Return on assets (%)") xtitle("End of year") title("Parallel trends in hospitality venues ROA in UK (2018-2022)") tlabel(2018(1)2022) legend(order(1 "g2022" 2 "Never Treated" 3 "Not Yet")) ysize(2) xsize(3) tline(2021, lpattern(dash))

graph export para22.png, replace

***Plot all cohorts vs Not-yet and Never Treated
twoway (connected avg_g2019 year, sort) (connected avg_g2020 year, sort) (connected avg_g2021 year, sort) (connected avg_g2022 year, sort) (connected avg_never_treated year, sort) (connected avg_not_yet year, sort), ytitle("Return on assets (%)") xtitle("End of year") title("Parallel trends in hospitality venues ROA in UK (2018-2022)") tlabel(2018(1)2022) legend(order(1 "G2019" 2 "G2020" 3 "G2021" 4 "G2022" 5 "Never Treated" 6 "Not Yet")) ysize(2) xsize(3)



