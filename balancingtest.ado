program balancingtestrow
	syntax varlist(max=1) [if/] , balancevar(varlist) [controls(varlist) absorb(varlist) cluster(varlist) noheader]

	if "`header'" == "" {
		di in green "Variable" ///
			in white " & " in green "Control" ///
			in white " & " in green "T - C" ///
			in white " & " in green "s.e." ///
			in white " & " in green "N" ///
			in white " \\"
	}

	if "`if'" == "" {
		local if 1
	}

	local vl : var label `varlist'
	if "`vl'" == "" {
		local vl "`varlist'"
	}
	di in green "`vl'" _continue

	su `varlist' if `if' & !`balancevar', meanonly
	di in white " & " in yellow %4.3f = r(mean) _continue
	
	qui regareg `varlist' `balancevar' `controls' if `if', absorb(`absorb') cluster(`cluster')
	local t = _b[`balancevar'] / _se[`balancevar']
	local p = 2 * ttail(e(df_r), abs(`t'))
	local stars = ((`p' <= .1) + (`p' < .05)) * "*"
	di in white " & " _continue
	if _b[`balancevar'] > 0 {
		di in yellow "+" _continue
	}
	di in yellow %4.3f = _b[`balancevar'] "`stars'" _continue
	di in white " & " in yellow "(" %4.3f = _se[`balancevar'] ")" _continue
	
	qui count if `if' & !missing(`varlist')
	di in white " & " in yellow %3.0f = r(N) _continue
	
	di in white " \\"
end

program balancingtest
	syntax varlist [if] , balancevar(varlist) [controls(varlist) absorb(varlist) cluster(varlist) noheader]
	if "`header'" == "" {
		di in green "Variable" ///
			in white " & " in green "Control" ///
			in white " & " in green "T - C" ///
			in white " & " in green "s.e." ///
			in white " & " in green "N" ///
			in white " \\"
	}
	foreach y in `varlist' {
		balancingtestrow `y' `if', balancevar(`balancevar') controls(`controls') absorb(`absorb') cluster(`cluster') noheader
	}
end
