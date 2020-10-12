# [Journal of Labor Economics, 2020, vol. 38, no. 2] [A Pleasure That Hurts: The Ambiguous Effects of Elite Tutoring on Underprivileged High School Students] Validation and Replication results

> Some useful links:
> - [Official Data and Code Availability Policy](https://www.aeaweb.org/journals/policies/data-code)
> - [Unofficial Verification Guidance](https://social-science-data-editors.github.io/guidance/Verification_guidance.html) for additional tips and criteria.

SUMMARY
-------

> INSTRUCTION: The Data Editor will fill this part out. It will be based on any [REQUIRED] and [SUGGESTED] action items that the report makes a note of. 

> INSTRUCTION: ALWAYS do "Data description", "Code description". If data is present, ALWAYS do "Data checks". If time is sufficient (initial assessment!), do "Replication steps", if not, explain why not.

Data description
----------------

### Data Sources

Data is provided and has been uploaded as the file Data_for_A_Pleasure_That_Hurts_replication.dta 

### Analysis Data Files

- [ ] Analysis data files mentioned, provided. File names listed below.
> > find . Data_for_A_Pleasure_That_Hurts_replication.dta 

Data deposit
------------

> INSTRUCTIONS: Most deposits will be at openICPSR, but all need to be checked for complete metadata. Detailed guidance is at [https://aeadataeditor.github.io/aea-de-guidance/data-deposit-aea-guidance.html](https://aeadataeditor.github.io/aea-de-guidance/data-deposit-aea-guidance.html). 

### Requirements 

> INSTRUCTIONS: Check that these requirements are met. 

- [ ] Authors (with affiliations) are listed in the same order as on the paper

> INSTRUCTIONS: If any of the above are NOT checked, leave the related [REQUIRED] element here. Otherwise, delete the line.

> [REQUIRED] Please review the title of the openICPSR deposit as per our guidelines (below).

> [REQUIRED] Please review authors and affiliations on the openICPSR deposit. In general, they are the same, and in the same order, as for the manuscript; however, authors can deviate from that order.


### Deposit Metadata

> INSTRUCTIONS: Some of these are specific to openICPSR (JEL, Manuscript Number). Others may or may not be present at other trusted repositories (Dataverse, Zenodo, etc.). Verify all items for openICPSR, check with supervisor for other deposits.

- [ ] JEL Classification (required)
- [ ] Manuscript Number (required)
- [ ] Subject Terms (highly recommended)
- [ ] Geographic coverage (highly recommended)
- [ ] Time period(s) (highly recommended)
- [ ] Collection date(s) (suggested)
- [ ] Universe (suggested)
- [ ] Data Type(s) (suggested)
- [ ] Data Source (suggested)
- [ ] Units of Observation (suggested)

> INSTRUCTIONS: Go through the checklist above, and then choose ONE of the following results:

- [NOTE] openICPSR metadata is sufficient.

For additional guidance, see [https://aeadataeditor.github.io/aea-de-guidance/data-deposit-aea-guidance.html](https://aeadataeditor.github.io/aea-de-guidance/data-deposit-aea-guidance.html).

Data checks
-----------

> INSTRUCTIONS: When data are present, run checks:
> - can data be read (using software indicated by author)?
> - Is data in archive-ready formats (CSV, TXT) or in custom formats (DTA, SAS7BDAT, Rdata)? Note: Numbers and Mathematica data files are not considered archive-safe and cannot be accepted. 
> - Run check for PII ([PII_stata_scan.do](PII_stata_scan.do), sourced from [here](https://github.com/J-PAL/stata_PII_scan) if using Stata) and report results. Note: this check will have lots of false positives - fields it thinks might be sensitive that are not, in fact, sensitive. Apply judgement.


Code description
----------------
There are four provided Stata do files, three Matlab .m files, including a "master.do".

- Table 5: could not identify code that produces Table 5


Stated Requirements
---------------------

You should create an empty folder called "tables" within that folder; some of the tables will be outputted in that directory as .tex files in addition to being printed out in Stata.

- [ ] Software Requirements 
  - [ ] Stata
    - command outreg2. (run the following command in Stata: ssc install outreg2)

Computing Environment of the Replicator
---------------------

  > INSTRUCTIONS: This might be automated, for now, please fill in manually. Remove examples that are not relevant, adjust examples to fit special circumstances. Some of this is available from the standard log output in Stata or R. Some frequently used details are below. Some of these details can be found as follows:
>
> - (Windows) by right-clicking on "This PC"
> - (Mac) Apple-menu > "About this Mac"
> - (Linux) see code in `tools/linux-system-info.sh`

- Mac Laptop, MacOS 10.14.6, 8 GB of memory
- CISER Shared Windows Server 2019, 256GB, Intel Xeon E5-4669 v3 @ 2.10Ghz (3 processors)
- CISER Virtual Windows Server 2016, 16GB, Intel Haswell 2.19 Ghz (2 processors)
- BioHPC Linux server, Centos 7.6, 64 cores; 1024GB RAM; 

> INSTRUCTIONS: Please also list the software you used (specific versions). List only the ones you used, add any not listed in the examples:

- Stata/MP 14

Replication steps
-----------------

1. Downloaded the data file, the do file and the ado files and save in the same folder.
2. Crate a new folder named "tables"
3. Change the direction of the file in the do file. use YOURLOCATION, clear where YOURLOCATION is the specific location in your computer.
4. In many parts of the code you will find the following: "{outregpath}" substitute it by "YOURLOCATION\tables\" 
5. Install the packages outreg and outreg2. Use: ssc install outreg and ssc install outreg2
6. Run the ado files.
7. Run the do file. 

Findings
--------

> INSTRUCTIONS: Describe your findings both positive and negative in some detail, for each **Data Preparation Code, Figure, Table, and any in-text numbers**. You can re-use the Excel file created under *Code Description*. When errors happen, be as precise as possible. For differences in figures, provide both a screenshot of what the manuscript contains, as well as the figure produced by the code you ran. For differences in numbers, provide both the number as reported in the manuscript, as well as the number replicated. If too many numbers, contact your supervisor.

1. Cannot produce Table 3. 

### Data Preparation Code

Examples:

- Program `1-create-data.do` ran without error, output expected data
- Program `2-create-appendix-data.do` failed to produce any output.

### Tables

Examples:

- Table 1: Looks the same
- Table 2: (contains no data)
- Table 3: Minor differences in row 5, column 3, 0.003 instead of 0.3

### Figures

> INSTRUCTIONS: Please provide a comparison with the paper when describing that figures look different. Use a screenshot for the paper, and the graph generated by the programs for the comparison. Reference the graph generated by the programs as a local file within the repository.

Example:

- Figure 1: Looks the same
- Figure 2: no program provided
- Figure 3: Paper version looks different from the one generated by programs:

Paper version:
![Paper version](template/dog.jpg)

Figure 3 generated by programs:

![Replicated version](template/odie.jpg)

### In-Text Numbers

> INSTRUCTIONS: list page and line number of in-text numbers. If ambiguous, cite the surrounding text, i.e., "the rate fell to 52% of all jobs: verified".

[ ] There are no in-text numbers, or all in-text numbers stem from tables and figures.

[ ] There are in-text numbers, but they are not identified in the code

- Page 21, line 5: Same


Classification
--------------

> INSTRUCTIONS: Make an assessment here.
>
> Full reproduction can include a small number of apparently insignificant changes in the numbers in the table. Full reproduction also applies when changes to the programs needed to be made, but were successfully implemented.
>
> Partial reproduction means that a significant number (>25%) of programs and/or numbers are different.
>
> Note that if any data is confidential and not available, then a partial reproduction applies. This should be noted in the Reasons
>
> Note that when all data is confidential, it is unlikely that this exercise should have been attempted.
>
> Failure to reproduce: only a small number of programs ran successfully, or only a small number of numbers were successfully generated (<25%)

- [ ] full reproduction
- [ ] full reproduction with minor issues
- [ ] partial reproduction (see above)
- [ ] not able to reproduce most or all of the results (reasons see above)

### Reason for incomplete reproducibility

- [ ] `Discrepancy in output` (either figures or numbers in tables or text differ)
- [ ] `Bugs in code`  that  were fixable by the replicator (but should be fixed in the final deposit)
- [ ] `Code missing`, in particular if it  prevented the replicator from completing the reproducibility check
- [ ] `Code not functional` is more severe than a simple bug: it  prevented the replicator from completing the reproducibility check
- [ ] `Software not available to replicator`  may happen for a variety of reasons, but in particular (a) when the software is commercial, and the replicator does not have access to a licensed copy, or (b) the software is open-source, but a specific version required to conduct the reproducibility check is not available.
- [ ] `Insufficient time available to replicator` is applicable when (a) running the code would take weeks or more (b) running the code might take less time if sufficient compute resources were to be brought to bear, but no such resources can be accessed in a timely fashion (c) the replication package is very complex, and following all (manual and scripted) steps would take too long.
- [ ] `Data missing` is marked when data *should* be available, but was erroneously not provided, or is not accessible via the procedures described in the replication package


- [ ] `Data not available` is marked when data requires additional access steps, for instance purchase or application procedure. 
