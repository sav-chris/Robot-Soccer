% This determines the output degree of fulfillment

function [SpeedLN_DOF,SpeedN_DOF,SpeedZ_DOF,SpeedP_DOF,SpeedLP_DOF]=GetOutputDegreeofFulfillment(Distance,Angle)

%get membership lelvels of each fuzzy set correspoding to sensor inputs (distance and angle)
[Mu_Distance, Mu_Angle]=GetDegreeOfMembership(Distance,Angle);

%set up matrix of distance values
Mu_Distance= transpose(Mu_Distance);
Mu_Distance=[Mu_Distance,Mu_Distance,Mu_Distance,Mu_Distance,Mu_Distance];

%set upmatrix the same size bu full of angle membership values
Mu_Angle=[Mu_Angle;Mu_Angle;Mu_Angle];

%Use fuzzy RULES
%Get minimum values for final degree of fulfillment

DOF=min(Mu_Distance,Mu_Angle);

%Determine DOF values for each output

SpeedLN_DOF=DOF(13);

N_DOF_array=[DOF(10),DOF(11),DOF(14),DOF(15)];
SpeedN_DOF=max(N_DOF_array);

Z_DOF_array=[DOF(6:9),DOF(12)];
SpeedZ_DOF=max(Z_DOF_array);

P_DOF_array=[DOF(2:5)];
SpeedP_DOF=max(P_DOF_array);

SpeedLP_DOF=DOF(1);



