*** Settings ***
Documentation  This suite contains simple test demo for www.airbnb.com
Library  SeleniumLibrary
Test Teardown  Close All Browsers

*** Variables ***
${url_main}  https://www.airbnb.com
${url_login}  https://www.airbnb.com/login
${browser}  chrome
${location}  New York
${fake_number}  123456
${lettersStr}  abcdef
${xpathToCountry}  //*[@id="country"]
${Finland_code}  358FI

*** Test Cases ***
User can search for accommodations by inputting city names
    [Documentation]  The user can search for accommodations based on the location
    Given The user have opened the page
    When The user enter the destination city and click search
    Then The user can find a list of accommodations located in the destination city

User can not login with empty phone number input
    [Documentation]  The user can not continue to login if no phone number is entered
    Given The user opened the login page
    When The user click on the Continue button
    Then There is error about empty phone number shown on the page

User can not login with fake phone number
    [Documentation]  The user can not login by entering fake phone number
    Given The user opened the login page
    When The user change the country code to Finland if it was not
    And The user enter an invalid number  ${fake_number}
    Then There is error about a fake phone number

User can not enter letters into phone number input field
    [Documentation]  The phone number input can not take letters as input
    Given The user opened the login page
    When The user enter an invalid number  ${lettersStr}
    Then There is error about empty phone number shown on the page

*** Keywords ***
The user have opened the page
    Open Browser  ${url_main}  ${browser}
    ${Get_title}    Get Title
    Should Be Equal As Strings
    ...  ${Get_title}
    ...  Airbnb: Vacation Rentals, Cabins, Beach Houses, Unique Homes & Experiences
    Page Should Contain Element  id:bigsearch-query-attached-location-input
    Page Should Contain  Not sure where to go? Perfect.
    Sleep  5s

The user enter the destination city and click search
    Input Text   id:bigsearch-query-attached-location-input  ${location}
    Submit Form
    Wait Until Page Contains  Stays in ${location}
    Sleep  5s

The user can find a list of accomations located in the destination city
    Page Should Contain  Stays in ${location}
    Page Should Contain Element  id:menuItemButton-room_type
    Page Should Contain Element  id:menuItemButton-price_range
    Page Should Contain Element  id:menuItemButton-flexible_cancellation

The user opened the login page
    Open Browser  ${url_login}  ${browser}
    ${Get_title}    Get Title
    Should Be Equal As Strings  ${Get_title}   	Log In / Sign Up
    Wait Until Page Contains Element  id:phoneInputphoneNumber
    Page Should Contain  Welcome to Airbnb
    Sleep  5s

The user click on the Continue button
    Submit Form
    Sleep  3s

There is error about empty phone number shown on the page
    Page Should Contain Element  id:phone-number-error-phoneNumber
    Page Should Contain    Phone number is required.

The user enter an invalid number
    [Arguments]   ${input_number}
    Input Text  id:phoneInputphoneNumber  ${input_number}
    Submit Form
    Sleep  3s

The user change the country code to Finland if it was not
    ${Get_country}  Get Selected List Value   ${xpathToCountry}
    Run Keyword If  '${Get_country}' != '${Finland_code}'
    ...  Select From List By Value  ${xpathToCountry} ${Finland_code}
    Sleep  3s
    Page Should Contain  ${Finland_code}

There is error about a fake phone number
    Page Should Contain
    ...  We can't send a code to this phone number. Try using a different one.
