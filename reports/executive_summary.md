# Google Play Store Growth Analytics — Executive Summary

**Question:** Which category, pricing, and app design choices maximize the odds of
reaching 1M+ installs for a new Android app launch?

**Approach:** Analyzed 9,658 unique apps using SQL, statistical hypothesis testing,
and machine learning.

**Key findings:**
1. Category matters enormously — success rates range from 4.6% (Medical) to 83.7%
   (Entertainment), an 18x gap (p < 0.001).
2. Free apps succeed far more than paid apps (37.9% vs 0-4.8%, p < 0.001).
3. Apps updated within 30 days succeed 3x more often than apps untouched for a year.
4. Larger apps succeed more often, reversing the initial hypothesis that smaller
   apps install faster.
5. A Random Forest model using only pre-launch factors predicts success with
   ROC-AUC 0.828, confirming category, size, and update recency as the top drivers.

**Recommendation:** Launch a free app in Entertainment, sized near the 75th
percentile for the category, updated at least monthly.

**Estimated impact:** Predicted success probability rises from 45.5% to 75.0%
(95% CI: [28.5%, 30.5%] uplift) versus a typical, unoptimized launch.

**Next step:** Validate with a Google Play Console store-listing A/B test
(4,432 visitors/arm, 8,865 total, 80% power) before committing to a full launch.
