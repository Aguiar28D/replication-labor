program descstats
	syntax varlist [if/] [, filters(string) sd nvar n]

	if "`if'" == "" {
		local if 1
	}

	di in green "Variable" _continue
	if "`filters'" == "" {
		di in white " & " in green "Mean" _continue
	}
	else {
		foreach c in `filters' {
			di in white " & " in green "`c'" _continue
		}
	}
	di in red " \\"

	foreach x in `varlist' {
		local vl : var label `x'
		if "`vl'" == "" {
			local vl "`x'"
		}
		di in green "`vl'" _continue

		if "`filters'" == "" {
			su `x' if `if', meanonly
			di in white " & " in yellow %4.3f = r(mean) _continue
		}
		else {
			foreach c in `filters' {
				su `x' if `if' & ${filter_`c'}, meanonly
				di in white " & " in yellow %4.3f = r(mean) _continue
			}
		}
		di in red " \\"


		if "`sd'" == "sd" {
			if "`filters'" == "" {
				qui su `x' if `if'
				di in white " & " in yellow "(" %4.3f = r(sd) ")" _continue
			}
			else {
				foreach c in `filters' {
					qui su `x' if `if' & ${filter_`c'}
					di in white " & " in yellow "(" %4.3f = r(sd)  ")" _continue
				}
			}
			di in red " \\"
		}

		if "`nvar'" == "nvar" {
			di in green  "\$N\$" _continue
			if "`filters'" == "" {
				qui su `x' if `if'
				di in white " & " in yellow r(N) _continue
			}
			else {
				foreach c in `filters' {
					qui su `x' if `if' & ${filter_`c'}
					di in white " & " in yellow r(N)  _continue
				}
			}
			di in red " \\"
		}
	}

	if "`n'" == "n" {
		di in green  "\$N\$" _continue
		if "`filters'" == "" {
			qui count if `if'
			di in white " & " in yellow r(N) _continue
		}
		else {
			foreach c in `filters' {
				qui count if `if' & ${filter_`c'}
				di in white " & " in yellow r(N)  _continue
			}
		}
		di in red " \\"
	}

end
