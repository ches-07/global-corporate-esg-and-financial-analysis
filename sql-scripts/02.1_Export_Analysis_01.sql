-- =============================================================================
-- ESG Analysis Dataset – Complete Records Only
-- Purpose: Extract companies with full ESG, financial, and SDG data.
-- Output:  esg_analysis_01.csv
-- =============================================================================
USE esg_db;

SELECT
    company_name,
    ticker,
    employees,
    esg_score,
    piotroski_score,
    altman_score,
    
    
    -- SDG indicators (all must be non NULL and non empty)
    sdg_no_poverty,
    sdg_no_hunger,
    sdg_good_health,
    sdg_quality_education,
    sdg_gender_equality,
    sdg_clean_water,
    sdg_clean_energy,
    sdg_decent_work,
    sdg_industry_innovation,
    sdg_reduced_inequalities,
    sdg_sustainable_cities,
    sdg_responsible_consumption,
    sdg_climate_action,
    sdg_life_below_water,
    sdg_life_on_land,
    sdg_peace_justice,
    sdg_partnerships
FROM
    esg_company
WHERE
    -- Core scores must be present
    esg_score IS NOT NULL
    AND employees IS NOT NULL
    AND piotroski_score IS NOT NULL
    AND altman_score IS NOT NULL
     
    
    -- All SDG fields must have meaningful (non empty) values
    AND NULLIF(TRIM(sdg_no_poverty), '') IS NOT NULL
    AND NULLIF(TRIM(sdg_no_hunger), '') IS NOT NULL
    AND NULLIF(TRIM(sdg_good_health), '') IS NOT NULL
    AND NULLIF(TRIM(sdg_quality_education), '') IS NOT NULL
    AND NULLIF(TRIM(sdg_gender_equality), '') IS NOT NULL
    AND NULLIF(TRIM(sdg_clean_water), '') IS NOT NULL
    AND NULLIF(TRIM(sdg_clean_energy), '') IS NOT NULL
    AND NULLIF(TRIM(sdg_decent_work), '') IS NOT NULL
    AND NULLIF(TRIM(sdg_industry_innovation), '') IS NOT NULL
    AND NULLIF(TRIM(sdg_reduced_inequalities), '') IS NOT NULL
    AND NULLIF(TRIM(sdg_sustainable_cities), '') IS NOT NULL
    AND NULLIF(TRIM(sdg_responsible_consumption), '') IS NOT NULL
    AND NULLIF(TRIM(sdg_climate_action), '') IS NOT NULL
    AND NULLIF(TRIM(sdg_life_below_water), '') IS NOT NULL
    AND NULLIF(TRIM(sdg_life_on_land), '') IS NOT NULL
    AND NULLIF(TRIM(sdg_peace_justice), '') IS NOT NULL
    AND NULLIF(TRIM(sdg_partnerships), '') IS NOT NULL
;