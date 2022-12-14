import json

file = open('deneydata_raw.txt','r')
Lines = file.readlines()
time = 0.0
obj = {}
for idx, line in enumerate(Lines):
    if(idx == 0):
        continue
    split = line.split('_')
    obj[str(time)] = {
        "Sac" : format(float(split[0].replace('xxxx','-1').replace(',','.')), ".8f"),
        "Spro" : format(float(split[1].replace('xxxx','-1').replace(',','.')), ".8f"),
        "Sbu" : format(float(split[2].replace('xxxx','-1').replace(',','.')), ".8f"),
        "Sca" : format(float(split[3].replace('xxxx','-1').replace(',','.')), ".8f"),
        "Slac" : format(float(split[4].replace('xxxx','-1').replace(',','.').replace('\n','')), ".8f"),
    }
    time = time + 0.5


print(obj["0.0"])

json_object = json.dumps(obj, indent=4)
 
# Writing to sample.json
with open("deneydata.json", "w+") as outfile:
    outfile.write(json_object)