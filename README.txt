This is a fair reproducibility research code of the paper:
"Fair Kernel Learning" submitted to ECML 2017. 

Authors:
Adrian Perez-Suay, and Valero Laparra, and Gonzalo Mateo-Garcia, 
and Jordi Mu~noz-Mari, and Luis Gomez-Chova, and Gustau Camps-Valls

All authors are currently in Image Processing Laboratory (IPL) 
In the group Image and Signal Processing at:

http://isp.uv.es/

Adrian Perez-Suay, 2017 (c) Copyright
Contact: adrian.perez@uv.es

--------------
Original data used in this demo are downloaded from LIBSVM at:

https://www.csie.ntu.edu.tw/~cjlin/libsvmtools/datasets/binary.html

We downloaded the a9a libsvm dataset and convert to Octave/GNU through its libsvmread function from LIBSVM. More info about the a9a dataset can be obtained also in the UCI repository: 

http://archive.ics.uci.edu/ml/
--------------

Running the code:
- execute in Matlab and/or Octave the only .m function in the main directory: FKL_2017_ECML
- Source code and functions invoked by the above function are located at code/ directory.
- Data used in the paper are located at data/ directory.
- Results in .mat format will be allocated at results/ directory.
- Finally, the plot of the results will be in the figures/ directory.

IMPORTANT NOTE: 
In the FKL_2017_ECML.m set the variable exp equal to 2 (exp = 2) in order to reproduce exactly the experimentation setup we did in the ECML submitted paper.
