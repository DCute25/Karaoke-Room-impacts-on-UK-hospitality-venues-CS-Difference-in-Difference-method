cd "C:\Aalto\BSc Thesis\Stata_Thesis\Data_checked"

import delimited "Karaoke_Room_Checked.csv", clear

***Check for duplicate in panel data
duplicates list venueid year


***All business types and Karaoke rooms

csdid roa years_incorporation, ivar(venueid) time(year) gvar(treat_year) notyet


estat simple
estat group

estat calendar
csdid_plot, title("Average Treatment effects on the treated across periods")

*Save output table as an estimation equation
estimates store m1, title("Not-yet") 

//Plot group ATT dynamic effects
estat attgt

csdid_plot, group(2019) title("Average Treatment effects on the Treated for group 2019")

csdid_plot, group(2020) title("Average Treatment effects on the Treated for group 2020")

csdid_plot, group(2021)  title("Average Treatment effects on the Treated for group 2021")

csdid_plot, group(2022) title("Average Treatment effects on the Treated for group 2022")


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
twoway (connected avg_g2020 year, sort) (connected avg_not_yet year, sort), ytitle("Return on assets (%)") xtitle("End of year") title("Parallel trends of group first treated in 2020)") tlabel(2018(1)2022) legend(order(1 "G2020" 2 "Not Yet")) ysize(2) xsize(3) tline(2019, lpattern(dash))


***Plot cohort g2021 vs Not-yet and Never Treated 
twoway (connected avg_g2021 year, sort) (connected avg_not_yet year, sort), ytitle("Return on assets (%)") xtitle("End of year") title("Parallel trends of group first treated in 2021") tlabel(2018(1)2022) legend(order(1 "G2021" 2 "Not Yet")) ysize(2) xsize(3) tline(2020, lpattern(dash))


***Plot cohort g2022 vs Not-yet and Never Treated 
twoway (connected avg_g2022 year, sort) (connected avg_not_yet year, sort), ytitle("Return on assets (%)") xtitle("End of year") title("Parallel trends of group first treated in 2022") tlabel(2018(1)2022) legend(order(1 "G2022" 2 "Not Yet")) ysize(2) xsize(3) tline(2021, lpattern(dash))


***Plot cohort vs Not-yet and Never Treated
twoway (connected avg_g2019 year, sort) (connected avg_g2020 year, sort) (connected avg_g2021 year, sort) (connected avg_g2022 year, sort) (connected avg_never_treated year, sort) (connected avg_not_yet year, sort), ytitle("Return on assets (%)") xtitle("End of year") title("Parallel trends in hospitality venues ROA in UK (2018-2022)") tlabel(2018(1)2022) legend(order(1 "G2019" 2 "G2020" 3 "G2021" 4 "G2022" 5 "Never Treated" 6 "Not Yet")) ysize(2) xsize(3)


