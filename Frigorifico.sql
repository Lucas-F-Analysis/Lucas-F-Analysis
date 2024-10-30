CREATE DATABASE Frigorifico;
USE Frigorifico;

CREATE TABLE Ganado (
    ID_Ganado INT AUTO_INCREMENT PRIMARY KEY, -- Identificador único para cada ganado
    Tipo_Ganado VARCHAR(50) NOT NULL,                 -- Tipo de ganado (ej: bovino, ovino)
    Peso_Entrada DECIMAL(10, 2) NOT NULL,             -- Peso del ganado en kg
    Edad INT NOT NULL,                                -- Edad del ganado en años
    ID_Proveedor INT NOT NULL,                  -- Nombre del proveedor
    Fecha_Entrada DATE NOT NULL,                      -- Fecha de entrada del ganado
    Costo_Compra DECIMAL(10, 2) NOT NULL,             -- Costo de compra por el ganado
    Región_Origen VARCHAR(100) NOT NULL,              -- Región de origen del ganado
    Calidad VARCHAR(50) NOT NULL                        -- Condiciones climáticas en el momento de entrada
);

CREATE TABLE Proveedores (
	ID_Proveedor INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Ubicacion VARCHAR(100),
    Contacto VARCHAR(50),
    Condiciones_Proveedor VARCHAR(250)
);

CREATE TABLE Clima (
    ID_Clima INT AUTO_INCREMENT PRIMARY KEY,
    ID_Proveedor INT NOT NULL, -- Relacionado con la ubicación del proveedor
    Fecha DATE NOT NULL,
    Condiciones_Climáticas VARCHAR(255), -- Ej: "Soleado, 25°C"
    Impacto_Ganado VARCHAR(20), -- Afecta sí/no
    FOREIGN KEY (ID_Proveedor) REFERENCES Proveedores(ID_Proveedor) -- Relación con Proveedores
);

CREATE TABLE Transporte_Ganado (
    ID_Transporte INT AUTO_INCREMENT PRIMARY KEY,
    ID_Ganado INT NOT NULL,
    ID_Clima INT, -- Relacionado con las condiciones climáticas del transporte
    Costo_Transporte DECIMAL(10, 2) NOT NULL,
    Fecha_Transporte DATE NOT NULL,
    Condiciones_Transporte VARCHAR(255),
    FOREIGN KEY (ID_Ganado) REFERENCES Ganado(ID_Ganado),
    FOREIGN KEY (ID_Clima) REFERENCES Clima(ID_Clima) -- Relación con Clima
);

CREATE TABLE Alimentacion (
	ID_Alimentacion INT AUTO_INCREMENT PRIMARY KEY, -- Identificador único para cada alimentación
    ID_Ganado INT NOT NULL,									-- Relación con el ganado
    Tipo_Alimento VARCHAR(100),						-- Tipo de alimento
    Costo_Alimento DECIMAL(10, 2) NOT NULL,					-- Costo del alimento por kg
    Cantidad_Alimento DECIMAL(10, 2) NOT NULL,				-- Cantidad en kg
    Duracion_Alimentacion INT,						-- Duración en días
    Fecha_Alimentacion DATE NOT NULL,							-- Fecha de registro de la alimentación
    FOREIGN KEY (ID_Ganado) REFERENCES Ganado(ID_Ganado) -- Clave foránea a la tabla de ganado
);

CREATE TABLE Medicamentos (
	ID_Medicamento INT AUTO_INCREMENT PRIMARY KEY,  -- Identificador único para cada medicamento
    ID_Ganado INT NOT NULL,									-- Relación con el ganado
    Tipo_Medicamento VARCHAR(100),					-- Tipo de medicamento
    Cantidad_Medicamento DECIMAL(10, 2),			-- Cantidad administrada
    Costo_Medicamento DECIMAL(10, 2) NOT NULL,				-- Costo del medicamento
    Fecha_Aplicacion DATE NOT NULL,	
	Dosis DECIMAL(10, 2),
    FOREIGN KEY (ID_Ganado) REFERENCES Ganado(ID_Ganado)  -- Relación con la tabla de ganado
);



CREATE TABLE Faena (
	ID_Faena INT AUTO_INCREMENT PRIMARY KEY,
    ID_Ganado INT NOT NULL,
    Fecha_Faena DATE NOT NULL,
    Costo_Faena DECIMAL(10, 2),
    Peso_Canal DECIMAL(10, 2),
    Tiempo_Faena INT,
    Descartes DECIMAL(10, 2),
    FOREIGN KEY (ID_Ganado) REFERENCES Ganado(ID_Ganado)
);

CREATE TABLE Oreo (
	ID_Oreo INT AUTO_INCREMENT PRIMARY KEY,
    ID_Faena INT NOT NULL,
    Fecha_Ingreso_Oreo DATE NOT NULL,
    Fecha_Salida_Oreo DATE,
    Temperatura_Oreo DECIMAL(10, 2),
    Costo_Oreo DECIMAL(10, 2),
    FOREIGN KEY (ID_Faena) REFERENCES Faena(ID_Faena)
);

CREATE TABLE Cortes_Carne (
	ID_Corte INT AUTO_INCREMENT PRIMARY KEY,
    ID_Faena INT NOT NULL,
    Tipo_Corte VARCHAR(100) NOT NULL,
    Peso_Corte DECIMAL(10, 2) NOT NULL,
    Costo_Mano_Obra_Corte DECIMAL(10, 2) NOT NULL,		-- Costo de mano de obra para el corte
    Costo_Corte_Total DECIMAL(10, 2) NOT NULL,
    Fecha_Corte DATE NOT NULL,
	FOREIGN KEY (ID_Faena) REFERENCES Faena(ID_Faena)
);

CREATE TABLE Cuero (
    ID_Cuero INT AUTO_INCREMENT PRIMARY KEY,
    ID_Faena INT NOT NULL, -- Relación con el proceso de faenado
    Peso_Cuero DECIMAL(10, 2) NOT NULL, -- Peso del cuero en kg
    Precio_Venta DECIMAL(10, 2), -- Precio de venta del cuero
    Calidad_Cuero VARCHAR(50), -- Calidad del cuero (Alta, Media, Baja)
    Fecha_Extracción DATE NOT NULL,
    FOREIGN KEY (ID_Faena) REFERENCES Faena(ID_Faena) -- Relación con el faenado
);

CREATE TABLE Producto_Preparado (
    ID_Producto INT AUTO_INCREMENT PRIMARY KEY,
    ID_Corte INT NOT NULL, -- Relación con los cortes de carne
    Cantidad INT NOT NULL, -- Cantidad de productos preparados
    Fecha_Preparación DATE NOT NULL,
    Fecha_Vencimiento DATE,
    Precio_Venta DECIMAL(10, 2) NOT NULL, -- Precio final de venta por unidad
    FOREIGN KEY (ID_Corte) REFERENCES Cortes_Carne(ID_Corte) -- Relación con los cortes de carne
);

CREATE TABLE Condiciones_Mercado (
    ID_Mercado INT AUTO_INCREMENT PRIMARY KEY,
    Fecha DATE NOT NULL,
    Demanda VARCHAR(50), -- Alta, Media, Baja
    Oferta VARCHAR(50), -- Alta, Media, Baja
    Precio_Mercado DECIMAL(10, 2), -- Precio promedio del mercado por kg
    Regulaciones VARCHAR(255), -- Regulaciones o normativas vigentes
    Epoca_Año VARCHAR(50) -- Estación del año, festividades, etc.
);

CREATE TABLE Ventas (
    ID_Venta INT AUTO_INCREMENT PRIMARY KEY,
    ID_Producto INT NOT NULL, -- Relación con los productos preparados
    Cantidad_Vendida INT NOT NULL, -- Cantidad de productos vendidos
    Fecha_Venta DATE NOT NULL,
    Precio_Venta_Total DECIMAL(10, 2) NOT NULL, -- Precio total de la venta
    Cliente VARCHAR(255), -- Cliente al que se vendió el producto
    FOREIGN KEY (ID_Producto) REFERENCES Producto_Preparado(ID_Producto) -- Relación con el producto preparado
);

CREATE TABLE Costos_Transporte_Salidaa (
    ID_Transporte_Salida INT AUTO_INCREMENT PRIMARY KEY,
    ID_Venta INT NOT NULL, -- Relación con la venta realizada
    Costo_Transporte DECIMAL(10, 2) NOT NULL, -- Costo de transporte del producto
    Empresa_Transporte VARCHAR(255), -- Empresa o proveedor de transporte
    Fecha_Transporte DATE NOT NULL,
    FOREIGN KEY (ID_Venta) REFERENCES Ventas(ID_Venta) -- Relación con la venta
);

CREATE TABLE Regulaciones (
    ID_Regulacion INT AUTO_INCREMENT PRIMARY KEY,
    Descripcion VARCHAR(255) NOT NULL, -- Descripción de la regulación
    Tipo_Regulacion VARCHAR(100), -- Tipo de regulación (e.g., sanitaria, transporte, mercado)
    Fecha_Vigencia_Inicio DATE NOT NULL, -- Inicio de la regulación
    Fecha_Vigencia_Fin DATE, -- Fin de la regulación, si aplica
    Autoridad_Competente VARCHAR(100) -- Autoridad que emite la regulación
);


ALTER TABLE Producto_Preparado
ADD COLUMN ID_Mercado INT,
ADD FOREIGN KEY (ID_Mercado) REFERENCES Condiciones_Mercado(ID_Mercado);

ALTER TABLE Ventas
ADD COLUMN ID_Mercado INT,
ADD FOREIGN KEY (ID_Mercado) REFERENCES Condiciones_Mercado(ID_Mercado);

ALTER TABLE Producto_Preparado
ADD COLUMN ID_Regulacion INT,
ADD FOREIGN KEY (ID_Regulacion) REFERENCES Regulaciones(ID_Regulacion);

ALTER TABLE Costos_Transporte_Salidaa
ADD COLUMN ID_Regulacion INT,
ADD FOREIGN KEY (ID_Regulacion) REFERENCES Regulaciones(ID_Regulacion);

ALTER TABLE Condiciones_Mercado
ADD COLUMN ID_Regulacion INT,
ADD FOREIGN KEY (ID_Regulacion) REFERENCES Regulaciones(ID_Regulacion);

ALTER TABLE Ventas
ADD COLUMN ID_Regulacion INT,
ADD FOREIGN KEY (ID_Regulacion) REFERENCES Regulaciones(ID_Regulacion);

CREATE TABLE Epoca_Año (
    ID_Epoca INT AUTO_INCREMENT PRIMARY KEY,
    Nombre_Epoca VARCHAR(100) NOT NULL, -- Puede ser 'Verano', 'Invierno', etc.
    Mes_Inicio INT NOT NULL, -- El mes de inicio de la época (1 para Enero, 2 para Febrero, etc.)
    Mes_Fin INT NOT NULL, -- El mes de finalización de la época
    Descripcion VARCHAR(255) -- Descripción opcional sobre esta época
);

ALTER TABLE Ganado
ADD COLUMN ID_Epoca INT,
ADD FOREIGN KEY (ID_Epoca) REFERENCES Epoca_Año(ID_Epoca);

ALTER TABLE Condiciones_Mercado
ADD COLUMN ID_Epoca INT,
ADD FOREIGN KEY (ID_Epoca) REFERENCES Epoca_Año(ID_Epoca);

ALTER TABLE Ventas
ADD COLUMN ID_Epoca INT,
ADD FOREIGN KEY (ID_Epoca) REFERENCES Epoca_Año(ID_Epoca);

ALTER TABLE Producto_Preparado
ADD COLUMN ID_Epoca INT,
ADD FOREIGN KEY (ID_Epoca) REFERENCES Epoca_Año(ID_Epoca);

CREATE TABLE Costos_Insumos (
    ID_Costo_Insumo INT AUTO_INCREMENT PRIMARY KEY,
    Tipo_Insumo VARCHAR(100) NOT NULL, -- Tipo de insumo (e.g., alimentación, medicamentos)
    Costo DECIMAL(10, 2) NOT NULL, -- Costo por unidad
    Cantidad DECIMAL(10, 2) NOT NULL, -- Cantidad del insumo
    Fecha DATE NOT NULL, -- Fecha en la que se incurre en el costo
    Descripcion VARCHAR(255) -- Descripción opcional
);

CREATE TABLE Costos_Faena (
    ID_Costo_Faena INT AUTO_INCREMENT PRIMARY KEY,
    Costo DECIMAL(10, 2) NOT NULL, -- Costo de la faena por res
    Fecha DATE NOT NULL, -- Fecha en la que se incurre en el costo
    Descripcion VARCHAR(255) -- Descripción opcional
);

CREATE TABLE Costos_Transporte_Salida (
    ID_Costo_Transporte INT AUTO_INCREMENT PRIMARY KEY,
    Costo DECIMAL(10, 2) NOT NULL, -- Costo del transporte
    Fecha DATE NOT NULL, -- Fecha en la que se incurre en el costo
    ID_Regulacion INT, -- Relacionado a regulaciones si aplica
    FOREIGN KEY (ID_Regulacion) REFERENCES Regulaciones(ID_Regulacion)
);



CREATE TABLE Perdidas (
    ID_Perdida INT AUTO_INCREMENT PRIMARY KEY,
    ID_Producto INT, -- Relación con Producto_Preparado
    Fecha DATE NOT NULL, -- Fecha en la que se incurre la pérdida
    Cantidad DECIMAL(10, 2) NOT NULL, -- Cantidad perdida
    Motivo VARCHAR(255) NOT NULL, -- Motivo de la pérdida
    Costo_Directo DECIMAL(10, 2) NOT NULL, -- Costo directo asociado a la pérdida
    FOREIGN KEY (ID_Producto) REFERENCES Producto_Preparado(ID_Producto)
);

