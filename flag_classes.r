scores = read.csv("nm_ajc_results.csv", header=T, sep=",")

# For each state, grade, cohort and year, we created a linear regression model, weighted by the 
# number of students in a class
scoresToFit = subset(scores, grade==5 & test_year==2011 & subject == 'read')
fit = lm(scoresToFit$ss2 ~ scoresToFit$ss1, weights= (scoresToFit$n1 + scoresToFit$n2))

# studentized residuals with t-test
# rstandard returns regular studentized residuals
resid_z = rstandard(fit)
# tbd: may be more standard to use rstudent here
resid_t = studres(fit)
# calculate P( |t| >= resid_t, df = n1 - 1 ), a two-tail test
p.value = 2 *  pt(abs(resid_t),df=scoresToFit$n1-1)
tprob = 2 * (1 - pt(abs(resid_t),df=scoresToFit$n1-1))
# tprob represents the chance probability of each year-two score
# R library functions: 

# rstandard - standardized residuals: uses population standard
# deviation (result not used here)

# studres - In regression analysis, the standard errors of the
# estimators at different data points vary (compare the middle versus
# endpoints of a simple linear regression), and thus one must divide
# the different residuals by different estimates for the error,
# yielding what are called studentized residuals. (does not use
# population standard deviation)
