Feature: Get Token

  Background:
    Given url 'https://somos-grandes-api.whiz.pe'
    * def token = null
    * def login_data = read('classpath:data/login.json')

  Scenario: Get Authentication Token
    Given path '/api/auth/login'
    And request login_data[0]
    And header Content-Type = 'application/json'
    And method POST
    Then status 200
    And def responseToken = response.access_token
    And karate.set('token', responseToken)
    And karate.log('Token value:', karate.get('token'))
    And print 'Token received:', responseToken
    And match karate.get('token') == responseToken

