import json

fp = open('result.json')
inputs  = json.load(fp)
fp.close()

#order Ssu Saa Sfa Sva Sbu Spro Sac Sh2 Sch4 SIC SIN SI Xxc Xch Xpr Xli Xsu Xaa  Xfa Xc4 Xpro Xac Xh2 XI Scat San Shva Shbu Shpro Shac Shco3 Snh3 S_H_ion S_gas_h2 S_gas_ch4 S_gas_co2 q_gas Xhomo XCE Slac Sca
order = ["Ssu", "Saa", "Sfa", "Sva", "Sbu", "Spro", "Sac", "Sh2", "Sch4", "SIC", "SIN", "SI", "Xxc", "Xch", "Xpr", "Xli", "Xsu", "Xaa","Xfa", "Xc4", "Xpro", "Xac", "Xh2", "XI", "Scat", "San", "Shva", "Shbu", "Shpro", "Shac", "Shco3", "Snh3", "S_H_ion", "S_gas_h2", "S_gas_ch4", "S_gas_co2", "q_gas", "Xhomo", "XCE", "Slac", "Sca", "WRERRE"]

final = {}

for ids, result in enumerate(inputs):
    time = result.pop(0)
    final[str(time)] = result

print(final["0.01"])

with open('timebased.json', 'w', encoding='utf-8') as f:
    json.dump(final, f, ensure_ascii=False, indent=4)

## düzenleme böyle olmamalı
##tek obje içinde time : xx, sac : xx gibi ayırmalıyız