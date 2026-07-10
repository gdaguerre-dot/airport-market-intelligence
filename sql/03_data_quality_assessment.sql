/******************************************************************************
 Proyecto : Airport Market Intelligence
 Autor    : Gerónimo Daguerre
 Archivo  : 03_data_quality_assessment.sql

 Objetivo
 --------
 Evaluar la calidad del dataset Flights_Raw mediante la identificación de
 registros duplicados, valores nulos, inconsistencias y posibles anomalías
 que puedan afectar el análisis y la construcción del modelo analítico.

 Base de datos
 -------------
 AirportMarketDB

 Tabla
 -----
 Flights_Raw

 Descripción
 -----------
 Este script corresponde a la etapa de Data Quality dentro de la arquitectura
 del proyecto.

 Su finalidad es medir la calidad del conjunto de datos antes de iniciar el
 proceso ETL y documentar las principales incidencias detectadas.

 Dependencias
 ------------
 Este script asume que:

 • AirportMarketDB ya existe.
 • Flights_Raw fue importada correctamente.
 • Se ejecutaron previamente los scripts:

      01_importacion_dataset.sql
      02_exploratory_data_analysis.sql

******************************************************************************/

USE AirportMarketDB;
GO

/******************************************************************************
 1. Registros duplicados
******************************************************************************/

-- Verificar si existen registros completamente duplicados.

SELECT
    YEAR,
    MONTH_NUM,
    FLT_DATE,
    APT_ICAO,
    COUNT(*) AS Cantidad
FROM Flights_Raw
GROUP BY
    YEAR,
    MONTH_NUM,
    FLT_DATE,
    APT_ICAO
HAVING COUNT(*) > 1;


/******************************************************************************
 2. Valores nulos o vacíos
******************************************************************************/

-- Evaluar la presencia de valores nulos en las variables principales.

SELECT

    SUM(CASE WHEN YEAR IS NULL THEN 1 ELSE 0 END) AS Nulos_YEAR,

    SUM(CASE WHEN MONTH_NUM IS NULL THEN 1 ELSE 0 END) AS Nulos_MONTH,

    SUM(CASE WHEN FLT_DATE IS NULL THEN 1 ELSE 0 END) AS Nulos_FECHA,

    SUM(CASE WHEN APT_ICAO IS NULL THEN 1 ELSE 0 END) AS Nulos_ICAO,

    SUM(CASE WHEN APT_NAME IS NULL THEN 1 ELSE 0 END) AS Nulos_AEROPUERTO,

    SUM(CASE WHEN STATE_NAME IS NULL THEN 1 ELSE 0 END) AS Nulos_PAIS

FROM Flights_Raw;


/******************************************************************************
 3. Valores "NA"
******************************************************************************/

-- Cuantificar la presencia de valores "NA" en las columnas IFR.

SELECT

    SUM(CASE WHEN FLT_DEP_IFR_2='NA' THEN 1 ELSE 0 END) AS DEP_IFR_NA,

    SUM(CASE WHEN FLT_ARR_IFR_2='NA' THEN 1 ELSE 0 END) AS ARR_IFR_NA,

    SUM(CASE WHEN FLT_TOT_IFR_2='NA' THEN 1 ELSE 0 END) AS TOT_IFR_NA

FROM Flights_Raw;


/******************************************************************************
 4. Valores negativos
******************************************************************************/

-- Verificar que no existan cantidades negativas.

SELECT *

FROM Flights_Raw

WHERE

    FLT_DEP_1 < 0

OR  FLT_ARR_1 < 0

OR  FLT_TOT_1 < 0;


/******************************************************************************
 5. Consistencia matemática
******************************************************************************/

-- Verificar que:
-- Salidas + Llegadas = Total

SELECT *

FROM Flights_Raw

WHERE

FLT_DEP_1 + FLT_ARR_1 <> FLT_TOT_1;


/******************************************************************************
 6. Integridad de códigos ICAO
******************************************************************************/

-- Verificar longitud del código ICAO.

SELECT DISTINCT

APT_ICAO

FROM Flights_Raw

WHERE LEN(APT_ICAO) <> 4;


/******************************************************************************
 7. Países sin nombre
******************************************************************************/

SELECT *

FROM Flights_Raw

WHERE

STATE_NAME IS NULL

OR LTRIM(RTRIM(STATE_NAME))='';


/******************************************************************************
 8. Aeropuertos sin nombre
******************************************************************************/

SELECT *

FROM Flights_Raw

WHERE

APT_NAME IS NULL

OR LTRIM(RTRIM(APT_NAME))='';


/******************************************************************************
 9. Cobertura temporal
******************************************************************************/

-- Detectar fechas faltantes.

SELECT

MIN(FLT_DATE) AS Fecha_Minima,

MAX(FLT_DATE) AS Fecha_Maxima,

COUNT(DISTINCT FLT_DATE) AS Dias_Distintos

FROM Flights_Raw;


/******************************************************************************
 10. Valores extremos
******************************************************************************/

-- Identificar las mayores cantidades de operaciones.

SELECT TOP (20)

APT_NAME,

FLT_DATE,

FLT_TOT_1

FROM Flights_Raw

ORDER BY FLT_TOT_1 DESC;


/******************************************************************************
 11. Distribución de registros por año
******************************************************************************/

SELECT

YEAR,

COUNT(*) AS Registros

FROM Flights_Raw

GROUP BY YEAR

ORDER BY YEAR;


/******************************************************************************
 Observaciones
******************************************************************************/

-- No se detectaron registros duplicados para la combinación
-- Fecha + Aeropuerto (esperado).

-- Las variables principales presentan una alta completitud.

-- Las columnas IFR contienen una cantidad significativa de valores "NA",
-- por lo que no serán utilizadas para el cálculo de indicadores
-- principales del proyecto.

-- La variable FLT_TOT_1 presenta consistencia con la suma de llegadas
-- y salidas.

-- Los códigos ICAO mantienen el formato estándar de cuatro caracteres.

-- El conjunto de datos presenta una calidad adecuada para continuar
-- con el proceso ETL.


/******************************************************************************
 Conclusión
******************************************************************************/

-- La evaluación de Data Quality permitió validar la confiabilidad del
-- conjunto de datos utilizado en el proyecto.

-- Se verificó:

-- ✔ Integridad estructural.
-- ✔ Ausencia de duplicados relevantes.
-- ✔ Consistencia matemática.
-- ✔ Integridad de claves geográficas.
-- ✔ Identificación de columnas con alta proporción de valores "NA".

-- Como resultado, se decidió utilizar FLT_TOT_1 como métrica principal
-- del análisis y excluir las variables IFR de los indicadores
-- estratégicos debido a su baja completitud.

-- El siguiente paso consistirá en diseñar el modelo dimensional que
-- servirá de base para el desarrollo del dashboard en Power BI.

******************************************************************************
