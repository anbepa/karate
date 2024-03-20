Feature: Login

  Background: Define URL
    Given url urlBase
    * def fn = function(rsp) { return Object.keys(rsp) }

  @positiveCase
  Scenario: Validate login response structure
    * def login_data = read('classpath:data/login.json')
    * def response_login_data = read('classpath:data/response_login.json')
    Given path '/api/auth/login'
    And request login_data[0]
    When method Post
    Then status 200
    And match fn(response_login_data) contains ["status","message","access_token","token_type","first_login","user"]


  @negativeCase
  Scenario: Sign in with invalid email

    * def login_data = read('classpath:data/login.json')
    Given path '/api/auth/login'
    And request login_data[1]
    And method Post
    Then status 400
    And match response.message == 'This e-mail does not exist'
    * print karate.pretty(response)


  @negativeCase
  Scenario: Sign in with password  incorrect

    * def login_data = read('classpath:data/login.json')
    Given path '/api/auth/login'
    And request login_data[2]
    And method Post
    Then status 400
    And match response.message == 'This password is incorrect'
    * print karate.pretty(response)

  @negativeCase
  Scenario: Sign in with Invalid email

    * def login_data = read('classpath:data/login.json')
    Given path '/api/auth/login'
    And request login_data[3]
    And method Post
    Then status 400
    And match response.error[0] == 'email : Invalid email'
    * print karate.pretty(response)

