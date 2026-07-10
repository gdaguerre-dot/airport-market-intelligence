/******************************************************************************
 Proyecto : Airport Market Intelligence
 Autor    : Gerónimo Daguerre
 Archivo  : 01_importacion_dataset.sql

 Objetivo
 --------
 Documentar la preparación del entorno de trabajo y validar que la importación
 del dataset Flights.csv a SQL Server se realizó correctamente.

 Base de datos
 -------------
 AirportMarketDB

 Tabla
 -----
 Flights_Raw

 Descripción
 -----------
 Este script corresponde a la etapa de ingestión de datos (Raw Layer)
 dentro de la arquitectura del proyecto.

 No realiza la importación del archivo CSV, ya que ésta se efectuó mediante
 el asistente "Import Flat File" de SQL Server Management Studio.

 Su finalidad es verificar que el conjunto de datos quedó correctamente
 almacenado antes de iniciar el análisis exploratorio (EDA).

 Dependencias
 ------------
 Este script asume que:

 • La base de datos AirportMarketDB ya fue creada.
 • La tabla Flights_Raw fue generada mediante Import Flat File.
 • El archivo Flights.csv fue importado correctamente.

******************************************************************************/

-- Seleccionar la base de datos del proyecto.

USE AirportMarketDB;
GO

/******************************************************************************
 Primera inspección del dataset
******************************************************************************/

-- Visualizar los primeros registros importados.

SELECT TOP (10) *
FROM Flights_Raw;


/******************************************************************************
 Validación de la importación
******************************************************************************/

-- Verificar la cantidad total de registros importados.
-- Resultado esperado: 688.099 registros.

SELECT
    COUNT(*) AS Total_Registros
FROM Flights_Raw;


/******************************************************************************
 Validación de la estructura
******************************************************************************/

-- Verificar la cantidad de columnas importadas.
-- Resultado esperado: 14 columnas.

SELECT
    COUNT(*) AS Total_Columnas
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Flights_Raw';


-- Revisar los tipos de datos asignados automáticamente por SQL Server.

SELECT
    COLUMN_NAME,
    DATA_TYPE,
    CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Flights_Raw'
ORDER BY ORDINAL_POSITION;


/******************************************************************************
 Revisión de variables principales
******************************************************************************/

-- Verificar el formato de las variables temporales.

SELECT TOP (20)
    YEAR,
    MONTH_NUM,
    FLT_DATE
FROM Flights_Raw;


-- Revisar algunos países presentes en el dataset.

SELECT DISTINCT TOP (20)
    STATE_NAME
FROM Flights_Raw
ORDER BY STATE_NAME;


-- Revisar algunos aeropuertos presentes en el dataset.

SELECT DISTINCT TOP (20)
    APT_ICAO,
    APT_NAME
FROM Flights_Raw
ORDER BY APT_NAME;


/******************************************************************************
 Observaciones
******************************************************************************/

-- El archivo Flights.csv fue importado mediante Import Flat File.

-- La tabla Flights_Raw representa la capa Raw del proyecto.

-- No se realizaron transformaciones durante la importación.

-- Las columnas que contienen valores "NA" fueron importadas inicialmente
-- como NVARCHAR para preservar la integridad del dataset original.

-- Las tareas de limpieza, estandarización y conversión de tipos de datos
-- serán desarrolladas en las etapas posteriores del proceso ETL.


/******************************************************************************
 Conclusión
******************************************************************************/

-- La importación del dataset fue validada correctamente.

-- Se verificó:
-- ✔ Cantidad de registros.
-- ✔ Cantidad de columnas.
-- ✔ Tipos de datos.
-- ✔ Variables principales.
-- ✔ Cobertura inicial del dataset.

-- El conjunto de datos queda disponible para iniciar la etapa de
-- Exploratory Data Analysis (EDA), donde se analizará la estructura,
-- distribución y calidad de la información antes de su transformación
-- y modelado dimensional.
