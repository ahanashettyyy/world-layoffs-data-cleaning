#EXPLORATORY DATA ANALYSIS

SELECT * FROM layoffs_staging2;

SELECT MAX(TOTAL_LAID_OFF), MAX(percentage_laid_off) FROM layoffs_staging2;

SELECT * FROM layoffs_staging2 WHERE percentage_laid_off=1 ORDER BY total_laid_off DESC;

SELECT * FROM layoffs_staging2 WHERE percentage_laid_off=1 ORDER BY funds_raised_millions DESC;

SELECT COMPANY, SUM(TOTAL_LAID_OFF) FROM layoffs_staging2 GROUP BY COMPANY ORDER BY 2 DESC;

SELECT min(`date`), max(`date`) FROM layoffs_staging2;

SELECT industry, SUM(TOTAL_LAID_OFF) FROM layoffs_staging2 GROUP BY industry ORDER BY 2 DESC;

SELECT Country, SUM(TOTAL_LAID_OFF) FROM layoffs_staging2 GROUP BY COuntry ORDER BY 2 DESC;
SELECT year(`date`), SUM(TOTAL_LAID_OFF) FROM layoffs_staging2 GROUP BY year(`date`) ORDER BY 1 DESC;
SELECT month(`date`), SUM(TOTAL_LAID_OFF) FROM layoffs_staging2 GROUP BY month(`date`);

select substring(`date`,1,7) as `month`, sum(total_laid_off) from layoffs_staging2 ;
SELECT stage, SUM(TOTAL_LAID_OFF) FROM layoffs_staging2 GROUP BY stage ORDER BY 2 DESC;

SELECT company, SUM(percentage_laid_off) FROM layoffs_staging2 GROUP BY company ORDER BY 2 DESC;
#rolling total
with rolling_total as
(select substring(`date`,1,7) as `month`, sum(total_laid_off) as total_off from layoffs_staging2  where substring(`date`,1,7) is not null group by `month` order by 1 asc)
select `month`, total_off,
sum(total_off) over (order by `month`) as roll_total from rolling_total;

sELECT COMPANY, year(`date`),SUM(TOTAL_LAID_OFF) FROM layoffs_staging2 GROUP BY COMPANY,year(`date`) ORDER BY 3 desc;
#rank companys based on highest lay offs yearly
with company_year  (company,years,total_laid_off) as
(sELECT COMPANY, year(`date`) ,SUM(TOTAL_LAID_OFF) FROM layoffs_staging2 GROUP BY COMPANY,year(`date`) ),
company_year_rank as
(select *, dense_rank() over (partition by years order by total_laid_off desc) as `rank` from company_year where years is not null 
)
select * from company_year_rank where `rank`<=5;














