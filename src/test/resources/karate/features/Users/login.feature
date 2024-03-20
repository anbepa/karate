Feature: Login

  Background: Define URL
    Given url urlBase
    * def fn = function(rsp) { return Object.keys(rsp) }
    * def response = {"status":true,"message":"User authenticated successfully","access_token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiNjFhMzNhNjAtZTUxMy0xMWVkLWI3MTEtM2IzY2FjMWRhZGY2IiwiaWF0IjoxNjgzNjg4OTE5LCJleHAiOjE2ODM3NzUzMTl9.-jjtCaaDT9FjTNuJMa6vakzMgkZejnFwbdni2P3gFkw","token_type":"Bearer","expires":"1d","user":{"id":"61a33a60-e513-11ed-b711-3b3cac1dadf6","fullname":"Test","nickname":"Test","email":"prueba2@prueba2.com"}}


  @positiveCase
  Scenario: Validate login response structure
    * def login_data = read('classpath:data/login.json')
    * def response_login_data = read('classpath:data/response_login.json')
    Given path '/api/auth/login'
    And request login_data[0]
    When method Post
    Then status 200
    And match fn(response_login_data) contains ["status","message","access_token","token_type","expires","user"]


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

