--1 QUAIS SÃO OS PRODUTOS MAIS VENDIDOS
 
SELECT TOP 10
   Dimproduct.ProductName  AS PRODUTO, 
   SUM(Factsales.SalesQuantity) AS TOTAL_VENDIDO    
FROM FactSales
JOIN DimProduct ON FactSales.ProductKey = DimProduct.Productkey
GROUP BY Dimproduct.ProductName
ORDER BY Total_Sold DESC; 

--2 QUAIS AS CAEGORIAS MAIS LUCRATIVAS?
SELECT 
    DimProductCategory.ProductCategoryName AS CATEGORIA,
    SUM(FactSales.SalesAmount) AS LUCRO
FROM FactSales
JOIN DimProduct ON FactSales.ProductKey = DimProduct.ProductKey
JOIN DimProductCategory ON DimProduct.ProductKey = DimProductCategory.ProductCategoryKey
GROUP BY DimProductCategory.ProductCategoryName
ORDER BY LUCRO DESC;

select * from FactSales


--3 COMO AS VENDAS VARIAM MENSALMENTE?
SELECT 
    YEAR(DateKey) AS ANO,
    MONTH(DateKey) AS MES, 
    SUM(SalesAmount) AS VENDAS
FROM FactSales
GROUP BY YEAR(DateKey), MONTH(DateKey)
ORDER BY ANO, MES;

--4 QUAIS LOJAS TEM O MELHOR DESEMPENHO?
SELECT 
	DimStore.StoreName, 
	SUM(FactSales.SalesAmount) AS VENDAS
FROM FactSales
JOIN DimStore ON FactSales.StoreKey = DimStore.StoreKey
GROUP BY DimStore.StoreName
ORDER BY VENDAS DESC;

--5 QUAIS CLIENTES MAIS VALIOSOS PARA LOJAS ONLINE?

SELECT 
	  CONCAT(DimCustomer.FirstName,' ',DimCustomer.LastName) AS NOME, 
       SUM(FactOnlineSales.SalesAmount) AS GASTO
FROM FactOnlineSales
JOIN DimCustomer ON FactOnlineSales.CustomerKey = DimCustomer.CustomerKey
GROUP BY CONCAT(DimCustomer.FirstName,' ',DimCustomer.LastName)
ORDER BY GASTO DESC;

--6 QUAIS REGIÕES MAIS VENDERAM?
SELECT 
	DimGeography.RegionCountryName AS REGIAO,
	SUM(FactSales.SalesAmount) AS VENDAS
FROM FactSales
JOIN DimStore ON FactSales.StoreKey = DimStore.StoreKey
JOIN DimGeography ON DimGeography.GeographyKey = DimStore.GeographyKey
GROUP BY DimGeography.RegionCountryName
ORDER BY VENDAS DESC;

--7 QUAL IMPACTO DAS PROMOÇÕES NAS VENDAS?
SELECT 
	DimPromotion.PromotionType AS TIPO_PROMOCAO,
	SUM(FactSales.SalesAmount) AS VENDAS_C_PROMOCAO
FROM FactSales
JOIN DimPromotion ON FactSales.PromotionKey = DimPromotion.PromotionKey
GROUP BY DimPromotion.PromotionType
ORDER BY SUM(FactSales.SalesAmount) DESC;,

--8 QUAIS AS TENDENCIAS DE DEVOLUÇÃO DE PRODUTO?
SELECT 
	DimProduct.ProductName AS PRODUTO, 
	COUNT(FactSales.ReturnQuantity) AS NUMERO_DEVOLUCAO
FROM FactSales
JOIN DimProduct ON FactSales.ProductKey = DimProduct.ProductKey
GROUP BY DimProduct.ProductName
ORDER BY COUNT(FactSales.ReturnQuantity) DESC;

--9 QUAL O TEMPO MÉDIO DE PERMANÊNCIA DOS FUNCIONARIOS DA EMPRESA 
SELECT 
	AVG(DATEDIFF(day, DimEmployee.HireDate, DimEmployee.EndDate)) AS AverageTenure
FROM DimEmployee
WHERE DimEmployee.EndDate IS NOT NULL;