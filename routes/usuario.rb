require 'sinatra'
require 'json'

# Para login
post '/usuario/login' do
  body = request.body.read
  data = JSON.parse(body)

  correo = data['correo']
  contrasena = data['contrasena']

  status 500
  resp = ''

  begin 
    record = Usuario.where(correo: correo, contrasena: contrasena).first

    if record then
      status 200
      resp = record.to_json
    else
      status 404
      resp = 'Correo y/o contraseña incorrectos'
    end
    rescue Sequel::DatabaseError => e
      status = 500
      resp = 'Error al acceder a la base de datos'
      puts e.message
    rescue StandardError => e
      status = 500
      resp = 'Ocurrió un error no esperado al validar el usuario'
      puts e.message
    end

  status status
  return resp
end


# Para recuperar contraseña
post '/usuario/validar' do
  body = request.body.read
  data = JSON.parse(body)

  correo = data['correo']

  status 500
  resp = ''

  begin 
    record = Usuario.where(correo: correo).first

    if record then
      status 200
      resp = 'Correo encontrado'
      # logica de postmark
    else
      status 404
      resp = 'Correo no encontrado'
    end
    rescue Sequel::DatabaseError => e
      status = 500
      resp = 'Error al acceder a la base de datos'
      puts e.message
    rescue StandardError => e
      status = 500
      resp = 'Ocurrió un error no esperado al validar el usuario'
      puts e.message
    end

    status status
    return resp
end

post '/usuario/registro' do
  content_type :json

  # Obtener los parámetros requeridos
  nombres = params[:nombres]
  apellidos = params[:apellidos]
  fecha_nacimiento_str = params[:fecha_nacimiento]
  correo = params[:correo]
  celular = params[:celular]
  contrasena = params[:contrasena]

  # Obtener los parámetros opcionales
  altura = params[:altura]
  peso = params[:peso]
  sexo = params[:sexo]
  condiciones_medicas = params[:condiciones_medicas]
  alergias = params[:alergias]
  otros = params[:otros]

  resp = ''

  # Validación de campos requeridos
  if [nombres, apellidos, fecha_nacimiento_str, correo, celular, contrasena].any?(&:nil?)
    status = 400
    resp = 'Faltan completar campos requeridos'
  else
    # Verificar que el correo no esté registrado
    begin
      existing_user = Usuario.where(correo: correo).first
      if existing_user
        status = 409
        resp = 'El correo ya está registrado'
      else
        # Convertir la fecha de nacimiento al formato de Date en Ruby
        begin
          fecha_nacimiento = Date.strptime(fecha_nacimiento_str, '%d/%m/%Y')
        rescue ArgumentError
          status = 400
          resp = 'La fecha de nacimiento no está en el formato correcto (dd/mm/yyyy)'
        else
          # Crear el usuario en la base de datos con campos opcionales
          begin
            usuario = Usuario.create(
              nombres: nombres,
              apellidos: apellidos,
              fecha_nacimiento: fecha_nacimiento,
              correo: correo,
              contrasena: contrasena,
              celular: celular,
              altura: altura.nil? || altura.empty? ? nil : altura,
              peso: peso.nil? || peso.empty? ? nil : peso,
              sexo: sexo.nil? || sexo.empty? ? nil : sexo,
              condiciones_medicas: condiciones_medicas.nil? || condiciones_medicas.empty? ? nil : condiciones_medicas,
              alergias: alergias.nil? || alergias.empty? ? nil : alergias,
              otros: otros.nil? || otros.empty? ? nil : otros
            )
            status = 201
            resp = 'Usuario registrado exitosamente'
          rescue Sequel::DatabaseError => e
            status = 500
            resp = 'Error al guardar en la base de datos'
            puts e.message
          end
        end
      end
    rescue Sequel::DatabaseError => e
      status = 500
      resp = 'Error al acceder a la base de datos'
      puts e.message
    end
  end

  status status
  return resp
end