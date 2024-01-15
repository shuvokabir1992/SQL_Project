select

market_st.ZoneCode,

market_st.ZoneName,

market_st.RegeionCode,

market_st.RegeionName,

market_st.MarketCode,

market_st.MarketName,

ProductCategory.ProductCategoryName,

ProductCategory.BusinessNature,

 

SUM(Bud_TB.Budget) AS Budget,

SUM(Sal_TB.Sales) AS Sales

 

from ((

 

select SalesProduct.MarketId,SalesProduct.ProductId,SUM(SalesProduct.SaleQuantity*SalesProduct.FreeQuantity) AS Sales

from IrisNetSD_HPL.dbo.SalesProduct

Where SalesProduct.SaleDate between '1 JAN 2022' and '31 DEC 2022'

Group by SalesProduct.MarketId,SalesProduct.ProductId

 

) AS Sal_TB

 

full join (

 

select SalesBudgetMonthwiseMarket.MarketId,SalesBudgetMonthwiseMarket.ProductId,

SUM(

 

SalesBudgetMonthwiseMarket.QuantityMonth01*SalesBudgetYearlyMonthlyProductTP.JanUnitTP

+ SalesBudgetMonthwiseMarket.QuantityMonth02*SalesBudgetYearlyMonthlyProductTP.FebUnitTP

+ SalesBudgetMonthwiseMarket.QuantityMonth03*SalesBudgetYearlyMonthlyProductTP.MarUnitTP

+ SalesBudgetMonthwiseMarket.QuantityMonth04*SalesBudgetYearlyMonthlyProductTP.AprUnitTP

+ SalesBudgetMonthwiseMarket.QuantityMonth05*SalesBudgetYearlyMonthlyProductTP.MayUnitTP

+ SalesBudgetMonthwiseMarket.QuantityMonth06*SalesBudgetYearlyMonthlyProductTP.JunUnitTP

+ SalesBudgetMonthwiseMarket.QuantityMonth07*SalesBudgetYearlyMonthlyProductTP.JulUnitTP

+ SalesBudgetMonthwiseMarket.QuantityMonth08*SalesBudgetYearlyMonthlyProductTP.AugUnitTP

+ SalesBudgetMonthwiseMarket.QuantityMonth09*SalesBudgetYearlyMonthlyProductTP.SepUnitTP

+ SalesBudgetMonthwiseMarket.QuantityMonth10*SalesBudgetYearlyMonthlyProductTP.OctUnitTP

+ SalesBudgetMonthwiseMarket.QuantityMonth11*SalesBudgetYearlyMonthlyProductTP.Nov
) AS Budget

from IrisNetSD_HPL.dbo.SalesBudgetMonthwiseMarket inner join IrisNetSD_HPL.dbo.SalesBudgetYearlyMonthlyProductTP
UnitTP

+ SalesBudgetMonthwiseMarket.QuantityMonth12*SalesBudgetYearlyMonthlyProductTP.DecUnitTP

 

 

on SalesBudgetMonthwiseMarket.ProductId = SalesBudgetYearlyMonthlyProductTP.ProductId

Where SalesBudgetMonthwiseMarket.YearNo = 2022 AND SalesBudgetYearlyMonthlyProductTP.YearNo = 2022

Group by SalesBudgetMonthwiseMarket.MarketId,SalesBudgetMonthwiseMarket.ProductId

) AS Bud_TB on Sal_TB.MarketId = Bud_TB.MarketId AND Sal_TB.ProductId = Bud_TB.ProductId)

 

inner join IrisNetSD_HPL.dbo.Product on Sal_TB.ProductId = Product.ProductId OR Bud_TB.ProductId = Product.ProductId

inner join IrisNetSD_HPL.dbo.ProductCategory on Product.ProductCategoryId = ProductCategory.ProductCategoryId

 

inner join market on Sal_TB.MarketId = market.MarketId OR Bud_TB.MarketId = market.MarketId

--inner join m_market_map_with_regeion_and_zone on m_market_map_with_regeion_and_zone.MarketID = Market.MarketId

 

 

inner join

(

select m.ZoneCode,z.ZoneName,r.RegeionCode,r.RegeionName,m.MarketCode,m.MarketID,m.MarketName

from ((SMD_HPL_Discount.dbo.m_market_map_with_regeion_and_zone_2022 as m

inner join SMD_HPL_Discount.dbo.m_regeion_map_with_zone_2022 as r on m.RegeionCode = r.RegeionCode)

inner join SMD_HPL_Discount.dbo.m_zone_2022 as z on m.ZoneCode = z.ZoneCode)

 

UNION

 

select r.ZoneCode,z.ZoneName,r.RegeionCode,r.RegeionName,r.RegeionCode,r.RegeionID,r.RegeionName

from SMD_HPL_Discount.dbo.m_regeion_map_with_zone_2022 as r

inner join SMD_HPL_Discount.dbo.m_zone_2022 as z on r.ZoneCode = z.ZoneCode

 

UNION

 

select z.ZoneCode,z.ZoneName,z.ZoneCode,z.ZoneName,z.ZoneCode,z.ZoneID,z.ZoneName from SMD_HPL_Discount.dbo.m_zone_2022 as z) AS market_st on market.MarketId = market_st.MarketID

 

 

 

 

Group by

market_st.ZoneCode,

market_st.ZoneName,

market_st.RegeionCode,

market_st.RegeionName,

market_st.MarketCode,

market_st.MarketName,

ProductCategory.ProductCategoryName,

ProductCategory.BusinessNature

 

Order BY

market_st.ZoneName


