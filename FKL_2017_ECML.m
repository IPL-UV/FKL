% Fair Kernel Learning
% http://isp.uv.es/
% Adrian Perez-Suay, 2017 (c) Copyright
% Contact: adrian.perez@uv.es
% Source code to reproduce the ECML 2017 paper: "Fair Kernel Learning"
% Authors: Adrian Perez-Suay, and Valero Laparra, and Gonzalo Mateo-Garcia, 
% and Jordi Mu~noz-Mari, and Luis Gomez-Chova, and Gustau Camps-Valls

close all, clear, clc
addpath(genpath('.'))

%% Small experimentation (low demanding)
exp = 1; %
% ECML'17 experimentation (high demanding)
% exp = 2; % uncomment this line

%% Experiment (SEX)
% Do the learning being independent to sex variable
% Fair Kernel Learning
FKL_sex
% Fair Dimensionality Reduction
FDR_sex

%% Experiment (SEX and RACE)
% Do the learning being independent to sex and race variables
% Fair Kernel Learning
FKL_sex_race
% Fair Dimensionality Reduction
FDR_sex_race

%% Draw results (both experiments)
draw_FKL
draw_FDR
