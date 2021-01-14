clear all
clc 
 
mm = importdata("pumsb.dat")


diary('D:\Temp\Result.txt')
   
tic;
result = setcover(mm);

 
tp = transpose(result)
sum(result(:)==1)
 toc
diary('off');
