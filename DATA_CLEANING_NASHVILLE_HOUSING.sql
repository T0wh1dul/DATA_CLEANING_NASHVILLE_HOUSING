
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

			----------  OwnerAddress

select OwnerAddress
from PortfolioProject.dbo.Housing_data

select 
PARSENAME(replace(OwnerAddress,',','.'),3)
,PARSENAME(replace(OwnerAddress,',','.'),2)
,PARSENAME(replace(OwnerAddress,',','.'),1)
from PortfolioProject.dbo.Housing_data



--1
Alter table PortfolioProject.dbo.Housing_data
add OwnerSplitAddress NvArchar(255);

update PortfolioProject.dbo.Housing_data
set OwnerSplitAddress = PARSENAME(replace(OwnerAddress,',','.'),3)
--2

Alter table PortfolioProject.dbo.Housing_data
add OwnerSplitCity  NvArchar(255);

update PortfolioProject.dbo.Housing_data
set OwnerSplitCity= PARSENAME(replace(OwnerAddress,',','.'),2)

--3

Alter table PortfolioProject.dbo.Housing_data
add OwnerSplitState NvArchar(255);

update PortfolioProject.dbo.Housing_data
set OwnerSplitState = PARSENAME(replace(OwnerAddress,',','.'),1)


select *
from PortfolioProject.dbo.Housing_data

----------------------------------------------------------------

-- Changing Y and N to Yes and no in "Sold as vacant" Field


--select distinct(SoldAsVacant), COUNT(SoldAsVacant)
--From  PortfolioProject.dbo.Housing_data
--group by SoldAsVacant
--order by 2



select SoldAsVacant,
Case when SoldAsVacant = 'Y' then 'Yes'
	 When SoldAsVacant = 'N' then 'No'
	 else SoldAsVacant 
	 end
From  PortfolioProject.dbo.Housing_data


update PortfolioProject.dbo.Housing_data
set SoldAsVacant = Case when SoldAsVacant = 'Y' then 'Yes'
	 When SoldAsVacant = 'N' then 'No'
	 else SoldAsVacant 
	 end


	 -- for review
		select distinct(SoldAsVacant), COUNT(SoldAsVacant)
		From  PortfolioProject.dbo.Housing_data
		group by SoldAsVacant
		order by 2

-----------------------------------------------------------------------------------


----Removing Duplicates

With RowNumCTE AS(
select * ,
	ROW_NUMBER() over( 
	Partition by ParcelID,
			 PropertyAddress,
			 SalePrice,
			 SaleDate,
			 LegalReference
			 Order by 
			 UniqueID
			 ) Row_num

From  PortfolioProject.dbo.Housing_data

)

--delete
--from RowNumCTE
--where Row_num >1 
 
select * 
from RowNumCTE
where Row_num >1 
order by PropertyAddress



-----------------------------------------------------------------------------

-- Deleted unused columns -- 

--select *
--From  PortfolioProject.dbo.Housing_data

alter table PortfolioProject.dbo.Housing_data
drop column Owneraddress, TaxDistrict, PropertyAddress, SaleDate

select *
From  PortfolioProject.dbo.Housing_data