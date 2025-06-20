@REQ_MARVEL-004 @HU004 @update_character @marvel_characters_api @Agente2 @E2 @iniciativa_marvel
Feature: MARVEL-004 Actualizar personaje por ID (microservicio para gestión de personajes de Marvel)
  
  Background:
    * url port_marvel_characters_api
    * def generarHeaders =
      """
      function() {
        return {
          "Content-Type": "application/json"
        };
      }
      """
    * def headers = generarHeaders()
    * headers headers
    * def timestamp = function() { return new Date().getTime() }
  
  @id:1 @actualizarPersonaje @solicitudExitosa200
  Scenario: T-API-MARVEL-004-CA01-Actualizar personaje exitosamente 200 - karate
    # Primero creamos un personaje
    * def crearPersonaje =
      """
      function() {
        var request = karate.read('classpath:data/marvel_characters_api/request_create_character.json');
        request.name = 'Test Character-' + new Date().getTime();
        var response = karate.call('classpath:com/pichincha/features/marvel_characters_api/crearPersonaje.feature@id:1', { jsonData: request });
        return response.response;
      }
      """
    * def personaje = call crearPersonaje
    * def personajeId = personaje.id

    # Luego lo actualizamos
    * path username, 'api', 'characters', personajeId
    * def jsonData = read('classpath:data/marvel_characters_api/request_update_character.json')
    * set jsonData.name = personaje.name
    * set jsonData.description = 'Updated description ' + timestamp()
    And request jsonData
    When method PUT
    Then status 200
    # And match response != null
    # And match response.id == personajeId
    # And match response.description contains 'Updated'

  @id:2 @actualizarPersonaje @noEncontrado404
  Scenario: T-API-MARVEL-004-CA02-Actualizar personaje no existente 404 - karate
    * path username, 'api', 'characters', '9999'
    * def jsonData = read('classpath:data/marvel_characters_api/request_update_character.json')
    And request jsonData
    When method PUT
    Then status 404
    # And match response.error == 'Character not found'
    # And match response contains { error: '#notnull' }

  @id:3 @actualizarPersonaje @datosInvalidos400
  Scenario: T-API-MARVEL-004-CA03-Actualizar personaje con datos inválidos 400 - karate
    # Primero creamos un personaje
    * def crearPersonaje =
      """
      function() {
        var request = karate.read('classpath:data/marvel_characters_api/request_create_character.json');
        request.name = 'Test Character-' + new Date().getTime();
        var response = karate.call('classpath:com/pichincha/features/marvel_characters_api/crearPersonaje.feature@id:1', { jsonData: request });
        return response.response;
      }
      """
    * def personaje = call crearPersonaje
    * def personajeId = personaje.id
    
    * path username, 'api', 'characters', personajeId
    * def jsonData = read('classpath:data/marvel_characters_api/request_invalid_character.json')
    And request jsonData
    When method PUT
    Then status 400
    # And match response.name == 'Name is required'
    # And match response.alterego == 'Alterego is required'

  @id:4 @actualizarPersonaje @errorServicio500
  Scenario: T-API-MARVEL-004-CA04-Actualizar personaje con error interno 500 - karate
    * path username, 'api', 'characters', '-1'
    * def jsonData = read('classpath:data/marvel_characters_api/request_update_character.json')
    * set jsonData.name = '"; DROP TABLE characters; --'
    * configure retry = { count: 1, interval: 500 }
    And request jsonData
    When method PUT
    Then status 500
    # And match response.error != null
    # And match response.status == 500
