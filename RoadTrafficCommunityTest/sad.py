# import json
# from http import HTTPStatus
#
# import requests
#
# BASE_URL = "https://api.openweathermap.org/data/2.5/weather"
# API = BASE_URL + "?longtitude={lontitude}&latitude={latitude}"
# class WeatherInfo:
#     response: str
#
#     @classmethod
#     def from_dict(cls, data: dict) -> "WeatherInfo":
#         return cls(
#             response=data,
#         )
#
#
# def test_retrieve_weather_using_mocks(mocker, fake_weather_info):
#     """Given a city name, test that a HTML report about the weather is generated
#     correctly."""
#     # Creates a fake requests response object
#     fake_resp = mocker.Mock()
#     # Mock the json method to return the static weather data
#     fake_resp.json = mocker.Mock(return_value=fake_weather_info)
#     # Mock the status code
#     fake_resp.status_code = HTTPStatus.OK
#
#     mocker.patch("weather_app.requests.get", return_value=fake_resp)
#
#     weather_info = retrieve_weather(city="London")
#     assert weather_info == WeatherInfo.from_dict(fake_weather_info)
#
# def retrieve_weather(longtitude: float,latitude:float) -> WeatherInfo:
#     """Finds the weather for a city and returns a WeatherInfo instance."""
#     data = find_weather_for(longtitude,latitude)
#     return WeatherInfo.from_dict(data)
#
# def find_weather_for(longtitude: float,latitude:float) -> dict:
#     url = API.format(longtitude=longtitude, latitude=latitude)
#     resp = requests.get(url)
#     return resp.json()
#
# def fake_weather_info():
#     """Fixture that returns a static weather data."""
#     with open("tests/resources/weather.json") as f:
#         return json.load(f)