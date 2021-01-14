clear all
clc

Max_Gen= 500;
Max_FES= 500;
Particle_Number= 20;

tic;

%each row indicates a set
% mm = [1 5 3 0; 2 1 3 0; 4 0 0 0;1 2 3 5];
mm=importdata('pumsb.dat');

[gbest,gbestval,cg_curve,sol_best]= PSO_func3(mm,Max_Gen,Max_FES,Particle_Number);
sol_best            % best sequence of 1/0
gbestval            % best result after summation
toc  
