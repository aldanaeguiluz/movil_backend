require_relative 'database'

class Usuario < Sequel::Model(DB[:usuarios])
end

class Suscripcion < Sequel::Model(DB[:suscripciones])
end

class Kit < Sequel::Model(DB[:kits])
end

class ProductoKit < Sequel::Model(DB[:productos_kits])
end

class Producto < Sequel::Model(DB[:productos])
end

class Botica < Sequel::Model(DB[:boticas])
end

class TipoSuscripcion < Sequel::Model(DB[:tipo_suscripcion])
end

class Envio < Sequel::Model(DB[:envios])
end

class Receta < Sequel::Model(DB[:recetas])
end

class EstadoSuscripcion < Sequel::Model(DB[:estado_suscripcion])
end

class EstadoEnvio < Sequel::Model(DB[:estado_envio])
end

class EstadoReceta < Sequel::Model(DB[:estado_receta])
end

class Direccion < Sequel::Model(DB[:direcciones])
end
