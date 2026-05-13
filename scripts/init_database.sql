/* Create Database and Schemas
Create new database named "Datawarehouse". This also add three schemas inside the database: "Bronze", "Silver", "Gold"

*/



USE master;
CREATE database Datawarehouse;


USE Datawarehouse;
GO
CREATE SCHEMA Bronze;
GO
CREATE SCHEMA Silver;
GO
CREATE SCHEMA Gold;
GO
