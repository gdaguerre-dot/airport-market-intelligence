# Airport Market Intelligence

`Power BI` · `SQL` · `Business Intelligence` · `Storytelling` · `Aviation Industry`

> Caso de consultoría estratégica: dónde debería un operador turístico-aeronáutico priorizar sus esfuerzos comerciales en el mercado aeroportuario europeo, aplicando criterios reales de gestión aeroportuaria (no solo volumen de tráfico).

📄 **Documentación completa:** [`pdf/Airport_Market_Intelligence.pdf`](./pdf/Airport_Market_Intelligence.pdf)
📊 **Dashboard Power BI:** [`powerbi/Airport_Market_Intelligence.pbix`](./powerbi/)

---

## Caso de negocio: VueloJusto

VueloJusto opera dentro del ecosistema turístico y aeronáutico. Como en la mayoría de las organizaciones del sector, los recursos destinados a marketing, alianzas estratégicas y experiencia del cliente son limitados — por lo que resulta necesario identificar qué mercados aeroportuarios ofrecen el mayor potencial de crecimiento.

**Pregunta de negocio:**
¿En qué mercados aeroportuarios europeos debería VueloJusto priorizar sus esfuerzos comerciales y de Customer Experience para maximizar impacto y crecimiento?

## Por qué este proyecto es distinto a un dashboard de tráfico aéreo

La mayoría de los análisis de tráfico aéreo se detienen en el volumen: qué país o aeropuerto mueve más vuelos. Este proyecto va un paso más allá, aplicando criterios reales de **gestión comercial y económica aeroportuaria** para transformar el dato de tráfico en un criterio de priorización de negocio:

- El volumen de operaciones se usa como proxy de demanda potencial (el dataset no incluye datos individuales de pasajeros), pero la **priorización final no se basa solo en volumen**, sino en un modelo de ingreso comercial estimado (pasajeros × gasto medio), en el balance entre capacidad y demanda de cada hub, y en la estabilidad de su recuperación post-pandemia como filtro de riesgo comercial.
- Esta capa de interpretación surge de experiencia real en operaciones aeroportuarias, Customer Experience y desarrollo de iniciativas para el sector turístico — no es una inferencia genérica sobre el dataset.

## Dataset

| Métrica | Valor |
|---|---|
| Registros | 688.099 |
| Países | 42 |
| Aeropuertos | 332 |
| Período | 2016–2022 |
| Fuente | [European Flights Dataset — Kaggle](https://www.kaggle.com/datasets/umerhaddii/european-flights-dataset) |

**Variables principales:** país, aeropuerto, año, mes, operaciones IFR, llegadas, salidas, movimientos totales.

## Modelo de datos

Esquema de estrella:

- **Tabla de hechos:** `Fact_TraficoAereo`
- **Dimensiones:** `Dim_Fecha`, `Dim_Aeropuerto`, `Dim_Pais`

## KPIs

| KPI | Qué mide |
|---|---|
| Total de Operaciones | Volumen base del mercado |
| Top 5 Countries Contribution | Concentración de mercado por país |
| Top Airports Contribution (Pareto 80/20) | Concentración de mercado por hub |
| YoY Growth % | Evolución temporal del tráfico |
| Recovery Rate vs. 2019 | Velocidad y estabilidad de recuperación post-COVID |
| **Potencial de Ingreso Comercial Estimado** | Operaciones × gasto medio estimado por pasajero — prioriza por oportunidad económica, no solo por volumen |

## Principales hallazgos

- Un número reducido de países y aeropuertos concentra una proporción significativa del tráfico aéreo europeo.
- España, Alemania, Reino Unido y Francia se perfilan como los mercados de mayor volumen y estabilidad.
- El tráfico aéreo sufrió una contracción histórica en 2020, con una recuperación gradual y desigual entre mercados.

## Recomendaciones estratégicas

**Corto plazo — Priorización por eficiencia comercial, no solo volumen.**
Descartar de la priorización aquellos hubs que ya muestran señales de saturación, donde más tráfico no se traduce en mejor experiencia sino en mayor congestión, y priorizar los que combinan alto volumen con capacidad disponible.

**Mediano plazo — Priorización por ingreso potencial, no solo por tráfico.**
Usar el ingreso comercial estimado (no solo el ranking de vuelos) para identificar mercados donde el mismo volumen de operaciones representa una oportunidad económica mayor.

**Largo plazo — Recuperación como filtro de riesgo antes de invertir.**
Usar la estabilidad de recuperación post-2019 como criterio de riesgo antes de comprometer inversión comercial de largo plazo: mercados con recuperación rápida y sostenida son candidatos más seguros para acuerdos comerciales de mayor plazo.

## Tecnologías utilizadas

SQL · Power BI · DAX · Modelado Dimensional (Star Schema) · Power Query · Storytelling con datos

## Estructura del repositorio

```
README.md
pdf/
    Airport_Market_Intelligence.pdf
sql/
    01_creacion_tablas.sql
    02_consultas_exploratorias.sql
    03_consultas_analiticas.sql
    04_validaciones_calidad.sql
powerbi/
    Airport_Market_Intelligence.pbix
images/
    modelo_estrella.png
    dashboard_vista_general.png
    dashboard_priorizacion.png
```

## Limitaciones del análisis

El dataset no contiene información individual de pasajeros ni indicadores directos de experiencia del cliente. El volumen de operaciones se utiliza como proxy de demanda potencial, y el ingreso comercial estimado se calcula con un valor de referencia conservador, no con datos financieros reales de VueloJusto. Las recomendaciones combinan evidencia del dato con criterio de industria — ambas capas se presentan de forma diferenciada en la documentación completa.

## Autor

**Gerónimo Daguerre**
Business Intelligence · Análisis de Datos · Operaciones Turísticas y de Aviación

[LinkedIn](https://www.linkedin.com/in/gerodaguerre/) · [GitHub](https://github.com/gdaguerre-dot)

## Licencia

Proyecto desarrollado con fines educativos y de portfolio profesional, sobre un dataset público de Kaggle. El caso de negocio (VueloJusto) es ilustrativo; los criterios de priorización aplicados se apoyan en experiencia profesional real del autor en el sector aeroportuario y turístico.
