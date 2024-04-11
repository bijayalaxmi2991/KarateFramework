Feature: Restful booker CRUD operations

Background:
Given url baseUrl
And path 'auth'
* def tokenPayload = 
"""
	{
    "username" : "admin",
    "password" : "password123"
	}
"""
And request tokenPayload
When method POST
* def token = "token="+response.token
* print token
Given url baseUrl
And header Cookie = "" + token
* configure headers = {Content-Type : 'application/json', Accept : 'application/json'}


#Scenario: GET BookingIDs
#And path 'booking'
#When method GET
#Then status 200
#* print response


#Scenario: GET Booking for an ID
#And path 'booking/2481'
#When method GET
#Then status 200
#* print response
#* def jsonResponse = response
#* def actFirstName = jsonResponse.firstname
#* def actLastName = jsonResponse.lastname
#* match actFirstName == 'Jake'
#* match actLastName == 'Smith'


Scenario: Create Booking POST

* def bookingPayload = 
"""
{
    "firstname" : "Bijaya",
    "lastname" : "Laxmi",
    "totalprice" : 2000,
    "depositpaid" : true,
    "bookingdates" : {
        "checkin" : "2024-02-02",
        "checkout" : "2024-02-05"
    },
    "additionalneeds" : "Breakfast"
}
"""
And path 'booking'
And request bookingPayload
When method POST
Then status 200
And match $.bookingid == "#present"
And match $.booking.firstname == "Bijaya"
And match $.booking.lastname == "Laxmi"
* def id = response.bookingid
* print response.bookingid
* print id

Scenario: Update Booking PUT

* def bookingPayload = 
"""
{
    "firstname" : "Bijaya1",
    "lastname" : "Laxmi1",
    "totalprice" : 2000,
    "depositpaid" : true,
    "bookingdates" : {
        "checkin" : "2024-02-02",
        "checkout" : "2024-02-05"
    },
    "additionalneeds" : "Breakfast"
}
"""
And path 'booking/' + id
And request bookingPayload
When method POST
Then status 200
And match $.booking.firstname == "Bijaya1"
And match $.booking.lastname == "Laxmi1"

