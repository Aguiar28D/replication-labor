program outregloop
	syntax varlist [if/] using/ , loop(string) [depvar(varname) depvars(varlist) controls(string) filters(string) absorb(varlist) cluster(varlist) outreg_options(string) append]
	if "`if'" == "" {
		local if 1
	}

	if "`loop'" == "depvars" {
		if "`depvars'" == "" {			
			di as error "You must specify a varlist for the depvars option"
			exit 111
		}

		// Find the names of the first and last variables.
		local firstcolfound 0
		foreach y in `depvars' {
			if `firstcolfound' == 0 {
				local firstcol `y'
				local firstcolfound 1
			}
			local lastcol `y'
		}

		foreach y in `depvars' {
			qui regareg `y' `varlist' `controls' if `if', absorb(`absorb') cluster(`cluster')

			if "`y'" == "`firstcol'" {
				if ("`append'" == "") {
					qui outreg using `using', keep(`varlist') replace `outreg_options'
				}
				else {
					qui outreg using `using', keep(`varlist') merge `outreg_options'
				}
			}
			else if "`y'" == "`lastcol'" {
				outreg using `using', keep(`varlist') merge `outreg_options'
			}
			else {
				qui outreg using `using', keep(`varlist') merge `outreg_options'
			}
		}

	}

	else if "`loop'" == "filters" {
		if "`filters'" == "" {
			di as error "You must specify the filters option"
			exit 111
		}
		if "`depvar'" == "" {
			di as error "You must specify the depvar option"
			exit 111
		}

		// Find the names of the first and last variables.
		local firstcolfound 0
		foreach c in `filters' {
			if `firstcolfound' == 0 {
				local firstcol `c'
				local firstcolfound 1
			}
			local lastcol `c'
		}

		foreach c in `filters' {
			qui regareg `depvar' `varlist' `controls' if `if' & ${filter_`c'}, absorb(`absorb') cluster(`cluster')

			if "`c'" == "`firstcol'" {
				if ("`append'" == "") {
					qui outreg using `using', keep(`varlist') replace `outreg_options'
				}
				else {
					qui outreg using `using', keep(`varlist') merge `outreg_options'
				}
			}
			else if "`c'" == "`lastcol'" {
				outreg using `using', keep(`varlist') merge `outreg_options'
			}
			else {
				qui outreg using `using', keep(`varlist') merge `outreg_options'
			}

		}
	}

	else if "`loop'" == "filters_depvars" {
		if "`filters'" == "" {
			di as error "You must specify the filters option"
			exit 111
		}
		if "`depvars'" == "" {
			di as error "You must specify a varlist for the depvars option"
			exit 111
		}

		// Find the names of the first and last variables.

		local firstcolfound 0
		foreach c in `filters' {
			foreach y in `depvars' {
				if `firstcolfound' == 0 {
					local firstcond `c'
					local firstvar `y'
					local firstcolfound 1
				}
				local lastcond `c'
				local lastvar `y'
			}
		}

		foreach c in `filters' {
			local thisif `if' & ${filter_`c'}
			foreach y in `depvars' {
				qui regareg `y' `varlist' `controls' if `thisif', absorb(`absorb') cluster(`cluster')

				if "`c'" == "`firstcond'" & "`y'" == "`firstvar'" {
					if ("`append'" == "") {
						qui outreg using `using', keep(`varlist') replace `outreg_options'
					}
					else {
						qui outreg using `using', keep(`varlist') merge `outreg_options'
					}
				}
				else if "`c'" == "`lastcond'" & "`y'" == "`lastvar'" {
					outreg using `using', keep(`varlist') merge `outreg_options'
				}
				else {
					qui outreg using `using', keep(`varlist') merge `outreg_options'
				}
			}
		}
	}

	else if "`loop'" == "depvars_indepvars" {
		if "`depvars'" == "" {
			di as error "You must specify a varlist for the depvars option"
			exit 111
		}

		// Find the names of the first and last variables.

		local firstcolfound 0
		foreach y in `depvars' {
			foreach x in `varlist' {
				if `firstcolfound' == 0 {
					local firsty `y'
					local firstx `x'
					local firstcolfound 1
				}
				local lasty `y'
				local lastx `x'
			}
		}

		foreach y in `depvars' {
			foreach x in `varlist' {
				qui regareg `y' `x' `controls' if `if', absorb(`absorb') cluster(`cluster')

				if "`y'" == "`firsty'" & "`x'" == "`firstx'" {
					if ("`append'" == "") {
						qui outreg using `using', keep(`x') replace `outreg_options'
					}
					else {
						qui outreg using `using', keep(`x') merge `outreg_options'
					}
				}
				else {
					qui outreg using `using', keep(`x') merge `outreg_options'
				}
			}
			qui regareg `y' `varlist' `controls' if `if', absorb(`absorb') cluster(`cluster')
			if "`y'" == "`lasty'" {
				outreg using `using', keep(`varlist') merge `outreg_options'
			}
			else {
				qui outreg using `using', keep(`varlist') merge `outreg_options'
			}
		}
	}
end
