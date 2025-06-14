select * 
from PortfolioProject.dbo.Housing_data

-- Standardize the date format 
select SaleDateConverted, Convert(Date,SaleDate)
from PortfolioProject.dbo.Housing_data

update PortfolioProject.dbo.Housing_data
set SaleDate = CONVERT(date,Saledate)

Alter table housing_data
add SaleDateConverted date;

update PortfolioProject.dbo.Housing_data
set SaleDateConverted = CONVERT(date,Saledate)

--------------------------------------------------------
--Porpulate Property Address date,

select *
from PortfolioProject.dbo.Housing_data
order by ParcelID



select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress,  ISNULL(a.propertyAddress,b.PropertyAddress)
from PortfolioProject.dbo.Housing_data a
join PortfolioProject.dbo.Housing_data b
	on a.ParcelID = b.ParcelID
	and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null 

update a
Set PropertyAddress = ISNULL(a.propertyAddress,b.PropertyAddress)
from PortfolioProject.dbo.Housing_data a
join PortfolioProject.dbo.Housing_data b
	on a.ParcelID = b.ParcelID
	and a.[UniqueID ] <> b.[UniqueID ]

	-----------------------------------------------------------------------+
--braeking out address into individual column (address, city, State)

select PropertyAddress
from PortfolioProject.dbo.Housing_data
--order by ParcelID

select 
SUBSTRING( PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1) as Address
, SUBSTRING( PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress)) as Address

from PortfolioProject.dbo.Housing_data


Alter table PortfolioProject.dbo.Housing_data
add PropretySplitAddress NvArchar(255);

update PortfolioProject.dbo.Housing_data
set PropretySplitAddress = SUBSTRING( PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1)

Alter table PortfolioProject.dbo.Housing_data
add PropretySplitCity  NvArchar(255);

update PortfolioProject.dbo.Housing_data
set PropretySplitCity= SUBSTRING( PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress))


select *
from PortfolioProject.dbo.Housing_data
