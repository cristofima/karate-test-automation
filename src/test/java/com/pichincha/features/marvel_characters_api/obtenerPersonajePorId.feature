@REQ_MARVEL-002 @HU002 @get_character_by_id @marvel_characters_api @Agente2 @E2 @iniciativa_marvel
Feature: MARVEL-002 Obtener personaje por ID (microservicio para gestión de personajes de Marvel)
  
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
  
  @id:1 @obtenerPersonajePorId @solicitudExitosa200
  Scenario: T-API-MARVEL-002-CA01-Obtener personaje por ID exitosamente 200 - karate
    * path username, 'api', 'characters', '1'
    When method GET
    Then status 200
    # And match response != null
    # And match response.id == 1

  @id:2 @obtenerPersonajePorId @noEncontrado404
  Scenario: T-API-MARVEL-002-CA02-Obtener personaje por ID no existente 404 - karate
    * path username, 'api', 'characters', '9999'
    When method GET
    Then status 404
    # And match response.error == 'Character not found'
    # And match response contains { error: '#notnull' }

  @id:3 @obtenerPersonajePorId @errorServicio500
  Scenario: T-API-MARVEL-002-CA03-Obtener personaje por ID con error interno 500 - karate
    * path username, 'api', 'characters', '-1'
    * configure retry = { count: 1, interval: 500 }
    When method GET
    Then status 500
    # And match response.error != null
    # And match response.status == 500
