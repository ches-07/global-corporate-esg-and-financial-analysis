-- ============================================================
-- ESG DATABASE SETUP
-- ============================================================

CREATE DATABASE IF NOT EXISTS esg_db;

USE esg_db;


-- ============================================================
-- 1. STAGING TABLE
--    Raw CSV data is loaded here as TEXT.
-- ============================================================

DROP TABLE IF EXISTS stg_esg;

CREATE TABLE stg_esg (

    -- --------------------------------------------------------
    -- Company Identification
    -- --------------------------------------------------------

    domain       VARCHAR(110),
    company_name VARCHAR(150),
    ticker       VARCHAR(100),

    -- --------------------------------------------------------
    -- ESG Involvement
    -- --------------------------------------------------------

    involvement_alcohol                TEXT,
    involvement_adult_entertainment    TEXT,
    involvement_gambling               TEXT,
    involvement_tobacco                TEXT,
    involvement_animal_testing         TEXT,
    involvement_fur_leather             TEXT,
    involvement_controversial_weapons  TEXT,
    involvement_small_arms             TEXT,
    involvement_catholic_values        TEXT,
    involvement_gmo                    TEXT,
    involvement_military               TEXT,
    involvement_pesticides             TEXT,
    involvement_thermal_coal           TEXT,
    involvement_palm_oil               TEXT,

    -- --------------------------------------------------------
    -- Company Classification & Employees
    -- --------------------------------------------------------

    employees TEXT,
    industry  TEXT,
    sector    TEXT,

    -- --------------------------------------------------------
    -- Financial Health
    -- --------------------------------------------------------

    altman_score    TEXT,
    piotroski_score TEXT,

    -- --------------------------------------------------------
    -- ESG Controversies: High-Level Categories
    -- --------------------------------------------------------

    controversy_environment             TEXT,
    controversy_social                  TEXT,
    controversy_customers               TEXT,
    controversy_human_rights_community TEXT,
    controversy_labor_supply_chain      TEXT,
    controversy_governance              TEXT,

    -- --------------------------------------------------------
    -- Decarbonization Targets
    -- --------------------------------------------------------

    decarb_target_year              TEXT,
    decarb_target_comprehensiveness TEXT,
    decarb_target_ambition_pa       TEXT,
    decarb_target                   TEXT,
    decarb_target_temp_rise         TEXT,
    temperature_goal                TEXT,

    -- --------------------------------------------------------
    -- UN Sustainable Development Goals
    -- --------------------------------------------------------

    sdg_no_poverty              TEXT,
    sdg_no_hunger               TEXT,
    sdg_good_health             TEXT,
    sdg_quality_education       TEXT,
    sdg_gender_equality         TEXT,
    sdg_clean_water             TEXT,
    sdg_clean_energy            TEXT,
    sdg_decent_work             TEXT,
    sdg_industry_innovation     TEXT,
    sdg_reduced_inequalities    TEXT,
    sdg_sustainable_cities      TEXT,
    sdg_responsible_consumption TEXT,
    sdg_climate_action          TEXT,
    sdg_life_below_water        TEXT,
    sdg_life_on_land            TEXT,
    sdg_peace_justice           TEXT,
    sdg_partnerships            TEXT,

    -- --------------------------------------------------------
    -- Overall ESG Score
    -- --------------------------------------------------------

    esg_score TEXT,

    -- --------------------------------------------------------
    -- MSCI Involvement Indicators
    -- --------------------------------------------------------

    msci_controversial_weapons TEXT,
    msci_gambling              TEXT,
    msci_tobacco               TEXT,
    msci_alcohol               TEXT,

    -- --------------------------------------------------------
    -- Supply Chain / Labor
    -- --------------------------------------------------------

    controversy_supply_chain_labor TEXT,

    -- --------------------------------------------------------
    -- Aggregated / Legacy Fields
    -- --------------------------------------------------------

    `Controversies`          TEXT,
    `Decarbonization Target` TEXT,
    `Sdg`                    TEXT,

    -- --------------------------------------------------------
    -- Labor & Workplace Controversies
    -- --------------------------------------------------------

    controversy_collective_bargaining    TEXT,
    controversy_health_safety             TEXT,
    controversy_discrimination_diversity  TEXT,
    controversy_labor_management          TEXT,

    -- --------------------------------------------------------
    -- Involvement Aggregates
    -- --------------------------------------------------------

    `Involvement`      TEXT,
    `Involvement_Msci` TEXT,

    -- --------------------------------------------------------
    -- Detailed Controversy Categories
    -- --------------------------------------------------------

    controversy_anticompetitive          TEXT,
    controversy_privacy_data             TEXT,
    controversy_bribery_fraud            TEXT,
    controversy_governance_structures    TEXT,
    controversy_customer_relations      TEXT,
    controversy_product_safety           TEXT,
    controversy_human_rights             TEXT,
    controversy_energy_climate           TEXT,
    controversy_toxic_emissions          TEXT,
    controversy_local_communities        TEXT,
    controversy_biodiversity             TEXT,
    controversy_other                    TEXT,
    controversy_marketing                TEXT,
    controversy_civil_liberties          TEXT,
    controversy_operational_waste        TEXT,
    controversy_supply_chain             TEXT,
    controversy_water_stress             TEXT,
    controversy_child_labor              TEXT,
    controversy_controversial_investments TEXT

);


-- ============================================================
-- 2. LOAD RAW CSV DATA
-- ============================================================

LOAD DATA LOCAL INFILE
    'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\esg_metrics\\esg_clean.csv'
INTO TABLE stg_esg
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;


-- ============================================================
-- 3. PRODUCTION / CLEANED COMPANY TABLE
--    Numeric fields are converted from TEXT to numeric types.
-- ============================================================

DROP TABLE IF EXISTS esg_company;

CREATE TABLE esg_company (

    -- --------------------------------------------------------
    -- Primary Key & Company Identification
    -- --------------------------------------------------------

    company_id   BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    domain       VARCHAR(110),
    company_name VARCHAR(150),
    ticker       VARCHAR(100),

    -- --------------------------------------------------------
    -- ESG Involvement
    -- --------------------------------------------------------

    involvement_alcohol                TEXT,
    involvement_adult_entertainment    TEXT,
    involvement_gambling               TEXT,
    involvement_tobacco                TEXT,
    involvement_animal_testing         TEXT,
    involvement_fur_leather             TEXT,
    involvement_controversial_weapons  TEXT,
    involvement_small_arms             TEXT,
    involvement_catholic_values        TEXT,
    involvement_gmo                    TEXT,
    involvement_military               TEXT,
    involvement_pesticides             TEXT,
    involvement_thermal_coal           TEXT,
    involvement_palm_oil               TEXT,

    -- --------------------------------------------------------
    -- Company Classification & Employees
    -- --------------------------------------------------------

    employees DECIMAL(15,2),
    industry  TEXT,
    sector    TEXT,

    -- --------------------------------------------------------
    -- Financial Health
    -- --------------------------------------------------------

    altman_score     DECIMAL(10,3),
    piotroski_score DECIMAL(10,2),

    -- --------------------------------------------------------
    -- ESG Controversies: High-Level Categories
    -- --------------------------------------------------------

    controversy_environment             TEXT,
    controversy_social                  TEXT,
    controversy_customers               TEXT,
    controversy_human_rights_community TEXT,
    controversy_labor_supply_chain      TEXT,
    controversy_governance              TEXT,

    -- --------------------------------------------------------
    -- Decarbonization Targets
    -- --------------------------------------------------------

    decarb_target_year              DECIMAL(10,2),
    decarb_target_comprehensiveness DECIMAL(10,2),
    decarb_target_ambition_pa       DECIMAL(10,2),
    decarb_target                   TEXT,
    decarb_target_temp_rise         TEXT,
    temperature_goal                DECIMAL(5,2),

    -- --------------------------------------------------------
    -- UN Sustainable Development Goals
    -- --------------------------------------------------------

    sdg_no_poverty              TEXT,
    sdg_no_hunger               TEXT,
    sdg_good_health             TEXT,
    sdg_quality_education       TEXT,
    sdg_gender_equality         TEXT,
    sdg_clean_water             TEXT,
    sdg_clean_energy            TEXT,
    sdg_decent_work             TEXT,
    sdg_industry_innovation     TEXT,
    sdg_reduced_inequalities    TEXT,
    sdg_sustainable_cities      TEXT,
    sdg_responsible_consumption TEXT,
    sdg_climate_action          TEXT,
    sdg_life_below_water        TEXT,
    sdg_life_on_land            TEXT,
    sdg_peace_justice           TEXT,
    sdg_partnerships            TEXT,

    -- --------------------------------------------------------
    -- Overall ESG Score
    -- --------------------------------------------------------

    esg_score DECIMAL(10,2),

    -- --------------------------------------------------------
    -- MSCI Involvement Indicators
    -- --------------------------------------------------------

    msci_controversial_weapons TEXT,
    msci_gambling              TEXT,
    msci_tobacco               TEXT,
    msci_alcohol               TEXT,

    -- --------------------------------------------------------
    -- Supply Chain / Labor
    -- --------------------------------------------------------

    controversy_supply_chain_labor TEXT,

    -- --------------------------------------------------------
    -- Aggregated / Legacy Fields
    -- --------------------------------------------------------

    `Controversies`          TEXT,
    `Decarbonization Target` TEXT,
    `Sdg`                    TEXT,

    -- --------------------------------------------------------
    -- Labor & Workplace Controversies
    -- --------------------------------------------------------

    controversy_collective_bargaining   TEXT,
    controversy_health_safety            TEXT,
    controversy_discrimination_diversity TEXT,
    controversy_labor_management         TEXT,

    -- --------------------------------------------------------
    -- Involvement Aggregates
    -- --------------------------------------------------------

    `Involvement`      TEXT,
    `Involvement_Msci` TEXT,

    -- --------------------------------------------------------
    -- Detailed Controversy Categories
    -- --------------------------------------------------------

    controversy_anticompetitive           TEXT,
    controversy_privacy_data              TEXT,
    controversy_bribery_fraud             TEXT,
    controversy_governance_structures     TEXT,
    controversy_customer_relations        TEXT,
    controversy_product_safety            TEXT,
    controversy_human_rights              TEXT,
    controversy_energy_climate            TEXT,
    controversy_toxic_emissions           TEXT,
    controversy_local_communities         TEXT,
    controversy_biodiversity              TEXT,
    controversy_other                     TEXT,
    controversy_marketing                 TEXT,
    controversy_civil_liberties           TEXT,
    controversy_operational_waste         TEXT,
    controversy_supply_chain              TEXT,
    controversy_water_stress              TEXT,
    controversy_child_labor               TEXT,
    controversy_controversial_investments TEXT,

    -- --------------------------------------------------------
    -- Indexes
    -- --------------------------------------------------------

    INDEX idx_company_name (company_name),
    INDEX idx_ticker       (ticker),
    INDEX idx_domain       (domain)

)
ENGINE = InnoDB
ROW_FORMAT = DYNAMIC;


-- ============================================================
-- 4. MOVE DATA FROM STAGING TO PRODUCTION
--    Text fields are copied directly.
--    Empty fields are stored as NULL.
--    Numeric fields are converted from TEXT to DECIMAL.
--    Empty values are changed to NULL before conversion.
-- ============================================================


INSERT INTO esg_company (
    domain,
    company_name,
    ticker,
    involvement_alcohol,
    involvement_adult_entertainment,
    involvement_gambling,
    involvement_tobacco,
    involvement_animal_testing,
    involvement_fur_leather,
    involvement_controversial_weapons,
    involvement_small_arms,
    involvement_catholic_values,
    involvement_gmo,
    involvement_military,
    involvement_pesticides,
    involvement_thermal_coal,
    involvement_palm_oil,
    employees,
    industry,
    sector,
    altman_score,
    piotroski_score,
    controversy_environment,
    controversy_social,
    controversy_customers,
    controversy_human_rights_community,
    controversy_labor_supply_chain,
    controversy_governance,
    decarb_target_year,
    decarb_target_comprehensiveness,
    decarb_target_ambition_pa,
    decarb_target,
    decarb_target_temp_rise,
    temperature_goal,
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
    sdg_partnerships,
    esg_score,
    msci_controversial_weapons,
    msci_gambling,
    msci_tobacco,
    msci_alcohol,
    controversy_supply_chain_labor,
    `Controversies`,
    `Decarbonization Target`,
    `Sdg`,
    controversy_collective_bargaining,
    controversy_health_safety,
    controversy_discrimination_diversity,
    controversy_labor_management,
    `Involvement`,
    `Involvement_Msci`,
    controversy_anticompetitive,
    controversy_privacy_data,
    controversy_bribery_fraud,
    controversy_governance_structures,
    controversy_customer_relations,
    controversy_product_safety,
    controversy_human_rights,
    controversy_energy_climate,
    controversy_toxic_emissions,
    controversy_local_communities,
    controversy_biodiversity,
    controversy_other,
    controversy_marketing,
    controversy_civil_liberties,
    controversy_operational_waste,
    controversy_supply_chain,
    controversy_water_stress,
    controversy_child_labor,
    controversy_controversial_investments
)
SELECT
    NULLIF(TRIM(domain), ''),
    NULLIF(TRIM(company_name), ''),
    NULLIF(TRIM(ticker), ''),
    involvement_alcohol,
    involvement_adult_entertainment,
    involvement_gambling,
    involvement_tobacco,
    involvement_animal_testing,
    involvement_fur_leather,
    involvement_controversial_weapons,
    involvement_small_arms,
    involvement_catholic_values,
    involvement_gmo,
    involvement_military,
    involvement_pesticides,
    involvement_thermal_coal,
    involvement_palm_oil,
    CAST(NULLIF(TRIM(employees), '') AS DECIMAL(15,2)),
    industry,
    sector,
    CAST(NULLIF(TRIM(altman_score), '') AS DECIMAL(10,3)),
    CAST(NULLIF(TRIM(piotroski_score), '') AS DECIMAL(10,2)),
    controversy_environment,
    controversy_social,
    controversy_customers,
    controversy_human_rights_community,
    controversy_labor_supply_chain,
    controversy_governance,
    CAST(NULLIF(TRIM(decarb_target_year), '') AS DECIMAL(10,2)),
    CAST(NULLIF(TRIM(decarb_target_comprehensiveness), '') AS DECIMAL(10,2)),
    CAST(NULLIF(TRIM(decarb_target_ambition_pa), '') AS DECIMAL(10,2)),
    decarb_target,
    decarb_target_temp_rise,
    CAST(NULLIF(TRIM(temperature_goal), '') AS DECIMAL(5,2)),
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
    sdg_partnerships,
    CAST(NULLIF(TRIM(esg_score), '') AS DECIMAL(10,2)),
    msci_controversial_weapons,
    msci_gambling,
    msci_tobacco,
    msci_alcohol,
    controversy_supply_chain_labor,
    `Controversies`,
    `Decarbonization Target`,
    `Sdg`,
    controversy_collective_bargaining,
    controversy_health_safety,
    controversy_discrimination_diversity,
    controversy_labor_management,
    `Involvement`,
    `Involvement_Msci`,
    controversy_anticompetitive,
    controversy_privacy_data,
    controversy_bribery_fraud,
    controversy_governance_structures,
    controversy_customer_relations,
    controversy_product_safety,
    controversy_human_rights,
    controversy_energy_climate,
    controversy_toxic_emissions,
    controversy_local_communities,
    controversy_biodiversity,
    controversy_other,
    controversy_marketing,
    controversy_civil_liberties,
    controversy_operational_waste,
    controversy_supply_chain,
    controversy_water_stress,
    controversy_child_labor,
    controversy_controversial_investments
FROM stg_esg;


-- ============================================================
-- 5. SANITY CHECKS
--    Row counts should match; numeric columns should have no
--    silently-corrupted values (i.e. non-empty TEXT that failed
--    to cast and became NULL).
-- ============================================================

SELECT
    (SELECT COUNT(*) FROM stg_esg)     AS staging_rows,
    (SELECT COUNT(*) FROM esg_company) AS production_rows;

SELECT COUNT(*) AS bad_employees
FROM stg_esg
WHERE TRIM(employees) <> ''
  AND NULLIF(TRIM(employees), '') IS NOT NULL
  AND TRIM(employees) NOT REGEXP '^-?[0-9]+(\\.[0-9]+)?$';

SELECT COUNT(*) AS bad_esg_score
FROM stg_esg
WHERE TRIM(esg_score) <> ''
  AND TRIM(esg_score) NOT REGEXP '^-?[0-9]+(\\.[0-9]+)?$';