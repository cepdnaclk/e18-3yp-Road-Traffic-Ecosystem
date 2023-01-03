import  requests


class Response(object):
    def __init__(self):
        self.headers = {
            'Accept-Encoding': 'gzip, deflate, sdch',
            'Accept-Language': 'en-US,en;q=0.8',
            'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36',
            'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
            'Referer': 'http://www.wikipedia.org/',
            'Connection': 'keep-alive'}
        self.url = " https://13bc-18-179-204-141.ngrok.io/find_nearest_users?longtitude=79.93994&latitude=-1.17222"

    @property
    def get(self):
        try:
            r = requests.get(url=self.url, headers= self.headers, timeout=5)
            if r.ok:
                return r
            else:
                return None
        except requests.exceptions.Timeout:
            return 'Bad Response'

resp=Response()
print(resp.get.json())