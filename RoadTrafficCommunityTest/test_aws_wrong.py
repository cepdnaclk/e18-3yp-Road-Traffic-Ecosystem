import unittest
from unittest.mock import patch
import unittest
from aws_wrong import Response_wrong


class TestResponse(unittest.TestCase):
    def test_aws_reponse(self):
        # fake_json = [{'Res':"Location Updated"}]
        fake_json = {"Res": -1}
        with patch('Response.requests.get') as mock_get:
            mock_get.return_value.status_code = 200
            mock_get.return_value.json.return_value = fake_json


            obj = Response_wrong()
            response = obj.get
            print(response.json())

        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.json(), fake_json)

if __name__ == "__main__":
    unittest.main()