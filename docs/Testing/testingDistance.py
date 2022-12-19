import unittest
import closerPoints


#def distance(lat1, lat2, lon1, lon2)

class TestCloserPoints(unittest.TestCase):

    def test_distance(self):
        self.assertEqual(closerPoints.distance(6.0540,6.9328,80.2008,79.8580),105)
        self.assertEqual(closerPoints.distance(6.0540,7.3046,80.2008,80.6281),147)
        self.assertEqual(closerPoints.distance(6.9328,7.3046,79.8580,80.6281),94)


if __name__ == '__main__':
    unittest.main()

