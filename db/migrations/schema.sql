CREATE TABLE estado_suscripcion (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    descripcion VARCHAR(40)
);

CREATE TABLE tipo_suscripcion (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    descripcion VARCHAR(40)
);

CREATE TABLE usuarios (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    nombres VARCHAR(40),
    apellidos VARCHAR(40),
    fecha_nacimiento DATE,
    correo VARCHAR(40),
    contrasena VARCHAR(40),
    altura FLOAT,
    peso FLOAT,
    sexo CHAR(1),
    condiciones_medicas TEXT,
    alergias TEXT,
    celular INT,
    otros VARCHAR(40)
);

CREATE TABLE estado_receta (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    descripcion VARCHAR(40)
);

CREATE TABLE boticas (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    nombre VARCHAR(40),
    logo VARCHAR(30),
    cantidad_productos INT
);

CREATE TABLE productos (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    nombre VARCHAR(40),
    marca VARCHAR(40),
    precio FLOAT,
    descripcion TEXT,
    contraindicaciones TEXT,
    advertencias TEXT,
    imagen VARCHAR(30),
    presentacion VARCHAR(40),
    requiere_receta BOOLEAN,
    id_botica INT,
    FOREIGN KEY (id_botica) REFERENCES boticas(id)
);

CREATE TABLE recetas (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    fecha DATE,
    imagen VARCHAR(40),
    id_usuario INT,
    id_producto INT,
    id_estado INT,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id),
    FOREIGN KEY (id_producto) REFERENCES productos(id),
    FOREIGN KEY (id_estado) REFERENCES estado_receta(id)
);

CREATE TABLE suscripciones (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    costo FLOAT,
    fecha_inicio DATE,
    fecha_fin DATE,
    precio_total FLOAT,
    metodo_pago VARCHAR(40),
    id_usuario INT,
    id_estado INT,
    id_tipo_suscripcion INT,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id),
    FOREIGN KEY (id_estado) REFERENCES estado_suscripcion(id),
    FOREIGN KEY (id_tipo_suscripcion) REFERENCES tipo_suscripcion(id)
);

CREATE TABLE kits (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    subtotal FLOAT,
    id_suscripcion INT,
    FOREIGN KEY (id_suscripcion) REFERENCES suscripciones(id)
);

CREATE TABLE productos_kits (
    cantidad INT,
    id_kit INT,
    id_producto INT,
    FOREIGN KEY (id_kit) REFERENCES kits(id),
    FOREIGN KEY (id_producto) REFERENCES productos(id)
);

CREATE TABLE estado_envio (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    descripcion VARCHAR(40)
);

CREATE TABLE direcciones (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    departamento VARCHAR(40),
    distrito VARCHAR(40),
    direccion VARCHAR(40),
    numero INT
);

CREATE TABLE envios (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    fecha_envio DATE,
    id_estado_envio INT,
    id_kit INT,
    id_direccion INT,
    FOREIGN KEY (id_estado_envio) REFERENCES estado_envio(id),
    FOREIGN KEY (id_kit) REFERENCES kits(id),
    FOREIGN KEY (id_direccion) REFERENCES direcciones(id)
);
