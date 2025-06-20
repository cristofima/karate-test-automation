function fn() {    
  var env = karate.env || 'local';
  karate.log('karate.env system property was:', env);
  
  // Configuración base para todos los entornos
  var config = {
    baseUrl: 'http://bp-se-test-cabcd9b246a5.herokuapp.com'
  };
  
  // URLs para todos los microservicios (nombrados con formato port_nombre_microservicio)
  config.port_marvel_characters_api = 'http://bp-se-test-cabcd9b246a5.herokuapp.com';
  config.username = 'crcorona';
  
  // Configuración específica por entorno
  if (env == 'dev') {
    config.baseUrl = 'http://bp-se-test-cabcd9b246a5.herokuapp.com';
    config.port_marvel_characters_api = 'http://bp-se-test-cabcd9b246a5.herokuapp.com';
    config.username = 'crcorona';
  } 
  else if (env == 'qa') {
    config.baseUrl = 'http://bp-se-test-cabcd9b246a5.herokuapp.com';
    config.port_marvel_characters_api = 'http://bp-se-test-cabcd9b246a5.herokuapp.com';
    config.username = 'crcorona';
  }
  
  return config;
}
