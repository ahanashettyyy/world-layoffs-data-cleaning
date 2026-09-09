#data cleaning
select * from layoffs;

#remove duplicates
#standardize data
#Null values n blank values
#remove any columns

create table layoffs_staging like layoffs;
select * from layoffs_staging;
insert layoffs_staging select * from layoffs;
select * from layoffs_staging;

#finding duplicates:(adding rows numbers by grouping based on partition parameters, if greater than 1 row number means duplicates of that row exists)
select * 
,row_number() over( partition by company,industry,total_laid_off, percentage_laid_off, `date`)
 as row_num 
 from layoffs_staging;
 
 #cte to find duplicates using above query
 with duplicate_cte as 
 (select * 
,row_number() over( partition by company,location,industry,total_laid_off, percentage_laid_off, `date`,stage,country, funds_raised_millions)
 as row_num 
 from layoffs_staging
 )
 select * from duplicate_cte where row_num>1;
 
 
 select * from layoffs_staging where company='casper';
 
 #this below wont work cus ctes are not updatable
 with duplicate_cte as 
 (select * 
,row_number() over( partition by company,location,industry,total_laid_off, percentage_laid_off, `date`,stage,country, funds_raised_millions)
 as row_num 
 from layoffs_staging
 )
 delete from duplicate_cte where row_num>1;
 
 #so we create a third table as the row number n grouped table and do further deletion on it
 
 CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

 
 select * from layoffs_staging2;
 
 insert into layoffs_staging2 
 select * 
 ,row_number() 
 over( partition by company,location,industry,total_laid_off, percentage_laid_off, `date`,stage,country, funds_raised_millions)
 as row_num 
 from layoffs_staging;
 
select * from layoffs_staging2 where row_num>1;
  
delete from layoffs_staging2 where row_num>1;

#duplicates deleted


#standardizing data

select distinct(company) from layoffs_staging2;
select company, trim(company) from layoffs_staging2;
select distinct(trim(company)) from layoffs_staging2;
#removing extra whitespaces before company names
update layoffs_staging2
set company=trim(company);

select distinct(company) from layoffs_staging2;

select distinct industry from layoffs_staging2 order by industry;
select * from layoffs_staging2 where industry like 'crypto%';
#found multiple industrys called crypto n cryptocurrrency but both of them are the same
update layoffs_staging2 
set industry='Crypto' 
where industry like 'crypto%';

select * from layoffs_staging2 where industry like 'crypto%';

select distinct industry from layoffs_staging2 order by industry;

 select distinct(location) from layoffs_staging2 order by 1;
 #no correction
 
 
select distinct(country) from layoffs_staging2 order by 1;
#error in united states written as "united states."
select distinct(country) from layoffs_staging2 where country like 'united states%';

update layoffs_staging2 
set country='United States' 
where country like 'united states%';

select distinct(country) from layoffs_staging2 where country like 'united states%';

#date is text type. convert to date
select `date`, str_to_date(`date`,'%m/%d/%Y')
from layoffs_staging2; 

update layoffs_staging2 
set `date`= str_to_date(`date`,'%m/%d/%Y');

select * from layoffs_staging2;

alter table layoffs_staging2 
modify column `date` DATE;


#standardization done


#remove null n blank

select * from layoffs_staging2 where total_laid_off is NULL and percentage_laid_off is null;

select * from layoffs_staging2 where industry is null or industry='';
select * from layoffs_staging2  where company ="airbnb";
#found two records of companies in same loc having null under industry in secondth record

select * from layoffs_staging2 t1 join layoffs_staging2 t2
 on t1.company=t2.company where( t1.industry is NULL or t1.industry='') and t2.industry is not null;
 
UPDATE layoffs_staging2
SET industry ='travel'
WHERE company = 'Airbnb'
  AND location = 'SF Bay Area';
  
#but we need to fix this for all other companys where its happening. so general way to do it:
update layoffs_staging2 t1 join
layoffs_staging2 t2 on t1.company=t2.company 
set t1.industry= t2.industry where (t1.industry IS NULL OR t1.industry='')
and t2.industry is not null;
#didnt work

  



UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
    ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE (t1.industry IS NULL OR t1.industry = '')
  AND t2.industry IS NOT NULL;
  
  
  SELECT
    t1.company,
    t1.industry AS t1_industry,
    t2.industry AS t2_industry
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
    ON t1.company = t2.company
WHERE (t1.industry IS NULL OR t1.industry = '')
AND t2.industry IS NOT NULL;

UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
    ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE (t1.industry IS NULL OR t1.industry = '')
AND t2.industry IS NOT NULL
AND t2.industry <> '';


  SELECT
    t1.company,
    t1.industry AS t1_industry,
    t2.industry AS t2_industry
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
    ON t1.company = t2.company
WHERE (t1.industry IS NULL OR t1.industry = '')
AND t2.industry IS NOT NULL;


select * from layoffs_staging2 where industry is null or industry='';
select * from layoffs_staging2  where company  like "Bally's%";

#deleting data

select * from layoffs_staging2 where total_laid_off is NULL and percentage_laid_off is null;


#gon delete date that has null in both total_laid_off and percentage_laid_off because its of no use in this dataset

delete from layoffs_staging2 where total_laid_off is NULL and percentage_laid_off is null;


select * from layoffs_staging2 ;

alter table layoffs_staging2
drop column row_num;



#FINAL CLEANED DATA:
select * from layoffs_staging2 ;

