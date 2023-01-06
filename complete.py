import json

GRAPHICS = ["S_gas_co2"] # TODO DENEY DATASI YOKSA PROGRAM ÇÖKMEMELİ
## Matlab çalıştırma ve output alma

import matlab.engine

eng = matlab.engine.start_matlab()
tf = eng.adm1init(nargout=1)

f = open("result-final.json", "w+")
f.write(str(tf))


## Output düzenleme

fp = open('result-final.json')
inputs  = json.load(fp)
fp.close()

# Input order
order = ["Ssu", "Saa", "Sfa", "Sva", "Sbu", "Spro", "Sac", "Sh2", "Sch4", "SIC", "SIN", "SI", "Xxc", "Xch", "Xpr", "Xli", "Xsu", "Xaa","Xfa", "Xc4", "Xpro", "Xac", "Xh2", "XI", "Scat", "San", "Shva", "Shbu", "Shpro", "Shac", "Shco3", "Snh3", "S_H_ion", "S_gas_h2", "S_gas_ch4", "S_gas_co2", "q_gas", "Xhomo", "XCE", "Slac", "Sca"]

final = {}
time = 0.0
for result in inputs:
    obj = {}
    print(result)
    print("RESULT LEN :{} - ORDER LEN : {}".format(len(result), len(order)))
    if len(result) == len(order):
        for ids, element in enumerate(order):
            obj[order[ids]] = format(result[ids],".8f")
        final[str(time)] = obj
        time = round(time + 0.2, 2)



with open('timebased-final.json', 'w+', encoding='utf-8') as f:
    json.dump(final, f, ensure_ascii=False, indent=4)

## Open graph

import matplotlib.pyplot as plt

fp = open('timebased-final.json')
data  = json.load(fp)
fp.close()

fp = open('deneydata.json')
deney_data = json.load(fp)
fp.close()

for graph in GRAPHICS:
    graph_x = []
    graph_y = []
    deney_x = []
    deney_y = []
    for key, value in data.items():
        graph_x.append(float(key))
        graph_y.append(float(value[graph]))
    for key, value in deney_data.items():
        if graph in value:
            if float(value[graph]) > -1:
                deney_x.append(float(key))
                deney_y.append(float(value[graph]))


    plt.plot(graph_x, graph_y)
    plt.scatter(deney_x, deney_y)
    # naming the x axis
    plt.xlabel('x - time')
    # naming the y axis
    plt.ylabel('y - axis')
    
    # giving a title to my graph
    plt.title('{} vs time'.format(graph))


    # function to show the plot
    plt.show()