# Python 3 program to calculate Distance Between Two Points on Earth
from math import radians, cos, sin, asin, sqrt
def distance(lat1, lat2, lon1, lon2):
     
    # The math module contains a function named
    # radians which converts from degrees to radians.
    lon1 = radians(lon1)
    lon2 = radians(lon2)
    lat1 = radians(lat1)
    lat2 = radians(lat2)
      
    # Haversine formula
    dlon = lon2 - lon1
    dlat = lat2 - lat1
    a = sin(dlat / 2)**2 + cos(lat1) * cos(lat2) * sin(dlon / 2)**2
 
    c = 2 * asin(sqrt(a))
    
    # Radius of earth in kilometers. Use 3956 for miles
    r = 6371
      
    # calculate the result
    return round(c * r)
     
     
# driver code
'''lat1 = 53.32055555555556
lat2 = 53.31861111111111
lon1 = -1.7297222222222221
lon2 =  -1.6997222222222223
print(distance(lat1, lat2, lon1, lon2), "K.M")'''


#negative latitiude southern hemisphere
#negative longitude western hemisphere

'''
Galle
lati 6.0540
lon 80.2008

Colombo
lati 6.9328
lon 79.8580

Kandy
lati 7.3046
lon 80.6281


galle to colombo = 105
galle to Kandy = 147
colombo to kandy = 94

'''
point1lat = 53.32055555555556
point1lon = -1.7297222222222221

latitude = [45,67,87,23,45,89,43,42,53.4,53.32055555555556]
longitude = [-1.3,-2.1,-3.6,-1.7,-1.5,-1.4,-2.5,-1.7,-1.7,-1.7297222222222221]

closerPoints = []

for i in range(0, len(latitude)):
    if(point1lat>0 and latitude[i]<0):
        continue
    elif(point1lat<0 and latitide[i]>0):
        continue
    elif(point1lon>0 and longitude[i]<0):
        continue
    elif(point1lon<0 and longitude[i]>0):
        continue
    else:
        dist = distance(point1lat, latitude[i], point1lon, longitude[i])

    if(dist<=20):
        closerPoints.append(i)

for j in range(len(closerPoints)):
    print (closerPoints[j])
