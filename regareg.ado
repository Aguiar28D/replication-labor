program regareg
	syntax varlist(fv) [if] [, absorb(varlist) cluster(varlist)]

	if "`absorb'" == "" {
		if "`cluster'" == "" {
			reg `varlist' `if', vce(robust)
		}
		else {
			reg `varlist' `if', vce(cluster `cluster')
		}
	}
	else {
		if "`cluster'" == "" {
			areg `varlist' `if', absorb(`absorb') vce(robust)
		}
		else {
			areg `varlist' `if', absorb(`absorb') vce(cluster `cluster')
		}
	}
end
