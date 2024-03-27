Feature: Register

  Background:
    * configure headers = {'Content-Type': 'application/json'}
    * url urlBase
    * def sleep = function(pause) { java.lang.Thread.sleep(pause) }
    * def client_ID = null
    * def token = null
    * def generateRandomEmail =
      """
      function() {
        var chars = 'abcdefghijklmnopqrstuvwxyz1234567890';
        var randomString = '';
        for (var i = 0; i < 10; i++) {
          var randomIndex = Math.floor(Math.random() * chars.length);
          randomString += chars.charAt(randomIndex);
        }
        return randomString + '@example.com';
      }
      """

    * def generateRandomPhoneNumber =
      """
      function() {
        var prefix = '+5730';
        var randomNumber = '';
        for (var i = 0; i < 8; i++) {
          randomNumber += Math.floor(Math.random() * 10);
        }
        return prefix + randomNumber;
      }
      """


  Scenario: Crud Register


    # Register
    Given path '/api/auth/register'
    And request {"name":"Test","last_name":"Test","phone":"+573014148410","birthdate":"2000-10-10","email":"anretanto@gmail.com","password":"aBc123*"}
    And method Post
    Then status 200
    And def client_ID = response.user.id
    And karate.set('client_ID', client_ID)


    # Login
    Given path '/api/auth/login'
    And request {"email":"anretanto@gmail.com","password":"aBc123*"}
    And method POST
    Then status 200
    And def responseToken = response.access_token
    And karate.set('token', responseToken)

    # Update User
    Given path '/api/users'
    * def randomEmail = generateRandomEmail()
    * def phone = generateRandomPhoneNumber()
    And request {"name":"Tesdt","last_name":"Tedst","birthdate":"2000-10-10","gender":"F","email":"#(randomEmail)","phone":"#(phone)","economic_dependent":1,"linkedin_url":"https://www.google.com/","twitter_url":"https://www.google.com/","facebook_url":"https://www.google.com/","instagram_url":"https://www.google.com/"}
    And header Authorization = 'Bearer ' + karate.get('token')
    When method PATCH
    Then status 200

   # Delete User
    Given path '/api/users/' + karate.get('client_ID')
    And request {"reason": "Ejemplo de ejemplof"}
    And header Authorization = 'Bearer ' + karate.get('token')
    When method DELETE
    Then status 200

