# 🚗 Sistema de Gestión de Ventas de Vehículos

Este proyecto es un programa desarrollado en **Prolog** que permite gestionar un catálogo de ventas de vehículos, realizar consultas personalizadas y generar reportes de inventario.

Entre sus funcionalidades se incluyen:

- Definir un catálogo de vehículos (marca, referencia, tipo, precio y año).
- Filtrar vehículos por presupuesto máximo.
- Listar vehículos por marca utilizando `findall/3`.
- Agrupar vehículos por tipo y año usando `bagof/3`. 
- Generar reportes con restricciones de presupuesto (máximo $1,000,000).
- Calcular el valor total de los vehículos seleccionados, respetando un límite máximo de inventario.  

## 📌 Información del Proyecto
- **Autor:** Juan Esteban Palacio Betancur
- **Asignatura:** Lenguajes y Paradigmas de Programación
- **Práctica:** 2
- **Entorno de desarrollo:** SWI-Prolog y Visual Studio Code

## 🧪 Casos de Prueba

### 1️⃣ Listar todos los SUVs de Toyota con precio menor a $30,000
?- test_case1(List).
List = [rav4, hilux].

### 2️⃣ Mostrar vehículos de Ford agrupados por tipo y año
?- test_case2(List).
List = [(sedan, 2020, fiesta)] ;
List = [(pickup, 2023, ranger)] ;
List = [(sport, 2023, mustang)].

### 3️⃣ Calcular el valor total del inventario de tipo Sedan sin superar $500,000
?- test_case3(Result).
Result = ([(fiesta, 18000), (versa, 20000), (corolla, 22000), (serie3, 37000)], 97000).

## ⚙️ Otros Ejemplos de Funcionamiento 

### Filtrar por presupuesto 
?- meet_budget(corolla, 23000).
true.

### Listar vehículos por marca
?- vehicles_by_brand(ford, List).
List = [fiesta, ranger, mustang].

### Agrupar por tipo y año
?- vehicles_by_brand_type_year(toyota, List).
List = [(sedan, 2021, corolla)] ;
List = [(suv, 2023, hilux)] ;
List = [(suv, 2022, rav4)].
