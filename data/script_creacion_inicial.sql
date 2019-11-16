/*GRUPO JJFG*/
/*
-------------------------------------------------------------------------------
SECCIONES
-------------------------------------------------------------------------------
SECCION_0 : DEFINICION DE LA BASE A UTILIZAR
SECCION_1 : CREACION DEL ESQUEMA
SECCION_2 : ELIMINACIÓN DE TABLAS
SECCION_3 : CREACIÓN DE LAS TABLAS 
SECCION_4 : DEFINICIÓN DE CONSTRAINTS
SECCION_5 : MIGRACION DE DATOS DE TABLA MAESTRA
SECCION_6 : CREACIÓN DE OBJETOS DE BASE DE DATOS A UTILIZAR
            VIEWS, FUNCTIONS, PROCEDURES, TRIGGERS

-------------------------------------------------------------------------------
*/

/* ****************************************************************************
* SECCION_0 : DEFINICION DE LA BASE A UTILIZAR
**************************************************************************** */

USE GD2C2019;


/* ****************************************************************************
* SECCION_1 : CREACION DEL ESQUEMA
**************************************************************************** */

--Si no existe el esquema, entonces, lo creamos
IF (NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = 'JJFG'))
	BEGIN
		PRINT 'Creando schema ...';
		EXEC ('CREATE SCHEMA JJFG AUTHORIZATION gdCupon2019');
	END;

/* ****************************************************************************
* SECCION_2 : ELIMINACIÓN DE TABLAS
**************************************************************************** */
	IF OBJECT_ID ('VISTA_COMPRA') IS NOT NULL
	   DROP VIEW VISTA_COMPRA



PRINT 'Eliminando tablas del sistema ...';

--13
	IF OBJECT_ID ('JJFG.FACTURACION') IS NOT NULL
	   DROP TABLE  JJFG.FACTURACION;

--12
	IF OBJECT_ID ('JJFG.COMPRA') IS NOT NULL
	   DROP TABLE  JJFG.COMPRA;

--11
	IF OBJECT_ID ('JJFG.OFERTA') IS NOT NULL
	   DROP TABLE  JJFG.OFERTA;

--10
	IF OBJECT_ID ('JJFG.CARGA') IS NOT NULL
	   DROP TABLE  JJFG.CARGA;

--09
	IF OBJECT_ID ('JJFG.TIPO_PAGO') IS NOT NULL
	   DROP TABLE  JJFG.TIPO_PAGO;

--08
	IF OBJECT_ID ('JJFG.CLIENTE') IS NOT NULL
	   DROP TABLE  JJFG.CLIENTE;

--07
	IF OBJECT_ID ('JJFG.PROVEEDOR') IS NOT NULL
	   DROP TABLE  JJFG.PROVEEDOR;

--06
	IF OBJECT_ID ('JJFG.ADMINISTRADOR') IS NOT NULL
	   DROP TABLE  JJFG.ADMINISTRADOR;

--05
	IF OBJECT_ID ('JJFG.FUNCIONALIDAD_X_ROL') IS NOT NULL
	   DROP TABLE  JJFG.FUNCIONALIDAD_X_ROL;

--04
	IF OBJECT_ID ('JJFG.FUNCIONALIDAD') IS NOT NULL
	   DROP TABLE  JJFG.FUNCIONALIDAD;

--03
	IF OBJECT_ID ('JJFG.ROL_X_USUARIO') IS NOT NULL
	   DROP TABLE  JJFG.ROL_X_USUARIO;

--02
	IF OBJECT_ID ('JJFG.ROL') IS NOT NULL
	   DROP TABLE  JJFG.ROL;

--01
	IF OBJECT_ID ('JJFG.USUARIO') IS NOT NULL
	   DROP TABLE  JJFG.USUARIO;


PRINT 'Tablas eliminadas ...';

/* ****************************************************************************
* SECCION_3 : CREACIÓN DE LAS TABLAS 
**************************************************************************** */

PRINT 'Creando tablas ...';
-- ORDEN DE CRACION DE TABLAS
--01
	CREATE TABLE JJFG.USUARIO (
	Usua_ID 			INT IDENTITY(1,1)	  NOT NULL, -- [PK]
	Usua_Username   	NVARCHAR(255)         NOT NULL, 
	Usua_Password		VARBINARY(255)		  NOT NULL,
	Usua_Login_Fallidos	TINYINT,
	Usua_Habilitado     BIT
	);
		
--02
	CREATE TABLE JJFG.ROL (
	Rol_ID			    TINYINT	IDENTITY(1,1) NOT NULL, -- [PK]
	Rol_Nombre			VARCHAR(50)			  NOT NULL,
	Rol_Habilitado  	BIT
    );

--03
	CREATE TABLE JJFG.ROL_X_USUARIO (
	RxU_Usua_Id		INT,      -- [FK] Ref a USUARIO.Usua_ID
	RxU_Rol_Id		TINYINT   -- [FK] Ref a ROL.Rol_ID
    );

--04
	CREATE TABLE JJFG.FUNCIONALIDAD (
	Func_ID   			TINYINT IDENTITY(1,1) NOT NULL, -- [PK]
	Func_Nombre			VARCHAR(50)
	);

--05
	CREATE TABLE JJFG.FUNCIONALIDAD_X_ROL (
	FxR_Rol_Id  		TINYINT , -- [FK] Ref a ROL.Rol_ID
	FxR_Func_Id     	TINYINT   -- [FK] Ref a FUNCIONALIDAD.Func_ID
	);

--06
	CREATE TABLE JJFG.ADMINISTRADOR (
	Admin_Usua_Id	    INT            NOT NULL,-- [FK] Ref a USUARIO.Usua_ID
	Admin_Nombre		NVARCHAR(255)  NOT NULL,
	);

--07
	CREATE TABLE JJFG.PROVEEDOR (
	Provee_ID   	           NUMERIC (18,0) IDENTITY(1,1) NOT NULL,-- [PK] 
	Provee_Usua_Id		       INT,                                  -- [FK] Ref a USUARIO.Usua_ID
	Provee_Cuit                NVARCHAR(20),  -- Único                        
	Provee_Razon_Social        NVARCHAR(100), -- Único
	Provee_Mail                NVARCHAR(255),  
	Provee_Telefono            NUMERIC (18,0), 
	Provee_Direccion           NVARCHAR(100), 
	Provee_Codigo_Postal       INT, 
	Provee_Ciudad              NVARCHAR(255),
    Provee_Rubro               NVARCHAR(100),
	Provee_Nombre_Contacto     NVARCHAR(255),
	Provee_Habilitado          BIT 
	);

--08
	CREATE TABLE JJFG.CLIENTE (
	Clie_ID   	            NUMERIC (18,0) IDENTITY(1,1) NOT NULL,-- [PK] 
	Clie_Usua_Id		    INT,                                  -- [FK] Ref a USUARIO.Usua_ID
	Clie_Nombre             NVARCHAR(255), 
	Clie_Apellido           NVARCHAR(255),  
	Clie_Dni                NUMERIC (18,0), -- Único
	Clie_Mail               NVARCHAR(255),
	Clie_Telefono           NUMERIC (18,0), 
	Clie_Direccion          NVARCHAR(255), 
	Clie_Ciudad             NVARCHAR(255),
	Clie_Codigo_Postal      INT,
	Clie_Fecha_Nacimiento   DATETIME,
	Clie_Credito_Monto      NUMERIC (18,2),
	Clie_Habilitado         BIT    
	);

--09
	CREATE TABLE JJFG.TIPO_PAGO (
	Tipo_Pago_ID            TINYINT IDENTITY(1,1) NOT NULL, --[PK] 
	Tipo_Pago_Descripcion   NVARCHAR(100) 
    );
	
--10
	CREATE TABLE JJFG.CARGA (
	Carga_Clie_Id           NUMERIC (18,0), -- [FK] Ref a CLIENTE.Clie_ID 
	Carga_Tipo_Pago_Id      TINYINT,        -- [FK] Ref a TIPO_PAGO.Tipo_Pago_ID
	Carga_Fecha             DATETIME,
    Carga_Monto             NUMERIC (18,2),
	);

--11
	CREATE TABLE JJFG.OFERTA (
	Oferta_ID                    INT IDENTITY(1,1) NOT NULL, -- [PK]
    Oferta_Codigo                NVARCHAR(50),      
	Oferta_Provee_Id             NUMERIC (18,0),             -- [FK] Ref a PROVEEDOR.Provee_ID 
	Oferta_Descripcion           NVARCHAR(255),
    Oferta_Fecha_Inicio          DATETIME,
    Oferta_Fecha_Vencimiento     DATETIME,
	Oferta_Fecha_Publicacion     DATETIME,
    Oferta_Precio_Lista          NUMERIC (18,2), 
	Oferta_Precio_Oferta         NUMERIC (18,2),
	Oferta_Stock_Disponile       INT,
	Oferta_Cantidad_Maxima       INT,
	Oferta_Porcentaje_Descuento  NUMERIC(18,4)
	);


--12
	CREATE TABLE JJFG.COMPRA (
	Compra_ID       	        INT IDENTITY(1,1) NOT NULL, -- [PK] 
	Compra_Clie_Id              NUMERIC (18,0), -- [FK] Ref a CLIENTE.Clie_ID
	Compra_Clie_Dest_Id         NUMERIC (18,0), -- [FK] Ref a CLIENTE.Clie_ID   
	Compra_Oferta_Id		    INT,            -- [FK] Ref a OFERTA.Oferta_ID 
	Compra_Cantidad             INT,  
	Compra_Fecha                DATETIME,
	Compra_Fecha_Vencimiento    DATETIME,
	Compra_Fecha_Entregado      DATETIME
	);

--13
	CREATE TABLE JJFG.FACTURACION (
	Facturacion_Provee_Id        NUMERIC (18,0),  -- [FK] Ref a PROVEEDOR.Provee_ID
	Facturacion_Fecha_Inicio     DATETIME, 
	Facturacion_Fecha_Fin        DATETIME,
    Facturacion_Factura_Fecha    DATETIME, 
	Facturacion_Factura_Numero   NUMERIC (18,0),
	Facturacion_Factura_Importe  NUMERIC (18,2) 
	); 


PRINT 'Tablas Creadas ...';

/* ****************************************************************************
* SECCION_4 : DEFINICIÓN DE CONSTRAINTS
**************************************************************************** */

PRINT 'Definiendo Constraints  Claves Primarias,  Check,  Unique ...';

--01
	ALTER TABLE JJFG.USUARIO ADD CONSTRAINT PK_Usua_ID PRIMARY KEY(Usua_ID);
	ALTER TABLE JJFG.USUARIO ADD CONSTRAINT UQ_Usua_Username UNIQUE (Usua_Username);
	ALTER TABLE JJFG.USUARIO ADD CONSTRAINT DF_Usua_Login_Fallidos DEFAULT 0 FOR Usua_Login_Fallidos;
	ALTER TABLE JJFG.USUARIO ADD CONSTRAINT CK_Usua_Habilitado CHECK (Usua_Habilitado  = 1 OR Usua_Habilitado  = 0)
	ALTER TABLE JJFG.USUARIO ADD CONSTRAINT DF_Usua_Habilitado  DEFAULT 1 FOR Usua_Habilitado

--02
	ALTER TABLE JJFG.ROL ADD CONSTRAINT PK_Rol_ID PRIMARY KEY(Rol_ID);
	ALTER TABLE JJFG.ROL ADD CONSTRAINT CK_Rol_Habilitado CHECK (Rol_Habilitado = 1 OR Rol_Habilitado = 0);
	ALTER TABLE JJFG.ROL ADD CONSTRAINT DF_Rol_Habilitado  DEFAULT 1 FOR Rol_Habilitado ;

--03
	-- JJFG.ROL_X_USUARIO          NO TIENE PK

--04
	ALTER TABLE JJFG.FUNCIONALIDAD ADD CONSTRAINT PK_Func_ID PRIMARY KEY(Func_ID);

--05
	-- JJFG.FUNCIONALIDAD_X_ROL    NO TIENE PK

--06

     -- JJFG.ADMINISTRADOR    NO TIENE PK          

--07

	ALTER TABLE JJFG.PROVEEDOR ADD CONSTRAINT PK_Provee_ID PRIMARY KEY (Provee_ID);

	ALTER TABLE JJFG.PROVEEDOR ADD CONSTRAINT UQ_Provee_Cuit UNIQUE (Provee_Cuit);
	
	ALTER TABLE JJFG.PROVEEDOR ADD CONSTRAINT CK_Provee_Habilitado CHECK (Provee_Habilitado  = 1 OR Provee_Habilitado  = 0)
	ALTER TABLE JJFG.PROVEEDOR ADD CONSTRAINT DF_Provee_Habilitado  DEFAULT 1 FOR Provee_Habilitado


--08

	ALTER TABLE JJFG.CLIENTE ADD CONSTRAINT PK_Clie_ID PRIMARY KEY(Clie_ID);

	ALTER TABLE JJFG.CLIENTE ADD CONSTRAINT UQ_Usua_Clie_Dni UNIQUE (Clie_Dni);
	
	ALTER TABLE JJFG.CLIENTE ADD CONSTRAINT CK_Clie_Habilitado CHECK (Clie_Habilitado  = 1 OR Clie_Habilitado  = 0)
	ALTER TABLE JJFG.CLIENTE ADD CONSTRAINT DF_Clie_Habilitado  DEFAULT 1 FOR Clie_Habilitado

--09

	ALTER TABLE JJFG.TIPO_PAGO ADD CONSTRAINT PK_Tipo_Pago_ID PRIMARY KEY(Tipo_Pago_ID);
	
--10

	-- JJFG.CARGA  NO TIENE PK
	
--11

	ALTER TABLE JJFG.OFERTA ADD CONSTRAINT PK_Oferta_ID PRIMARY KEY(Oferta_ID);

--12

	ALTER TABLE JJFG.COMPRA ADD CONSTRAINT PK_Compra_ID PRIMARY KEY(Compra_ID);

--13

	-- JJFG.FACTURACION  NO TIENE PK


PRINT 'Definiendo Constraints  Claves Foraneas ...';

--01
	-- JJFG.USUARIO   NO TIENE FK
	
--02
	-- JJFG.ROL       NO TIENE FK

--03
	ALTER TABLE JJFG.ROL_X_USUARIO ADD CONSTRAINT FK_RxU_Usua_Id FOREIGN KEY (RxU_Usua_Id) REFERENCES JJFG.USUARIO(Usua_ID);
	ALTER TABLE JJFG.ROL_X_USUARIO ADD CONSTRAINT FK_RxU_Rol_Id FOREIGN KEY (RxU_Rol_Id) REFERENCES JJFG.ROL(Rol_ID);

--04
	-- JJFG.FUNCIONALIDAD    NO TIENE FK

--05
	ALTER TABLE JJFG.FUNCIONALIDAD_X_ROL ADD CONSTRAINT FK_FxR_Rol_Id  FOREIGN KEY (FxR_Rol_Id ) REFERENCES JJFG.ROL(Rol_ID);
	ALTER TABLE JJFG.FUNCIONALIDAD_X_ROL ADD CONSTRAINT FK_FxR_Func_Id  FOREIGN KEY (FxR_Func_Id ) REFERENCES JJFG.FUNCIONALIDAD(Func_ID);

--06

	ALTER TABLE JJFG.ADMINISTRADOR ADD CONSTRAINT FK_Admin_Usua_Id FOREIGN KEY (Admin_Usua_Id) REFERENCES JJFG.USUARIO(Usua_ID);

--07

	ALTER TABLE JJFG.PROVEEDOR ADD CONSTRAINT FK_Provee_Usua_Id FOREIGN KEY (Provee_Usua_Id) REFERENCES JJFG.USUARIO(Usua_ID);

--08

    ALTER TABLE JJFG.CLIENTE ADD CONSTRAINT FK_Clie_Usua_Id FOREIGN KEY (Clie_Usua_Id) REFERENCES JJFG.USUARIO(Usua_ID);

--09

    -- JJFG.TIPO_PAGO   NO TIENE FK

--10

	ALTER TABLE JJFG.CARGA ADD CONSTRAINT FK_Carga_Clie_Id FOREIGN KEY (Carga_Clie_Id) REFERENCES JJFG.CLIENTE(Clie_ID);
	ALTER TABLE JJFG.CARGA ADD CONSTRAINT FK_Carga_Tipo_Pago_Id FOREIGN KEY (Carga_Tipo_Pago_Id) REFERENCES JJFG.TIPO_PAGO(Tipo_Pago_ID);

--11

	ALTER TABLE JJFG.OFERTA ADD CONSTRAINT FK_Oferta_Provee_Id FOREIGN KEY (Oferta_Provee_Id) REFERENCES JJFG.PROVEEDOR(Provee_ID);

--12

	ALTER TABLE JJFG.COMPRA ADD CONSTRAINT FK_Compra_Oferta_Id FOREIGN KEY (Compra_Oferta_Id) REFERENCES JJFG.OFERTA(Oferta_ID);
    ALTER TABLE JJFG.COMPRA ADD CONSTRAINT FK_Compra_Clie_Id FOREIGN KEY (Compra_Clie_Id) REFERENCES JJFG.CLIENTE(Clie_ID);
	
	
--13

	ALTER TABLE JJFG.FACTURACION ADD CONSTRAINT FK_Facturacion_Provee_Id FOREIGN KEY (Facturacion_Provee_Id) REFERENCES JJFG.PROVEEDOR(Provee_ID);

PRINT 'Constraints Definidas ...';

/* ****************************************************************************
* SECCION_5 : MIGRACION DE DATOS DE TABLA MAESTRA
**************************************************************************** */

PRINT 'Cargando las Tablas ...';

--01 Carga de Tabla "ROL"

	INSERT INTO JJFG.ROL (Rol_Nombre)
	VALUES
	    ('ADMINISTRADOR'), 
		('CLIENTE'),
		('PROVEEDOR');

    PRINT 'Tabla ROL Cargada';
		       
			-- SELECT * FROM JJFG.ROL

-- 02 Carga de Tabla "FUNCIONALIDAD"

	INSERT INTO JJFG.FUNCIONALIDAD (Func_Nombre)
	VALUES
	    ('ABM de ROL'), 
		('ABM de CLIENTES'),
		('ABM de PROVEEDOR'),
		('REGISTRAR USUARIO'),
		('CARGAR CREDITO'),
		('CONFECCION y PUBLICACION de OFERTAS'),
		('COMPRAR OFERTA'),
		('ENTREGA / CONSUMO de OFERTA'),
		('FACTURACION a PROVEEDOR'),
		('EDITAR LISTADO ESTADISTICO');


		 PRINT 'Tabla FUNCIONALIDAD Cargada';

			-- SELECT * FROM JJFG.FUNCIONALIDAD

--03 Carga de Tabla "FUNCIONALIDAD_X_ROL"

	INSERT INTO JJFG.FUNCIONALIDAD_X_ROL (FxR_Rol_Id, FxR_Func_Id)

	    (SELECT R.Rol_ID, F.Func_ID FROM  JJFG.ROL R, JJFG.FUNCIONALIDAD F WHERE Rol_Nombre = 'ADMINISTRADOR');

   INSERT INTO JJFG.FUNCIONALIDAD_X_ROL (FxR_Rol_Id, FxR_Func_Id) 
   VALUES
	    ((SELECT Rol_ID FROM  JJFG.ROL  WHERE Rol_Nombre = 'CLIENTE'), (SELECT Func_ID FROM JJFG.FUNCIONALIDAD WHERE Func_Nombre = 'REGISTRAR USUARIO')),
		((SELECT Rol_ID FROM  JJFG.ROL  WHERE Rol_Nombre = 'CLIENTE'), (SELECT Func_ID FROM JJFG.FUNCIONALIDAD WHERE Func_Nombre = 'CARGAR CREDITO')),
		((SELECT Rol_ID FROM  JJFG.ROL  WHERE Rol_Nombre = 'CLIENTE'), (SELECT Func_ID FROM JJFG.FUNCIONALIDAD WHERE Func_Nombre = 'COMPRAR OFERTA')),
		
		((SELECT Rol_ID FROM  JJFG.ROL  WHERE Rol_Nombre = 'PROVEEDOR'), (SELECT Func_ID FROM JJFG.FUNCIONALIDAD WHERE Func_Nombre = 'REGISTRAR USUARIO')),
		((SELECT Rol_ID FROM  JJFG.ROL  WHERE Rol_Nombre = 'PROVEEDOR'), (SELECT Func_ID FROM JJFG.FUNCIONALIDAD WHERE Func_Nombre = 'CONFECCION y PUBLICACION de OFERTAS')),
		((SELECT Rol_ID FROM  JJFG.ROL  WHERE Rol_Nombre = 'PROVEEDOR'), (SELECT Func_ID FROM JJFG.FUNCIONALIDAD WHERE Func_Nombre = 'ENTREGA / CONSUMO de OFERTA'));
		
			
        PRINT 'Tabla FUNCIONALIDAD_X_ROL Cargada';
        
			-- SELECT * FROM JJFG.FUNCIONALIDAD_X_ROL 	

-- 04 Carga de Tabla "USUARIO"

	INSERT INTO JJFG.USUARIO (Usua_Username, Usua_Password, Usua_Login_Fallidos) 
	VALUES 
		('admin', HASHBYTES('SHA2_256','w23e'),'0'), 
		('Jose', HASHBYTES('SHA2_256','Jose'),'0'), 
		('Juan', HASHBYTES('SHA2_256','Juan'),'0'), 
		('Fernando', HASHBYTES('SHA2_256','Fernando'),'0'),
		('Gustavo', HASHBYTES('SHA2_256','Gustavo'),'0');

	PRINT 'Tabla USUARIO Cargada';
	
	   -- select * from JJFG.USUARIO

--05 Carga de Tabla "JJFG.ROL_X_USUARIO"

	INSERT JJFG.ROL_X_USUARIO (RxU_Usua_Id, RxU_Rol_Id)
	VALUES ((SELECT Usua_ID FROM JJFG.USUARIO WHERE Usua_Username = 'admin' ),(SELECT Rol_ID FROM JJFG.ROL WHERE Rol_Nombre = 'ADMINISTRADOR')),
	       ((SELECT Usua_ID FROM JJFG.USUARIO WHERE Usua_Username = 'Jose' ),(SELECT Rol_ID FROM JJFG.ROL WHERE Rol_Nombre = 'CLIENTE')), 
		   ((SELECT Usua_ID FROM JJFG.USUARIO WHERE Usua_Username = 'Juan' ),(SELECT Rol_ID FROM JJFG.ROL WHERE Rol_Nombre = 'CLIENTE')),
	       ((SELECT Usua_ID FROM JJFG.USUARIO WHERE Usua_Username = 'Fernando' ),(SELECT Rol_ID FROM JJFG.ROL WHERE Rol_Nombre = 'PROVEEDOR')),
	       ((SELECT Usua_ID FROM JJFG.USUARIO WHERE Usua_Username = 'Gustavo' ),(SELECT Rol_ID FROM JJFG.ROL WHERE Rol_Nombre = 'PROVEEDOR'));
		   
    PRINT 'Tabla FROL_X_USUARIO Cargada';

	-- SELECT * FROM JJFG.ROL_X_USUARIO  

-- 06 Carga de Tabla "ADMINISTRADOR"

	INSERT INTO JJFG.ADMINISTRADOR (Admin_Usua_Id, Admin_Nombre) 
	VALUES 
		 ((SELECT Usua_ID FROM  JJFG.USUARIO  WHERE Usua_Username = 'admin'), 'Administrador General')

    
	PRINT 'Tabla ADMINISTRADOR Cargada';

	-- select * from JJFG.ADMINISTRADOR

-- 07 Carga de Tabla "JJFG.PROVEEDOR"

	INSERT INTO JJFG.PROVEEDOR (Provee_Cuit, Provee_Razon_Social, Provee_Telefono, Provee_Direccion, Provee_Ciudad, Provee_Rubro) 
    SELECT DISTINCT Provee_CUIT, Provee_RS, Provee_Telefono, Provee_Dom, Provee_Ciudad, Provee_Rubro
	FROM gd_esquema.Maestra
	WHERE Provee_Cuit IS NOT NULL

    PRINT 'Tabla PROVEEDOR Cargada';

	-- SELECT * FROM JJFG.PROVEEDOR

-- 08 Carga de Tabla "JJFG.CLIENTE"


	SELECT DISTINCT Cli_Dni, Carga_Credito, Carga_Fecha, Tipo_Pago_Desc INTO #CLIENTE_CARGA_CREDITO_TEMP FROM gd_esquema.Maestra

	INSERT INTO JJFG.CLIENTE (Clie_Nombre, Clie_Apellido, Clie_Dni, Clie_Mail, Clie_Telefono, Clie_Direccion, Clie_Ciudad, Clie_Fecha_Nacimiento, Clie_Credito_Monto)
    SELECT DISTINCT M.Cli_Nombre, M.Cli_Apellido, M.Cli_Dni, M.Cli_Mail, M.Cli_Telefono, M.Cli_Direccion, M.Cli_Ciudad, M.Cli_Fecha_Nac,
	               (SELECT SUM(T.Carga_Credito) FROM #CLIENTE_CARGA_CREDITO_TEMP T WHERE T.Cli_Dni = M.Cli_Dni AND T.Carga_Credito IS NOT NULL) 
	FROM gd_esquema.Maestra M
	WHERE Cli_Nombre IS NOT NULL
		
	DROP TABLE #CLIENTE_CARGA_CREDITO_TEMP

	PRINT 'Tabla CLIENTE Cargada';
	
	-- SELECT * FROM JJFG.CLIENTE

-- 09 Carga de Tabla "JJFG.TIPO_PAGO"

	INSERT INTO JJFG.TIPO_PAGO (Tipo_Pago_Descripcion)
    SELECT DISTINCT Tipo_Pago_Desc 
	FROM gd_esquema.Maestra
	WHERE Tipo_Pago_Desc IS NOT NULL

	PRINT 'Tabla TIPO_PAGO Cargada';

	-- SELECT * FROM JJFG.TIPO_PAGO

-- 10 Carga de Tabla "JJFG.CARGA"

 	INSERT INTO JJFG.CARGA (C.carga_Clie_Id, Carga_Tipo_Pago_Id, Carga_Fecha, Carga_Monto)
    SELECT C.Clie_ID, TP.Tipo_Pago_ID, M.Carga_Fecha, M.Carga_Credito
	FROM JJFG.CLIENTE C LEFT JOIN gd_esquema.Maestra M ON C.Clie_Dni = M.Cli_Dni JOIN JJFG.TIPO_PAGO TP ON M.Tipo_Pago_Desc = TP.Tipo_Pago_Descripcion
	GROUP BY C.Clie_ID, TP.Tipo_Pago_ID, M.Carga_Fecha, M.Carga_Credito

	PRINT 'Tabla CARGA Cargada';

	--SELECT * FROM JJFG.CARGA
	
-- 11 Carga de Tabla "JJFG.OFERTA"

	INSERT INTO JJFG.OFERTA (Oferta_Codigo, Oferta_Provee_Id, Oferta_Descripcion, Oferta_Fecha_Inicio, Oferta_Fecha_Vencimiento,Oferta_Fecha_Publicacion, Oferta_Precio_Lista, Oferta_Precio_Oferta, Oferta_Porcentaje_Descuento)
    SELECT DISTINCT Oferta_Codigo, P.Provee_ID, M.Oferta_Descripcion, M.Oferta_Fecha, M.Oferta_Fecha_Venc, M.Oferta_Fecha,M.Oferta_Precio_Ficticio, M.Oferta_Precio, (1 - (M.Oferta_Precio / M.Oferta_Precio_Ficticio)) 
	FROM gd_esquema.Maestra M RIGHT JOIN JJFG.PROVEEDOR P ON M.Provee_CUIT = P.Provee_Cuit

	PRINT 'Tabla OFERTA Cargada';

	--SELECT * FROM JJFG.OFERTA
	
-- 12 Carga de Tabla "JJFG.COMPRA"

    /*Levantamos en una tabla temporal a todos los clientes con su fecha de compra y su fecha de entrega*/
	SELECT C.Clie_ID, O.Oferta_ID, M.Oferta_Cantidad, M.Oferta_Fecha_Compra, M.Oferta_Entregado_Fecha 
	INTO #TEMPORAL_COMPRA_COMPLETA 
	FROM gd_esquema.Maestra M JOIN JJFG.CLIENTE C ON M.Cli_Dni = C.Clie_Dni
	                          JOIN JJFG.OFERTA O ON M.Oferta_Codigo = O.Oferta_Codigo 
	WHERE M.Oferta_Codigo IS NOT NULL AND M.Oferta_Entregado_Fecha IS NULL

   
   /*levantamos en otra tabla temporal a todos los clientes que hayan retirado su compra, es decir con el campo Oferta_Entregado_Fecha en NOT NULL */
    SELECT C.Clie_ID, O.Oferta_ID, M.Oferta_Cantidad, M.Oferta_Fecha_Compra, M.Oferta_Entregado_Fecha 
	INTO #TEMPORAL_COMPRA_ENTREGADA 
	FROM gd_esquema.Maestra M JOIN JJFG.CLIENTE C ON M.Cli_Dni = C.Clie_Dni
	                          JOIN JJFG.OFERTA O ON M.Oferta_Codigo = O.Oferta_Codigo 
	WHERE M.Oferta_Codigo IS NOT NULL AND M.Oferta_Entregado_Fecha IS NOT NULL

	/*Hacemos un merge con las dos tablas temporales para cargar la tabla JJFG.COMPRA*/
	INSERT INTO JJFG.COMPRA(Compra_Clie_Id, Compra_Oferta_Id, Compra_Cantidad, Compra_Fecha, Compra_Fecha_Entregado)
	SELECT TCC.Clie_ID, TCC.Oferta_ID, TCC.Oferta_Cantidad, TCC.Oferta_Fecha_Compra, TCE.Oferta_Entregado_Fecha 
	FROM #TEMPORAL_COMPRA_COMPLETA TCC LEFT JOIN #TEMPORAL_COMPRA_ENTREGADA TCE 
	ON TCC.Clie_ID = TCE.Clie_ID AND
	   TCC.Oferta_ID = TCE.Oferta_ID AND
	   TCC.Oferta_Cantidad = TCE.Oferta_Cantidad AND
	   TCC.Oferta_Fecha_Compra = TCE.Oferta_Fecha_Compra

   	DROP TABLE #TEMPORAL_COMPRA_COMPLETA
	DROP TABLE #TEMPORAL_COMPRA_ENTREGADA

	PRINT 'Tabla COMPRA Cargada';
   
    --SELECT * FROM JJFG.COMPRA

-- 13 Carga de Tabla "JJFG.FACTURACION"

	INSERT INTO JJFG.FACTURACION (Facturacion_Provee_Id, Facturacion_Factura_Fecha, Facturacion_Factura_Numero)
    SELECT Provee_ID, M.Factura_Fecha, M.Factura_Nro FROM JJFG.PROVEEDOR P JOIN gd_esquema.Maestra M ON P.Provee_Razon_Social = M.Provee_RS 
	WHERE M.Factura_Fecha IS NOT NULL
	
	PRINT 'Tabla FACTURACION Cargada';

   -- SELECT * FROM JJFG.FACTURACION

PRINT 'Tablas Cargadas ...'	


/* ****************************************************************************
* SECCION_6 : CREACIÓN DE OBJETOS DE BASE DE DATOS A UTILIZAR
              VIEWS, FUNCTIONS, PROCEDURES, TRIGGERS
**************************************************************************** */

GO
IF OBJECT_ID ('JJFG.VerificarPassword') IS NOT NULL
   DROP PROCEDURE JJFG.VerificarPassword; 
GO

GO
CREATE PROCEDURE JJFG.VerificarPassword @usu_password varchar(255)
as
   select Usua_Username from JJFG.USUARIO where Usua_Password = HASHBYTES('SHA2_256',@usu_password)
GO

--exec JJFG.VerificarPassword 'w23e'



GO
IF OBJECT_ID ('JJFG.VerificarCuentaHabilitada') IS NOT NULL
   DROP PROCEDURE JJFG.VerificarCuentaHabilitada; 
GO

GO
CREATE PROCEDURE JJFG.VerificarCuentaHabilitada @usu_id int
as
   select Usua_Username from JJFG.USUARIO where Usua_ID = @usu_id and 
                                                Usua_Login_Fallidos < 3 and
												Usua_Habilitado = 1
GO

-- exec JJFG.VerificarCuentaHabilitada '3'


/*
GO
IF OBJECT_ID ('JJFG.Fn_obtenerLoginFallidos') IS NOT NULL
   DROP FUNCTION JJFG.Fn_obtenerLoginFallidoss; 
GO

GO
CREATE FUNCTION  JJFG.Fn_obtenerLoginFallidos (@usu_id int)
returns int
as
  Begin
    Declare @cantidad int 
    set @cantidad = (select Usua_Login_Fallidos from JJFG.USUARIO where Usua_ID = @usu_id)
	Return(@cantidad)
  End
GO

-- select JJFG.Fn_obtenerLoginFallidos (3)
*/

GO
IF OBJECT_ID ('JJFG.obtenerLoginFallidos') IS NOT NULL
   DROP PROCEDURE JJFG.obtenerLoginFallidos; 
GO

GO
CREATE PROCEDURE JJFG.obtenerLoginFallidos @usu_id int
as
   select Usua_Login_Fallidos from JJFG.USUARIO where Usua_ID = @usu_id
GO


-- exec JJFG.obtenerLoginFallidos '3'


GO
IF OBJECT_ID ('JJFG.SumarUnLoginFallido') IS NOT NULL
   DROP PROCEDURE JJFG.SumarUnLoginFallido ; 
GO

GO
CREATE PROCEDURE JJFG.SumarUnLoginFallido @usu_id int
as
   UPDATE JJFG.USUARIO
   SET Usua_Login_Fallidos = Usua_Login_Fallidos + 1
   WHERE Usua_ID = @usu_id AND Usua_ID != 1
GO


-- execute JJFG.SumarUnLoginFallido '1'


GO
IF OBJECT_ID ('JJFG.ResetearLoginFallido') IS NOT NULL
   DROP PROCEDURE JJFG.ResetearLoginFallido ; 
GO

GO
CREATE PROCEDURE JJFG.ResetearLoginFallido @usu_id int
as
   UPDATE JJFG.USUARIO
   SET Usua_Login_Fallidos = 0
   WHERE Usua_ID = @usu_id
GO

-- execute JJFG.ResetearLoginFallido '3'


GO
IF OBJECT_ID ('JJFG.TraerRolId') IS NOT NULL
   DROP PROCEDURE JJFG.TraerRolId; 
GO

GO
CREATE PROCEDURE JJFG.TraerRolId @usu_id int
as
   select Rol_ID from JJFG.ROL join ROL_X_USUARIO on Rol_ID = RxU_Rol_Id
                               join USUARIO on RxU_Usua_Id = Usua_ID  
   where Usua_ID = @usu_id
GO


--exec JJFG.TraerRolId '5'