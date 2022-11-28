# 1) time vs Sac
# 2)time vs Spro
# 3)time vs Sbu
# 4)time vs Sva
# 5)time vs Sh2
# 6)time vs Sco2
# 7) time vs Xch
# 8) time vs Xpr
# 9) time vs Xli

import scipy
import json
import matlab.engine

fp = open('sample.json')
inputs  = json.load(fp)
fp.close()

eng = matlab.engine.start_matlab()
tf = eng.adm1init(nargout=1)
print('printing return')
# result dosyaya yazdır
print(tf)

f = open("result.txt", "w")
f.write(str(tf))

#result arrayinde sıralama şöyle
# ARRAY[SATIR][PROPERTY] => PROPERTY SIRALAMASI time, [Ssu Saa Sfa Sva Sbu Spro Sac Sh2 Sch4 SIC SIN SI Xxc Xch Xpr Xli Xsu Xaa  Xfa Xc4 Xpro Xac Xh2 XI Scat San Shva Shbu Shpro...
# Shac Shco3 Snh3 S_H_ion S_gas_h2 S_gas_ch4 S_gas_co2 q_gas Xhomo XCE Slac Sca] 
# İlk property time