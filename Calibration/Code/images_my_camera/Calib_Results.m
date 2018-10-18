% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly executed under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 3208.464287151296503 ; 3197.604182457551360 ];

%-- Principal point:
cc = [ 1702.260938139477503 ; 1502.440102089261700 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ 0.237163221664953 ; -1.365462685420244 ; -0.001327078673339 ; 0.030278350882049 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 26.575606510035058 ; 26.871725974751396 ];

%-- Principal point uncertainty:
cc_error = [ 35.579265745112593 ; 29.973066099438107 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.046649909319122 ; 0.371021508610303 ; 0.004197427268056 ; 0.004091622351304 ; 0.000000000000000 ];

%-- Image size:
nx = 3024;
ny = 3024;


%-- Various other variables (may be ignored if you do not use the Matlab Calibration Toolbox):
%-- Those variables are used to control which intrinsic parameters should be optimized

n_ima = 15;						% Number of calibration images
est_fc = [ 1 ; 1 ];					% Estimation indicator of the two focal variables
est_aspect_ratio = 1;				% Estimation indicator of the aspect ratio fc(2)/fc(1)
center_optim = 1;					% Estimation indicator of the principal point
est_alpha = 0;						% Estimation indicator of the skew coefficient
est_dist = [ 1 ; 1 ; 1 ; 1 ; 0 ];	% Estimation indicator of the distortion coefficients


%-- Extrinsic parameters:
%-- The rotation (omc_kk) and the translation (Tc_kk) vectors for every calibration image and their uncertainties

%-- Image #1:
omc_1 = [ -1.711932e+00 ; -1.849424e+00 ; -5.622098e-01 ];
Tc_1  = [ -2.392864e+02 ; -4.806463e+02 ; 1.752127e+03 ];
omc_error_1 = [ 7.903632e-03 ; 1.057993e-02 ; 1.312977e-02 ];
Tc_error_1  = [ 1.958029e+01 ; 1.737475e+01 ; 2.005161e+01 ];

%-- Image #2:
omc_2 = [ -1.420643e+00 ; -1.772736e+00 ; -6.370335e-02 ];
Tc_2  = [ -3.000385e+01 ; -4.629612e+02 ; 1.958376e+03 ];
omc_error_2 = [ 7.983469e-03 ; 9.714273e-03 ; 1.210335e-02 ];
Tc_error_2  = [ 2.186567e+01 ; 1.836975e+01 ; 1.961318e+01 ];

%-- Image #3:
omc_3 = [ -1.278612e+00 ; -1.678993e+00 ; 2.567711e-01 ];
Tc_3  = [ -4.520715e+01 ; -2.796792e+02 ; 1.959685e+03 ];
omc_error_3 = [ 8.281967e-03 ; 9.632943e-03 ; 1.106766e-02 ];
Tc_error_3  = [ 2.168271e+01 ; 1.825968e+01 ; 1.802398e+01 ];

%-- Image #4:
omc_4 = [ -1.300179e+00 ; -1.722381e+00 ; -1.449080e-02 ];
Tc_4  = [ 2.363709e+01 ; -4.482090e+02 ; 2.002877e+03 ];
omc_error_4 = [ 7.843908e-03 ; 9.695540e-03 ; 1.143407e-02 ];
Tc_error_4  = [ 2.241128e+01 ; 1.869436e+01 ; 1.982401e+01 ];

%-- Image #5:
omc_5 = [ -1.544933e+00 ; -1.913620e+00 ; -1.071912e-01 ];
Tc_5  = [ -8.797095e+01 ; -4.390578e+02 ; 1.455219e+03 ];
omc_error_5 = [ 7.628978e-03 ; 9.551018e-03 ; 1.255944e-02 ];
Tc_error_5  = [ 1.624352e+01 ; 1.382846e+01 ; 1.502278e+01 ];

%-- Image #6:
omc_6 = [ -1.463031e+00 ; -1.795827e+00 ; 1.823546e-02 ];
Tc_6  = [ -1.327768e+02 ; -3.659949e+02 ; 1.475432e+03 ];
omc_error_6 = [ 7.909714e-03 ; 9.436249e-03 ; 1.177893e-02 ];
Tc_error_6  = [ 1.631199e+01 ; 1.385365e+01 ; 1.464976e+01 ];

%-- Image #7:
omc_7 = [ -1.395137e+00 ; -1.904439e+00 ; 2.684577e-02 ];
Tc_7  = [ -7.751417e+01 ; -4.329177e+02 ; 1.447031e+03 ];
omc_error_7 = [ 7.671915e-03 ; 9.420096e-03 ; 1.201135e-02 ];
Tc_error_7  = [ 1.611611e+01 ; 1.357632e+01 ; 1.452019e+01 ];

%-- Image #8:
omc_8 = [ -1.780766e+00 ; -1.880896e+00 ; -4.059541e-01 ];
Tc_8  = [ -2.664785e+02 ; -4.232606e+02 ; 1.513380e+03 ];
omc_error_8 = [ 8.173381e-03 ; 1.015026e-02 ; 1.320181e-02 ];
Tc_error_8  = [ 1.689244e+01 ; 1.493960e+01 ; 1.731088e+01 ];

%-- Image #9:
omc_9 = [ -1.130394e+00 ; -1.795133e+00 ; 1.838273e-01 ];
Tc_9  = [ -7.022581e+01 ; -3.081647e+02 ; 1.457387e+03 ];
omc_error_9 = [ 7.585450e-03 ; 9.880434e-03 ; 1.090292e-02 ];
Tc_error_9  = [ 1.607411e+01 ; 1.357517e+01 ; 1.367159e+01 ];

%-- Image #10:
omc_10 = [ -7.466395e-01 ; -1.694599e+00 ; 4.214330e-01 ];
Tc_10  = [ 1.066281e+02 ; -3.272904e+02 ; 1.458084e+03 ];
omc_error_10 = [ 7.327208e-03 ; 1.008824e-02 ; 9.795258e-03 ];
Tc_error_10  = [ 1.630917e+01 ; 1.355389e+01 ; 1.326980e+01 ];

%-- Image #11:
omc_11 = [ -1.887547e+00 ; -1.953326e+00 ; -7.124224e-02 ];
Tc_11  = [ -2.934241e+02 ; -2.861065e+02 ; 1.576341e+03 ];
omc_error_11 = [ 8.959147e-03 ; 9.491062e-03 ; 1.591632e-02 ];
Tc_error_11  = [ 1.730773e+01 ; 1.499617e+01 ; 1.631134e+01 ];

%-- Image #12:
omc_12 = [ -1.063301e+00 ; -2.016040e+00 ; 3.245807e-01 ];
Tc_12  = [ 3.106206e+01 ; -3.866203e+02 ; 1.484149e+03 ];
omc_error_12 = [ 7.181827e-03 ; 9.712430e-03 ; 1.201781e-02 ];
Tc_error_12  = [ 1.653500e+01 ; 1.380841e+01 ; 1.372583e+01 ];

%-- Image #13:
omc_13 = [ -7.540957e-01 ; -1.731394e+00 ; 3.576629e-01 ];
Tc_13  = [ 1.673746e+02 ; -3.056005e+02 ; 1.646312e+03 ];
omc_error_13 = [ 7.126353e-03 ; 1.005382e-02 ; 1.004881e-02 ];
Tc_error_13  = [ 1.847334e+01 ; 1.530317e+01 ; 1.504208e+01 ];

%-- Image #14:
omc_14 = [ -1.856375e+00 ; -1.973367e+00 ; 2.343106e-01 ];
Tc_14  = [ -7.462399e+01 ; -5.703827e+02 ; 1.911675e+03 ];
omc_error_14 = [ 1.094430e-02 ; 9.269684e-03 ; 1.704467e-02 ];
Tc_error_14  = [ 2.138203e+01 ; 1.782150e+01 ; 1.911269e+01 ];

%-- Image #15:
omc_15 = [ -1.857414e+00 ; -1.895555e+00 ; 3.606135e-01 ];
Tc_15  = [ -1.433811e+02 ; -3.927075e+02 ; 1.598188e+03 ];
omc_error_15 = [ 9.586983e-03 ; 8.032818e-03 ; 1.471455e-02 ];
Tc_error_15  = [ 1.762725e+01 ; 1.487450e+01 ; 1.509908e+01 ];

