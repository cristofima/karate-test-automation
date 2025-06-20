@REQ_MARVEL-003 @HU003 @create_character @marvel_characters_api @Agente2 @E2 @iniciativa_marvel
Feature: MARVEL-003 Crear personaje (microservicio para gestión de personajes de Marvel)
  
  Background:
    * url port_marvel_characters_api
    * path username, 'api', 'characters'
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
  
  @id:1 @crearPersonaje @solicitudExitosa201
  Scenario: T-API-MARVEL-003-CA01-Crear personaje exitosamente 201 - karate
    * def jsonData = read('classpath:data/marvel_characters_api/request_create_character.json')
    * set jsonData.name = 'Iron Man-' + timestamp()
    And request jsonData
    When method POST
    Then status 201
    And match response != null
    And match response.id != null

  @id:2 @crearPersonaje @nombreDuplicado400
  Scenario: T-API-MARVEL-003-CA02-Crear personaje con nombre duplicado 400 - karate
    * def jsonData = read('classpath:data/marvel_characters_api/request_create_character.json')
    And request jsonData
    When method POST
    Then status 400
    And match response.error == 'Character name already exists'
    And match response contains { error: '#notnull' }

  @id:3 @crearPersonaje @datosInvalidos400
  Scenario: T-API-MARVEL-003-CA03-Crear personaje con datos inválidos 400 - karate
    * def jsonData = read('classpath:data/marvel_characters_api/request_invalid_character.json')
    And request jsonData
    When method POST
    Then status 400
    And match response.name == 'Name is required'
    And match response.alterego == 'Alterego is required'
