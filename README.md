# Fair Kernel Learning (FKL) and Feature Analysis Tools

**Version:** 1.0  
**Release Date:** 2017

## Overview
This repository provides the Fair Kernel Learning (FKL) implementation and tools for Feature Discriminative Ratio (FDR) and Feature Kernel Learning (FKL) analysis. The repository also includes utilities for visualization, kernel learning, and fairness-driven learning methods, as presented in the ECML 2017 paper:

**"Fair Kernel Learning"**  
**Authors:** Adrian Perez-Suay, Valero Laparra, Gonzalo Mateo-Garcia, Jordi Muñoz-Marí, Luis Gomez-Chova, Gustau Camps-Valls  
**Image Processing Laboratory (IPL)** - [http://isp.uv.es/](http://isp.uv.es/)

This repository offers utilities for performing fair kernel learning with demographic-aware tools for fairness analysis, particularly for attributes like sex and race.

## Features
- **Fair Kernel Learning (FKL):** Implementation of fairness-aware learning methods.
- **FDR Computation:** Calculate Feature Discriminative Ratios (FDR) for datasets.
- **FKL Computation:** Perform Feature Kernel Learning (FKL) for fairness-based feature selection.
- **Demographic Analysis:** Specific scripts to analyze fairness performance by demographic subgroups.
- **Visualization Tools:**
  - `draw_FDR.m`: Plot FDR results.
  - `draw_FKL.m`: Visualize FKL results.
- **Pre-Loaded Datasets:** Supports a9a dataset from LIBSVM and UCI repositories.

## Usage
### Example 1: Run Fair Kernel Learning (FKL)
Run the main script `FKL_2017_ECML.m` to perform Fair Kernel Learning.

```matlab
% Fair Kernel Learning Example
clear; clc; close all;

% Set experiment type for exact reproduction
exp = 2;

% Run the main FKL function
FKL_2017_ECML;
```
**Important Note:** To reproduce the experimental setup exactly as in the ECML 2017 paper, set the variable `exp` to `2` (`exp = 2;`) in the script `FKL_2017_ECML.m`.

### Example 2: Compute Feature Discriminative Ratio (FDR)
Run `FDR.m` to compute the Feature Discriminative Ratio for your dataset.

```matlab
% FDR Example
clear; clc; close all;

% Load or define data
X = rand(100, 10); % 100 samples, 10 features
Y = randi([0, 1], 100, 1); % Binary class labels

% Compute FDR
FDR_scores = FDR(X, Y);

% Display results
disp('Feature Discriminative Ratios:');
disp(FDR_scores);
```

### Example 3: Visualize FDR Results
Use `draw_FDR.m` to visualize FDR scores.

```matlab
% Visualize FDR
FDR_scores = rand(1, 10); % Example FDR scores for 10 features
draw_FDR(FDR_scores);

% Plot customization
title('Feature Discriminative Ratios');
xlabel('Features');
ylabel('FDR Score');
```

### Example 4: Compute Feature Kernel Learning (FKL)
Run `FKL.m` to compute FKL values for your dataset.

```matlab
% FKL Example
clear; clc; close all;

% Load or define data
X = rand(100, 10); % 100 samples, 10 features
Y = randi([0, 1], 100, 1); % Binary class labels

% Compute FKL
FKL_scores = FKL(X, Y);

% Display FKL scores
disp('Feature Kernel Learning Scores:');
disp(FKL_scores);
```

### Example 5: Analyze Fairness by Demographics (Sex and Race)
Run specific scripts to analyze FDR and FKL for specific demographic groups.

```matlab
% Example: FKL analysis by sex
FKL_sex;

% Example: FKL analysis by sex and race
FKL_sex_race;
```

### Example 6: Use Radial Basis Function (RBF) Kernel
Use `rbf.m` to compute the RBF kernel for your data.

```matlab
% RBF Kernel Example
X1 = rand(10, 5);
X2 = rand(8, 5);
sigma = 1.0;

% Compute RBF kernel
K = rbf(X1, X2, sigma);
disp('RBF Kernel Matrix:');
disp(K);
```

## Dataset
The dataset used in this project is the a9a dataset from LIBSVM and UCI repositories.

- **Original source:** LIBSVM datasets  
- **Additional info:** UCI Machine Learning Repository  
The dataset was converted to Octave/GNU format using `libsvmread` from LIBSVM.

## Installation
1. Clone the repository:

```bash
git clone https://github.com/IPL-UV/FKL.git
cd fair-kernel-learning
```

2. Add paths to MATLAB:

```matlab
addpath(pwd);
```

3. Verify your MATLAB environment and ensure all functions are accessible.

## Authors
- **Adrian Perez-Suay**  
- **Valero Laparra**  
- **Gonzalo Mateo-Garcia**  
- **Jordi Muñoz-Marí**  
- **Luis Gomez-Chova**  
- **Gustau Camps-Valls**  

**Image Processing Laboratory (IPL)** - [http://isp.uv.es/](http://isp.uv.es/)

**Contact:** [adrian.perez@uv.es](mailto:adrian.perez@uv.es)

## License
```
Copyright (c) 2017  adrian.perez@uv.es, gustau.camps@uv.es

All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

- Redistributions of source code must retain the above copyright notice,
  this list of conditions and the following disclaimer.
- Redistributions in binary form must reproduce the above copyright notice,
  this list of conditions and the following disclaimer in the documentation
  and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
POSSIBILITY OF SUCH DAMAGE.
```

