function config() {
    var env = karate.env; // obtener la propiedad del sistema 'karate.env' en build.gradle
    karate.log('karate.env system property was:', env);
    karate.configure('ssl', true);
    karate.configure('logPrettyResponse', false);

    if (!env) {
        env = 'local'; // un valor predeterminado personalizado
    }

    var config = {
        useCustomAuth: true,
        urlBase: 'https://060f-2001-1388-80d-ed0d-cd41-18d7-17b7-ed75.ngrok-free.app' // Valor predeterminado de urlBase
    };

    if (env == 'dev') {
        config.urlBase = 'https://ml9c4hwuh4.execute-api.us-east-2.amazonaws.com/dev';
    } else if (env == 'cer') {
        config.urlBase = 'https://ml9c4hwuh4.execute-api.us-east-2.amazonaws.com/dev';
    } else if (env == 'local') {
        config.urlBase = 'https://060f-2001-1388-80d-ed0d-cd41-18d7-17b7-ed75.ngrok-free.app';
    }

    var access_token = (function() {
        var login_data = karate.read('classpath:data/login.json');
        var response = karate.callSingle('classpath:karate/GetToken/token.feature', login_data[0]);
        var token = response.response.access_token;
        karate.configure('headers', { 'Authorization': 'Bearer ' + token });
        //return token;
    })();

    karate.configure('connectTimeout', 5000);
    karate.configure('readTimeout', 5000);
    return config; // Agregar esta línea para devolver la variable config
}