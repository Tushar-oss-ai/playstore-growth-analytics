Cell 4: overall market snapshot
q("""
SELECT COUNT(*)                                        AS total_apps,
       SUM(Success)                                    AS successful_apps,
       ROUND(100.0 * AVG(Success), 1)                  AS success_rate_pct,
       ROUND(AVG(Rating), 2)                           AS avg_rating,
       SUM(CASE WHEN Price = 0 THEN 1 ELSE 0 END)      AS free_apps
FROM apps
""")

Cell 5: success rate by category (H1)
q("""
SELECT Category,
       COUNT(*)                                        AS n_apps,
       SUM(Success)                                    AS n_success,
       ROUND(100.0 * AVG(Success), 1)                  AS success_rate_pct,
       ROUND(AVG(Rating), 2)                           AS avg_rating
FROM apps
GROUP BY Category
HAVING COUNT(*) >= 50
ORDER BY success_rate_pct DESC
""")

Cell 6: winner-takes-all check (H5)
q("""
WITH ranked AS (
    SELECT Category,
           Installs,
           ROW_NUMBER() OVER (PARTITION BY Category ORDER BY Installs DESC) AS rnk,
           SUM(Installs) OVER (PARTITION BY Category) AS category_total_installs
    FROM apps
)
SELECT Category,
       COUNT(*) AS n_apps,
       ROUND(100.0 * SUM(CASE WHEN rnk <= 10 THEN Installs ELSE 0 END)
             / MAX(category_total_installs), 1) AS top10_share_pct
FROM ranked
GROUP BY Category
HAVING COUNT(*) >= 50
ORDER BY top10_share_pct DESC
""")

Cell 7: free vs paid (H2)
q("""
SELECT Price_Bucket,
       COUNT(*)                            AS n_apps,
       ROUND(100.0 * AVG(Success), 1)      AS success_rate_pct,
       ROUND(AVG(Rating), 2)               AS avg_rating
FROM apps
GROUP BY Price_Bucket
ORDER BY success_rate_pct DESC
""")

Cell 8: update recency (H3)
q("""
SELECT Update_Bucket,
       COUNT(*)                            AS n_apps,
       ROUND(100.0 * AVG(Success), 1)      AS success_rate_pct
FROM apps
GROUP BY Update_Bucket
ORDER BY 
  CASE Update_Bucket
    WHEN '<=30d' THEN 1 WHEN '31-90d' THEN 2 WHEN '91-180d' THEN 3
    WHEN '181-365d' THEN 4 ELSE 5
  END
""")

Cell 9: app size (H4)
q("""
SELECT Size_Bucket,
       COUNT(*)                            AS n_apps,
       ROUND(100.0 * AVG(Success), 1)      AS success_rate_pct
FROM apps
WHERE Size_Bucket IS NOT NULL
GROUP BY Size_Bucket
ORDER BY 
  CASE Size_Bucket
    WHEN '<5MB' THEN 1 WHEN '5-15MB' THEN 2 WHEN '15-30MB' THEN 3
    WHEN '30-60MB' THEN 4 ELSE 5
  END
""")