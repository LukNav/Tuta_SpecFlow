Feature: PostCodeTest
	As a UK citizen
	I want a postcode lookup
	Because I want to find out more information about it

Background: 
	Given I am using the base url 'http://api.postcodes.io/postcodes/' value

Scenario Outline: As a Service I validate values in API Response
	Given I setup the request to GET using the provided '<postCode>' value
	When I send the request
	Then I should receive a response
	And I should have received a status code of '200' value  
	And I validate eastings should have '<eastings>' and northings should have '<northings>' values
	And I validate code of district administration '<code_adminDistrict>' value
    And I validate Response Object  field '<responseObject>' should have '<ResponseObjectValue>' value


	
	Examples: 
	| postCode | responseCode | country          | eastings | northings | code_adminDistrict | responseObject | ResponseObjectValue        |
	| LS3 1EP  | 200          | England          | 429320   | 433751    | E08000035          | nhs_ha         | Yorkshire and the Humber   |
	| WA2 9QU  | 200          | England          | 360639   | 390679    | E06000007          | nhs_ha         | North West                 |
	| BT30 8HE | 200          | Northern Ireland | 346246   | 341931    | N09000010          | nhs_ha         | Health & Social Care Board |
	| SE7 7NR  | 200          | England          | 540987   | 178168    | E09000011          | nhs_ha         | London                     |
	| SY3 9DX  | 200          | England          | 347535   | 310803    | E06000051          | nhs_ha         | West Midlands              |
	| ---      | ---          | ---              | ---      | ---       | ---                | ---            | ---                        |
	| LT-0000  | 404          |                  |          |           |                    | nhs_ha         |                            |
	| GMFV+7H  | 404          | Ireland          |          |           |                    |                |                            |
	| LS3 1EP  | 200          | England          | 429320   | 433751    | E08000035          | lsoa           | Leeds 063B                 |
	| LS3 1EP  | 200          | England          | 429320   | 433751    | E08000035          | msoa           | Leeds 063                  |
# tasks:
#	
#	1) Create an assertion that checks if the returned status code is 200 (use HttpResponseMessage.StatusCode )

#	2) Create an assertion that would validate: country
#	3) Create an assertion that would validate: eastings, northings
#	4) Create an assertion that would validate: codes.admin_district

#   

#	5) Complete the examples table with more test cases 
#		- it MUST contain a negative test
#		- there should be atleast 4 test cases (this is with the negative test case)

#	6) Add an additional assertion that validates either: nhs_ha, lsoa, msoa

#		e.g. responseObject has the field which will be checked, 
#		ResponseObjectValue has the value it's tested against 

#(3 different object)
#	| postCode	| responseObject | ResponseObjectValue		|
#	| LS3 1EP 	| nhs_ha		 | Yorkshire and the Humber |
#	| LS3 1EP	| longitude      | Leeds 063B				|
#	| LS3 1EP	| latitude       | Leeds 063				|  


# Notes: 
# Good postcodes: LS3 1EP, NR34 2PF, OX49 5NU, M32 0JG, NE30 1DP

# The example's first test case has everything filled for tasks 1-5, you still need to add columns for task 6 thou!

# For task 6, is recomendet to use a switch statement rather than multiple nested if statements
# https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/keywords/switch
# https://www.csharp-examples.net/switch/