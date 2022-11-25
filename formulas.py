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
print(tf)