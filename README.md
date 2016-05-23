# AJC School Cheating Analysis Applied To New Mexico

In March 2012 the Atlanta Journal Consitituion ran a series titled, Cheating our children: Suspicious school test scores across the nation.  It included an interactive data browser which allowed you to browse for statistical aberations like what they saw when they uncovered the massive cheating in Atlanta schools.  That scandal led to a prison term for Beverly La-Forte Hall, a member of the notorious family of Eli Broad 'academy' superintendents. I asked for and they sent me the New Mexico subset of the data behind their browser.  I did this because the browser had limitations which prevented me from drilling down to individual schools.

That was three years ago but I still have the R script I used to replicate their results and drill down to individual classes at individual schools in New Mexico.  That R script and a compressed version of the data set are in this repository.

I believe the data covers school years 2008-2012.  The analysis requires nothing more complicated than a linear model and some statistical hypothesis testing.  The methodology was described on the AJC web site at the time (http://www.ajc.com/news/news/local/cheating-our-children-the-ajcs-methodology-behind-/nQSTN/) and a third party statisiician had 'peer reviewed' the methodology to certify that it is sound.  While the statistics may be sound the error bars in the data collection process are so large that the data is meaningless as a political policy tool yet that is exactly how it is typically used.

The modeling is rather simple: create a linear model fit of the next year's scores based upon this year's scores.  Assume the change in scores is normally distributed.  Use a 2-tailed student's t test with 95% confidence to flag outliers.  Then look for improbable clusters of unusual score changes within districts by calculating the probability that a district would, by random chance, have a number of flagged classes in a year, given the district’s total number of classes and the percentage of classes flagged statewide.

When I drilled down on the statewide data I found that the Gadsden school district had the most statistically improbable improvements in test scores.  (Gadsden is a region in SE New Mexico named after the Gadsden Purchase rather than after any town or county found there.) Curiously, the principal of that district was a State senator.  I don't know much else about the district other than it had a large student population for a NM district (12,000 students??) and it is supposed to be rural, made by merging smaller districts from a number of spread out towns.  Note that 'statistically improbable' does not mean impossible.  This particular district simply stood out as an outlier.

I was also interested in specific schools in Santa Fe.  During 2011, grade 4 at Gonzales Elementary School was a noticable outlier, standing out for how much scores _dropped_ (in math, for example, from a scaled score of 43.3 to 32.8).  Wood Gormley saw the largest increase.  This is as expected.  Wood Gormley attracts parents who believe in the the system of ranking schools by test scores and have the resources to buy real estate within the school's attendance boundary.  These parents take standardized tests seriously and push their children to score high on the tests.

At the time I ran this analysis you could download the necessary data from the Public Education Department's web site (though I got the data from the AJC).  The method for calculating scale scores was changed in NM around 2012 which would make the analysis more questionable if it crossed that transition year.  In the 2014 school year the state switched from the NMSBA tests to PARCC tests so you'd have similar problems using this analysis across the 2013-2014 transition.

To look at data for one school district, do something like this (71 is Santa Fe Schools):

   ```sfIdx = scores$district_id == 71```

then,

   sum(scores$flagged_t95[sfIdx])/sum(sfIdx)
