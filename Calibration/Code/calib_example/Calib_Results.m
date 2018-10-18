% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly executed under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 657.395393284333068 ; 657.763147018719337 ];

%-- Principal point:
cc = [ 302.983742183984702 ; 242.616262383526220 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ -0.255839056130409 ; 0.127576412013774 ; -0.000208105311572 ; 0.000033482820775 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 0.346911879915653 ; 0.371112463289175 ];

%-- Principal point uncertainty:
cc_error = [ 0.705464061481865 ; 0.645527720575312 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.002706689707172 ; 0.010758237954875 ; 0.000145789168861 ; 0.000144007724438 ; 0.000000000000000 ];

%-- Image size:
nx = 640;
ny = 480;


%-- Various other variables (may be ignored if you do not use the Matlab Calibration Toolbox):
%-- Those variables are used to control which intrinsic parameters should be optimized

n_ima = 20;						% Number of calibration images
est_fc = [ 1 ; 1 ];					% Estimation indicator of the two focal variables
est_aspect_ratio = 1;				% Estimation indicator of the aspect ratio fc(2)/fc(1)
center_optim = 1;					% Estimation indicator of the principal point
est_alpha = 0;						% Estimation indicator of the skew coefficient
est_dist = [ 1 ; 1 ; 1 ; 1 ; 0 ];	% Estimation indicator of the distortion coefficients


%-- Extrinsic parameters:
%-- The rotation (omc_kk) and the translation (Tc_kk) vectors for every calibration image and their uncertainties

%-- Image #1:
omc_1 = [ 1.654779e+00 ; 1.651918e+00 ; -6.699925e-01 ];
Tc_1  = [ -5.919248e+02 ; -2.791360e+02 ; 2.843277e+03 ];
omc_error_1 = [ 8.237491e-04 ; 1.064560e-03 ; 1.360699e-03 ];
Tc_error_1  = [ 3.053677e+00 ; 2.815900e+00 ; 1.547135e+00 ];

%-- Image #2:
omc_2 = [ 1.849011e+00 ; 1.900560e+00 ; -3.971213e-01 ];
Tc_2  = [ -5.165484e+02 ; -5.311819e+02 ; 2.525350e+03 ];
omc_error_2 = [ 8.655041e-04 ; 1.057837e-03 ; 1.645356e-03 ];
Tc_error_2  = [ 2.726658e+00 ; 2.496183e+00 ; 1.520819e+00 ];

%-- Image #3:
omc_3 = [ 1.742391e+00 ; 2.077563e+00 ; -5.052450e-01 ];
Tc_3  = [ -4.174751e+02 ; -5.820922e+02 ; 2.584935e+03 ];
omc_error_3 = [ 7.921066e-04 ; 1.120867e-03 ; 1.700925e-03 ];
Tc_error_3  = [ 2.787249e+00 ; 2.554424e+00 ; 1.461944e+00 ];

%-- Image #4:
omc_4 = [ 1.827858e+00 ; 2.116776e+00 ; -1.103193e+00 ];
Tc_4  = [ -2.147780e+02 ; -5.162340e+02 ; 2.597015e+03 ];
omc_error_4 = [ 7.109841e-04 ; 1.161242e-03 ; 1.592719e-03 ];
Tc_error_4  = [ 2.809107e+00 ; 2.549649e+00 ; 1.177714e+00 ];

%-- Image #5:
omc_5 = [ 1.079052e+00 ; 1.922500e+00 ; -2.527477e-01 ];
Tc_5  = [ -3.074880e+02 ; -7.638515e+02 ; 2.455517e+03 ];
omc_error_5 = [ 6.944831e-04 ; 1.082856e-03 ; 1.219279e-03 ];
Tc_error_5  = [ 2.675716e+00 ; 2.432812e+00 ; 1.439675e+00 ];

%-- Image #6:
omc_6 = [ -1.701812e+00 ; -1.929291e+00 ; -7.914702e-01 ];
Tc_6  = [ -4.963415e+02 ; -2.654922e+02 ; 1.483261e+03 ];
omc_error_6 = [ 6.674802e-04 ; 1.081016e-03 ; 1.464362e-03 ];
Tc_error_6  = [ 1.603513e+00 ; 1.504120e+00 ; 1.231625e+00 ];

%-- Image #7:
omc_7 = [ 1.996748e+00 ; 1.931472e+00 ; 1.310634e+00 ];
Tc_7  = [ -2.764413e+02 ; -2.591177e+02 ; 1.467253e+03 ];
omc_error_7 = [ 1.278362e-03 ; 6.563942e-04 ; 1.535911e-03 ];
Tc_error_7  = [ 1.610991e+00 ; 1.469923e+00 ; 1.300367e+00 ];

%-- Image #8:
omc_8 = [ 1.961458e+00 ; 1.824261e+00 ; 1.326197e+00 ];
Tc_8  = [ -5.670403e+02 ; -3.452016e+02 ; 1.540244e+03 ];
omc_error_8 = [ 1.220037e-03 ; 6.695324e-04 ; 1.473027e-03 ];
Tc_error_8  = [ 1.761323e+00 ; 1.596982e+00 ; 1.464918e+00 ];

%-- Image #9:
omc_9 = [ -1.363691e+00 ; -1.980542e+00 ; 3.210319e-01 ];
Tc_9  = [ -6.262607e+00 ; -7.505291e+02 ; 2.428822e+03 ];
omc_error_9 = [ 8.318219e-04 ; 1.068291e-03 ; 1.376511e-03 ];
Tc_error_9  = [ 2.639984e+00 ; 2.396053e+00 ; 1.497281e+00 ];

%-- Image #10:
omc_10 = [ -1.513265e+00 ; -2.086817e+00 ; 1.882465e-01 ];
Tc_10  = [ -9.869308e+01 ; -1.001436e+03 ; 2.867206e+03 ];
omc_error_10 = [ 1.014557e-03 ; 1.214632e-03 ; 1.830495e-03 ];
Tc_error_10  = [ 3.172617e+00 ; 2.848248e+00 ; 1.987256e+00 ];

%-- Image #11:
omc_11 = [ -1.793085e+00 ; -2.064817e+00 ; -4.799214e-01 ];
Tc_11  = [ -5.035125e+02 ; -7.845457e+02 ; 2.349155e+03 ];
omc_error_11 = [ 9.101245e-04 ; 1.146143e-03 ; 1.970019e-03 ];
Tc_error_11  = [ 2.600897e+00 ; 2.439132e+00 ; 1.965938e+00 ];

%-- Image #12:
omc_12 = [ -1.839113e+00 ; -2.087345e+00 ; -5.155437e-01 ];
Tc_12  = [ -4.449343e+02 ; -5.907656e+02 ; 2.016582e+03 ];
omc_error_12 = [ 7.758652e-04 ; 1.101385e-03 ; 1.817448e-03 ];
Tc_error_12  = [ 2.215270e+00 ; 2.062433e+00 ; 1.643740e+00 ];

%-- Image #13:
omc_13 = [ -1.919019e+00 ; -2.116536e+00 ; -5.941699e-01 ];
Tc_13  = [ -4.423062e+02 ; -4.785336e+02 ; 1.816005e+03 ];
omc_error_13 = [ 7.237312e-04 ; 1.090139e-03 ; 1.786810e-03 ];
Tc_error_13  = [ 1.989188e+00 ; 1.846124e+00 ; 1.491808e+00 ];

%-- Image #14:
omc_14 = [ -1.954383e+00 ; -2.124577e+00 ; -5.844155e-01 ];
Tc_14  = [ -4.119915e+02 ; -4.571427e+02 ; 1.636343e+03 ];
omc_error_14 = [ 6.811548e-04 ; 1.068394e-03 ; 1.749259e-03 ];
Tc_error_14  = [ 1.794997e+00 ; 1.661868e+00 ; 1.338882e+00 ];

%-- Image #15:
omc_15 = [ -2.110763e+00 ; -2.253834e+00 ; -4.948458e-01 ];
Tc_15  = [ -6.638014e+02 ; -4.483648e+02 ; 1.583467e+03 ];
omc_error_15 = [ 7.861861e-04 ; 1.000605e-03 ; 1.906498e-03 ];
Tc_error_15  = [ 1.760471e+00 ; 1.648197e+00 ; 1.443005e+00 ];

%-- Image #16:
omc_16 = [ 1.886909e+00 ; 2.336194e+00 ; -1.735757e-01 ];
Tc_16  = [ -5.311436e+01 ; -5.677793e+02 ; 2.318556e+03 ];
omc_error_16 = [ 1.080868e-03 ; 1.141775e-03 ; 2.373491e-03 ];
Tc_error_16  = [ 2.504230e+00 ; 2.273630e+00 ; 1.708913e+00 ];

%-- Image #17:
omc_17 = [ -1.612908e+00 ; -1.953394e+00 ; -3.473542e-01 ];
Tc_17  = [ -4.507760e+02 ; -4.631867e+02 ; 1.633962e+03 ];
omc_error_17 = [ 6.730108e-04 ; 1.029433e-03 ; 1.450974e-03 ];
Tc_error_17  = [ 1.771948e+00 ; 1.648528e+00 ; 1.186676e+00 ];

%-- Image #18:
omc_18 = [ -1.341751e+00 ; -1.692559e+00 ; -2.970118e-01 ];
Tc_18  = [ -6.178977e+02 ; -5.259994e+02 ; 1.470978e+03 ];
omc_error_18 = [ 7.723999e-04 ; 1.000083e-03 ; 1.145505e-03 ];
Tc_error_18  = [ 1.610974e+00 ; 1.502693e+00 ; 1.152718e+00 ];

%-- Image #19:
omc_19 = [ -1.925985e+00 ; -1.837926e+00 ; -1.440322e+00 ];
Tc_19  = [ -3.552191e+02 ; -2.652395e+02 ; 1.113865e+03 ];
omc_error_19 = [ 6.643737e-04 ; 1.171549e-03 ; 1.484621e-03 ];
Tc_error_19  = [ 1.250079e+00 ; 1.146801e+00 ; 1.081110e+00 ];

%-- Image #20:
omc_20 = [ 1.896147e+00 ; 1.593137e+00 ; 1.471912e+00 ];
Tc_20  = [ -4.794479e+02 ; -2.934541e+02 ; 1.320591e+03 ];
omc_error_20 = [ 1.237531e-03 ; 6.846320e-04 ; 1.333991e-03 ];
Tc_error_20  = [ 1.525806e+00 ; 1.366837e+00 ; 1.307885e+00 ];

