import json
file = open('read.txt','r')
Lines = file.readlines()
obj = {

}
for line in Lines:
    text = line.strip()
    # split comments
    split_comment = text.split('%')
    if len(split_comment[0]) > 0:
        split = split_comment[0].split('=')

        if len(split) > 1:
            name = split[0].lower().strip()
            value = split[1]
            print("Property : {} Value : {}".format(name.lower(),value))
            value = value.strip().replace(';', '')

            bolum_index = value.find('/')
            if bolum_index > -1:
                value_split = value.split('/')
                value = str(float(value_split[0]) / float(value_split[1]))

            #scientific_notation = value.find('e')
            #if scientific_notation > -1:
            #    value = format(float(value), ".8f")
            # Time ı değiştirmeliyiz formatı farklı
            if name != 'time':
                obj[name] = format(float(value), ".8f")
                continue
            obj[name] = value
            

# Serializing json
json_object = json.dumps(obj, indent=4)
 
# Writing to sample.json
with open("sample.json", "w") as outfile:
    outfile.write(json_object)
