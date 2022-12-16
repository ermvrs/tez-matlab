import matplotlib.pyplot as plt
import json

fp = open('timebased.json')
data  = json.load(fp)
fp.close()

fp = open('deneydata.json')
deney_data = json.load(fp)
fp.close()

graph_x = []
graph_y = []
deney_x = []
deney_y = []
for key, value in data.items():
    graph_x.append(float(key))
    graph_y.append(float(value["Sac"]))

for key, value in deney_data.items():
    if float(value["Sac"]) > -1:
        deney_x.append(float(key))
        deney_y.append(float(value["Sac"]))


plt.plot(graph_x, graph_y)
plt.scatter(deney_x, deney_y)
# naming the x axis
plt.xlabel('x - time')
# naming the y axis
plt.ylabel('y - axis')
  
# giving a title to my graph
plt.title('Sac vs time')


# function to show the plot
plt.show()

# DENEY DATA -1 ise data yok demek onları grafiğe işaretleme
#   DENEY DATA NOKTA OLARAK EKLENECEK