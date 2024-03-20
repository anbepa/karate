function fn() {
    karate.configure('connectTimeout', 20000);
    karate.configure('readTimeout', 20000);
    karate.configure ('ssl', true);

    var baseUrl = karate.properties['baseUrl'] || 'https://#{business-service}#-internal-#{env}#.apps.#{domain-name}#.com'
    var projectName = karate.properties['projectName'] || 'super-svp'
    var channel = karate.properties['channel'] || '#{channel-name}#'

    return {
        api: {
           baseUrl : baseUrl + '/'+projectName+ '/api/v1'
        }
    };
}