% M-file RMonod1.m
% Runs the Monod1 file
% Monod Kinetics with decay; Batch System

A=[time,out];

fid=fopen('ADM.xls', 'a+')
dlmwrite('ADM.xls',A,'\t')

fclose('all')
