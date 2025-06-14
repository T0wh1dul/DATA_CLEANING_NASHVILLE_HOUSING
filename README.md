**Nashville Housing Data Cleaning Project**
This repository contains SQL scripts used to clean and transform raw housing data for Nashville, Tennessee. The goal of this project is to prepare the dataset for further analysis or reporting by addressing common data quality issues such as inconsistent date formats, missing values, duplicate records, and unstandardized text fields.

**Project Overview**
Data cleaning is a crucial step in any data analysis pipeline. This project demonstrates practical SQL techniques for cleaning a real-world dataset. The provided SQL code systematically tackles various data inconsistencies, making the data more reliable and ready for consumption by business intelligence tools or machine learning models.

**Dataset**
The dataset used in this project is named Housing_data and is assumed to reside in a database named PortfolioProject. It contains various attributes related to housing properties in Nashville, including ParcelID, PropertyAddress, SaleDate, SalePrice, OwnerAddress, SoldAsVacant, and more.

**SQL Scripts**
The primary SQL script for this project is embedded within this README. It performs a series of data cleaning operations in a sequential manner.

**Key Transformations Performed**
The SQL code performs the following cleaning and transformation steps:

1. Standardize Date Format
Converts the SaleDate column to a consistent Date format.
Adds a new column SaleDateConverted to store the standardized date.
2. Populate Property Address Data
Identifies and populates PropertyAddress fields where they are NULL by looking for matching ParcelID values in other records. This assumes that properties with the same ParcelID should have the same PropertyAddress.
3. Break Out Address into Individual Columns
Property Address: Splits the PropertyAddress into PropretySplitAddress (street address) and PropretySplitCity (city) using string manipulation functions (SUBSTRING, CHARINDEX).
Owner Address: Splits the OwnerAddress into OwnerSplitAddress (street address), OwnerSplitCity (city), and OwnerSplitState (state) using PARSENAME for more robust parsing of comma-separated values.
4. Change 'Y' and 'N' to 'Yes' and 'No' in "Sold as Vacant" Field
Standardizes the SoldAsVacant column values from 'Y'/'N' to 'Yes'/'No' for better readability and consistency.
5. Remove Duplicates
Identifies and removes duplicate rows based on a set of key columns (ParcelID, PropertyAddress, SalePrice, SaleDate, LegalReference) using a Common Table Expression (CTE) and ROW_NUMBER().
6. Delete Unused Columns
Drops redundant or unnecessary columns (OwnerAddress, TaxDistrict, PropertyAddress, SaleDate) after their information has been extracted or transformed into new, more usable columns.

**How to Use**
To replicate these cleaning steps:

**Database Setup:** Ensure you have a SQL Server database named PortfolioProject and a table named Housing_data populated with your raw data.
**Execute SQL:** Run the provided SQL script in your SQL Server Management Studio (SSMS) or any compatible SQL client. Execute each section sequentially to ensure proper data transformation.
Future Enhancements
**Error Handling:** Add TRY-CATCH blocks for more robust error handling during updates and alterations.
Performance Optimization: For very large datasets, consider indexing relevant columns before performing updates and joins to improve performance.
Data Validation: Implement checks to validate data quality after transformations (e.g., ensuring all addresses are non-null).
**ETL Pipeline:** Integrate these scripts into a larger ETL (Extract, Transform, Load) pipeline for automated data processing.
Contributing
Feel free to fork this repository, suggest improvements, or open issues. Any contributions are welcome!

**License**
This project is open-source and available under the MIT License.
