cd "C:\Users\sasha\Desktop\law and economics\project\grid_data_culture_counts"

* Drop any previous estimates
estimates drop _all

* Define grid sizes
local grids 5 10 15 20 25 30 40 50

foreach g in `grids' {
    use grid_`g'km.dta, clear
    
    reg culture_count stone_count, robust
    estimates store reg_`g'
    
    * Add summary stats
    estadd local N_ = round(e(N), 1)
	
    
}

* Create LaTeX table
esttab reg_* using "stone_culture_regressions_table.tex", se star(* 0.10 ** 0.05 *** 0.01) title("Effect of Stone Presence on Cultural Sight Count") mtitles("5km" "10km" "15km" "20km" "25km" "30km" "40km" "50km")label nobaselevel varlabels(stone_count "Quantity of stone quarries" _cons "Intercept")  addnotes("Robust standard errors") stats(N_ , labels("Observations"))  replace


**********  Logit regression

* Drop any previous estimates
estimates drop _all

* Define grid sizes
local grids 5 10 15 20 25 30 40 50

foreach g in `grids' {
    use grid_`g'km.dta, clear
    
    * Perform logistic regression (logit) to get probabilities
    logit culture_count stone_count, robust
    estimates store reg_`g'
    
    * Add summary stats
    estadd local N_ = round(e(N), 1)
}

* Create LaTeX table
esttab reg_* using "stone_culture_logit_regressions_table.tex", se star(* 0.10 ** 0.05 *** 0.01) title("Effect of Stone Presence on Cultural Sight Count (Logit)") mtitles("5km" "10km" "15km" "20km" "25km" "30km" "40km" "50km") label nobaselevel varlabels(stone_count "Quantity of stone quarries" _cons "Intercept") addnotes("Robust standard errors") stats(N_ , labels("Observations")) replace
