@REQ_MARVEL-005 @HU005 @delete_character @marvel_characters_api @Agente2 @E2 @iniciativa_marvel
Feature: MARVEL-005 Eliminar personaje por ID (microservicio para gestión de personajes de Marvel)
  
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
  
  @id:1 @eliminarPersonaje @solicitudExitosa204
  Scenario: T-API-MARVEL-005-CA01-Eliminar personaje exitosamente 204 - karate
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
    
    # Luego lo eliminamos
    * path username, 'api', 'characters', personajeId
    When method DELETE
    Then status 204
    And match response == ''

  @id:2 @eliminarPersonaje @noEncontrado404
  Scenario: T-API-MARVEL-005-CA02-Eliminar personaje no existente 404 - karate
    * path username, 'api', 'characters', '9999'
    When method DELETE
    Then status 404
    And match response.error == 'Character not found'
    And match response contains { error: '#notnull' }
