/*
Replication dofile for the paper:
A pleasure that hurts: the ambiguous effects of elite tutoring on underprivileged high school students
by Son Thierry Ly, Eric Maurin and Arnaud Riegert
Journal of Labor Economics
*/


/* Load the main dataset */

clear
clear matrix
set more off, perm
use YOURLOCATION/Data_for_A_Pleasure_That_Hurts_replication.dta, clear


/* Preamble: global variables and settings */

** Variable lists
global ybalancing retard female upperclass6 stddnb_score1MAT stddnb_score1FRE acad_track filiere_p_s
global ybalancing_baseline pereimmigre mereimmigre pereetudessup mereetudessup ///
	aidedevoir autoeval_b_tb ideemetier ambition_master ///
	conn_grandeecole_bin conn_cpge_bin conn_univ_bin conn_iep_bin conn_iut_bin conn_bac2_bin ///
	aideorientation  egachance ///
	int_politique01 int_economie01 int_actunat01 int_actuinternat01 int_litterature01 int_histoire01 int_scitech01 int_sport01 int_sjsociete01 int_arts01
global takeup_vars campus1 missed_2sessions_or_less_p poursuite_2a
global outcomes_bac stdbac_score_PREMIERE stdbac_score_TERMINALE stdbac_moy1 bac_obtenu bac_obtenu_r_2a
global outcomes_bac_S stdbac_score_PREMIERE stdbac_score_FRW stdbac_score_FRO stdbac_score_TPE ///
	stdbac_score_TERMSCIENCES_S stdbac_score_MAT stdbac_score_PC stdbac_score_BIO ///
	stdbac_score_TERMLITT_S stdbac_score_HG stdbac_score_PHI stdbac_score_LG1 ///
	stdbac_moy1 bac_obtenu
global outcomes_bac_ESL stdbac_score_PREMIERE stdbac_score_FRW stdbac_score_FRO stdbac_score_TPE ///
	stdbac_score_MAT stdbac_score_SSC stdbac_score_SCI ///
	stdbac_score_TERMLITT_S stdbac_score_HG stdbac_score_PHI stdbac_score_LG1 ///
	stdbac_moy1 bac_obtenu
global outcomes_cpge_main cpge1 cpge2
global outcomes_epb epb_tuteur_proche01 epb_tuteur_motivant01 epb_tuteur_trop_complexe01 epb_bcp_temps_transport01 epb_pas_devoirs_jours_seances01 epb_bcp_travail01 ///
	epb_moins_temps_devoirs01 epb_poursuite_2a epb_groupe_agreable01 epb_groupe_camarades01 epb_bcp_temps_camarades01 epb_garde_contact_camarades01 
global fullcontrols retard sexe upperclass6 dnbMAT_notmissing dnb_score1MAT_xnm dnbFRE_notmissing dnb_score1FRE_xnm
global fullcontrolshighab $fullcontrols highab_X_retard highab_X_female highab_X_upperclass6 highab_X_dnbMAT_notmissing highab_X_dnbMAT highab_X_dnbFRE_notmissing highab_X_dnbFRE

** Subsample filters
global filter_All 1
global filter_LoAb highab == 0
global filter_HiAb highab == 1
global filter_S filiere_p_s == 1
global filter_ESL filiere_p_s == 0
global filter_C1 promo == 2010
global filter_C2 promo == 2011

** Table formatting options
global or_opt se starlev(10 5) tex bd(3) va starloc(1)
global outregpath "./tables/"


/* The code to generate the table starts here */


*** Table 1: Descriptive statistics ***

// Columns I and II of this table are based on proprietary data from the French ministry of education.
// Please contact the authors if you need information on how to obtain this data and how to replicate it

// The command below outputs columns III through V of the table
descstats female upperclass5 lowses dnb_score1_std_idf retard acad_track filiere_p_s, n filters(All C1 C2)


*** Table 2: Take-up ***

descstats $takeup_vars if selectionne & promo == 2010, filters(All LoAb HiAb) n nvar
descstats $takeup_vars if selectionne & promo == 2011, filters(All LoAb HiAb) n nvar


*** Table 3: Main results ***

foreach panel in All LoAb HiAb {
	di in white "Panel: `panel'"
	outregloop selectionne if ${filter_`panel'} using "${outregpath}main_results_panel`panel'.tex", loop(depvars) depvars($outcomes_bac) controls($fullcontrols) absorb(group_filiere) cluster(group_class5) outreg_options($or_opt)
}

di "Panel: Difference"
outregloop selectionne_X_highab using "${outregpath}main_results_panelDiff.tex", ///
	loop(depvars) depvars($outcomes_bac) controls(selectionne highab $fullcontrolshighab) absorb(group_filiere_highab) cluster(group_class5) outreg_options($or_opt)


*** Table 4: Effect of the treatment on the access to CPGE programs ***

foreach panel in All LoAb HiAb {
	di "Panel: `panel'"
	outregloop selectionne if ${filter_`panel'} using "${outregpath}results_cpge_panel`panel'.tex", loop(filters_depvars) filters(All S ESL) depvars($outcomes_cpge_main) controls($fullcontrols) absorb(group_filiere) cluster(group_class5) outreg_options($or_opt)
}

di "Panel: Difference"
outregloop selectionne_X_highab using "${outregpath}results_cpge_panelDiff.tex", ///
	loop(filters_depvars) filters(All S ESL) depvars($outcomes_cpge_main) controls(selectionne highab $fullcontrolshighab) absorb(group_filiere_highab) cluster(group_class5) outreg_options($or_opt)


*** Table 5: Effect of tutor characteristics on grade 11 average ***

foreach panel in All LoAb HiAb {
	di in white "Panel: `panel'"
	qui areg stdbac_score_PREMIERE selectionne $fullcontrols if ${filter_`panel'}, absorb(group_filiere) cluster(group_class5)
	qui outreg using "${outregpath}tutor_effects_panel`panel'.tex", keep(selectionne) replace $or_opt
	qui areg stdbac_score_PREMIERE selectionne selectionne_X_tuteur_female $fullcontrols if ${filter_`panel'}, absorb(group_filiere) cluster(group_class5)
	qui outreg using "${outregpath}tutor_effects_panel`panel'.tex", keep(selectionne selectionne_X_tuteur_female) merge $or_opt
	qui areg stdbac_score_PREMIERE selectionne selectionne_X_tuteur_whitecollar $fullcontrols if ${filter_`panel'}, absorb(group_filiere) cluster(group_class5)
	qui outreg using "${outregpath}tutor_effects_panel`panel'.tex", keep(selectionne selectionne_X_tuteur_whitecollar) merge $or_opt
	qui areg stdbac_score_PREMIERE selectionne selectionne_X_tuteur_female selectionne_X_tuteur_whitecollar $fullcontrols if ${filter_`panel'}, absorb(group_filiere) cluster(group_class5)
	outreg using "${outregpath}tutor_effects_panel`panel'.tex", keep(selectionne selectionne_X_tuteur_female selectionne_X_tuteur_whitecollar) merge $or_opt
}


*** Table 6: Post intervention survey ***
descstats $outcomes_epb if epb_response & selectionne, n filters(All LoAb HiAb)


/* START OF ONLINE APPENDIX */

*** Table A.1: Balancing test ***

balancingtest $ybalancing, balancevar(selectionne) absorb(group_filiere)
balancingtest $ybalancing if $filter_LoAb, balancevar(selectionne) absorb(group_filiere)
balancingtest $ybalancing if $filter_HiAb, balancevar(selectionne) absorb(group_filiere)


*** Table A.2: Balancing test baseline ***

balancingtest $ybalancing_baseline, balancevar(selectionne) absorb(group_filiere)


*** Table A.3: Balancing test on teacher characteristics ***

// This table is based on proprietary data from the French ministry of Education.
// Please contact the authors if you need information on how to obtain this data and how to replicate it


*** Table A.4 : DNB rank deciles
ta dnb1_rank_dec highab, m nofreq col


*** Table A.5: Ability groups comparison baseline vars ***

balancingtest $ybalancing_baseline, balancevar(highab) absorb(group_filiere)


*** Table A.6: Multiple hypotheses ***

foreach panel in LoAb HiAb {
	foreach y in $outcomes_bac cpge1 cpge2 {
		areg `y' selectionne $fullcontrols if ${filter_`panel'}, absorb(group_filiere) cluster(group_class5)
	}
}
// This loop prints out all the regressions in tables 3 and 4, the p-value on the first line of each results table being the unadjusted one.
// Adjusted p-values are simply obtained by multiplying the unadjusted p-values following Holm's method.


*** Table A.7: Main results, by cohort ***

foreach promo in 2010 2011 {
	di "Promo `promo'"

	foreach panel in All LoAb HiAb {
		di "Panel: `panel'"
		outregloop selectionne if ${filter_`panel'} & promo == `promo' using "${outregpath}main_results_promo`promo'_panel`panel'.tex", ///
			loop(depvars) depvars($outcomes_bac) controls($fullcontrols) absorb(group_filiere) cluster(group_class5) outreg_options($or_opt)
	}

	di "Panel: Difference"
	outregloop selectionne_X_highab if promo == `promo' using "${outregpath}main_results_promo`promo'_panelDiff.tex", ///
		loop(depvars) depvars($outcomes_bac) controls(selectionne highab $fullcontrolshighab) absorb(group_filiere_highab) cluster(group_class5) outreg_options($or_opt)
}


*** Table A.8 & A.9: Impact of the program on subject-wise grades at the Baccalaureate exam ***

foreach filiere in S ESL {

	di "Filiere `filiere'"

	foreach panel in All LoAb HiAb {
		di "Panel: `panel'"
		outregloop selectionne if ${filter_`panel'} & ${filter_`filiere'} using "${outregpath}bacscores_filiere`filiere'_panel`panel'.tex", ///
			loop(depvars) depvars(${outcomes_bac_`filiere'}) controls($fullcontrols) absorb(group_filiere) cluster(group_class5) outreg_options($or_opt)
	}

	di "Panel: Difference"
	outregloop selectionne_X_highab if ${filter_`filiere'} using "${outregpath}bacscores_filiere`filiere'_panelDiff.tex", ///
		loop(depvars) depvars(${outcomes_bac_`filiere'}) controls(selectionne highab $fullcontrolshighab) absorb(group_filiere_highab) cluster(group_class5) outreg_options($or_opt)
}


*** Table A.10: Effect of peers characteristics on grade 11 average (first cohort only) ***

foreach panel in All LoAb HiAb {
	di in white "Panel: `panel'"
	qui areg stdbac_score_PREMIERE selectionne $fullcontrols if ${filter_`panel'} & promo == 2010, absorb(group_filiere) cluster(group_class5)
	qui outreg using "${outregpath}peer_effects_panel`panel'.tex", keep(selectionne) replace $or_opt
	qui areg stdbac_score_PREMIERE selectionne selectionne_X_p_female_otp $fullcontrols if ${filter_`panel'} & promo == 2010, absorb(group_filiere) cluster(group_class5)
	qui outreg using "${outregpath}peer_effects_panel`panel'.tex", keep(selectionne selectionne_X_p_female_otp) merge $or_opt
	qui areg stdbac_score_PREMIERE selectionne selectionne_X_p_highab_otp $fullcontrols if ${filter_`panel'} & promo == 2010, absorb(group_filiere) cluster(group_class5)
	qui outreg using "${outregpath}peer_effects_panel`panel'.tex", keep(selectionne selectionne_X_p_highab_otp) merge $or_opt
	qui areg stdbac_score_PREMIERE selectionne selectionne_X_p_female_otp selectionne_X_p_highab_otp $fullcontrols if ${filter_`panel'} & promo == 2010, absorb(group_filiere) cluster(group_class5)
	outreg using "${outregpath}peer_effects_panel`panel'.tex", keep(selectionne selectionne_X_p_female_otp selectionne_X_p_highab_otp) merge $or_opt
}


*** Table A.11: Balancing test of baseline vars depending on whether they answer the post treatment survey ***

balancingtest $ybalancing if selectionne, balancevar(rep_epb) absorb(group_filiere)


*** Table A.12: Post treatment survey, differences depenging on tutor characteristics ***

balancingtest epb_tuteur_proche01 epb_tuteur_motivant01 epb_tuteur_trop_complexe01 poursuite_2a if selectionne, balancevar(tuteur_female)
balancingtest epb_tuteur_proche01 epb_tuteur_motivant01 epb_tuteur_trop_complexe01 poursuite_2a if selectionne, balancevar(tuteur_whitecollar)


*** Figure A.1

foreach v in bac_score_PREMIERE bac_score_TERMINALE {
	egen stdsample`v' = std(`v')
}

su stdmoyenne_s stdsamplebac_score_PREMIERE stdsamplebac_score_TERMINALE if selectionne & highab
su stdmoyenne_s stdsamplebac_score_PREMIERE stdsamplebac_score_TERMINALE if !selectionne & highab
su stdmoyenne_s stdsamplebac_score_PREMIERE stdsamplebac_score_TERMINALE if selectionne & !highab
su stdmoyenne_s stdsamplebac_score_PREMIERE stdsamplebac_score_TERMINALE if !selectionne & !highab

/* End of file */
