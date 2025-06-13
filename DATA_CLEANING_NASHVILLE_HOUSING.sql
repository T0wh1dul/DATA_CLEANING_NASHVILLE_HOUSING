select * 
from PortfolioProject.dbo.Housing_data

-- Standardize the date format 
select SaleDateConverted, Convert(Date,SaleDate)
from PortfolioProject.dbo.Housing_data

update Housing_data
set SaleDate = CONVERT(date,Saledate)

Alter table housing_data
add SaleDateConverted date;

update Housing_data
set SaleDateConverted = CONVERT(date,Saledate)

--------------------------------------------------------
--Porpulate Property Address date,

select *
from PortfolioProject.dbo.Housing_data
--where PropertyAddress is null 
order by ParcelID



select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress,  ISNULL(a.propertyAddress,b.PropertyAddress)
from PortfolioProject.dbo.Housing_data a
join PortfolioProject.dbo.Housing_data b
	on a.ParcelID = b.ParcelID
	and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null 