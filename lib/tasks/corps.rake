# lib/tasks/corps.rake
require 'json'
require 'set' 

namespace :corps do
  desc "Analiza un plan de combate de cazadores y demonios"
  task :analyse, [:file] => :environment do |t, args|

    # Verifica que se haya proporcionado un nombre de archivo
    unless args[:file]
      puts "Uso: rake corps:analyse[ruta_del_plan.json]"
      exit
    end

    # Carga y procesa el archivo JSON
    begin
        data = JSON.parse(File.read(args[:file]))
      rescue Errno::ENOENT
        puts "Error: El archivo '#{args[:file]}' no se encontró."
        exit
      rescue JSON::ParserError
        puts "Error: El archivo '#{args[:file]}' no es un JSON válido."
        exit
      end

    # Mapea los personajes a un hash para un acceso más rápido por su ID
    cazadores_hash = data['cazadores'].map { |c| [c['registro'], c] }.to_h
    demonios_hash = data['demonios'].map { |d| [d['registro'], d] }.to_h

    # Inicializa las variables de estado del combate
    plan_correcto = true
    combate_erroneo = nil
    cazadores_derrotados_count = 0
    demonios_derrotados_count = 0

    # Conjuntos para llevar el registro de los IDs de los personajes derrotados
    derrotados_cazadores_ids = Set.new
    derrotados_demonios_ids = Set.new

    # Itera sobre cada combate en el orden del archivo
    data['combates'].each do |combate|
      # Verifica si algún participante ya está derrotado
      cazadores_en_combate_ids = combate['cazadores']
      demonios_en_combate_ids = combate['demonios']

      if (cazadores_en_combate_ids.any? { |id| derrotados_cazadores_ids.include?(id) }) ||
         (demonios_en_combate_ids.any? { |id| derrotados_demonios_ids.include?(id) })
        plan_correcto = false
        combate_erroneo = combate['nombre']
        break
      end

      # Suma el poder de cada bando
      poder_cazadores = cazadores_en_combate_ids.sum { |id| cazadores_hash[id]['nivel_de_fuerza'] }
      poder_demonios = demonios_en_combate_ids.sum { |id| demonios_hash[id]['nivel_de_fuerza'] }

      # Determina el resultado del combate
      if poder_cazadores >= poder_demonios
        # Los cazadores ganan. Los demonios son derrotados.
        demonios_derrotados_count += demonios_en_combate_ids.size
        demonios_en_combate_ids.each { |id| derrotados_demonios_ids.add(id) }
      else
        # Los demonios ganan. Los cazadores son derrotados.
        cazadores_derrotados_count += cazadores_en_combate_ids.size
        cazadores_en_combate_ids.each { |id| derrotados_cazadores_ids.add(id) }
      end
    end

    # Imprime el resultado final
    if plan_correcto
      puts "Plan de combate correcto."
    else
      puts "Plan de combate incorrecto, en batalla \"#{combate_erroneo}\"."
    end
    puts "#{demonios_derrotados_count} demonios derrotados"
    puts "#{cazadores_derrotados_count} cazadores derrotados"
  end
end