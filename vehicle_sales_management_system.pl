% ==== Sistema de Gestión de Ventas de Vehículos ====

% ---- Catálogo de Vehículos ----

% vehicle(Brand, Reference, Type, Price, Year).
vehicle(toyota, corolla, sedan, 22000, 2021).
vehicle(toyota, rav4, suv, 28000, 2022).
vehicle(toyota, hilux, suv, 25000, 2023).
vehicle(ford, fiesta, sedan, 18000, 2020).
vehicle(ford, ranger, pickup, 40000, 2023).
vehicle(ford, mustang, sport, 45000, 2023).
vehicle(bmw, x5, suv, 60000, 2021).
vehicle(bmw, serie3, sedan, 37000, 2022).
vehicle(chevrolet, tracker, suv, 25000, 2021).
vehicle(chevrolet, camaro, sport, 55000, 2023).
vehicle(nissan, versa, sedan, 20000, 2022).
vehicle(nissan, frontier, pickup, 33000, 2023).

% ---- Filtros y Consultas Básicas ----

% Filtrar por presupuesto
meet_budget(Reference, BudgetMax) :-
    vehicle(_, Reference, _, Price, _),
    Price =< BudgetMax.

% Listar vehículos por marca
vehicles_by_brand(Brand, List) :-
    findall(Reference, vehicle(Brand, Reference, _, _, _), List).

% Listar vehículos de una marca agrupados por tipo y año
vehicles_by_brand_type_year(Brand, List) :-
    bagof((Type, Year, Reference), vehicle(Brand, Reference, Type, _, Year), List).

% ---- Generación de Reportes ----

% Generar reporte de vehículos por marca, tipo y presupuesto
generate_report(Brand, Type, Budget, Result) :-
    findall((Reference, Price),
            (vehicle(Brand, Reference, Type, Price, _), Price =< Budget),
            Vehicles),
    total_value(Vehicles, Total),
    (   Total =< 1000000 ->  Result = (Vehicles, Total)
    ;   adjust_inventory(Vehicles, Adjusted, AdjustedTotal),
        Result = (Adjusted, AdjustedTotal)).

% Sumar precios de una lista de vehículos 
total_value([], 0).
total_value([(_, Price)|T], Total) :-
    total_value(T, SubTotal),
    Total is Price + SubTotal.

% Ajustar inventario si el total supera 1,000,000
adjust_inventory(Vehicles, Adjusted, Total) :-
    sort(2, @=<, Vehicles, Sorted),      % Ordenar por precio (ascendente)
    pick_until_limit(Sorted, 1000000, Adjusted, Total).

% Agregar vehículos mientras la suma no supere el límite
pick_until_limit([], _, [], 0).
pick_until_limit([(Reference, Price)|T], Limit, [(Reference, Price)|R], Total) :-
    Price =< Limit,
    NewLimit is Limit - Price,
    pick_until_limit(T, NewLimit, R, SubTotal),
    Total is Price + SubTotal.
pick_until_limit([(_, Price)|_], Limit, [], 0) :-
    Price > Limit.

% ---- Casos de Prueba ----

% Caso 1: Listar todos los SUVs de Toyota con precio menor a $30,000.
test_case1(List) :-
    findall(Reference, (vehicle(toyota, Reference, suv, Price, _), Price < 30000), List).

% Caso 2: Mostrar vehículos de Ford agrupados por tipo y año.
test_case2(List) :-
    vehicles_by_brand_type_year(ford, List).

% Caso 3: Calcular el valor total del inventario de tipo Sedan sin superar $500,000.
test_case3(Result) :-
    findall((Reference, Price),
            (vehicle(_, Reference, sedan, Price, _), Price < 500000),
            Sedans),
    sort(2, @=<, Sedans, SortedSedans),   % Ordenar por precio
    pick_until_limit(SortedSedans, 500000, Filtered, Total),
    Result = (Filtered, Total).