# Airbnb Smoke Test with Robot Framework
## Test Product
This suite contains simple test demo for www.airbnb.com. Airbnb is an online market platform for homestay and lodging for vacation rental and tourism activities (reference: wikipedia). 

## Test Scope
The scope of this project is limited to the functional testing of the features described in the following session of this document. Non-functional testing like stress,performance is beyond scope of this project.

## Test Environment
Please read reqirements.txt for the required packages information. The browser is Chrown. The device needs to be connected to internet.

## Test limitations and risk
Airbnb web page is of a dynamic web format, where the xpath of some elements might change if the size of the browser is changed. Therefore, some test cases requiring xpath variables might fail.

In addition, some test cases related entering invalid phone number might fail, due to Airbnb page robot detector, or it already reaches the maximum attempts in a time frame. They need some improvement, or otherwise need to droped from the automated test.

## Specifications & Requirement:
### Basic search based on location
* User can search for accommodations by inputting city names \n
### Basic login errors
* User can not login with empty phone number input \n
* User can not login with fake phone number \n
* User can not enter letters into phone number input field \n
