**Nashville Housing Data Cleaning Project**
This repository contains SQL scripts used to clean and transform raw housing data for Nashville. 
**The goal of this project** is to prepare the dataset for further analysis or reporting common data quality issues such as **inconsistent date formats, missing values, duplicate records, and unstandardized text fields.**

**Project Overview**
Data cleaning is a crucial step in any data analysis. This project shows that SQL Queries for cleaning a real-world dataset. The provided SQL code tackles various data inconsistencies, making the data more reliable and ready for consumption by business intelligence tools.

**Dataset**
The dataset used in this project is named Housing_data and database named PortfolioProject. It contains various attributes related to housing in Nashville, including ParcelID, PropertyAddress, SaleDate, SalePrice, OwnerAddress, SoldAsVacant, and more.

**Key Transformations SQL QUERIES**
The SQL code which is following cleaning and transformation steps:

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

