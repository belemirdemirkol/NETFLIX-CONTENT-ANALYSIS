# Netflix Content Analysis

An end-to-end data analysis project exploring the Netflix catalogue: what kind of content Netflix offers, where it comes from, and how the catalogue has grown over time.

I built this project to practise a full analysis workflow on a real dataset: cleaning data in SQL, continuing the work in Python, and turning the results into charts and written insights.

## Dataset

**Netflix Movies and TV Shows** (Kaggle): 8,807 titles and 12 columns, including type, title, director, cast, country, date added, release year, rating, duration, genres and description. The data runs until 25 September 2021.

## Tools

- **SQL (PostgreSQL, DBeaver):** data quality checks, cleaning and first analysis questions
- **Python (Pandas, NumPy):** further cleaning and feature engineering
- **Matplotlib & Seaborn:** visualisation
- **Jupyter Notebook**

## Project Structure

```
NETFLIX-CONTENT-ANALYSIS/
├── data/        # raw dataset
├── sql/         # data quality check, cleaning and analysis queries
└── notebooks/   # netflix_analysis.ipynb
```

## Process

1. **SQL cleaning:** fixed rating values that had shifted into the wrong column, filled missing text values with "unknown" and converted `date_added` to a date. Answered 6 questions in SQL.
2. **Python cleaning:** loaded the clean table from PostgreSQL, checked for duplicates and converted dates. Missing dates were left empty rather than filled, to avoid creating false information.
3. **Feature engineering:** extracted year and month added, split duration into a number (minutes for movies, seasons for TV shows), grouped ratings into age groups, and split multi-value country and genre cells into separate tables.
4. **Analysis & visualisation:** 9 questions, each with a chart and a written insight.

## Questions

1. Are there more movies or TV shows on Netflix?
2. How has the amount of content added to Netflix changed over the years?
3. In which months is more content added to Netflix?
4. Which age groups do movies and TV shows target?
5. Which countries produce the most content? (Top 10)
6. What are the most common genres? (Top 10)
7. How long are movies usually? (Duration in minutes)
8. How many seasons do TV shows usually have?
9. What are the most common genres in the top 5 countries? (Top 3 genres per country)

## Key Findings

- About **70% of the catalogue is movies** (6,131) and 30% TV shows (2,676).
- Real growth started **after 2016**; movie additions peaked in **2019** (1,424).
- There is **no strong seasonal pattern** in when content is added.
- **Adults** is the largest age group, but TV shows lean younger: 17.4% target Kids, compared with 7.2% of movies.
- The **United States** appears in 3,690 titles, more than three times India (1,046).
- **Dramas** is the only genre in the top 3 of all five leading countries.
- Half of all movies last **87–114 minutes**, and at least half of TV shows have **only one season**.

## Limitations

- The data ends in September 2021, so 2021 is an incomplete year.
- 831 titles with unknown country were excluded from the country analyses.
- Co-productions and titles with several genres are counted once for each country and genre.
- All results are based on the number of titles, not viewing time.

## How to Run

1. Load the dataset from `data/` into PostgreSQL and run the SQL scripts in `sql/`.
2. Open `notebooks/netflix_analysis.ipynb`.
3. In the connection cell, replace `YOUR_PASSWORD` with your own PostgreSQL password.
