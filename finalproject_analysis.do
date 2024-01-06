********************************************************************
* GLM Final Project -- Data Analysis
********************************************************************

cd "" //change your directory
use NELS88_cleaned, clear //this dataset should be stored in your directory
browse

* Descriptive stataistics & Bivariate relationships
tab control
tab control, nolabel

tab control gender
tab control reading
tab control math
tabstat SES, stat(n mean sd min max) by(control)
tabstat selfconcept, stat(n mean sd min max) by(control)

* Conduct ordinal logistic regression
ologit control gender reading math selfconcept SES
ologit control gender reading math selfconcept SES, or

//listcoef, help
//listcoef, help percent

* Proportional odds assumption
omodel logit control gender reading math selfconcept SES
	* OH NO! Didn't meet assumption. Change of plans
	
* Conduct generalized ordinal logistic regression
gologit2 control gender reading math selfconcept SES, pl lrforce store(constrained) or
gologit2 control gender reading math selfconcept SES, npl lrforce store(unconstrained) or
lrtest constrained unconstrained

* Plots
* self concept:
margins, at(selfconcept=(-3(0.5)1)) predict(outcome(0)) atmeans
	marginsplot, name(StronglyAgree, replace) title(Strongly Agree) xtitle(Self Concept) ///
	ytitle(Strongly Agree)
margins, at(selfconcept=(-3(0.5)1)) predict(outcome(1)) atmeans
	marginsplot, name(Agree, replace) title(Agree) xtitle(Self Concept) ///
	ytitle(Agree)
margins, at(selfconcept=(-3(0.5)1)) predict(outcome(2)) atmeans
	marginsplot, name(Disagree, replace) title(Disagree) xtitle(Self Concept) ///
	ytitle(Disagree)
margins, at(selfconcept=(-3(0.5)1)) predict(outcome(3)) atmeans
	marginsplot, name(StronglyDisagree, replace) title(Strongly disagree) xtitle(Self Concept) ///
	ytitle(Strongly disagree)
graph combine StronglyAgree Agree Disagree StronglyDisagree, ycommon
	graph export selfconcept.pdf, replace
	
* reading:
margins, at(reading=(0(1)2)) predict(outcome(0)) atmeans
	marginsplot, name(StronglyAgree, replace) title(Strongly Agree) xtitle(Reading) ///
	ytitle(Strongly Agree)
margins, at(reading=(0(1)2)) predict(outcome(1)) atmeans
	marginsplot, name(Agree, replace) title(Agree) xtitle(Reading) ///
	ytitle(Agree)
margins, at(reading=(0(1)2)) predict(outcome(2)) atmeans
	marginsplot, name(Disagree, replace) title(Disagree) xtitle(Reading) ///
	ytitle(Disagree)
margins, at(reading=(0(1)2)) predict(outcome(3)) atmeans
	marginsplot, name(StronglyDisagree, replace) title(Strongly disagree) xtitle(Reading) ///
	ytitle(Strongly disagree)
graph combine StronglyAgree Agree Disagree StronglyDisagree, ycommon
	graph export reading.pdf, replace



















