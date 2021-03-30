-- Evaluation bases de données
-- Exercice 2 Requêtes d'interrogation sur la base Northwind

-- 1- Liste des contacts français:

SELECT CompanyName, ContactName, ContactTitle, Phone 
FROM customers
WHERE Country = 'France';

-- 2- Produits vendus par le fournisseur "Exotic Liquids": 
SELECT ProductName, UnitPrice
FROM products, suppliers
WHERE CompanyName = 'Exotic Liquids'

-- 3- Nombre de produits vendus par les fournisseurs Français dans l'ordre décroissant:

SELECT CompanyName, 
COUNT(ProductID) AS nombreproduits 
FROM suppliers, products 
WHERE suppliers.SupplierID = products.SupplierID 
AND Country = "France" 
GROUP BY CompanyName 
ORDER BY nombreproduits DESC

-- 4-Liste des clients français ayant plus de 10 commandes:

SELECT CompanyName AS Client,
COUNT(DISTINCT orders.OrderID) AS nombrecommandes
FROM customers, orders, orderdetails
WHERE customers.CustomerID = orders.CustomerID
AND orders.orderID = orderdetails.OrderID
AND Country = "France"
GROUP BY Client
HAVING nombrecommandes > 10


-- 5-Liste des clients ayant un chiffre d'affaires > 30000:

SELECT CompanyName AS Client,
SUM(UnitPrice*Quantity) AS CA,
Country AS Pays 
FROM orderdetails, customers, orders
WHERE customers.CustomerID = orders.CustomerID
AND orders.OrderID =orderdetails.OrderID
GROUP BY Client
HAVING CA > 30000
ORDER BY CA DESC 

-- 6-Liste des pays dont les clients ont passé commande de produits fournis par "Exotic Liquids":

SELECT customers.country AS Pays
FROM customers, orders, orderdetails, products, suppliers
WHERE customers.customerID = orders.customerID 
AND orders.orderID = orderdetails.orderID 
AND orderdetails.productID = products.productID
AND products.SupplierID = suppliers.SupplierID
AND suppliers.CompanyName = "Exotic Liquids"
GROUP BY Pays

-- 7-Montant des ventes de 1997:

SELECT SUM(UnitPrice*Quantity) AS montantvente1997
FROM orderdetails
WHERE orderdetails.OrderID = orders.OrderID
AND YEAR(OrderDate) = 1997

-- 8-Montant des ventes de 1997 mois par mois:

SELECT MONTH(OrderDate) AS mois97,
SUM(UnitPrice*Quantity) AS montantventes
FROM orderdetails, orders
WHERE orderdetails.OrderID = orders.OrderID
AND YEAR(OrderDate) = 1997
GROUP BY mois97

-- 9-Depuis quelle date le client "Du monde entier" n'a plus commandé?

SELECT MAX(OrderDate) AS "Date de dernière commande"
FROM orders, customers
WHERE orders.CustomerID = customers.CustomerID
AND CompanyName = "Du monde entier"

-- 10-Quel est le délai moyen de livraison en jours?

SELECT FLOOR(AVG(datediff(ShippedDate,OrderDate))) AS "Délai moyen de livraison en jours"
FROM orders