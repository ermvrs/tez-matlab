import matplotlib.pyplot as plt
import json

fp = open('timebased.json')
data  = json.load(fp)
fp.close()

graph_x = []
graph_y = []
for key, value in data.items():
    graph_x.append(float(key))
    graph_y.append(float(value["Sac"]))

print(graph_y)

plt.plot(graph_x, graph_y)
  
# naming the x axis
plt.xlabel('x - axis')
# naming the y axis
plt.ylabel('y - axis')
  
# giving a title to my graph
plt.title('Sac vs time')
  
# function to show the plot
plt.show()